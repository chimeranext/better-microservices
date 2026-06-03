"use client";
import { useEffect, useState } from "react";
import { defaultModel, type WizardModel } from "@/lib/wizard";
import { decodeState, encodeState } from "@/lib/url-state";
import { Button } from "@/components/ui";
import { StepServices } from "@/components/steps/Services";
import { StepInfra } from "@/components/steps/Infra";
import { StepAddons } from "@/components/steps/Addons";
import { StepReview } from "@/components/steps/Review";

const STEPS = ["Services", "Infra", "Addons", "Review"] as const;

export function Wizard() {
  const [model, setModel] = useState<WizardModel>(defaultModel);
  const [step, setStep] = useState(0);

  useEffect(() => { setModel(decodeState(new URLSearchParams(window.location.search))); }, []);
  useEffect(() => {
    const qs = encodeState(model);
    const url = qs ? `?${qs}` : window.location.pathname;
    window.history.replaceState(null, "", url);
  }, [model]);

  const patch = (p: Partial<WizardModel>) => setModel((m) => ({ ...m, ...p }));

  return (
    <section id="configure" className="my-12 rounded-2xl border border-border bg-card p-6">
      <ol className="mb-6 flex gap-2 text-sm">
        {STEPS.map((s, i) => (
          <li key={s} className={i === step ? "font-semibold text-brand-secondary" : "text-muted-foreground"}>
            {i + 1}. {s}{i < STEPS.length - 1 ? " →" : ""}
          </li>
        ))}
      </ol>
      <div data-testid="wizard-body">
        {/* Step bodies are added in Tasks 10–12; render placeholders keyed by step for now */}
        {step === 0 && <StepServices model={model} patch={patch} onViewReadme={() => {}} />}
        {step === 1 && <StepInfra model={model} patch={patch} />}
        {step === 2 && <StepAddons model={model} patch={patch} />}
        {step === 3 && <StepReview model={model} />}
      </div>
      <div className="mt-6 flex justify-between">
        <Button variant="secondary" disabled={step === 0} onClick={() => setStep((s) => s - 1)}>Back</Button>
        <Button disabled={step === STEPS.length - 1} onClick={() => setStep((s) => s + 1)}>Next</Button>
      </div>
    </section>
  );
}
