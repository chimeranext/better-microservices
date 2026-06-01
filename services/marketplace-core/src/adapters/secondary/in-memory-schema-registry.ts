import { readFile, readdir } from "node:fs/promises";
import { join } from "node:path";
import type { SchemaData, SchemaRegistry, ValidationResult } from "../../domain/ports/index.js";
import { NotFoundError } from "../../shared-kernel/errors.js";
import type { FulfillmentType, InventoryPolicy } from "../../shared-kernel/types.js";

/**
 * In-memory schema registry. On boot, walks the given directory and caches
 * every `*.json` file it finds as a schema keyed by `domain/name:version`.
 *
 * Real implementations will swap this for a postgres-backed registry with
 * versioning + compatibility checks — this is deliberately minimal so the
 * Flutter storefront spike can evolve its schemas without a database.
 */
export class InMemorySchemaRegistry implements SchemaRegistry {
  private readonly schemas = new Map<string, SchemaData>();

  static async fromDirectory(dir: string): Promise<InMemorySchemaRegistry> {
    const registry = new InMemorySchemaRegistry();
    await registry.loadFromDirectory(dir);
    return registry;
  }

  static fromSeed(schemas: SchemaData[]): InMemorySchemaRegistry {
    const registry = new InMemorySchemaRegistry();
    for (const schema of schemas) {
      registry.put(schema);
    }
    return registry;
  }

  async register(schema: SchemaData): Promise<string> {
    this.put(schema);
    return schema.id;
  }

  async get(schemaRef: string): Promise<SchemaData | null> {
    return this.schemas.get(schemaRef) ?? null;
  }

  async list(domain?: string): Promise<SchemaData[]> {
    const all = Array.from(this.schemas.values());
    return domain ? all.filter((s) => s.domain === domain) : all;
  }

  async validate(
    schemaRef: string,
    attributes: Record<string, unknown>,
  ): Promise<ValidationResult> {
    const schema = await this.get(schemaRef);
    if (!schema) {
      throw new NotFoundError(`Schema not found: ${schemaRef}`, { schemaRef });
    }
    const missing = schema.requiredFields.filter((field) => !(field in attributes));
    if (missing.length > 0) {
      return {
        valid: false,
        errors: missing.map((field) => ({ field, message: "required field missing" })),
      };
    }
    return { valid: true, errors: [] };
  }

  async validateFulfillmentTypes(
    schemaRef: string,
    types: FulfillmentType[],
  ): Promise<ValidationResult> {
    const schema = await this.get(schemaRef);
    if (!schema) {
      throw new NotFoundError(`Schema not found: ${schemaRef}`, { schemaRef });
    }
    const rules = schema.fulfillmentRules;
    if (!rules) return { valid: true, errors: [] };

    const inSet = (set: FulfillmentType[], subset: FulfillmentType[]): boolean =>
      subset.every((t) => set.includes(t));

    const allowed = rules.allowed.some((set) => inSet(set, types));
    if (!allowed) {
      return {
        valid: false,
        errors: [
          {
            field: "fulfillmentTypes",
            message: `Combination ${types.join("+")} is not in allowed fulfillment rules`,
          },
        ],
      };
    }
    const forbidden = rules.forbidden.some((set) => inSet(types, set));
    if (forbidden) {
      return {
        valid: false,
        errors: [
          {
            field: "fulfillmentTypes",
            message: `Combination ${types.join("+")} is explicitly forbidden`,
          },
        ],
      };
    }
    return { valid: true, errors: [] };
  }

  async validateInventoryPolicy(
    schemaRef: string,
    policy: InventoryPolicy,
  ): Promise<ValidationResult> {
    const schema = await this.get(schemaRef);
    if (!schema) {
      throw new NotFoundError(`Schema not found: ${schemaRef}`, { schemaRef });
    }
    const rules = schema.inventoryRules;
    if (!rules) return { valid: true, errors: [] };

    if (!rules.allowedPolicies.includes(policy)) {
      return {
        valid: false,
        errors: [
          {
            field: "inventoryPolicy",
            message: `Policy ${policy} is not allowed (allowed: ${rules.allowedPolicies.join(", ")})`,
          },
        ],
      };
    }
    return { valid: true, errors: [] };
  }

  private put(schema: SchemaData): void {
    const key = `${schema.domain}/${schema.name}:v${schema.version}`;
    this.schemas.set(key, schema);
    // Also register by id for direct lookup.
    this.schemas.set(schema.id, schema);
  }

  private async loadFromDirectory(dir: string): Promise<void> {
    const entries = await readdir(dir, { withFileTypes: true });
    for (const entry of entries) {
      if (entry.isDirectory()) {
        await this.loadFromDirectory(join(dir, entry.name));
      } else if (entry.isFile() && entry.name.endsWith(".json")) {
        const content = await readFile(join(dir, entry.name), "utf-8");
        const schema = JSON.parse(content) as SchemaData;
        this.put(schema);
      }
    }
  }
}
