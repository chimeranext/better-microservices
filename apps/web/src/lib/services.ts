export interface ServiceDef { slug: string; name: string; stack: string; blurb: string; disabled?: string; }
export const services: ServiceDef[] = [
  { slug: "agentic-core", name: "Agentic Core", stack: "Python · K8s sidecar", blurb: "Agent-orchestration gRPC sidecar. No domain graphs — yours stay in your monorepo." },
  { slug: "compliance-core", name: "Compliance Core", stack: "TypeScript · gRPC", blurb: "KYC/KYB/AML, sanctions & proof-of-personhood — one gRPC sidecar over Persona/Ondato/Incode/WorldID." },
  { slug: "filing-core", name: "Filing Core", stack: "TypeScript · gRPC", blurb: "Tax-declaration filing (TRIBU-CR, SAT MX, DIAN CO) — D-101/D-104/DIOT.", disabled: "2027" },
  { slug: "invoice-core", name: "Invoice Core", stack: "TypeScript · gRPC", blurb: "Multi-country e-invoicing (CR v4.4 · MX · CO) — gRPC sidecar over the Hacienda SDK." },
  { slug: "marketplace-core", name: "Marketplace Core", stack: "TypeScript · gRPC", blurb: "Marketplace-orchestration sidecar. Sagas & integrations stay in your monorepo." },
  { slug: "payments-core", name: "Payments Core", stack: "TypeScript · gRPC", blurb: "One payments gRPC sidecar — intents, subscriptions, escrow, refunds, disputes, reconciliation." },
];
export const selectableServices = services.filter((s) => !s.disabled);
