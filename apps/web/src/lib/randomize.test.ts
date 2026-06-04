import { describe, it, expect } from "vitest";
import { randomModel } from "./randomize";
import { defaultModel } from "./wizard";
import { selectableServices } from "./services";

const SELECTABLE = selectableServices.map((s) => s.slug);
const BROKERS = ["nats", "kafka", "redis"];
const ORCH = ["docker-compose", "k8s-helm", "both"];
const CIS = ["github-actions", "none"];
const EMBEDS = ["submodule", "vendor"];

const assertValid = (m: ReturnType<typeof randomModel>) => {
  expect(m.services.length).toBeGreaterThan(0);
  expect(m.services).not.toContain("filing-core");
  for (const s of m.services) expect(SELECTABLE).toContain(s);
  expect(m.name).toBe(defaultModel.name);
  expect(m.db).toBe("postgres");
  expect(BROKERS).toContain(m.broker);
  expect(ORCH).toContain(m.orchestration);
  expect(CIS).toContain(m.ci);
  expect(EMBEDS).toContain(m.embed);
  expect(typeof m.gateway).toBe("boolean");
  expect(typeof m.observability).toBe("boolean");
};

describe("randomModel", () => {
  it("rand=()=>0 yields a valid model", () => assertValid(randomModel(() => 0)));
  it("rand=()=>0.999 yields a valid model", () => assertValid(randomModel(() => 0.999)));

  it("is deterministic for a fixed rand sequence", () => {
    const seq = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.05, 0.15, 0.25, 0.35, 0.45, 0.55, 0.65, 0.75, 0.85, 0.95];
    const mk = () => {
      let i = 0;
      return randomModel(() => seq[i++ % seq.length]);
    };
    expect(mk()).toEqual(mk());
  });

  it("produces valid models across many seeds", () => {
    for (let k = 0; k < 50; k++) {
      let i = 0;
      const r = () => ((i++ * 9301 + 49297 + k * 7) % 233280) / 233280;
      assertValid(randomModel(r));
    }
  });
});
