"use client";
import { Check } from "lucide-react";
import { cn } from "@/lib/utils";

export interface OptionCardProps {
  title: string;
  desc: string;
  selected: boolean;
  disabled?: string;
  onClick: () => void;
  onViewReadme?: () => void;
}

export function OptionCard({ title, desc, selected, disabled, onClick, onViewReadme }: OptionCardProps) {
  const isDisabled = !!disabled;
  const activate = () => {
    if (!isDisabled) onClick();
  };
  return (
    <div
      role="button"
      tabIndex={isDisabled ? -1 : 0}
      aria-pressed={selected}
      aria-disabled={isDisabled}
      onClick={activate}
      onKeyDown={(e) => {
        if (isDisabled) return;
        if (e.key === "Enter" || e.key === " ") {
          e.preventDefault();
          activate();
        }
      }}
      className={cn(
        "relative flex flex-col gap-1 rounded-lg border p-4 text-left transition-colors focus:outline-none focus-visible:ring-2 focus-visible:ring-ring",
        selected
          ? "border-brand-primary bg-brand-primary/5"
          : "border-border bg-card hover:border-brand-primary/50",
        isDisabled
          ? "cursor-not-allowed opacity-50"
          : "cursor-pointer",
      )}
    >
      {selected && !isDisabled && (
        <Check className="absolute right-3 top-3 h-4 w-4 text-brand-primary" aria-hidden />
      )}
      <div className="flex items-center gap-2 pr-6">
        <span className="font-semibold text-foreground">{title}</span>
        {disabled && (
          <span className="rounded-full border border-border px-2 py-0.5 font-mono text-[10px] uppercase text-muted-foreground">
            {disabled}
          </span>
        )}
      </div>
      <span className="text-sm text-muted-foreground">{desc}</span>
      {onViewReadme && !isDisabled && (
        <button
          type="button"
          onClick={(e) => {
            e.stopPropagation();
            onViewReadme();
          }}
          className="mt-2 w-fit text-xs text-brand-secondary hover:underline focus:outline-none focus-visible:ring-1 focus-visible:ring-ring"
        >
          View README
        </button>
      )}
    </div>
  );
}
