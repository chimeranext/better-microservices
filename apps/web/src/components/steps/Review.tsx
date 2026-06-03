import { compileCommand } from "@/lib/command";
import { CommandBar } from "@/components/CommandBar";
import type { WizardModel } from "@/lib/wizard";

export function StepReview({ model }: { model: WizardModel }) {
  const tree = [
    `${model.name}/`,
    "  services/", ...model.services.map((s) => `    ${s}/  (submodule)`),
    model.gateway ? "  apps/gateway/" : "",
    "  packages/common/",
    model.orchestration !== "k8s-helm" ? "  docker-compose.yml" : "",
    model.orchestration !== "docker-compose" ? "  helm/" : "",
    "  turbo.json  pnpm-workspace.yaml",
  ].filter(Boolean).join("\n");
  return (
    <div className="space-y-4">
      <CommandBar command={compileCommand(model)} />
      <pre className="overflow-x-auto rounded-lg border border-border bg-muted p-4 font-mono text-xs text-muted-foreground">{tree}</pre>
      <p className="text-sm text-muted-foreground">Docs for your picks: {model.services.map((s) => (
        <a key={s} className="mr-3 text-brand-secondary hover:underline" href={`https://chimeranext.github.io/better-microservices/${s}/`}>{s} ↗</a>
      ))}</p>
    </div>
  );
}
