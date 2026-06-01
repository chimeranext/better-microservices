import { describe, expect, it } from "vitest";
import * as publicApi from "../src/index.js";

describe("marketplace-core public API smoke", () => {
  it("exports shared-kernel types and events", () => {
    expect(publicApi).toBeDefined();
    expect(Object.keys(publicApi).length).toBeGreaterThan(0);
  });
});
