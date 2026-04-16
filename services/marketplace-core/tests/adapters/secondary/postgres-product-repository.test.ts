import type { Pool, QueryResult } from "pg";
import { describe, expect, it, vi } from "vitest";
import { PostgresProductRepository } from "../../../src/adapters/secondary/postgres-product-repository.js";
import type { ProductData } from "../../../src/domain/ports/index.js";
import { ConflictError, NotFoundError } from "../../../src/shared-kernel/errors.js";
import { ProductStatus } from "../../../src/shared-kernel/types.js";

/**
 * Minimal mock pool: each test stubs `query` with vi.fn.mockResolvedValueOnce
 * to return whatever shape `pg` would give. We avoid spinning up a real DB
 * in this unit test — integration tests hit a real compose instance.
 */
function mockPool(): Pool & { query: ReturnType<typeof vi.fn> } {
  return { query: vi.fn() } as unknown as Pool & {
    query: ReturnType<typeof vi.fn>;
  };
}

function mockResult<T extends Record<string, unknown>>(
  rows: T[],
  rowCount = rows.length,
): QueryResult<T> {
  return {
    rows,
    rowCount,
    command: "",
    oid: 0,
    fields: [],
  };
}

const sampleProduct: ProductData = {
  id: "00000000-0000-0000-0000-000000000001",
  vendorId: "00000000-0000-0000-0000-000000000099",
  title: "Organic lettuce",
  description: "Fresh",
  slug: "organic-lettuce",
  status: ProductStatus.ACTIVE,
  productType: "hortaliza",
  tags: ["fresh"],
  schemaRef: "schema://vertivo/hortaliza:v1",
  attributes: { harvestDate: "2026-04-15" },
  geo: undefined,
  createdAt: "2026-04-15T00:00:00Z",
  updatedAt: "2026-04-15T00:00:00Z",
};

describe("PostgresProductRepository.create", () => {
  it("INSERTs and returns id", async () => {
    const pool = mockPool();
    pool.query.mockResolvedValueOnce(mockResult([{ id: sampleProduct.id }]));
    const repo = new PostgresProductRepository(pool);
    const id = await repo.create(sampleProduct);
    expect(id).toBe(sampleProduct.id);
    expect(pool.query).toHaveBeenCalledOnce();
  });

  it("translates pg 23505 unique violation to ConflictError", async () => {
    const pool = mockPool();
    pool.query.mockRejectedValueOnce({ code: "23505", message: "duplicate key" });
    const repo = new PostgresProductRepository(pool);
    await expect(repo.create(sampleProduct)).rejects.toBeInstanceOf(ConflictError);
  });

  it("rethrows other pg errors untouched", async () => {
    const pool = mockPool();
    pool.query.mockRejectedValueOnce(new Error("connection refused"));
    const repo = new PostgresProductRepository(pool);
    await expect(repo.create(sampleProduct)).rejects.toThrow("connection refused");
  });
});

describe("PostgresProductRepository.update", () => {
  it("builds a dynamic UPDATE with only provided fields", async () => {
    const pool = mockPool();
    pool.query.mockResolvedValueOnce(mockResult([], 1));
    const repo = new PostgresProductRepository(pool);
    await repo.update(sampleProduct.id, { title: "new title", tags: ["a"] });
    const sql = pool.query.mock.calls[0]?.[0] as string;
    expect(sql).toContain("title = $1");
    expect(sql).toContain("tags = $2");
    expect(sql).toContain("updated_at = $3");
  });

  it("throws NotFoundError when no row updates", async () => {
    const pool = mockPool();
    pool.query.mockResolvedValueOnce(mockResult([], 0));
    const repo = new PostgresProductRepository(pool);
    await expect(repo.update("missing", { title: "x" })).rejects.toBeInstanceOf(NotFoundError);
  });

  it("encodes attributes as JSON; geo=undefined is treated as 'unchanged'", async () => {
    const pool = mockPool();
    pool.query.mockResolvedValueOnce(mockResult([], 1));
    const repo = new PostgresProductRepository(pool);
    await repo.update("id", { attributes: { foo: 1 }, geo: undefined });
    const sql = pool.query.mock.calls[0]?.[0] as string;
    const params = pool.query.mock.calls[0]?.[1] as unknown[];
    expect(params).toContain(JSON.stringify({ foo: 1 }));
    // geo was undefined in the input → no "geo = ..." clause in the SQL.
    expect(sql).not.toContain("geo = ");
  });

  it("encodes geo as JSONB when a GeoLocation is provided", async () => {
    const pool = mockPool();
    pool.query.mockResolvedValueOnce(mockResult([], 1));
    const repo = new PostgresProductRepository(pool);
    await repo.update("id", {
      geo: {
        lat: 9.93,
        lng: -84.08,
        address: "SJO",
        city: "San Jose",
        state: "SJ",
        country: "CR",
      },
    });
    const sql = pool.query.mock.calls[0]?.[0] as string;
    const params = pool.query.mock.calls[0]?.[1] as unknown[];
    expect(sql).toContain("geo = $1::jsonb");
    expect(params[0]).toContain('"country":"CR"');
  });
});

