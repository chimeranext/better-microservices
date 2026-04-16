import type { DomainEvent } from "../../shared-kernel/events.js";
import type { FulfillmentType, InventoryPolicy, ProductStatus } from "../../shared-kernel/types.js";
import type { AvailabilityRule, GeoLocation, Money } from "../value-objects/index.js";

// ============================================================
// PORTS — Interfaces that the domain defines.
// Adapters (infrastructure) implement these.
// The domain NEVER imports adapters (Dependency Rule).
// ============================================================

// --- Product Repository ---

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

export interface PaginatedResult<T> {
  items: T[];
  nextCursor?: string;
  total: number;
}

// --- Search Engine ---

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

// --- Media Storage ---

export interface MediaStorage {
  upload(input: MediaUploadInput): Promise<MediaResult>;
  delete(mediaId: string): Promise<void>;
  getUrl(mediaId: string): Promise<string>;
}

export interface MediaUploadInput {
  ownerType: string;
  ownerId: string;
  mediaType: string;
  filename: string;
  data: Buffer | ReadableStream;
  altText?: string;
}

export interface MediaResult {
  id: string;
  url: string;
  mimeType: string;
  sizeBytes: number;
  width?: number;
  height?: number;
  durationSeconds?: number;
}

// --- Schema Registry ---

export interface SchemaRegistry {
  register(schema: SchemaData): Promise<string>;
  get(schemaRef: string): Promise<SchemaData | null>;
  list(domain?: string): Promise<SchemaData[]>;
  validate(schemaRef: string, attributes: Record<string, unknown>): Promise<ValidationResult>;
  validateFulfillmentTypes(schemaRef: string, types: FulfillmentType[]): Promise<ValidationResult>;
  validateInventoryPolicy(schemaRef: string, policy: InventoryPolicy): Promise<ValidationResult>;
}

export interface SchemaData {
  id: string;
  domain: string;
  name: string;
  version: number;
  jsonSchema: Record<string, unknown>;
  requiredFields: string[];
  uiHints?: Record<string, unknown>;
  fulfillmentRules?: FulfillmentRules;
  inventoryRules?: InventoryRules;
  availabilityRules?: AvailabilityRulesConfig;
}

export interface FulfillmentRules {
  allowed: FulfillmentType[][];
  forbidden: FulfillmentType[][];
  defaults: FulfillmentType[];
}

export interface InventoryRules {
  allowedPolicies: InventoryPolicy[];
  defaultPolicy: InventoryPolicy;
}

export interface AvailabilityRulesConfig {
  allowedTypes: string[];
  required: boolean;
}

export interface ValidationResult {
  valid: boolean;
  errors: Array<{ field: string; message: string }>;
}

// --- Transaction Port ---

export interface TransactionPort {
  confirm(input: TransactionInput): Promise<TransactionResult>;
  cancel(transactionId: string, reason: string): Promise<TransactionResult>;
  status(transactionId: string): Promise<TransactionStatus>;
}

export interface TransactionInput {
  productId: string;
  variantId: string;
  buyerId: string;
  quantity: number;
  metadata: Record<string, string>;
}

export interface TransactionResult {
  transactionId: string;
  success: boolean;
  status: string;
  errors: Array<{ field: string; message: string }>;
}

export interface TransactionStatus {
  transactionId: string;
  status: string;
  productId: string;
  variantId: string;
  buyerId: string;
  createdAt: string;
  updatedAt: string;
}

// --- Inventory Port ---

export interface InventoryPort {
  reserve(variantId: string, quantity: number, reason: string): Promise<InventoryResult>;
  release(variantId: string, quantity: number, reason: string): Promise<InventoryResult>;
  adjust(variantId: string, delta: number, reason: string): Promise<InventoryResult>;
  getAvailability(variantId: string, date?: string): Promise<AvailabilityInfo>;
}

export interface InventoryResult {
  variantId: string;
  success: boolean;
  quantity: number;
  reserved: number;
  available: number;
  errors: Array<{ field: string; message: string }>;
}

export interface AvailabilityInfo {
  variantId: string;
  available: boolean;
  rule?: AvailabilityRule;
  quantity: number;
  reserved: number;
  openSlots?: Array<{ dayOfWeek: number; startTime: string; endTime: string }>;
}

// --- Payment Gateway Port ---

export interface PaymentGatewayPort {
  charge(amount: Money, method: string, metadata: Record<string, string>): Promise<PaymentResult>;
  refund(transactionId: string): Promise<PaymentResult>;
  escrow(amount: Money, rules: Record<string, unknown>): Promise<PaymentResult>;
}

export interface PaymentResult {
  transactionId: string;
  success: boolean;
  status: string;
  providerRef?: string;
  errors: Array<{ field: string; message: string }>;
}

// --- Traceability Port ---

export interface TraceabilityPort {
  recordOrigin(
    productId: string,
    originParty: string,
    location: GeoLocation,
    metadata: Record<string, string>,
  ): Promise<TraceEventResult>;
  recordTransfer(
    productId: string,
    fromParty: string,
    toParty: string,
    location: GeoLocation,
    metadata: Record<string, string>,
  ): Promise<TraceEventResult>;
  recordTransformation(
    productId: string,
    inputProductIds: string[],
    description: string,
    metadata: Record<string, string>,
  ): Promise<TraceEventResult>;
  getChain(productId: string): Promise<TraceChainResult>;
  verifyChain(productId: string): Promise<boolean>;
}

export interface TraceEventResult {
  id: string;
  recordHash: string;
  previousHash: string;
  sequenceNumber: number;
}

export interface TraceChainResult {
  productId: string;
  events: Array<{
    id: string;
    eventType: string;
    description: string;
    fromParty?: string;
    toParty?: string;
    location?: GeoLocation;
    timestamp: string;
    recordHash: string;
    sequenceNumber: number;
    metadata: Record<string, string>;
  }>;
  integrityVerified: boolean;
}

// --- Reputation Port ---

export interface ReputationPort {
  submitRating(input: RatingInput): Promise<string>;
  getReputation(entityId: string): Promise<ReputationScore>;
  getReviewHistory(
    entityId: string,
    limit: number,
    cursor?: string,
  ): Promise<PaginatedResult<RatingData>>;
}

export interface RatingInput {
  fromId: string;
  toId: string;
  productId?: string;
  transactionId?: string;
  score: number;
  comment?: string;
}

export interface RatingData {
  id: string;
  fromId: string;
  toId: string;
  productId?: string;
  transactionId?: string;
  score: number;
  comment?: string;
  createdAt: string;
}

export interface ReputationScore {
  entityId: string;
  averageScore: number;
  totalRatings: number;
  scoreDistribution: Record<string, number>;
  lastUpdated: string;
}

// --- Event Bus ---

export interface EventBus {
  publish(event: DomainEvent): Promise<void>;
  subscribe(eventType: string, handler: (event: DomainEvent) => Promise<void>): void;
}
