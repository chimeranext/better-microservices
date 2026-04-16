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
