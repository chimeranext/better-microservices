export interface PaginatedResult<T> {
  items: T[];
  nextCursor?: string;
  total: number;
}
