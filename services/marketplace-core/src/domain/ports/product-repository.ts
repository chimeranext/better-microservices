import type { ProductStatus } from "../../shared-kernel/types.js";
import type { GeoLocation } from "../value-objects/index.js";
import type { PaginatedResult } from "./pagination.js";

export interface ProductRepository {
  create(product: ProductData): Promise<string>;
  update(id: string, data: Partial<ProductData>): Promise<void>;
  findById(id: string): Promise<ProductData | null>;
  findBySlug(slug: string): Promise<ProductData | null>;
  list(filters: ProductFilters): Promise<PaginatedResult<ProductData>>;
  delete(id: string): Promise<void>;
}

export interface ProductData {
  id: string;
  vendorId: string;
  title: string;
  description: string;
  slug: string;
  status: ProductStatus;
  productType: string;
  tags: string[];
  schemaRef: string;
  attributes: Record<string, unknown>;
  geo?: GeoLocation;
  createdAt: string;
  updatedAt: string;
}

export interface ProductFilters {
  vendorId?: string;
  status?: ProductStatus;
  collectionId?: string;
  tags?: string[];
  limit: number;
  cursor?: string;
}
