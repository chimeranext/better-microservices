import { describe, expect, it } from "vitest";
import { Storefront } from "../../../src/domain/entities/storefront.js";
import { InvariantViolationError } from "../../../src/shared-kernel/errors.js";

const base = {
  vendorId: "v-1",
  slug: "vertivo-store",
  name: "Vertivo Tienda",
  schemaRef: "schema://vertivo/hortalizas:v1",
};

describe("Storefront.create", () => {
  it("creates unpublished with default locale + empty theme", () => {
    const s = Storefront.create(base);
    expect(s.published).toBe(false);
    expect(s.locale).toBe("en");
    expect(s.theme).toEqual({});
    expect(s.updatedAt).toBe(s.createdAt);
  });

  it("accepts provided locale and theme", () => {
    const s = Storefront.create({ ...base, locale: "es", theme: { primary: "#0f0" } });
    expect(s.locale).toBe("es");
    expect(s.theme).toEqual({ primary: "#0f0" });
  });

  it("rejects empty vendorId / bad slug / empty name / empty schemaRef", () => {
    expect(() => Storefront.create({ ...base, vendorId: "" })).toThrow(InvariantViolationError);
    expect(() => Storefront.create({ ...base, slug: "BAD" })).toThrow(InvariantViolationError);
    expect(() => Storefront.create({ ...base, name: "" })).toThrow(InvariantViolationError);
    expect(() => Storefront.create({ ...base, schemaRef: "" })).toThrow(InvariantViolationError);
  });
});

describe("Storefront mutators", () => {
  it("rename + changeSchema + updateTheme + setLocale validate inputs", () => {
    const s = Storefront.create(base);
    s.rename("Nueva tienda");
    expect(s.name).toBe("Nueva tienda");
    expect(() => s.rename("")).toThrow(InvariantViolationError);

    s.changeSchema("schema://vertivo/hortalizas:v2");
    expect(s.schemaRef).toBe("schema://vertivo/hortalizas:v2");
    expect(() => s.changeSchema("")).toThrow(InvariantViolationError);

    s.updateTheme({ primary: "#000" });
    expect(s.theme).toEqual({ primary: "#000" });

    s.setLocale("es");
    expect(s.locale).toBe("es");
    expect(() => s.setLocale("")).toThrow(InvariantViolationError);
  });

  it("publish + unpublish are idempotent", () => {
    const s = Storefront.create(base);
    s.publish();
    s.publish();
    expect(s.published).toBe(true);
    s.unpublish();
    s.unpublish();
    expect(s.published).toBe(false);
  });

  it("restore + toData roundtrip", () => {
    const s = Storefront.create(base);
    s.publish();
    s.updateTheme({ x: 1 });
    const data = s.toData();
    expect(Storefront.restore(data).toData()).toEqual(data);
  });
});
