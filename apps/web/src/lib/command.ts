import type { WizardModel } from "./wizard";

export function compileCommand(m: WizardModel): string {
  const parts = [`npx create-better-microservices ${m.name || "my-startup"}`];
  parts.push(`--services ${[...m.services].sort().join(",") || "payments-core"}`);
  parts.push(`--db ${m.db}`);
  parts.push(`--broker ${m.broker}`);
  parts.push(`--orchestration ${m.orchestration}`);
  if (m.gateway) parts.push("--gateway");
  if (m.observability) parts.push("--observability");
  parts.push(`--ci ${m.ci}`);
  if (m.addons.length) parts.push(`--addons ${m.addons.join(",")}`);
  if (m.embed !== "submodule") parts.push(`--embed ${m.embed}`);
  return parts.join(" ");
}
