import { status as GrpcStatus, type ServerUnaryCall, type sendUnaryData } from "@grpc/grpc-js";
import type {
  PaginatedResult,
  ProductData,
  ProductRepository,
  SearchEngine,
} from "../../../domain/ports/index.js";
import { DomainError, NotFoundError } from "../../../shared-kernel/errors.js";
import type { ProductStatus as DomainProductStatus } from "../../../shared-kernel/types.js";
import { type ProtoProduct, type ProtoProductPage, productToProto } from "./mappers.js";

interface StorefrontDeps {
  repository: ProductRepository;
  search: SearchEngine;
}

interface BrowseRequestProto {
  vendor_id?: string;
  tags?: string[];
  limit?: number;
  cursor?: string;
}

interface SearchRequestProto {
  query?: string;
  collection_id?: string;
  tags?: string[];
  attribute_filters?: Record<string, string>;
  sort?: number;
  limit?: number;
  cursor?: string;
}

interface GetProductRequestProto {
  id?: string;
  slug?: string;
}

/**
 * Handler implementations for the `MarketplaceStorefront` gRPC service.
 *
 * Only the read-path (Browse/Get/Search) is wired in this PR — collections,
 * vendor profiles, and storefronts come in a follow-up once the data model
 * for those tables is finalised.
 */
export function createStorefrontServiceImpl(deps: StorefrontDeps) {
  return {
    BrowseProducts: async (
      call: ServerUnaryCall<BrowseRequestProto, ProtoProductPage>,
      callback: sendUnaryData<ProtoProductPage>,
    ): Promise<void> => {
      try {
        const req = call.request;
        const page = await deps.repository.list({
          vendorId: req.vendor_id || undefined,
          status: "ACTIVE" as DomainProductStatus,
          tags: req.tags && req.tags.length > 0 ? req.tags : undefined,
          limit: req.limit || 20,
          cursor: req.cursor || undefined,
        });
        callback(null, pageToProto(page));
      } catch (err) {
        callback(toGrpcError(err), null);
      }
    },

    GetProductDetail: async (
      call: ServerUnaryCall<GetProductRequestProto, ProtoProduct>,
      callback: sendUnaryData<ProtoProduct>,
    ): Promise<void> => {
      try {
        const req = call.request;
        let product: ProductData | null = null;
        if (req.id) {
          product = await deps.repository.findById(req.id);
        } else if (req.slug) {
          product = await deps.repository.findBySlug(req.slug);
        }
        if (!product) {
          throw new NotFoundError("Product not found", { id: req.id, slug: req.slug });
        }
        callback(null, productToProto(product));
      } catch (err) {
        callback(toGrpcError(err), null);
      }
    },

    SearchProducts: async (
      call: ServerUnaryCall<SearchRequestProto, ProtoProductPage>,
      callback: sendUnaryData<ProtoProductPage>,
    ): Promise<void> => {
      try {
        const req = call.request;
        const page = await deps.search.search({
          text: req.query || undefined,
          collectionId: req.collection_id || undefined,
          tags: req.tags && req.tags.length > 0 ? req.tags : undefined,
          attributeFilters: req.attribute_filters,
          limit: req.limit || 20,
          cursor: req.cursor || undefined,
        });
        callback(null, pageToProto(page));
      } catch (err) {
        callback(toGrpcError(err), null);
      }
    },

    ListCollections: (_call: unknown, callback: sendUnaryData<unknown>): void => {
      callback(
        {
          code: GrpcStatus.UNIMPLEMENTED,
          details: "ListCollections lands in a follow-up PR",
          name: "Unimplemented",
          message: "Unimplemented",
        },
        null,
      );
    },

    GetCollection: (_call: unknown, callback: sendUnaryData<unknown>): void => {
      callback(
        {
          code: GrpcStatus.UNIMPLEMENTED,
          details: "GetCollection lands in a follow-up PR",
          name: "Unimplemented",
          message: "Unimplemented",
        },
        null,
      );
    },

    GetStorefront: (_call: unknown, callback: sendUnaryData<unknown>): void => {
      callback(
        {
          code: GrpcStatus.UNIMPLEMENTED,
          details: "GetStorefront lands in a follow-up PR",
          name: "Unimplemented",
          message: "Unimplemented",
        },
        null,
      );
    },

    GetVendorProfile: (_call: unknown, callback: sendUnaryData<unknown>): void => {
      callback(
        {
          code: GrpcStatus.UNIMPLEMENTED,
          details: "GetVendorProfile lands in a follow-up PR",
          name: "Unimplemented",
          message: "Unimplemented",
        },
        null,
      );
    },
  };
}

function pageToProto(page: PaginatedResult<ProductData>): ProtoProductPage {
  return {
    products: page.items.map(productToProto),
    next_cursor: page.nextCursor ?? "",
    total: page.total,
  };
}

function toGrpcError(err: unknown): { code: number; details: string; message: string } {
  if (err instanceof NotFoundError) {
    return { code: GrpcStatus.NOT_FOUND, details: err.message, message: err.message };
  }
  if (err instanceof DomainError) {
    return {
      code: GrpcStatus.INVALID_ARGUMENT,
      details: err.message,
      message: err.message,
    };
  }
  const message = err instanceof Error ? err.message : String(err);
  return { code: GrpcStatus.INTERNAL, details: message, message };
}
