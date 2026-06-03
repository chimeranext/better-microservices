import { Switch, Checkbox } from "@/components/ui";
import { ADDONS, type WizardModel, type Addon, type Ci } from "@/lib/wizard";

export function StepAddons({ model, patch }: { model: WizardModel; patch: (p: Partial<WizardModel>) => void }) {
  const toggleAddon = (a: Addon) => patch({ addons: model.addons.includes(a) ? model.addons.filter((x) => x !== a) : [...model.addons, a] });
  return (
    <div className="space-y-6">
      <label className="flex items-center gap-3 text-sm"><Switch checked={model.observability} onCheckedChange={(v) => patch({ observability: v })} /> Observability (OTel + Grafana/Prometheus)</label>
      <label className="flex items-center gap-3 text-sm"><Switch checked={model.ci === "github-actions"} onCheckedChange={(v) => patch({ ci: (v ? "github-actions" : "none") as Ci })} /> CI (GitHub Actions)</label>
      <div>
        <p className="mb-2 text-sm font-semibold">Addons</p>
        {ADDONS.map((a) => (
          <label key={a} className="mr-4 inline-flex items-center gap-2 text-sm"><Checkbox checked={model.addons.includes(a)} onCheckedChange={() => toggleAddon(a)} />{a}</label>
        ))}
      </div>
    </div>
  );
}