describe("PostgresProductRepository.findById / findBySlug", () => {
  it("maps row → ProductData, returning null when absent", async () => {
    const pool = mockPool();
    pool.query.mockResolvedValueOnce(
      mockResult([
        {
          id: sampleProduct.id,
          vendor_id: sampleProduct.vendorId,
          title: sampleProduct.title,
          description: sampleProduct.description,
          slug: sampleProduct.slug,
          status: sampleProduct.status,
          product_type: sampleProduct.productType,
          tags: sampleProduct.tags,
          schema_ref: sampleProduct.schemaRef,
          attributes: sampleProduct.attributes,
          geo: null,
          created_at: new Date(sampleProduct.createdAt),
          updated_at: new Date(sampleProduct.updatedAt),
        },
      ]),
    );
    const repo = new PostgresProductRepository(pool);
    const found = await repo.findById(sampleProduct.id);
    expect(found?.title).toBe("Organic lettuce");

    pool.query.mockResolvedValueOnce(mockResult([]));
    expect(await repo.findBySlug("missing")).toBeNull();
  });
});

describe("PostgresProductRepository.list — cursor pagination", () => {
  it("encodes nextCursor when there is another page", async () => {
    const pool = mockPool();
    const now = new Date("2026-04-15T12:00:00Z");
    // Stub 3 rows to prove that a limit of 2 yields nextCursor from row[1].
    pool.query.mockResolvedValueOnce(
      mockResult([
        {
          id: "1",
          vendor_id: "v",
          title: "a",
          description: "",
          slug: "a",
          status: "ACTIVE",
          product_type: "x",
          tags: [],
          schema_ref: "s",
          attributes: {},
          geo: null,
          created_at: now,
          updated_at: now,
          total_count: "3",
        },
        {
          id: "2",
          vendor_id: "v",
          title: "b",
          description: "",
          slug: "b",
          status: "ACTIVE",
          product_type: "x",
          tags: [],
          schema_ref: "s",
          attributes: {},
          geo: null,
          created_at: now,
          updated_at: now,
          total_count: "3",
        },
        {
          id: "3",
          vendor_id: "v",
          title: "c",
          description: "",
          slug: "c",
          status: "ACTIVE",
          product_type: "x",
          tags: [],
          schema_ref: "s",
          attributes: {},
          geo: null,
          created_at: now,
          updated_at: now,
          total_count: "3",
        },
      ]),
    );
    const repo = new PostgresProductRepository(pool);
    const page = await repo.list({ limit: 2 });
    expect(page.items.length).toBe(2);
    expect(page.total).toBe(3);
    expect(page.nextCursor).toBeDefined();

    // Decode cursor round-trip — it should be base64url of a JSON payload.
    const decoded = JSON.parse(Buffer.from(page.nextCursor ?? "", "base64url").toString("utf-8"));
    expect(decoded.id).toBe("2");
  });

  it("no nextCursor when items ≤ limit", async () => {
    const pool = mockPool();
    pool.query.mockResolvedValueOnce(mockResult([]));
    const repo = new PostgresProductRepository(pool);
    const page = await repo.list({ limit: 20 });
    expect(page.items).toEqual([]);
    expect(page.nextCursor).toBeUndefined();
    expect(page.total).toBe(0);
  });

  it("applies vendorId + status + tags filters; ignores malformed cursors", async () => {
    const pool = mockPool();
    pool.query.mockResolvedValueOnce(mockResult([]));
    const repo = new PostgresProductRepository(pool);
    await repo.list({
      vendorId: "v-1",
      status: ProductStatus.ACTIVE,
      tags: ["fresh"],
      cursor: "this-is-not-base64",
      limit: 10,
    });
    const sql = pool.query.mock.calls[0]?.[0] as string;
    expect(sql).toContain("vendor_id = $1");
    expect(sql).toContain("status = $2");
    expect(sql).toContain("tags && $3::text[]");
    // The malformed cursor decode returns null, so no cursor WHERE clause appears.
    expect(sql).not.toContain("(created_at, id)");
  });

  it("decodes a valid base64url cursor and adds the WHERE clause", async () => {
    const pool = mockPool();
    pool.query.mockResolvedValueOnce(mockResult([]));
    const repo = new PostgresProductRepository(pool);
    const cursor = Buffer.from(
      JSON.stringify({ createdAt: "2026-04-15T00:00:00Z", id: "p-1" }),
      "utf-8",
    ).toString("base64url");
    await repo.list({ cursor, limit: 5 });
    const sql = pool.query.mock.calls[0]?.[0] as string;
    expect(sql).toContain("(created_at, id) <");
    const params = pool.query.mock.calls[0]?.[1] as unknown[];
    expect(params).toContain("2026-04-15T00:00:00Z");
    expect(params).toContain("p-1");
  });

  it("clamps excessive limit + enforces minimum of 1", async () => {
    const pool = mockPool();
    pool.query.mockResolvedValueOnce(mockResult([]));
    const repo = new PostgresProductRepository(pool);
    await repo.list({ limit: 9999 });
    const params = pool.query.mock.calls[0]?.[1] as unknown[];
    // last param is limit + 1 = 101
    expect(params[params.length - 1]).toBe(101);
  });
});

describe("PostgresProductRepository.delete", () => {
  it("NotFoundError when row missing", async () => {
    const pool = mockPool();
    pool.query.mockResolvedValueOnce(mockResult([], 0));
    const repo = new PostgresProductRepository(pool);
    await expect(repo.delete("x")).rejects.toBeInstanceOf(NotFoundError);
  });

  it("succeeds when row exists", async () => {
    const pool = mockPool();
    pool.query.mockResolvedValueOnce(mockResult([], 1));
    const repo = new PostgresProductRepository(pool);
    await expect(repo.delete("x")).resolves.toBeUndefined();
  });
});
