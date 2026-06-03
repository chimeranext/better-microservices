export interface ServiceDef { slug: string; name: string; stack: string; blurb: string; disabled?: string; }
export const services: ServiceDef[] = [
  { slug: "agentic-core", name: "Agentic Core", stack: "Python · Go · Dart", blurb: "Agent runtime — LLM orchestration, TUI, tools." },
  { slug: "compliance-core", name: "Compliance Core", stack: "Node", blurb: "KYC/AML, sanctions screening, audit." },
  { slug: "filing-core", name: "Filing Core", stack: "Node", blurb: "Regulatory filing automation.", disabled: "2027" },
  { slug: "invoice-core", name: "Invoice Core", stack: "Node", blurb: "E-invoicing (Hacienda CR v4.4, XAdES)." },
  { slug: "marketplace-core", name: "Marketplace Core", stack: "Node · appchain · Flutter", blurb: "Storefront + schema-driven catalog." },
  { slug: "payments-core", name: "Payments Core", stack: "Node", blurb: "Payment gateways, escrow, settlement." },
];
export const selectableServices = services.filter((s) => !s.disabled);
