import type { PaginatedResult } from "./pagination.js";

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
