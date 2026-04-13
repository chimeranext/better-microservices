export interface DomainEvent {
  eventId: string;
  eventType: string;
  aggregateId: string;
  timestamp: string;
  metadata: Record<string, string>;
}

export interface ProductListed extends DomainEvent {
  eventType: "ProductListed";
  vendorId: string;
  productId: string;
  schemaRef: string;
}

export interface ProductArchived extends DomainEvent {
  eventType: "ProductArchived";
  productId: string;
  reason: string;
}

export interface VariantCreated extends DomainEvent {
  eventType: "VariantCreated";
  productId: string;
  variantId: string;
  price: string;
  currency: string;
}

export interface InventoryReserved extends DomainEvent {
  eventType: "InventoryReserved";
  variantId: string;
  quantity: number;
  reason: string;
}

export interface InventoryReleased extends DomainEvent {
  eventType: "InventoryReleased";
  variantId: string;
  quantity: number;
  reason: string;
}

export interface InventoryAdjusted extends DomainEvent {
  eventType: "InventoryAdjusted";
  variantId: string;
  delta: number;
  reason: string;
}

export interface TransactionConfirmed extends DomainEvent {
  eventType: "TransactionConfirmed";
  transactionId: string;
  productId: string;
  variantId: string;
  buyerId: string;
}

export interface TransactionFailed extends DomainEvent {
  eventType: "TransactionFailed";
  transactionId: string;
  reason: string;
}

export interface RatingSubmitted extends DomainEvent {
  eventType: "RatingSubmitted";
  fromId: string;
  toId: string;
  score: number;
  productId: string;
}

export interface ReputationUpdated extends DomainEvent {
  eventType: "ReputationUpdated";
  entityId: string;
  newScore: number;
  totalRatings: number;
}

export interface TraceEventRecorded extends DomainEvent {
  eventType: "TraceEventRecorded";
  productId: string;
  traceType: string;
  recordHash: string;
}
