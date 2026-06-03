"use client";
import type { Category } from "@/lib/categories";
import type { WizardModel } from "@/lib/wizard";
import { dependencyHints } from "@/lib/deps";
import { OptionCard } from "./OptionCard";

export interface CategorySectionProps {
  category: Category;
  model: WizardModel;
  patch: (p: Partial<WizardModel>) => void;
}

export function CategorySection({ category, model, patch }: CategorySectionProps) {
  const hints = category.id === "services" ? dependencyHints(model.services) : [];
  return (
    <section className="space-y-3">
      <h3 className="font-mono text-sm uppercase tracking-wide text-brand-tertiary">
        ›_ {category.label}
      </h3>
      <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
        {category.options.map((opt) => (
          <OptionCard
            key={opt.value}
            title={opt.label}
            desc={opt.desc}
            selected={opt.isSelected(model)}
            disabled={opt.disabled}
            onClick={() => patch(opt.apply(model))}
          />
        ))}
      </div>
      {hints.length > 0 && (
        <ul className="space-y-1 text-sm">
          {hints.map((h) => (
            <li
              key={h.service + h.message}
              className={h.level === "warn" ? "text-warning" : "text-brand-tertiary"}
            >
              {h.level === "warn" ? "⚠ " : "→ "}
              {h.message}
            </li>
          ))}
        </ul>
      )}
    </section>
  );
}
