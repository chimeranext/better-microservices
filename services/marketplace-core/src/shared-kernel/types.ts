// --- Enums ---

export enum ProductStatus {
  DRAFT = "DRAFT",
  ACTIVE = "ACTIVE",
  ARCHIVED = "ARCHIVED",
}

export enum InventoryPolicy {
  TRACK = "TRACK",
  SINGLE = "SINGLE",
  UNTRACK = "UNTRACK",
  CAPACITY = "CAPACITY",
}

export enum FulfillmentType {
  PHYSICAL = "PHYSICAL",
  DIGITAL = "DIGITAL",
  IN_PERSON = "IN_PERSON",
  ONGOING = "ONGOING",
}

export enum VerificationStatus {
  UNVERIFIED = "UNVERIFIED",
  PENDING = "PENDING",
  VERIFIED = "VERIFIED",
}

export enum CollectionType {
  MANUAL = "MANUAL",
  SMART = "SMART",
}

export enum MediaOwnerType {
  PRODUCT = "PRODUCT",
  VARIANT = "VARIANT",
  VENDOR = "VENDOR",
  STOREFRONT = "STOREFRONT",
}

export enum MediaType {
  IMAGE = "IMAGE",
  VIDEO = "VIDEO",
  DOCUMENT = "DOCUMENT",
}

export enum SortOrder {
  MANUAL = "MANUAL",
  BEST_SELLING = "BEST_SELLING",
  PRICE_ASC = "PRICE_ASC",
  PRICE_DESC = "PRICE_DESC",
  CREATED_DESC = "CREATED_DESC",
  TITLE_ASC = "TITLE_ASC",
}
