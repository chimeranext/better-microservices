import { type Index, Meilisearch } from "meilisearch";
import type {
  PaginatedResult,
  ProductData,
  SearchEngine,
  SearchQuery,
} from "../../domain/ports/index.js";

const DEFAULT_LIMIT = 20;
const MAX_LIMIT = 100;
const INDEX_UID = "products";

/**
 * Meilisearch-backed SearchEngine. Index name is fixed ("products") to keep
 * the spike simple — multi-tenant indexes by schema_ref live in a future PR.
 *
 * Meilisearch stores the product document as-is and adds fast full-text +
 * attribute filtering. We lazy-init the index on first use so construction
 * doesn't fail if meilisearch is momentarily unreachable.
 */
export class MeilisearchEngine implements SearchEngine {
  private indexCache: Index | null = null;

  constructor(private readonly client: Meilisearch) {}

  static fromEnv(env: NodeJS.ProcessEnv = process.env): MeilisearchEngine {
    const host = env.MEILI_HOST ?? "http://localhost:7700";
    const apiKey = env.MEILI_MASTER_KEY;
    return new MeilisearchEngine(new Meilisearch({ host, apiKey }));
  }

  /**
   * Idempotent: creates the index + configures filterable/sortable attributes
   * on first call. Safe to invoke on every boot.
   */
  async ensureIndex(): Promise<void> {
    // EnqueuedTaskPromise awaits the enqueue; .waitTask() blocks for completion.
    // If the index already exists, createIndex enqueues a no-op (succeeds quickly).
    try {
      await this.client.createIndex(INDEX_UID, { primaryKey: "id" }).waitTask();
    } catch (err) {
      // Swallow "index_already_exists" — harmless on repeated boot.
      const code = (err as { code?: string }).code;
      if (code !== "index_already_exists") throw err;
    }

    const index = this.client.index(INDEX_UID);
    await index
      .updateSettings({
        filterableAttributes: ["vendorId", "status", "productType", "tags", "schemaRef"],
        sortableAttributes: ["createdAt"],
        searchableAttributes: ["title", "description", "tags", "productType"],
      })
      .waitTask();
    this.indexCache = index;
  }

  async index(product: ProductData): Promise<void> {
    const idx = await this.getIndex();
    await idx.addDocuments([serialize(product)], { primaryKey: "id" });
  }

  async remove(productId: string): Promise<void> {
    const idx = await this.getIndex();
    await idx.deleteDocument(productId);
  }

  async search(query: SearchQuery): Promise<PaginatedResult<ProductData>> {
    const idx = await this.getIndex();
    const limit = Math.min(Math.max(query.limit ?? DEFAULT_LIMIT, 1), MAX_LIMIT);
    const filters: string[] = [];

    if (query.collectionId) filters.push(`collectionIds = "${escapeQuote(query.collectionId)}"`);
    if (query.tags && query.tags.length > 0) {
      filters.push(`(${query.tags.map((t) => `tags = "${escapeQuote(t)}"`).join(" OR ")})`);
    }
    if (query.attributeFilters) {
      for (const [key, value] of Object.entries(query.attributeFilters)) {
        filters.push(`attributes.${escapeAttrKey(key)} = "${escapeQuote(value)}"`);
      }
    }

    const offset = query.cursor ? Number.parseInt(query.cursor, 10) || 0 : 0;
    const res = await idx.search<SerializedProduct>(query.text ?? "", {
      limit,
      offset,
      filter: filters.length > 0 ? filters.join(" AND ") : undefined,
      sort: query.sort ? [query.sort] : undefined,
    });

    const items = res.hits.map(deserialize);
    const nextCursor = res.hits.length === limit ? String(offset + limit) : undefined;

    return {
      items,
      total: res.estimatedTotalHits ?? res.hits.length,
      nextCursor,
    };
  }

  private async getIndex(): Promise<Index> {
    if (this.indexCache) return this.indexCache;
    const idx = this.client.index(INDEX_UID);
    this.indexCache = idx;
    return idx;
  }
}

interface SerializedProduct {
  id: string;
  vendorId: string;
  title: string;
  description: string;
  slug: string;
  status: string;
  productType: string;
  tags: string[];
  schemaRef: string;
  attributes: Record<string, unknown>;
  geo?: unknown;
  createdAt: string;
  updatedAt: string;
}

function serialize(product: ProductData): SerializedProduct {
  return {
    id: product.id,
    vendorId: product.vendorId,
    title: product.title,
    description: product.description,
    slug: product.slug,
    status: product.status,
    productType: product.productType,
    tags: product.tags,
    schemaRef: product.schemaRef,
    attributes: product.attributes,
    geo: product.geo,
    createdAt: product.createdAt,
    updatedAt: product.updatedAt,
  };
}

function deserialize(hit: SerializedProduct): ProductData {
  return {
    id: hit.id,
    vendorId: hit.vendorId,
    title: hit.title,
    description: hit.description,
    slug: hit.slug,
    status: hit.status as ProductData["status"],
    productType: hit.productType,
    tags: hit.tags,
    schemaRef: hit.schemaRef,
    attributes: hit.attributes,
    geo: hit.geo as ProductData["geo"],
    createdAt: hit.createdAt,
    updatedAt: hit.updatedAt,
  };
}

function escapeQuote(value: string): string {
  return value.replace(/"/g, '\\"');
}

function escapeAttrKey(key: string): string {
  // Meilisearch attribute paths only allow [A-Za-z0-9_.].
  return key.replace(/[^A-Za-z0-9_.]/g, "_");
}
