import { describe, it, expect } from "vitest";
import { dependencyHints } from "./deps";

describe("dependencyHints", () => {
  it("warns when marketplace-core is selected without payments-core", () => {
    const hints = dependencyHints(["marketplace-core"]);
    expect(hints).toContainEqual({ level: "warn", service: "marketplace-core", message: expect.stringContaining("payments-core") });
  });
  it("suggests payments-core when agentic-core is selected without it", () => {
    const hints = dependencyHints(["agentic-core"]);
    expect(hints).toContainEqual({ level: "suggest", service: "agentic-core", message: expect.stringContaining("payments-core") });
  });
  it("is silent when payments-core is present", () => {
    expect(dependencyHints(["marketplace-core","agentic-core","payments-core"])).toEqual([]);
  });
});
