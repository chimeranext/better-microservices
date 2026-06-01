import type { GeoLocation } from "../value-objects/index.js";

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
