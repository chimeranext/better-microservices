"use client";
import { useEffect, useState } from "react";
import { defaultModel, type WizardModel } from "@/lib/wizard";
import { decodeState, encodeState } from "@/lib/url-state";
import { Button } from "@/components/ui";

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
        {step === 0 && <p className="text-muted-foreground">Services step (Task 10)</p>}
        {step === 1 && <p className="text-muted-foreground">Infra step (Task 11)</p>}
        {step === 2 && <p className="text-muted-foreground">Addons step (Task 11)</p>}
        {step === 3 && <p className="text-muted-foreground">Review step (Task 12)</p>}
      </div>
      <div className="mt-6 flex justify-between">
        <Button variant="secondary" disabled={step === 0} onClick={() => setStep((s) => s - 1)}>Back</Button>
        <Button disabled={step === STEPS.length - 1} onClick={() => setStep((s) => s + 1)}>Next</Button>
      </div>
    </section>
  );
}
