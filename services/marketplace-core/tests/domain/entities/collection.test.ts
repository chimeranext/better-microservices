import { describe, expect, it } from "vitest";
import { Collection } from "../../../src/domain/entities/collection.js";
import { InvariantViolationError } from "../../../src/shared-kernel/errors.js";
import { CollectionType } from "../../../src/shared-kernel/types.js";

const baseManual = {
  vendorId: "v-1",
  title: "Hortalizas de temporada",
  slug: "temporada",
  type: CollectionType.MANUAL,
};

const baseSmart = {
  ...baseManual,
  slug: "smart",
  type: CollectionType.SMART,
};

describe("Collection.create", () => {
  it("creates MANUAL with empty productIds by default", () => {
    const c = Collection.create(baseManual);
    expect(c.productIds).toEqual([]);
    expect(c.updatedAt).toBe(c.createdAt);
  });

  it("SMART rejects explicit productIds at creation", () => {
    expect(() => Collection.create({ ...baseSmart, productIds: ["p-1"] })).toThrow(
      InvariantViolationError,
    );
    const c = Collection.create(baseSmart);
    expect(c.productIds).toEqual([]);
  });

  it("rejects empty vendorId, title, bad slug", () => {
    expect(() => Collection.create({ ...baseManual, vendorId: "" })).toThrow(
      InvariantViolationError,
    );
    expect(() => Collection.create({ ...baseManual, title: "" })).toThrow(InvariantViolationError);
    expect(() => Collection.create({ ...baseManual, slug: "BAD slug" })).toThrow(
      InvariantViolationError,
    );
  });
});

describe("Collection membership", () => {
  it("MANUAL addProduct is idempotent", () => {
    const c = Collection.create(baseManual);
    c.addProduct("p-1");
    c.addProduct("p-1");
    c.addProduct("p-2");
    expect(c.productIds).toEqual(["p-1", "p-2"]);
  });

  it("MANUAL removeProduct is idempotent", () => {
    const c = Collection.create({ ...baseManual, productIds: ["p-1", "p-2"] });
    c.removeProduct("p-1");
    c.removeProduct("p-1");
    expect(c.productIds).toEqual(["p-2"]);
  });

  it("addProduct rejects empty id", () => {
    const c = Collection.create(baseManual);
    expect(() => c.addProduct("")).toThrow(InvariantViolationError);
  });

  it("SMART forbids addProduct + removeProduct", () => {
    const c = Collection.create(baseSmart);
    expect(() => c.addProduct("p-1")).toThrow(InvariantViolationError);
    expect(() => c.removeProduct("p-1")).toThrow(InvariantViolationError);
  });
});

describe("Collection rename/describe + restore", () => {
  it("rename validates", () => {
    const c = Collection.create(baseManual);
    c.rename("Nueva temporada");
    expect(c.title).toBe("Nueva temporada");
    expect(() => c.rename("")).toThrow(InvariantViolationError);
  });

  it("describe updates freely", () => {
    const c = Collection.create(baseManual);
    c.describe("Descripción");
    expect(c.description).toBe("Descripción");
  });

  it("restore + toData roundtrip", () => {
    const c = Collection.create(baseManual);
    c.addProduct("p-1");
    const data = c.toData();
    expect(Collection.restore(data).toData()).toEqual(data);
  });
});
