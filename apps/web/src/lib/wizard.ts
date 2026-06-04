export type Broker = "nats" | "kafka" | "redis";
export type Orchestration = "docker-compose" | "k8s-helm" | "both";
export type Ci = "github-actions" | "none";
export type Embed = "submodule" | "vendor";
export const ADDONS = ["pre-commit", "dockerfiles", "env-example"] as const;
export type Addon = (typeof ADDONS)[number];

export interface WizardModel {
  name: string;
  services: string[];
  db: "postgres";
  broker: Broker;
  orchestration: Orchestration;
  gateway: boolean;
  observability: boolean;
  ci: Ci;
  addons: Addon[];
  embed: Embed;
}

export const defaultModel: WizardModel = {
  name: "my-startup", services: ["payments-core"], db: "postgres", broker: "nats",
  orchestration: "docker-compose", gateway: false, observability: false,
  ci: "github-actions", addons: [], embed: "submodule",
};

// Canonical rule for a safe project name: starts alphanumeric, then
// alphanumerics / dot / underscore / hyphen, max 64 chars. This is the
// charset that is safe to interpolate into a copyable shell command.
export const PROJECT_NAME_RE = /^[a-z0-9][a-z0-9._-]{0,63}$/i;

export function sanitizeProjectName(s: string): string {
  // strip anything outside the allowed charset; trim to 64; ensure it starts alphanumeric
  const cleaned = s.replace(/[^a-zA-Z0-9._-]/g, "").slice(0, 64).replace(/^[._-]+/, "");
  return cleaned;
}
