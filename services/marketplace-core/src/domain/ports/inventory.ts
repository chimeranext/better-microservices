import type { AvailabilityRule } from "../value-objects/index.js";

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
