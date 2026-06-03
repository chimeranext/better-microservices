"use client";
import { useState } from "react";
import { Check, Copy, X } from "lucide-react";
import { Button } from "@/components/ui";
import { categories } from "@/lib/categories";
import { compileCommand } from "@/lib/command";
import { defaultModel, sanitizeProjectName, type WizardModel } from "@/lib/wizard";

export interface BuilderSidebarProps {
  model: WizardModel;
  patch: (p: Partial<WizardModel>) => void;
  onRandomize: () => void;
  onReset: () => void;
  onShare: () => void;
}

interface Chip {
  key: string;
  label: string;
  remove: () => void;
}

export function BuilderSidebar({ model, patch, onRandomize, onReset, onShare }: BuilderSidebarProps) {
  const [copied, setCopied] = useState(false);
  const [shared, setShared] = useState(false);
  const command = compileCommand(model);

  const copyCommand = async () => {
    await navigator.clipboard.writeText(command);
    setCopied(true);
    setTimeout(() => setCopied(false), 1500);
  };

  const share = () => {
    onShare();
    setShared(true);
    setTimeout(() => setShared(false), 1500);
  };

  // Build per-category chip groups and the total selected count.
  let pickCount = 0;
  const groups = categories.map((cat) => {
    const selected = cat.options.filter((o) => o.isSelected(model));
    pickCount += selected.length;
    const chips: Chip[] = selected.map((opt) => {
      if (cat.mode === "multi") {
        return {
          key: cat.id + ":" + opt.value,
          label: opt.label,
          remove: () => {
            // services must keep at least one selection.
            if (cat.id === "services" && model.services.length <= 1) return;
            patch(opt.apply(model)); // toggle off
          },
        };
      }
      // single: removing resets this axis to the default model's value.
      const def = cat.options.find((o) => o.isSelected(defaultModel));
      return {
        key: cat.id + ":" + opt.value,
        label: opt.label,
        remove: () => {
          if (def) patch(def.apply(model));
        },
      };
    });
    return { id: cat.id, label: cat.label, chips };
  });

  return (
    <aside className="space-y-6 lg:sticky lg:top-6 lg:h-fit">
      <div className="space-y-2">
        <label
          htmlFor="project-name"
          className="block font-mono text-xs font-semibold uppercase tracking-wide text-muted-foreground"
        >
          Project name
        </label>
        <input
          id="project-name"
          data-testid="project-name"
          value={model.name}
          onChange={(e) => patch({ name: sanitizeProjectName(e.target.value) })}
          placeholder="my-startup"
          className="block w-full rounded-md border border-border bg-background px-3 py-2 font-mono text-sm text-foreground focus:outline-none focus:ring-2 focus:ring-ring"
        />
      </div>

      <div className="space-y-2">
        <span className="block font-mono text-xs font-semibold uppercase tracking-wide text-muted-foreground">
          CLI command
        </span>
        <div className="flex items-start gap-2">
          <code
            data-testid="command"
            className="flex-1 overflow-x-auto whitespace-pre-wrap break-all rounded-md border border-border bg-muted p-3 font-mono text-xs text-foreground"
          >
            {command}
          </code>
          <Button
            size="sm"
            variant="secondary"
            aria-label="Copy command"
            data-testid="copy-command"
            onClick={copyCommand}
          >
            {copied ? <Check className="h-4 w-4" /> : <Copy className="h-4 w-4" />}
          </Button>
        </div>
      </div>

      <div className="space-y-3">
        <div className="flex items-baseline justify-between">
          <span className="font-mono text-xs font-semibold uppercase tracking-wide text-muted-foreground">
            Selected stack
          </span>
          <span className="font-mono text-xs text-brand-tertiary">{pickCount} picks</span>
        </div>
        <div className="space-y-2">
          {groups.map((g) => (
            <div key={g.id} className="space-y-1">
              <span className="font-mono text-[10px] uppercase text-muted-foreground">
                {g.label}
              </span>
              <div className="flex flex-wrap gap-1.5">
                {g.chips.map((chip) => (
                  <span
                    key={chip.key}
                    className="inline-flex items-center gap-1 rounded-full border border-border bg-card px-2 py-0.5 text-xs text-foreground"
                  >
                    {chip.label}
                    <button
                      type="button"
                      aria-label={`Remove ${chip.label}`}
                      onClick={chip.remove}
                      className="rounded-full text-muted-foreground hover:text-foreground focus:outline-none focus-visible:ring-1 focus-visible:ring-ring"
                    >
                      <X className="h-3 w-3" />
                    </button>
                  </span>
                ))}
              </div>
            </div>
          ))}
        </div>
      </div>

      <div className="space-y-2">
        <span className="block font-mono text-xs font-semibold uppercase tracking-wide text-muted-foreground">
          Actions
        </span>
        <div className="flex flex-wrap gap-2">
          <Button
            variant="ghost"
            onClick={onRandomize}
            className="bg-brand-gradient text-white shadow hover:opacity-90 hover:bg-brand-gradient"
          >
            Randomize
          </Button>
          <Button variant="secondary" onClick={onReset}>
            Reset
          </Button>
          <Button variant="secondary" onClick={share}>
            {shared ? "Copied!" : "Share"}
          </Button>
        </div>
      </div>
    </aside>
  );
}
