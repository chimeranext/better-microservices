import { PROJECT_NAME_RE, type WizardModel } from "./wizard";

export function compileCommand(m: WizardModel): string {
  // Defense-in-depth: never interpolate an unsafe name into the copyable command.
  const safeName = PROJECT_NAME_RE.test(m.name) && m.name ? m.name : "my-startup";
  const parts = [`npx create-better-microservices ${safeName}`];
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
