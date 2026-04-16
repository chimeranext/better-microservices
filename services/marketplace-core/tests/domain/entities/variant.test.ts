import { describe, expect, it } from "vitest";
import { Variant } from "../../../src/domain/entities/variant.js";
import { createMoney } from "../../../src/domain/value-objects/money.js";
import { InvariantViolationError } from "../../../src/shared-kernel/errors.js";
import { InventoryPolicy } from "../../../src/shared-kernel/types.js";

const base = {
  productId: "p-1",
  sku: "LETTUCE-ORG-250G",
  price: createMoney("3.50", "USD"),
  inventoryPolicy: InventoryPolicy.TRACK,
};

describe("Variant.create", () => {
  it("creates with VariantCreated event queued", () => {
    const v = Variant.create(base);
    expect(v.id).toMatch(/^[0-9a-f-]{36}$/);
    expect(v.sku).toBe("LETTUCE-ORG-250G");
    expect(v.updatedAt).toBe(v.createdAt);
    const events = v.pullEvents();
    expect(events[0]?.eventType).toBe("VariantCreated");
  });

  it("rejects bad sku + empty productId", () => {
    expect(() => Variant.create({ ...base, sku: "bad sku" })).toThrow(InvariantViolationError);
    expect(() => Variant.create({ ...base, sku: "lower-case" })).toThrow(InvariantViolationError);
    expect(() => Variant.create({ ...base, productId: "   " })).toThrow(InvariantViolationError);
  });

  it("reprice + changePolicy update + touch updatedAt", async () => {
    const v = Variant.create(base);
    const before = v.updatedAt;
    await new Promise((r) => setTimeout(r, 2));
    v.reprice(createMoney("4.00", "USD"));
    expect(v.price.amount).toBe("4.00");
    expect(v.updatedAt).not.toBe(before);
    v.changePolicy(InventoryPolicy.SINGLE);
    expect(v.inventoryPolicy).toBe(InventoryPolicy.SINGLE);
  });

  it("restore + toData roundtrip; options exposed readonly", () => {
    const v = Variant.create({ ...base, options: { size: "large" } });
    expect(v.options).toEqual({ size: "large" });
    const data = v.toData();
    const restored = Variant.restore(data);
    expect(restored.toData()).toEqual(data);
    expect(restored.options).toEqual({ size: "large" });
  });
});
