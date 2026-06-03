import { describe, it, expect } from "vitest";
import { encodeState, decodeState } from "./url-state";
import { defaultModel, type WizardModel } from "./wizard";

describe("url-state", () => {
  it("round-trips a model through the query string", () => {
    const model: WizardModel = { ...defaultModel, name: "acme", services: ["payments-core","marketplace-core"], broker: "kafka", gateway: true, addons: ["pre-commit"], embed: "vendor" };
    const decoded = decodeState(new URLSearchParams(encodeState(model)));
    expect(decoded).toEqual(model);
  });
  it("falls back to defaults for missing/invalid params", () => {
    const decoded = decodeState(new URLSearchParams("broker=not-a-broker"));
    expect(decoded.broker).toBe(defaultModel.broker);
    expect(decoded.name).toBe(defaultModel.name);
  });
  it("omits default values from the encoded string (short URLs)", () => {
    expect(encodeState(defaultModel)).toBe("");
  });
  it("rejects a malicious project name and falls back to the default", () => {
    // ?name=x%3B%20rm%20-rf%20~  →  "x; rm -rf ~"
    const decoded = decodeState(new URLSearchParams("name=x%3B%20rm%20-rf%20~"));
    expect(decoded.name).toBe(defaultModel.name);
  });
});
