import { defaultModel, ADDONS, type WizardModel, type Broker, type Orchestration, type Ci, type Embed, type Addon } from "./wizard";
import { selectableServices } from "./services";

const BROKERS: Broker[] = ["nats", "kafka", "redis"];
const ORCH: Orchestration[] = ["docker-compose", "k8s-helm", "both"];
const CIS: Ci[] = ["github-actions", "none"];
const EMBEDS: Embed[] = ["submodule", "vendor"];
const SLUGS = selectableServices.map((s) => s.slug);

export function encodeState(m: WizardModel): string {
  const p = new URLSearchParams();
  if (m.name !== defaultModel.name) p.set("name", m.name);
  if (m.services.join(",") !== defaultModel.services.join(",")) p.set("services", m.services.join(","));
  if (m.broker !== defaultModel.broker) p.set("broker", m.broker);
  if (m.orchestration !== defaultModel.orchestration) p.set("orchestration", m.orchestration);
  if (m.gateway) p.set("gateway", "1");
  if (m.observability) p.set("observability", "1");
  if (m.ci !== defaultModel.ci) p.set("ci", m.ci);
  if (m.addons.length) p.set("addons", m.addons.join(","));
  if (m.embed !== defaultModel.embed) p.set("embed", m.embed);
  return p.toString();
}

const oneOf = <T,>(v: string | null, allowed: readonly T[], fb: T): T => (allowed.includes(v as T) ? (v as T) : fb);

export function decodeState(p: URLSearchParams): WizardModel {
  const services = (p.get("services")?.split(",").filter((s) => SLUGS.includes(s))) ?? defaultModel.services;
  const addons = (p.get("addons")?.split(",").filter((a) => (ADDONS as readonly string[]).includes(a)) as Addon[]) ?? [];
  return {
    name: p.get("name") || defaultModel.name,
    services: services.length ? services : defaultModel.services,
    db: "postgres",
    broker: oneOf(p.get("broker"), BROKERS, defaultModel.broker),
    orchestration: oneOf(p.get("orchestration"), ORCH, defaultModel.orchestration),
    gateway: p.get("gateway") === "1",
    observability: p.get("observability") === "1",
    ci: oneOf(p.get("ci"), CIS, defaultModel.ci),
    addons,
    embed: oneOf(p.get("embed"), EMBEDS, defaultModel.embed),
  };
}
