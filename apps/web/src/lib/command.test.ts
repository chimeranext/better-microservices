import { describe, it, expect } from "vitest";
import { compileCommand } from "./command";
import { defaultModel } from "./wizard";

describe("compileCommand", () => {
  it("emits the base command with name + required flags, omitting defaults", () => {
    expect(compileCommand(defaultModel)).toBe(
      "npx create-better-microservices my-startup --services payments-core --db postgres --broker nats --orchestration docker-compose --ci github-actions"
    );
  });
  it("includes boolean flags only when true, and csv addons", () => {
    const cmd = compileCommand({ ...defaultModel, services: ["marketplace-core","payments-core"], gateway: true, observability: true, addons: ["pre-commit","dockerfiles"] });
    expect(cmd).toContain("--services marketplace-core,payments-core");
    expect(cmd).toContain("--gateway");
    expect(cmd).toContain("--observability");
    expect(cmd).toContain("--addons pre-commit,dockerfiles");
  });
  it("emits --embed only when vendor (submodule is default), and --ci none", () => {
    const cmd = compileCommand({ ...defaultModel, embed: "vendor", ci: "none" });
    expect(cmd).toContain("--embed vendor");
    expect(cmd).toContain("--ci none");
  });
  it("does not emit --embed for the submodule default", () => {
    expect(compileCommand(defaultModel)).not.toContain("--embed");
  });
});
