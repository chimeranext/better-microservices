import { RadioGroup, RadioGroupItem, Switch } from "@/components/ui";
import type { WizardModel, Broker, Orchestration } from "@/lib/wizard";

const BROKERS: Broker[] = ["nats", "kafka", "redis"];
const ORCH: Orchestration[] = ["docker-compose", "k8s-helm", "both"];

export function StepInfra({ model, patch }: { model: WizardModel; patch: (p: Partial<WizardModel>) => void }) {
  return (
    <div className="space-y-6">
      <div>
        <p className="mb-2 text-sm font-semibold">Event bus broker</p>
        <RadioGroup value={model.broker} onValueChange={(v) => patch({ broker: v as Broker })} className="flex gap-4">
          {BROKERS.map((b) => <label key={b} className="flex items-center gap-2 text-sm"><RadioGroupItem value={b} />{b}</label>)}
        </RadioGroup>
      </div>
      <div>
        <p className="mb-2 text-sm font-semibold">Orchestration</p>
        <RadioGroup value={model.orchestration} onValueChange={(v) => patch({ orchestration: v as Orchestration })} className="flex gap-4">
          {ORCH.map((o) => <label key={o} className="flex items-center gap-2 text-sm"><RadioGroupItem value={o} />{o}</label>)}
        </RadioGroup>
      </div>
      <label className="flex items-center gap-3 text-sm"><Switch checked={model.gateway} onCheckedChange={(v) => patch({ gateway: v })} /> API Gateway</label>
      <p className="text-xs text-muted-foreground">Database: postgres (default)</p>
    </div>
  );
}
