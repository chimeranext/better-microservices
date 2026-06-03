"use client";
import { useState } from "react";
import { Button } from "@/components/ui";
import { Check, Copy } from "lucide-react";
export function CommandBar({ command }: { command: string }) {
  const [copied, setCopied] = useState(false);
  const copy = async () => { await navigator.clipboard.writeText(command); setCopied(true); setTimeout(() => setCopied(false), 1500); };
  return (
    <div className="sticky bottom-4 flex items-center gap-3 rounded-lg border border-border bg-background/90 p-3 backdrop-blur">
      <code data-testid="command" className="flex-1 overflow-x-auto whitespace-nowrap font-mono text-xs text-foreground">{command}</code>
      <Button size="sm" onClick={copy}>{copied ? <Check className="h-4 w-4" /> : <Copy className="h-4 w-4" />}</Button>
    </div>
  );
}
