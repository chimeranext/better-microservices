import type { WizardModel } from "./wizard";
import { services } from "./services";

export interface CardOption {
  value: string;
  label: string;
  desc: string;
  disabled?: string; // e.g. "2027"
  isSelected: (m: WizardModel) => boolean;
  apply: (m: WizardModel) => Partial<WizardModel>;
}

export interface Category {
  id: string; // chip-group key shown in the sidebar (e.g. "services")
  label: string; // section heading, e.g. "SERVICES"
  mode: "single" | "multi";
  options: CardOption[];
}

const toggle = <T>(list: T[], v: T): T[] =>
  list.includes(v) ? list.filter((x) => x !== v) : [...list, v];

const servicesCategory: Category = {
  id: "services",
  label: "SERVICES",
  mode: "multi",
  options: services.map((s) => ({
    value: s.slug,
    label: s.name,
    desc: s.blurb,
    disabled: s.disabled,
    isSelected: (m) => m.services.includes(s.slug),
    // never toggle a disabled service into the model
    apply: (m) =>
      s.disabled ? {} : { services: toggle(m.services, s.slug) },
  })),
};

const databaseCategory: Category = {
  id: "database",
  label: "DATABASE",
  mode: "single",
  options: [
    {
      value: "postgres",
      label: "PostgreSQL · default",
      desc: "Relational database for every service.",
      isSelected: (m) => m.db === "postgres",
      apply: () => ({ db: "postgres" }),
    },
  ],
};

const brokerCategory: Category = {
  id: "broker",
  label: "MESSAGE BROKER",
  mode: "single",
  options: [
    { value: "nats", label: "NATS", desc: "Lightweight pub/sub + JetStream." },
    { value: "kafka", label: "Kafka", desc: "Durable, high-throughput streaming." },
    { value: "redis", label: "Redis", desc: "Streams + cache, minimal ops." },
  ].map((o) => ({
    ...o,
    isSelected: (m: WizardModel) => m.broker === o.value,
    apply: () => ({ broker: o.value as WizardModel["broker"] }),
  })),
};

const orchestrationCategory: Category = {
  id: "orchestration",
  label: "ORCHESTRATION",
  mode: "single",
  options: [
    { value: "docker-compose", label: "Docker Compose", desc: "Local-first, single host." },
    { value: "k8s-helm", label: "Kubernetes · Helm", desc: "Production cluster deploys." },
    { value: "both", label: "Both", desc: "Compose for dev, Helm for prod." },
  ].map((o) => ({
    ...o,
    isSelected: (m: WizardModel) => m.orchestration === o.value,
    apply: () => ({ orchestration: o.value as WizardModel["orchestration"] }),
  })),
};

const gatewayCategory: Category = {
  id: "gateway",
  label: "API GATEWAY",
  mode: "single",
  options: [
    {
      value: "on",
      label: "API Gateway",
      desc: "Single edge entrypoint + routing.",
      isSelected: (m) => m.gateway,
      apply: () => ({ gateway: true }),
    },
    {
      value: "off",
      label: "No gateway",
      desc: "Services exposed directly.",
      isSelected: (m) => !m.gateway,
      apply: () => ({ gateway: false }),
    },
  ],
};

const observabilityCategory: Category = {
  id: "observability",
  label: "OBSERVABILITY",
  mode: "single",
  options: [
    {
      value: "on",
      label: "Observability",
      desc: "Metrics, traces and logs stack.",
      isSelected: (m) => m.observability,
      apply: () => ({ observability: true }),
    },
    {
      value: "off",
      label: "None",
      desc: "Skip the observability stack.",
      isSelected: (m) => !m.observability,
      apply: () => ({ observability: false }),
    },
  ],
};

const ciCategory: Category = {
  id: "ci",
  label: "CI",
  mode: "single",
  options: [
    { value: "github-actions", label: "GitHub Actions", desc: "Workflows for build + test." },
    { value: "none", label: "None", desc: "No CI pipelines generated." },
  ].map((o) => ({
    ...o,
    isSelected: (m: WizardModel) => m.ci === o.value,
    apply: () => ({ ci: o.value as WizardModel["ci"] }),
  })),
};

const addonsCategory: Category = {
  id: "addons",
  label: "ADDONS",
  mode: "multi",
  options: [
    { value: "pre-commit", label: "pre-commit", desc: "Lint + format git hooks." },
    { value: "dockerfiles", label: "Dockerfiles", desc: "Per-service container builds." },
    { value: "env-example", label: ".env.example", desc: "Documented env templates." },
  ].map((o) => ({
    ...o,
    isSelected: (m: WizardModel) =>
      m.addons.includes(o.value as WizardModel["addons"][number]),
    apply: (m: WizardModel) => ({
      addons: toggle(m.addons, o.value as WizardModel["addons"][number]),
    }),
  })),
};

const embedCategory: Category = {
  id: "embed",
  label: "EMBED",
  mode: "single",
  options: [
    { value: "submodule", label: "Submodule · default", desc: "Track services as git submodules." },
    { value: "vendor", label: "Vendor (subtree copy)", desc: "Copy services into the repo." },
  ].map((o) => ({
    ...o,
    isSelected: (m: WizardModel) => m.embed === o.value,
    apply: () => ({ embed: o.value as WizardModel["embed"] }),
  })),
};

export const categories: Category[] = [
  servicesCategory,
  databaseCategory,
  brokerCategory,
  orchestrationCategory,
  gatewayCategory,
  observabilityCategory,
  ciCategory,
  addonsCategory,
  embedCategory,
];
