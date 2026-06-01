import type { FulfillmentType } from "../../shared-kernel/types.js";
import type { GeoLocation, Money } from "../value-objects/index.js";
import type { PaginatedResult } from "./pagination.js";
import type { ProductData } from "./product-repository.js";

export interface SearchEngine {
  search(query: SearchQuery): Promise<PaginatedResult<ProductData>>;
  index(product: ProductData): Promise<void>;
  remove(productId: string): Promise<void>;
}

export interface SearchQuery {
  text?: string;
  collectionId?: string;
  fulfillmentTypes?: FulfillmentType[];
  priceMin?: Money;
  priceMax?: Money;
  near?: GeoLocation;
  radiusKm?: number;
  tags?: string[];
  attributeFilters?: Record<string, string>;
  sort?: string;
  limit: number;
  cursor?: string;
}
