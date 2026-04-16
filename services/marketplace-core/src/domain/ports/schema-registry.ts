import type { FulfillmentType, InventoryPolicy } from "../../shared-kernel/types.js";

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
