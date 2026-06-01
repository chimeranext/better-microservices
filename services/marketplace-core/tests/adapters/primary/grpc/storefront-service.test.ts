import { status as GrpcStatus } from "@grpc/grpc-js";
import { describe, expect, it, vi } from "vitest";
import { createStorefrontServiceImpl } from "../../../../src/adapters/primary/grpc/storefront-service.js";
import type {
  PaginatedResult,
  ProductData,
  ProductRepository,
  SearchEngine,
} from "../../../../src/domain/ports/index.js";
import { ProductStatus } from "../../../../src/shared-kernel/types.js";

const baseProduct: ProductData = {
  id: "p-1",
  vendorId: "v-1",
  title: "Lettuce",
  description: "",
  slug: "lettuce",
  status: ProductStatus.ACTIVE,
  productType: "hortaliza",
  tags: [],
  schemaRef: "s",
  attributes: {},
  createdAt: "2026-04-15T00:00:00Z",
  updatedAt: "2026-04-15T00:00:00Z",
};

const emptyPage: PaginatedResult<ProductData> = { items: [], total: 0 };

function mockRepo(overrides: Partial<ProductRepository> = {}): ProductRepository {
  return {
    create: vi.fn(),
    update: vi.fn(),
    findById: vi.fn().mockResolvedValue(null),
    findBySlug: vi.fn().mockResolvedValue(null),
    list: vi.fn().mockResolvedValue(emptyPage),
    delete: vi.fn(),
    ...overrides,
  };
}

function mockSearch(overrides: Partial<SearchEngine> = {}): SearchEngine {
  return {
    search: vi.fn().mockResolvedValue(emptyPage),
    index: vi.fn(),
    remove: vi.fn(),
    ...overrides,
  };
}

// Lightweight wrapper around handlers to look more like vitest's preferred
// async/await shape instead of gRPC's (call, callback) style. We erase the
// strict ServerUnaryCall<T> generic via unknown at the test boundary — only
// `call.request` matters for these handlers.
type GrpcLikeHandler = (call: unknown, callback: (err: unknown, value: unknown) => void) => unknown;

function invoke(handler: unknown, request: unknown): Promise<{ err: unknown; value: unknown }> {
  const h = handler as GrpcLikeHandler;
  return new Promise((resolve) => {
    h({ request }, (err, value) => resolve({ err, value }));
  });
}

describe("storefront-service.BrowseProducts", () => {
  it("returns paginated response with nextCursor passthrough", async () => {
    const search = mockSearch();
    const repo = mockRepo({
      list: vi.fn().mockResolvedValue({
        items: [baseProduct],
        total: 1,
        nextCursor: "abc",
      }),
    });
    const svc = createStorefrontServiceImpl({ repository: repo, search });
    const { err, value } = await invoke(svc.BrowseProducts, {
      vendor_id: "v-1",
      tags: ["fresh"],
      limit: 10,
    });
    expect(err).toBeNull();
    const page = value as { products: unknown[]; next_cursor: string };
    expect(page.products.length).toBe(1);
    expect(page.next_cursor).toBe("abc");
    expect(repo.list).toHaveBeenCalledWith(
      expect.objectContaining({ vendorId: "v-1", tags: ["fresh"], status: "ACTIVE", limit: 10 }),
    );
  });

  it("defaults limit + strips empty tags/vendor_id", async () => {
    const repo = mockRepo();
    const svc = createStorefrontServiceImpl({ repository: repo, search: mockSearch() });
    await invoke(svc.BrowseProducts, {});
    expect(repo.list).toHaveBeenCalledWith(
      expect.objectContaining({ vendorId: undefined, tags: undefined, limit: 20 }),
    );
  });

  it("maps repository error to INTERNAL status", async () => {
    const repo = mockRepo({
      list: vi.fn().mockRejectedValue(new Error("db down")),
    });
    const svc = createStorefrontServiceImpl({ repository: repo, search: mockSearch() });
    const { err } = await invoke(svc.BrowseProducts, {});
    expect((err as { code: number }).code).toBe(GrpcStatus.INTERNAL);
  });
});

