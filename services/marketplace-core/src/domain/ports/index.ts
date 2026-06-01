export type { PaginatedResult } from "./pagination.js";

export type {
  ProductRepository,
  ProductData,
  ProductFilters,
} from "./product-repository.js";

export type { SearchEngine, SearchQuery } from "./search-engine.js";

export type {
  MediaStorage,
  MediaUploadInput,
  MediaResult,
} from "./media-storage.js";

export type {
  SchemaRegistry,
  SchemaData,
  FulfillmentRules,
  InventoryRules,
  AvailabilityRulesConfig,
  ValidationResult,
} from "./schema-registry.js";

export type {
  TransactionPort,
  TransactionInput,
  TransactionResult,
  TransactionStatus,
} from "./transaction.js";

export type {
  InventoryPort,
  InventoryResult,
  AvailabilityInfo,
} from "./inventory.js";

export type { PaymentGatewayPort, PaymentResult } from "./payment-gateway.js";

export type {
  TraceabilityPort,
  TraceEventResult,
  TraceChainResult,
} from "./traceability.js";

export type {
  ReputationPort,
  RatingInput,
  RatingData,
  ReputationScore,
} from "./reputation.js";

export type { EventBus } from "./event-bus.js";
