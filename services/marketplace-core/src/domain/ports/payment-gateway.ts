import type { Money } from "../value-objects/index.js";

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
