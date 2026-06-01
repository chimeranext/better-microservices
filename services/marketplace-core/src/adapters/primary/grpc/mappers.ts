import type { ProductData } from "../../../domain/ports/index.js";
import type {
  FulfillmentType as DomainFulfillmentType,
  ProductStatus as DomainProductStatus,
} from "../../../shared-kernel/types.js";

/**
 * Proto ↔ domain conversions. Proto uses SCREAMING_SNAKE_CASE enum values with
 * UNSPECIFIED=0 (required by proto3); the domain uses shorter string literals.
 */

const PROTO_PRODUCT_STATUS: Record<string, number> = {
  DRAFT: 1,
  ACTIVE: 2,
  ARCHIVED: 3,
};

const DOMAIN_PRODUCT_STATUS_BY_PROTO: Record<number, DomainProductStatus | undefined> = {
  1: "DRAFT" as DomainProductStatus,
  2: "ACTIVE" as DomainProductStatus,
  3: "ARCHIVED" as DomainProductStatus,
};

const PROTO_FULFILLMENT_TYPE: Record<DomainFulfillmentType, number> = {
  PHYSICAL: 1,
  DIGITAL: 2,
  IN_PERSON: 3,
  ONGOING: 4,
} as Record<DomainFulfillmentType, number>;

const DOMAIN_FULFILLMENT_BY_PROTO: Record<number, DomainFulfillmentType | undefined> = {
  1: "PHYSICAL" as DomainFulfillmentType,
  2: "DIGITAL" as DomainFulfillmentType,
  3: "IN_PERSON" as DomainFulfillmentType,
  4: "ONGOING" as DomainFulfillmentType,
};

export interface ProtoProduct {
  id: string;
  vendor_id: string;
  title: string;
  description: string;
  slug: string;
  status: number;
  product_type: string;
  tags: string[];
  schema_ref: string;
  attributes: Record<string, string>;
  geo?: ProtoGeoLocation;
  created_at: string;
  updated_at: string;
  variants: ProtoVariant[];
  collection_ids: string[];
  media: ProtoMediaAsset[];
}

export interface ProtoVariant {
  id: string;
  product_id: string;
  [k: string]: unknown;
}

export interface ProtoMediaAsset {
  id: string;
  url: string;
  [k: string]: unknown;
}

export interface ProtoGeoLocation {
  lat: number;
  lng: number;
  address: string;
  city: string;
  state: string;
  country: string;
  postal_code?: string;
}

export interface ProtoProductPage {
  products: ProtoProduct[];
  next_cursor: string;
  total: number;
}

export function productToProto(product: ProductData): ProtoProduct {
  return {
    id: product.id,
    vendor_id: product.vendorId,
    title: product.title,
    description: product.description,
    slug: product.slug,
    status: PROTO_PRODUCT_STATUS[product.status] ?? 0,
    product_type: product.productType,
    tags: product.tags,
    schema_ref: product.schemaRef,
    // Proto map<string, string> — we stringify non-string values.
    attributes: Object.fromEntries(
      Object.entries(product.attributes).map(([k, v]) => [k, String(v)]),
    ),
    geo: product.geo
      ? {
          lat: product.geo.lat,
          lng: product.geo.lng,
          address: product.geo.address,
          city: product.geo.city,
          state: product.geo.state,
          country: product.geo.country,
          postal_code: product.geo.postalCode,
        }
      : undefined,
    created_at: product.createdAt,
    updated_at: product.updatedAt,
    variants: [],
    collection_ids: [],
    media: [],
  };
}

export function protoProductStatusToDomain(
  status: number | undefined,
): DomainProductStatus | undefined {
  if (status === undefined || status === 0) return undefined;
  return DOMAIN_PRODUCT_STATUS_BY_PROTO[status];
}

export function protoFulfillmentTypesToDomain(
  types: number[] | undefined,
): DomainFulfillmentType[] {
  if (!types) return [];
  return types
    .map((t) => DOMAIN_FULFILLMENT_BY_PROTO[t])
    .filter((t): t is DomainFulfillmentType => t !== undefined);
}

export function domainFulfillmentToProto(type: DomainFulfillmentType): number {
  return PROTO_FULFILLMENT_TYPE[type] ?? 0;
}