describe("storefront-service.GetProductDetail", () => {
  it("prefers id over slug", async () => {
    const repo = mockRepo({
      findById: vi.fn().mockResolvedValue(baseProduct),
    });
    const svc = createStorefrontServiceImpl({ repository: repo, search: mockSearch() });
    const { err, value } = await invoke(svc.GetProductDetail, {
      id: "p-1",
      slug: "lettuce",
    });
    expect(err).toBeNull();
    expect((value as { id: string }).id).toBe("p-1");
    expect(repo.findById).toHaveBeenCalledWith("p-1");
    expect(repo.findBySlug).not.toHaveBeenCalled();
  });

  it("falls back to slug when id empty", async () => {
    const repo = mockRepo({
      findBySlug: vi.fn().mockResolvedValue(baseProduct),
    });
    const svc = createStorefrontServiceImpl({ repository: repo, search: mockSearch() });
    const { err } = await invoke(svc.GetProductDetail, { slug: "lettuce" });
    expect(err).toBeNull();
    expect(repo.findBySlug).toHaveBeenCalledWith("lettuce");
  });

  it("NotFoundError → NOT_FOUND grpc code", async () => {
    const svc = createStorefrontServiceImpl({ repository: mockRepo(), search: mockSearch() });
    const { err } = await invoke(svc.GetProductDetail, { id: "missing" });
    expect((err as { code: number }).code).toBe(GrpcStatus.NOT_FOUND);
  });

  it("DomainError (not NotFound) → INVALID_ARGUMENT grpc code", async () => {
    const { InvariantViolationError } = await import("../../../../src/shared-kernel/errors.js");
    const repo = mockRepo({
      findById: vi.fn().mockRejectedValue(new InvariantViolationError("bad input")),
    });
    const svc = createStorefrontServiceImpl({ repository: repo, search: mockSearch() });
    const { err } = await invoke(svc.GetProductDetail, { id: "x" });
    expect((err as { code: number }).code).toBe(GrpcStatus.INVALID_ARGUMENT);
  });

  it("non-Error throwables are stringified into INTERNAL details", async () => {
    const repo = mockRepo({
      findById: vi.fn().mockRejectedValue("raw string, not an Error"),
    });
    const svc = createStorefrontServiceImpl({ repository: repo, search: mockSearch() });
    const { err } = await invoke(svc.GetProductDetail, { id: "x" });
    expect((err as { code: number; details: string }).code).toBe(GrpcStatus.INTERNAL);
    expect((err as { details: string }).details).toContain("raw string");
  });
});

describe("storefront-service.SearchProducts", () => {
  it("forwards text + filters to search engine", async () => {
    const search = mockSearch();
    const svc = createStorefrontServiceImpl({ repository: mockRepo(), search });
    await invoke(svc.SearchProducts, {
      query: "lettuce",
      tags: ["fresh"],
      attribute_filters: { organic: "true" },
      limit: 5,
    });
    expect(search.search).toHaveBeenCalledWith(
      expect.objectContaining({
        text: "lettuce",
        tags: ["fresh"],
        attributeFilters: { organic: "true" },
        limit: 5,
      }),
    );
  });

  it("empty string / empty tags → undefined on the port", async () => {
    const search = mockSearch();
    const svc = createStorefrontServiceImpl({ repository: mockRepo(), search });
    await invoke(svc.SearchProducts, { query: "", tags: [] });
    expect(search.search).toHaveBeenCalledWith(
      expect.objectContaining({ text: undefined, tags: undefined }),
    );
  });

  it("propagates search engine errors as INTERNAL", async () => {
    const search = mockSearch({
      search: vi.fn().mockRejectedValue(new Error("meili down")),
    });
    const svc = createStorefrontServiceImpl({ repository: mockRepo(), search });
    const { err } = await invoke(svc.SearchProducts, {});
    expect((err as { code: number }).code).toBe(GrpcStatus.INTERNAL);
  });
});

describe("storefront-service — unimplemented stubs", () => {
  it.each([
    ["ListCollections"],
    ["GetCollection"],
    ["GetStorefront"],
    ["GetVendorProfile"],
  ] as const)("%s returns UNIMPLEMENTED", async (rpc) => {
    const svc = createStorefrontServiceImpl({
      repository: mockRepo(),
      search: mockSearch(),
    });
    const handler = (svc as unknown as Record<string, (c: unknown, cb: unknown) => void>)[rpc];
    const { err } = await invoke(handler, {});
    expect((err as { code: number }).code).toBe(GrpcStatus.UNIMPLEMENTED);
  });
});
