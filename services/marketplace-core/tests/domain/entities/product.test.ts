import { describe, expect, it } from "vitest";
import { Product } from "../../../src/domain/entities/product.js";
import { InvariantViolationError } from "../../../src/shared-kernel/errors.js";
import { ProductStatus } from "../../../src/shared-kernel/types.js";

const baseInput = {
  vendorId: "v-1",
  title: "Organic lettuce",
  description: "Fresh hydroponic lettuce",
  slug: "organic-lettuce",
  productType: "hortaliza",
  schemaRef: "schema://vertivo/hortaliza:v1",
};

describe("Product.create", () => {
  it("creates a DRAFT product with generated id + timestamps", () => {
    const p = Product.create(baseInput);
    expect(p.id).toMatch(/^[0-9a-f-]{36}$/);
    expect(p.status).toBe(ProductStatus.DRAFT);
    expect(p.createdAt).toEqual(p.updatedAt);
    expect(p.tags).toEqual([]);
    expect(p.attributes).toEqual({});
  });

  it("applies optional tags/attributes/geo", () => {
    const p = Product.create({
      ...baseInput,
      tags: ["fresh", "local"],
      attributes: { harvestDate: "2026-04-15" },
    });
    expect(p.tags).toEqual(["fresh", "local"]);
    expect(p.attributes).toEqual({ harvestDate: "2026-04-15" });
  });

  it("rejects empty title, overlong title, invalid slug", () => {
    expect(() => Product.create({ ...baseInput, title: "" })).toThrow(InvariantViolationError);
    expect(() => Product.create({ ...baseInput, title: "x".repeat(201) })).toThrow(
      InvariantViolationError,
    );
    expect(() => Product.create({ ...baseInput, slug: "Bad Slug" })).toThrow(
      InvariantViolationError,
    );
    expect(() => Product.create({ ...baseInput, slug: "bad_slug" })).toThrow(
      InvariantViolationError,
    );
    expect(() => Product.create({ ...baseInput, vendorId: "   " })).toThrow(
      InvariantViolationError,
    );
    expect(() => Product.create({ ...baseInput, productType: "" })).toThrow(
      InvariantViolationError,
    );
    expect(() => Product.create({ ...baseInput, schemaRef: "" })).toThrow(InvariantViolationError);
    expect(() => Product.create({ ...baseInput, description: "x".repeat(5001) })).toThrow(
      InvariantViolationError,
    );
  });
});

describe("Product lifecycle", () => {
  it("rename validates + touches updatedAt", async () => {
    const p = Product.create(baseInput);
    const before = p.updatedAt;
    await new Promise((r) => setTimeout(r, 2));
    p.rename("Organic Lettuce (v2)");
    expect(p.title).toBe("Organic Lettuce (v2)");
    expect(p.updatedAt).not.toBe(before);
    expect(() => p.rename("")).toThrow(InvariantViolationError);
    p.rename("Organic Lettuce (v2)"); // same value → no-op
    expect(p.title).toBe("Organic Lettuce (v2)");
  });

  it("describe updates description + is no-op on same value", () => {
    const p = Product.create(baseInput);
    p.describe("Updated description");
    expect(p.description).toBe("Updated description");
    p.describe("Updated description"); // no-op
    expect(p.description).toBe("Updated description");
    expect(() => p.describe("x".repeat(5001))).toThrow(InvariantViolationError);
  });

  it("activate DRAFT → ACTIVE emits ProductListed; repeat is no-op", () => {
    const p = Product.create(baseInput);
    p.activate();
    expect(p.status).toBe(ProductStatus.ACTIVE);
    const events = p.pullEvents();
    expect(events.length).toBe(1);
    expect(events[0]?.eventType).toBe("ProductListed");
    p.activate();
    expect(p.pullEvents()).toEqual([]);
  });

  it("cannot activate an archived product", () => {
    const p = Product.create(baseInput);
    p.archive("duplicate");
    expect(() => p.activate()).toThrow(InvariantViolationError);
  });

  it("archive emits ProductArchived; rejects empty reason; repeat is no-op", () => {
    const p = Product.create(baseInput);
    p.archive("discontinued");
    expect(p.status).toBe(ProductStatus.ARCHIVED);
    const events = p.pullEvents();
    expect(events[0]?.eventType).toBe("ProductArchived");
    expect(() => p.archive("")).toThrow(InvariantViolationError);
    p.archive("again"); // no-op because already archived
    expect(p.pullEvents()).toEqual([]);
  });

  it("replaceTags, setAttribute, relocate all touch updatedAt", () => {
    const p = Product.create(baseInput);
    p.replaceTags(["hola", "chau"]);
    expect(p.tags).toEqual(["hola", "chau"]);
    p.setAttribute("ph", 6.2);
    expect(p.attributes).toEqual({ ph: 6.2 });
    expect(() => p.setAttribute("", 1)).toThrow(InvariantViolationError);
    p.relocate(undefined);
    expect(p.geo).toBeUndefined();
  });
});

describe("Product.restore + toData", () => {
  it("roundtrips ProductData", () => {
    const p = Product.create(baseInput);
    p.rename("New name");
    p.replaceTags(["a"]);
    const data = p.toData();
    const restored = Product.restore(data);
    expect(restored.toData()).toEqual(data);
    expect(restored.title).toBe("New name");
  });
});
