import { describe, it, expect } from "vitest";
import { categories, type Category } from "./categories";
import { defaultModel, type WizardModel } from "./wizard";
import { services } from "./services";

const byId = (id: string): Category => {
  const c = categories.find((c) => c.id === id);
  if (!c) throw new Error(`category ${id} not found`);
  return c;
};

describe("categories", () => {
  it("every category has at least one option", () => {
    expect(categories.length).toBeGreaterThan(0);
    for (const c of categories) expect(c.options.length).toBeGreaterThan(0);
  });

  it("covers each WizardModel axis as a category", () => {
    const ids = categories.map((c) => c.id);
    expect(ids).toEqual([
      "services", "database", "broker", "orchestration",
      "gateway", "observability", "ci", "addons", "embed",
    ]);
  });

  it("services category carries disabled:'2027' for filing-core and never applies it", () => {
    const cat = byId("services");
    const filing = cat.options.find((o) => o.value === "filing-core");
    expect(filing).toBeDefined();
    expect(filing!.disabled).toBe("2027");
    // applying a disabled option must not add it to the model
    const applied = { ...defaultModel, ...filing!.apply(defaultModel) };
    expect(applied.services).not.toContain("filing-core");
  });

  it("services option for each service exists; selectable ones toggle", () => {
    const cat = byId("services");
    for (const s of services) {
      const opt = cat.options.find((o) => o.value === s.slug);
      expect(opt, `option for ${s.slug}`).toBeDefined();
    }
    // payments-core is selected in default model
    const payments = cat.options.find((o) => o.value === "payments-core")!;
    expect(payments.isSelected(defaultModel)).toBe(true);
    // toggling it off removes it
    const off = { ...defaultModel, ...payments.apply(defaultModel) };
    expect(off.services).not.toContain("payments-core");
    // toggling on a non-default selectable adds it
    const compliance = cat.options.find((o) => o.value === "compliance-core")!;
    expect(compliance.isSelected(defaultModel)).toBe(false);
    const on = { ...defaultModel, ...compliance.apply(defaultModel) };
    expect(on.services).toContain("compliance-core");
  });

  it("each single category has exactly one selected option for the default model", () => {
    for (const c of categories.filter((c) => c.mode === "single")) {
      const selected = c.options.filter((o) => o.isSelected(defaultModel));
      expect(selected.length, `single category ${c.id}`).toBe(1);
    }
  });

  it("apply round-trips: applying an option makes it selected", () => {
    for (const c of categories.filter((c) => c.mode === "single")) {
      for (const o of c.options) {
        const m: WizardModel = { ...defaultModel, ...o.apply(defaultModel) };
        expect(o.isSelected(m), `${c.id}/${o.value}`).toBe(true);
      }
    }
  });

  it("gateway on/off map to the boolean correctly", () => {
    const cat = byId("gateway");
    const on = cat.options.find((o) => o.value === "on")!;
    const off = cat.options.find((o) => o.value === "off")!;
    expect(off.isSelected(defaultModel)).toBe(true); // default gateway=false
    const enabled = { ...defaultModel, ...on.apply(defaultModel) };
    expect(enabled.gateway).toBe(true);
    expect(on.isSelected(enabled)).toBe(true);
    const disabled = { ...enabled, ...off.apply(enabled) };
    expect(disabled.gateway).toBe(false);
    expect(off.isSelected(disabled)).toBe(true);
  });

  it("observability on/off map to the boolean correctly", () => {
    const cat = byId("observability");
    const on = cat.options.find((o) => o.isSelected({ ...defaultModel, observability: true }))!;
    const enabled = { ...defaultModel, ...on.apply(defaultModel) };
    expect(enabled.observability).toBe(true);
  });
});
