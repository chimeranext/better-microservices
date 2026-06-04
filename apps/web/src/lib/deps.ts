export interface Hint { level: "warn" | "suggest"; service: string; message: string; }

export function dependencyHints(selected: string[]): Hint[] {
  const has = (s: string) => selected.includes(s);
  const hints: Hint[] = [];
  if (has("marketplace-core") && !has("payments-core"))
    hints.push({ level: "warn", service: "marketplace-core", message: "marketplace-core emits purchase events but lacks settlement — add payments-core." });
  if (has("agentic-core") && !has("payments-core"))
    hints.push({ level: "suggest", service: "agentic-core", message: "agentic-core checkout flows usually need payments-core." });
  return hints;
}
