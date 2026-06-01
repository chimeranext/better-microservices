import type { Pool, QueryResultRow } from "pg";
import type {
  PaginatedResult,
  ProductData,
  ProductFilters,
  ProductRepository,
} from "../../domain/ports/index.js";
import type { GeoLocation } from "../../domain/value-objects/index.js";
import { ConflictError, NotFoundError } from "../../shared-kernel/errors.js";
import type { ProductStatus } from "../../shared-kernel/types.js";

interface ProductRow extends QueryResultRow {
  id: string;
  vendor_id: string;
  title: string;
  description: string;
  slug: string;
  status: string;
  product_type: string;
  tags: string[];
  schema_ref: string;
  attributes: Record<string, unknown>;
  geo: GeoLocation | null;
  created_at: Date;
  updated_at: Date;
}

const DEFAULT_LIMIT = 20;
const MAX_LIMIT = 100;

export class PostgresProductRepository implements ProductRepository {
  constructor(private readonly pool: Pool) {}

  async create(product: ProductData): Promise<string> {
    try {
      const result = await this.pool.query<{ id: string }>(
        `INSERT INTO products (
          id, vendor_id, title, description, slug, status, product_type,
          tags, schema_ref, attributes, geo, created_at, updated_at
        ) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10::jsonb,$11::jsonb,$12,$13)
        RETURNING id`,
        [
          product.id,
          product.vendorId,
          product.title,
          product.description,
          product.slug,
          product.status,
          product.productType,
          product.tags,
          product.schemaRef,
          JSON.stringify(product.attributes),
          product.geo ? JSON.stringify(product.geo) : null,
          product.createdAt,
          product.updatedAt,
        ],
      );
      return result.rows[0]?.id ?? product.id;
    } catch (err: unknown) {
      if (isUniqueViolation(err)) {
        throw new ConflictError(`Product with slug "${product.slug}" already exists`, {
          slug: product.slug,
        });
      }
      throw err;
    }
  }

  async update(id: string, data: Partial<ProductData>): Promise<void> {
    const fields: string[] = [];
    const values: unknown[] = [];
    let i = 1;

    const setField = (column: string, value: unknown) => {
      fields.push(`${column} = $${i++}`);
      values.push(value);
    };

    if (data.title !== undefined) setField("title", data.title);
    if (data.description !== undefined) setField("description", data.description);
    if (data.status !== undefined) setField("status", data.status);
    if (data.tags !== undefined) setField("tags", data.tags);
    if (data.attributes !== undefined) {
      fields.push(`attributes = $${i++}::jsonb`);
      values.push(JSON.stringify(data.attributes));
    }
    if (data.geo !== undefined) {
      fields.push(`geo = $${i++}::jsonb`);
      values.push(data.geo ? JSON.stringify(data.geo) : null);
    }

    fields.push(`updated_at = $${i++}`);
    values.push(new Date().toISOString());
    values.push(id);

    const result = await this.pool.query(
      `UPDATE products SET ${fields.join(", ")} WHERE id = $${i}`,
      values,
    );
    if (result.rowCount === 0) {
      throw new NotFoundError(`Product not found: ${id}`, { id });
    }
  }

  async findById(id: string): Promise<ProductData | null> {
    const result = await this.pool.query<ProductRow>("SELECT * FROM products WHERE id = $1", [id]);
    const row = result.rows[0];
    return row ? rowToData(row) : null;
  }

  async findBySlug(slug: string): Promise<ProductData | null> {
    const result = await this.pool.query<ProductRow>("SELECT * FROM products WHERE slug = $1", [
      slug,
    ]);
    const row = result.rows[0];
    return row ? rowToData(row) : null;
  }

  async list(filters: ProductFilters): Promise<PaginatedResult<ProductData>> {
    const limit = Math.min(Math.max(filters.limit ?? DEFAULT_LIMIT, 1), MAX_LIMIT);
    const conditions: string[] = [];
    const values: unknown[] = [];
    let i = 1;

    if (filters.vendorId) {
      conditions.push(`vendor_id = $${i++}`);
      values.push(filters.vendorId);
    }
    if (filters.status) {
      conditions.push(`status = $${i++}`);
      values.push(filters.status);
    }
    if (filters.tags && filters.tags.length > 0) {
      conditions.push(`tags && $${i++}::text[]`);
      values.push(filters.tags);
    }

    const cursor = filters.cursor ? decodeCursor(filters.cursor) : null;
    if (cursor) {
      conditions.push(`(created_at, id) < ($${i++}::timestamptz, $${i++}::uuid)`);
      values.push(cursor.createdAt, cursor.id);
    }

    const where = conditions.length > 0 ? `WHERE ${conditions.join(" AND ")}` : "";
    const sql = `
      SELECT *, COUNT(*) OVER () AS total_count
      FROM products
      ${where}
      ORDER BY created_at DESC, id
      LIMIT $${i}
    `;
    values.push(limit + 1);

    const result = await this.pool.query<ProductRow & { total_count: string }>(sql, values);
    const rows = result.rows;
    const hasMore = rows.length > limit;
    const page = hasMore ? rows.slice(0, limit) : rows;
    const items = page.map(rowToData);
    const total = rows[0] ? Number.parseInt(rows[0].total_count, 10) : 0;

    const last = page[page.length - 1];
    const nextCursor =
      hasMore && last
        ? encodeCursor({ createdAt: last.created_at.toISOString(), id: last.id })
        : undefined;

    return { items, total, nextCursor };
  }

  async delete(id: string): Promise<void> {
    const result = await this.pool.query("DELETE FROM products WHERE id = $1", [id]);
    if (result.rowCount === 0) {
      throw new NotFoundError(`Product not found: ${id}`, { id });
    }
  }
}

function rowToData(row: ProductRow): ProductData {
  return {
    id: row.id,
    vendorId: row.vendor_id,
    title: row.title,
    description: row.description,
    slug: row.slug,
    status: row.status as ProductStatus,
    productType: row.product_type,
    tags: row.tags,
    schemaRef: row.schema_ref,
    attributes: row.attributes,
    geo: row.geo ?? undefined,
    createdAt: row.created_at.toISOString(),
    updatedAt: row.updated_at.toISOString(),
  };
}

interface CursorPayload {
  createdAt: string;
  id: string;
}

function encodeCursor(payload: CursorPayload): string {
  return Buffer.from(JSON.stringify(payload), "utf-8").toString("base64url");
}

function decodeCursor(cursor: string): CursorPayload | null {
  try {
    return JSON.parse(Buffer.from(cursor, "base64url").toString("utf-8")) as CursorPayload;
  } catch {
    return null;
  }
}

function isUniqueViolation(err: unknown): boolean {
  return (
    typeof err === "object" &&
    err !== null &&
    "code" in err &&
    (err as { code: string }).code === "23505"
  );
}
