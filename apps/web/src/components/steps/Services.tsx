import { services } from "@/lib/services";
import { dependencyHints } from "@/lib/deps";
import { Card, Checkbox, Badge } from "@/components/ui";
import type { WizardModel } from "@/lib/wizard";

export function StepServices({ model, patch, onViewReadme }: {
  model: WizardModel; patch: (p: Partial<WizardModel>) => void; onViewReadme: (slug: string) => void;
}) {
  const toggle = (slug: string) => patch({ services: model.services.includes(slug) ? model.services.filter((s) => s !== slug) : [...model.services, slug] });
  const hints = dependencyHints(model.services);
  return (
    <div>
      <div className="grid gap-3 sm:grid-cols-2">
        {services.map((s) => {
          const checked = model.services.includes(s.slug);
          return (
            <Card key={s.slug} className={`p-4 ${s.disabled ? "opacity-50" : ""}`}>
              <label className="flex items-start gap-3">
                <Checkbox checked={checked} disabled={!!s.disabled} onCheckedChange={() => !s.disabled && toggle(s.slug)} />
                <div className="flex-1">
                  <div className="flex items-center gap-2">
                    <span className="font-mono text-sm text-brand-tertiary">{s.slug}</span>
                    {s.disabled && <Badge variant="secondary">{s.disabled}</Badge>}
                  </div>
                  <p className="mt-1 text-sm text-muted-foreground">{s.blurb}</p>
                  {!s.disabled && (
                    <button type="button" onClick={() => onViewReadme(s.slug)} className="mt-2 text-xs text-brand-secondary hover:underline">View README</button>
                  )}
                </div>
              </label>
            </Card>
          );
        })}
      </div>
      {hints.map((h, i) => (
        <p key={i} className={`mt-3 text-sm ${h.level === "warn" ? "text-accent" : "text-brand-tertiary"}`}>⚠ {h.message}</p>
      ))}
    </div>
  );
}
