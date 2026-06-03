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
