import { mkdir, mkdtemp, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { afterEach, beforeEach, describe, expect, it } from "vitest";
import { InMemorySchemaRegistry } from "../../../src/adapters/secondary/in-memory-schema-registry.js";
import type { SchemaData } from "../../../src/domain/ports/index.js";
import { NotFoundError } from "../../../src/shared-kernel/errors.js";
import { FulfillmentType, InventoryPolicy } from "../../../src/shared-kernel/types.js";

const baseSchema: SchemaData = {
  id: "schema-1",
  domain: "vertivo",
  name: "hortaliza",
  version: 1,
  jsonSchema: { type: "object" },
  requiredFields: ["harvestDate", "greenhouseId"],
};

describe("InMemorySchemaRegistry — seed + lookup", () => {
  it("fromSeed + get by ref + get by id", async () => {
    const registry = InMemorySchemaRegistry.fromSeed([baseSchema]);
    expect(await registry.get("vertivo/hortaliza:v1")).toEqual(baseSchema);
    expect(await registry.get("schema-1")).toEqual(baseSchema);
    expect(await registry.get("missing")).toBeNull();
  });

  it("list filters by domain", async () => {
    const a = { ...baseSchema, id: "a", domain: "vertivo" };
    const b = { ...baseSchema, id: "b", domain: "altrupets" };
    const registry = InMemorySchemaRegistry.fromSeed([a, b]);
    const all = await registry.list();
    expect(all.length).toBeGreaterThanOrEqual(2);
    const onlyVertivo = await registry.list("vertivo");
    expect(onlyVertivo.every((s) => s.domain === "vertivo")).toBe(true);
  });

  it("register + then get via returned id", async () => {
    const registry = new InMemorySchemaRegistry();
    const id = await registry.register(baseSchema);
    expect(id).toBe(baseSchema.id);
    expect(await registry.get("vertivo/hortaliza:v1")).toEqual(baseSchema);
  });
});

describe("InMemorySchemaRegistry — validate()", () => {
  it("passes when all required fields present", async () => {
    const registry = InMemorySchemaRegistry.fromSeed([baseSchema]);
    const result = await registry.validate("vertivo/hortaliza:v1", {
      harvestDate: "2026-04-15",
      greenhouseId: "gh-1",
    });
    expect(result).toEqual({ valid: true, errors: [] });
  });

  it("reports missing required fields", async () => {
    const registry = InMemorySchemaRegistry.fromSeed([baseSchema]);
    const result = await registry.validate("vertivo/hortaliza:v1", {
      harvestDate: "2026-04-15",
    });
    expect(result.valid).toBe(false);
    expect(result.errors).toEqual([{ field: "greenhouseId", message: "required field missing" }]);
  });

  it("throws NotFoundError for unknown schema ref", async () => {
    const registry = InMemorySchemaRegistry.fromSeed([]);
    await expect(registry.validate("missing", {})).rejects.toBeInstanceOf(NotFoundError);
  });
});

describe("InMemorySchemaRegistry — fulfillment rules", () => {
  const schemaWithRules: SchemaData = {
    ...baseSchema,
    fulfillmentRules: {
      allowed: [[FulfillmentType.PHYSICAL], [FulfillmentType.DIGITAL]],
      forbidden: [[FulfillmentType.PHYSICAL, FulfillmentType.DIGITAL]],
      defaults: [FulfillmentType.PHYSICAL],
    },
  };

  it("accepts a combination in allowed list", async () => {
    const registry = InMemorySchemaRegistry.fromSeed([schemaWithRules]);
    const result = await registry.validateFulfillmentTypes("vertivo/hortaliza:v1", [
      FulfillmentType.PHYSICAL,
    ]);
    expect(result.valid).toBe(true);
  });

  it("rejects a combination not in allowed", async () => {
    const registry = InMemorySchemaRegistry.fromSeed([schemaWithRules]);
    const result = await registry.validateFulfillmentTypes("vertivo/hortaliza:v1", [
      FulfillmentType.IN_PERSON,
    ]);
    expect(result.valid).toBe(false);
  });

  it("rejects an explicitly forbidden combination", async () => {
    const registry = InMemorySchemaRegistry.fromSeed([
      {
        ...baseSchema,
        fulfillmentRules: {
          allowed: [[FulfillmentType.PHYSICAL, FulfillmentType.DIGITAL]],
          forbidden: [[FulfillmentType.PHYSICAL, FulfillmentType.DIGITAL]],
          defaults: [],
        },
      },
    ]);
    const result = await registry.validateFulfillmentTypes("vertivo/hortaliza:v1", [
      FulfillmentType.PHYSICAL,
      FulfillmentType.DIGITAL,
    ]);
    expect(result.valid).toBe(false);
  });

  it("passes when schema has no rules", async () => {
    const registry = InMemorySchemaRegistry.fromSeed([baseSchema]);
    const result = await registry.validateFulfillmentTypes("vertivo/hortaliza:v1", [
      FulfillmentType.PHYSICAL,
    ]);
    expect(result.valid).toBe(true);
  });

  it("throws NotFoundError for unknown schema ref", async () => {
    const registry = InMemorySchemaRegistry.fromSeed([]);
    await expect(registry.validateFulfillmentTypes("missing", [])).rejects.toBeInstanceOf(
      NotFoundError,
    );
  });
});

describe("InMemorySchemaRegistry — inventory rules", () => {
  it("accepts allowed policy and rejects disallowed", async () => {
    const schema: SchemaData = {
      ...baseSchema,
      inventoryRules: {
        allowedPolicies: [InventoryPolicy.TRACK],
        defaultPolicy: InventoryPolicy.TRACK,
      },
    };
    const registry = InMemorySchemaRegistry.fromSeed([schema]);
    expect(
      (await registry.validateInventoryPolicy("vertivo/hortaliza:v1", InventoryPolicy.TRACK)).valid,
    ).toBe(true);
    const bad = await registry.validateInventoryPolicy(
      "vertivo/hortaliza:v1",
      InventoryPolicy.UNTRACK,
    );
    expect(bad.valid).toBe(false);
  });

  it("passes when schema has no inventory rules", async () => {
    const registry = InMemorySchemaRegistry.fromSeed([baseSchema]);
    expect(
      (await registry.validateInventoryPolicy("vertivo/hortaliza:v1", InventoryPolicy.TRACK)).valid,
    ).toBe(true);
  });

  it("throws NotFoundError for unknown schema ref", async () => {
    const registry = InMemorySchemaRegistry.fromSeed([]);
    await expect(
      registry.validateInventoryPolicy("missing", InventoryPolicy.TRACK),
    ).rejects.toBeInstanceOf(NotFoundError);
  });
});

describe("InMemorySchemaRegistry — fromDirectory", () => {
  let tempDir: string;

  beforeEach(async () => {
    tempDir = await mkdtemp(join(tmpdir(), "schema-registry-test-"));
  });
  afterEach(async () => {
    await rm(tempDir, { recursive: true, force: true });
  });

  it("loads .json files recursively", async () => {
    const nested = join(tempDir, "vertivo");
    await mkdir(nested, { recursive: true });
    await writeFile(
      join(nested, "hortaliza.v1.json"),
      JSON.stringify({ ...baseSchema, id: "from-file" }),
    );
    await writeFile(join(tempDir, "ignored.txt"), "not a schema");

    const registry = await InMemorySchemaRegistry.fromDirectory(tempDir);
    expect(await registry.get("from-file")).not.toBeNull();
  });
});
