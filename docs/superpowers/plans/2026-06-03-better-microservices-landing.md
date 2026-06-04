# Better-Microservices Landing / Configurator — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build `apps/web` — a Next.js + Shadcn "pick your microservices" landing whose core is a 4-step wizard that compiles a copyable `npx create-better-microservices …` command, with a README-first drawer per service.

**Architecture:** Next.js 14 App Router, **static-exported** (no server). The wizard's pure logic — command compiler, URL-state codec, dependency hints — lives in unit-tested `src/lib/*.ts` modules; React/Shadcn components consume them. Wizard state is mirrored to the URL for shareable configs. Brand = the shared **Chimera** palette (Tailwind theme + CSS vars).

**Tech Stack:** Next.js 14 (App Router, `output: 'export'`), TypeScript, Tailwind 3, Shadcn/ui (Radix), `react-markdown` (README drawer), Sora/Inter/JetBrains Mono, Vitest + @testing-library/react. Lives in the pnpm/Turbo monorepo workspace.

**Spec:** `openspec/changes/2026-06-01-landing-configurator/{proposal,design,tasks}.md` (palette in design.md "Design tokens — Chimera palette").

---

## File Structure

```
apps/web/
├── package.json · next.config.mjs · tsconfig.json · postcss.config.js
├── tailwind.config.ts            # Chimera tokens + shadcn theme
├── components.json               # shadcn config
├── vitest.config.ts
├── src/
│   ├── app/
│   │   ├── layout.tsx            # fonts, dark theme, metadata
│   │   ├── page.tsx              # Hero · ServicesShowcase · Wizard · Footer
│   │   └── globals.css           # tailwind + Chimera CSS vars (shadcn HSL)
│   ├── lib/
│   │   ├── services.ts           # the 6 services (filing disabled)
│   │   ├── wizard.ts             # WizardModel type + defaults
│   │   ├── command.ts(+test)     # compileCommand(model) → string   [TDD]
│   │   ├── url-state.ts(+test)   # encode/decode model ⇄ query      [TDD]
│   │   ├── deps.ts(+test)        # dependencyHints(services)        [TDD]
│   │   └── utils.ts              # cn() (shadcn)
│   └── components/
│       ├── ui/*                  # shadcn primitives
│       ├── Hero.tsx · ServicesShowcase.tsx · Footer.tsx
│       ├── Wizard.tsx            # stepper + state + URL sync
│       ├── steps/{Services,Infra,Addons,Review}.tsx
│       ├── ReadmeDrawer.tsx · CommandBar.tsx
```

The 6 configurable services (design "csv of the 6"; `vision-core`/`geospatial-core` are venture-specific Python engines, out of the picker): `agentic-core`, `compliance-core`, `filing-core` (disabled "2027"), `invoice-core`, `marketplace-core`, `payments-core`.

---

## Task 1: Scaffold `apps/web` (Next.js + TS + workspace wiring)

**Files:** Create `apps/web/package.json`, `next.config.mjs`, `tsconfig.json`, `postcss.config.js`, `src/app/{layout.tsx,page.tsx,globals.css}`, `vitest.config.ts`.

- [ ] **Step 1: package.json**

```json
{
  "name": "@better-microservices/web",
  "private": true,
  "version": "0.1.0",
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "test": "vitest run"
  },
  "dependencies": {
    "next": "14.2.15", "react": "18.3.1", "react-dom": "18.3.1",
    "react-markdown": "9.0.1", "lucide-react": "0.452.0",
    "class-variance-authority": "0.7.0", "clsx": "2.1.1", "tailwind-merge": "2.5.4"
  },
  "devDependencies": {
    "typescript": "5.6.3", "@types/react": "18.3.11", "@types/react-dom": "18.3.0", "@types/node": "20.16.11",
    "tailwindcss": "3.4.14", "postcss": "8.4.47", "autoprefixer": "10.4.20", "tailwindcss-animate": "1.0.7",
    "vitest": "2.1.3", "@testing-library/react": "16.0.1", "@testing-library/dom": "10.4.0", "jsdom": "25.0.1", "@vitejs/plugin-react": "4.3.2"
  }
}
```

- [ ] **Step 2: next.config.mjs (static export)**

```js
/** @type {import('next').NextConfig} */
export default { output: "export", images: { unoptimized: true }, reactStrictMode: true };
```

- [ ] **Step 3: tsconfig.json**

```json
{
  "compilerOptions": {
    "target": "ES2022", "lib": ["dom", "dom.iterable", "ES2022"], "jsx": "preserve",
    "module": "esnext", "moduleResolution": "bundler", "strict": true, "noEmit": true,
    "esModuleInterop": true, "resolveJsonModule": true, "isolatedModules": true,
    "skipLibCheck": true, "incremental": true,
    "paths": { "@/*": ["./src/*"] }, "plugins": [{ "name": "next" }]
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
```

- [ ] **Step 4: postcss.config.js + vitest.config.ts**

`postcss.config.js`:
```js
export default { plugins: { tailwindcss: {}, autoprefixer: {} } };
```
`vitest.config.ts`:
```ts
import { defineConfig } from "vitest/config";
import react from "@vitejs/plugin-react";
export default defineConfig({
  plugins: [react()],
  test: { environment: "jsdom", include: ["src/**/*.test.{ts,tsx}"], globals: true },
  resolve: { alias: { "@": new URL("./src", import.meta.url).pathname } },
});
```

- [ ] **Step 5: Minimal app shell (compiles)**

`src/app/globals.css`: `@tailwind base;@tailwind components;@tailwind utilities;`
`src/app/layout.tsx`:
```tsx
import "./globals.css";
export const metadata = { title: "better-microservices", description: "Pick the services your startup needs." };
export default function RootLayout({ children }: { children: React.ReactNode }) {
  return <html lang="en" className="dark"><body>{children}</body></html>;
}
```
`src/app/page.tsx`:
```tsx
export default function Home() { return <main />; }
```

- [ ] **Step 6: Install + build (from repo root, pnpm workspace)**

```bash
pnpm install
pnpm --filter @better-microservices/web build
```
Expected: install succeeds; `next build` exports `apps/web/out/`.

- [ ] **Step 7: Commit**

```bash
git add apps/web && git commit -m "chore(web): scaffold Next.js App Router + static export + vitest"
```

---

## Task 2: Tailwind + Chimera tokens (shadcn theme)

**Files:** Create `apps/web/tailwind.config.ts`, `apps/web/src/lib/utils.ts`; modify `apps/web/src/app/globals.css`.

- [ ] **Step 1: tailwind.config.ts (Chimera + shadcn HSL vars)**

```ts
import type { Config } from "tailwindcss";
const config: Config = {
  darkMode: ["class"],
  content: ["./src/**/*.{ts,tsx}"],
  theme: {
    extend: {
      colors: {
        border: "hsl(var(--border))", input: "hsl(var(--input))", ring: "hsl(var(--ring))",
        background: "hsl(var(--background))", foreground: "hsl(var(--foreground))",
        primary: { DEFAULT: "hsl(var(--primary))", foreground: "hsl(var(--primary-foreground))" },
        secondary: { DEFAULT: "hsl(var(--secondary))", foreground: "hsl(var(--secondary-foreground))" },
        muted: { DEFAULT: "hsl(var(--muted))", foreground: "hsl(var(--muted-foreground))" },
        accent: { DEFAULT: "hsl(var(--accent))", foreground: "hsl(var(--accent-foreground))" },
        card: { DEFAULT: "hsl(var(--card))", foreground: "hsl(var(--card-foreground))" },
        // Chimera brand (raw hues for gradients/pills)
        brand: { primary: "#7C5CFF", secondary: "#3B82F6", tertiary: "#22D3EE", accent: "#EC4899" },
      },
      fontFamily: { heading: ["var(--font-sora)"], body: ["var(--font-inter)"], mono: ["var(--font-mono)"] },
      borderRadius: { lg: "10px", md: "8px", sm: "6px" },
      backgroundImage: { "brand-gradient": "linear-gradient(90deg,#7C5CFF,#3B82F6,#22D3EE)" },
    },
  },
  plugins: [require("tailwindcss-animate")],
};
export default config;
```

- [ ] **Step 2: globals.css — Chimera mapped to shadcn HSL vars (dark base)**

```css
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  :root {
    --background: 257 38% 5%;        /* #08060F */
    --foreground: 260 30% 92%;       /* #ECE8F2 */
    --card: 252 30% 14%;             /* #1C1830 */
    --card-foreground: 260 30% 92%;
    --muted: 250 24% 12%;
    --muted-foreground: 252 11% 55%; /* #837C99 */
    --border: 252 26% 20%;           /* #2A2640 */
    --input: 252 26% 20%;
    --primary: 252 100% 68%;         /* #7C5CFF violet */
    --primary-foreground: 0 0% 100%;
    --secondary: 217 91% 60%;        /* #3B82F6 blue */
    --secondary-foreground: 0 0% 100%;
    --accent: 330 81% 60%;           /* #EC4899 magenta */
    --accent-foreground: 0 0% 100%;
    --ring: 252 100% 68%;
  }
  * { @apply border-border; }
  body { @apply bg-background text-foreground font-body antialiased; }
  h1,h2,h3 { @apply font-heading; }
}
```

- [ ] **Step 3: utils.ts (cn)**

```ts
import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";
export function cn(...inputs: ClassValue[]) { return twMerge(clsx(inputs)); }
```

- [ ] **Step 4: Wire fonts in layout.tsx**

Replace `layout.tsx` body to load fonts (next/font) and expose the CSS vars:
```tsx
import "./globals.css";
import { Sora, Inter, JetBrains_Mono } from "next/font/google";
const sora = Sora({ subsets: ["latin"], variable: "--font-sora", weight: ["600","800"] });
const inter = Inter({ subsets: ["latin"], variable: "--font-inter" });
const mono = JetBrains_Mono({ subsets: ["latin"], variable: "--font-mono" });
export const metadata = { title: "better-microservices — pick your stack", description: "Pick the services your startup needs and copy the scaffold command." };
export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" className={`dark ${sora.variable} ${inter.variable} ${mono.variable}`}>
      <body>{children}</body>
    </html>
  );
}
```

- [ ] **Step 5: Build check + commit**

Run: `pnpm --filter @better-microservices/web build` (Expected: succeeds).
```bash
git add apps/web && git commit -m "feat(web): Chimera palette → Tailwind/shadcn theme + fonts"
```

---

## Task 3: Shadcn primitives

**Files:** Create `apps/web/components.json` + `apps/web/src/components/ui/{button,card,badge,checkbox,radio-group,switch,tabs,sheet,tooltip}.tsx`.

- [ ] **Step 1: components.json**

```json
{
  "$schema": "https://ui.shadcn.com/schema.json",
  "style": "new-york", "rsc": false, "tsx": true,
  "tailwind": { "config": "tailwind.config.ts", "css": "src/app/globals.css", "baseColor": "slate", "cssVariables": true },
  "aliases": { "components": "@/components", "utils": "@/lib/utils", "ui": "@/components/ui" }
}
```

- [ ] **Step 2: Add the components**

From `apps/web/`:
```bash
npx shadcn@latest add button card badge checkbox radio-group switch tabs sheet tooltip --yes
```
If the CLI prompts/refuses non-interactively, copy each component from the shadcn registry (https://ui.shadcn.com/r/styles/new-york/<name>.json) into `src/components/ui/<name>.tsx` and install peer deps (`@radix-ui/react-checkbox`, `@radix-ui/react-radio-group`, `@radix-ui/react-switch`, `@radix-ui/react-tabs`, `@radix-ui/react-dialog`, `@radix-ui/react-tooltip`).

- [ ] **Step 3: Build check + commit**

Run: `pnpm --filter @better-microservices/web build` (Expected: succeeds).
```bash
git add apps/web && git commit -m "feat(web): shadcn primitives (button/card/sheet/checkbox/...)"
```

---

## Task 4: Services data + wizard model

**Files:** Create `apps/web/src/lib/services.ts`, `apps/web/src/lib/wizard.ts`.

- [ ] **Step 1: services.ts**

```ts
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
```

- [ ] **Step 2: wizard.ts (model + defaults)**

```ts
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
```

- [ ] **Step 3: Build check + commit**

Run `pnpm --filter @better-microservices/web build`.
```bash
git add apps/web && git commit -m "feat(web): services data + wizard model"
```

---

## Task 5: Command compiler (TDD)

**Files:** Create `apps/web/src/lib/command.ts`, `apps/web/src/lib/command.test.ts`.

- [ ] **Step 1: Write the failing test**

```ts
import { describe, it, expect } from "vitest";
import { compileCommand } from "./command";
import { defaultModel } from "./wizard";

describe("compileCommand", () => {
  it("emits the base command with name + required flags, omitting defaults", () => {
    expect(compileCommand(defaultModel)).toBe(
      "npx create-better-microservices my-startup --services payments-core --db postgres --broker nats --orchestration docker-compose --ci github-actions"
    );
  });
  it("includes boolean flags only when true, and csv addons", () => {
    const cmd = compileCommand({ ...defaultModel, services: ["payments-core","marketplace-core"], gateway: true, observability: true, addons: ["pre-commit","dockerfiles"] });
    expect(cmd).toContain("--services payments-core,marketplace-core");
    expect(cmd).toContain("--gateway");
    expect(cmd).toContain("--observability");
    expect(cmd).toContain("--addons pre-commit,dockerfiles");
  });
  it("emits --embed only when vendor (submodule is default), and --ci none", () => {
    const cmd = compileCommand({ ...defaultModel, embed: "vendor", ci: "none" });
    expect(cmd).toContain("--embed vendor");
    expect(cmd).toContain("--ci none");
  });
  it("does not emit --embed for the submodule default", () => {
    expect(compileCommand(defaultModel)).not.toContain("--embed");
  });
});
```

- [ ] **Step 2: Run to verify it fails**

Run: `npx vitest run src/lib/command.test.ts`
Expected: FAIL — `compileCommand` not defined.

- [ ] **Step 3: Implement command.ts**

```ts
import type { WizardModel } from "./wizard";

export function compileCommand(m: WizardModel): string {
  const parts = [`npx create-better-microservices ${m.name || "my-startup"}`];
  parts.push(`--services ${[...m.services].sort().join(",") || "payments-core"}`);
  parts.push(`--db ${m.db}`);
  parts.push(`--broker ${m.broker}`);
  parts.push(`--orchestration ${m.orchestration}`);
  if (m.gateway) parts.push("--gateway");
  if (m.observability) parts.push("--observability");
  parts.push(`--ci ${m.ci}`);
  if (m.addons.length) parts.push(`--addons ${m.addons.join(",")}`);
  if (m.embed !== "submodule") parts.push(`--embed ${m.embed}`);
  return parts.join(" ");
}
```
Note: services are sorted for deterministic output; the test uses already-sorted inputs.

- [ ] **Step 4: Run to verify it passes**

Run: `npx vitest run src/lib/command.test.ts`
Expected: PASS (4 tests).

- [ ] **Step 5: Commit**

```bash
git add apps/web/src/lib/command.ts apps/web/src/lib/command.test.ts && git commit -m "feat(web): command compiler + test"
```

---

## Task 6: URL-state codec (TDD)

**Files:** Create `apps/web/src/lib/url-state.ts`, `apps/web/src/lib/url-state.test.ts`.

- [ ] **Step 1: Write the failing test**

```ts
import { describe, it, expect } from "vitest";
import { encodeState, decodeState } from "./url-state";
import { defaultModel, type WizardModel } from "./wizard";

describe("url-state", () => {
  it("round-trips a model through the query string", () => {
    const model: WizardModel = { ...defaultModel, name: "acme", services: ["payments-core","marketplace-core"], broker: "kafka", gateway: true, addons: ["pre-commit"], embed: "vendor" };
    const decoded = decodeState(new URLSearchParams(encodeState(model)));
    expect(decoded).toEqual(model);
  });
  it("falls back to defaults for missing/invalid params", () => {
    const decoded = decodeState(new URLSearchParams("broker=not-a-broker"));
    expect(decoded.broker).toBe(defaultModel.broker);
    expect(decoded.name).toBe(defaultModel.name);
  });
  it("omits default values from the encoded string (short URLs)", () => {
    expect(encodeState(defaultModel)).toBe("");
  });
});
```

- [ ] **Step 2: Run to verify it fails**

Run: `npx vitest run src/lib/url-state.test.ts`
Expected: FAIL — module not found.

- [ ] **Step 3: Implement url-state.ts**

```ts
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
```

- [ ] **Step 4: Run to verify it passes**

Run: `npx vitest run src/lib/url-state.test.ts`
Expected: PASS (3 tests).

- [ ] **Step 5: Commit**

```bash
git add apps/web/src/lib/url-state.ts apps/web/src/lib/url-state.test.ts && git commit -m "feat(web): URL-state codec + test"
```

---

## Task 7: Dependency hints (TDD)

**Files:** Create `apps/web/src/lib/deps.ts`, `apps/web/src/lib/deps.test.ts`.

- [ ] **Step 1: Write the failing test**

```ts
import { describe, it, expect } from "vitest";
import { dependencyHints } from "./deps";

describe("dependencyHints", () => {
  it("warns when marketplace-core is selected without payments-core", () => {
    const hints = dependencyHints(["marketplace-core"]);
    expect(hints).toContainEqual({ level: "warn", service: "marketplace-core", message: expect.stringContaining("payments-core") });
  });
  it("suggests payments-core when agentic-core is selected without it", () => {
    const hints = dependencyHints(["agentic-core"]);
    expect(hints).toContainEqual({ level: "suggest", service: "agentic-core", message: expect.stringContaining("payments-core") });
  });
  it("is silent when payments-core is present", () => {
    expect(dependencyHints(["marketplace-core","agentic-core","payments-core"])).toEqual([]);
  });
});
```

- [ ] **Step 2: Run to verify it fails**

Run: `npx vitest run src/lib/deps.test.ts`
Expected: FAIL — module not found.

- [ ] **Step 3: Implement deps.ts**

```ts
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
```

- [ ] **Step 4: Run to verify it passes**

Run: `npx vitest run src/lib/deps.test.ts`
Expected: PASS (3 tests).

- [ ] **Step 5: Commit**

```bash
git add apps/web/src/lib/deps.ts apps/web/src/lib/deps.test.ts && git commit -m "feat(web): service dependency hints + test"
```

---

## Task 8: Marketing shell (Hero · ServicesShowcase · Footer)

**Files:** Create `apps/web/src/components/{Hero,ServicesShowcase,Footer}.tsx`; modify `src/app/page.tsx`.

- [ ] **Step 1: Hero.tsx**

```tsx
export function Hero() {
  return (
    <section className="py-16 text-center">
      <h1 className="bg-brand-gradient bg-clip-text text-4xl font-extrabold text-transparent sm:text-5xl">
        Pick the services your startup needs.
      </h1>
      <p className="mx-auto mt-4 max-w-2xl text-muted-foreground">
        A curated set of production-grade microservices. Choose what you need — copy the scaffold command.
      </p>
    </section>
  );
}
```

- [ ] **Step 2: ServicesShowcase.tsx**

```tsx
import { services } from "@/lib/services";
import { Card } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
export function ServicesShowcase() {
  return (
    <section className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
      {services.map((s) => (
        <Card key={s.slug} className="p-5">
          <div className="flex items-center justify-between">
            <h3 className="font-mono text-sm text-brand-tertiary">{s.slug}</h3>
            {s.disabled && <Badge variant="secondary">{s.disabled}</Badge>}
          </div>
          <p className="mt-2 text-sm text-muted-foreground">{s.blurb}</p>
          <p className="mt-3 text-xs text-muted-foreground">{s.stack}</p>
        </Card>
      ))}
    </section>
  );
}
```

- [ ] **Step 3: Footer.tsx**

```tsx
export function Footer() {
  return (
    <footer className="border-t border-border py-10 text-sm text-muted-foreground">
      <div className="mx-auto max-w-6xl px-6">
        <p>better-microservices · a <a className="text-brand-secondary" href="https://chimeranext.com">ChimeraNext</a> stack · source-available (BSL 1.1)</p>
      </div>
    </footer>
  );
}
```

- [ ] **Step 4: Wire into page.tsx + build**

```tsx
import { Hero } from "@/components/Hero";
import { ServicesShowcase } from "@/components/ServicesShowcase";
import { Footer } from "@/components/Footer";
export default function Home() {
  return (
    <>
      <main className="mx-auto max-w-6xl px-6">
        <Hero />
        <ServicesShowcase />
      </main>
      <Footer />
    </>
  );
}
```
Run: `pnpm --filter @better-microservices/web build` (Expected: succeeds; `out/index.html` contains all 6 service slugs).

- [ ] **Step 5: Commit**

```bash
git add apps/web && git commit -m "feat(web): marketing shell (hero, services showcase, footer)"
```

---

## Task 9: Wizard shell (stepper + state + URL sync)

**Files:** Create `apps/web/src/components/Wizard.tsx`; modify `src/app/page.tsx`.

- [ ] **Step 1: Wizard.tsx (client component)**

```tsx
"use client";
import { useEffect, useState } from "react";
import { defaultModel, type WizardModel } from "@/lib/wizard";
import { decodeState, encodeState } from "@/lib/url-state";
import { Button } from "@/components/ui/button";

const STEPS = ["Services", "Infra", "Addons", "Review"] as const;

export function Wizard() {
  const [model, setModel] = useState<WizardModel>(defaultModel);
  const [step, setStep] = useState(0);

  useEffect(() => { setModel(decodeState(new URLSearchParams(window.location.search))); }, []);
  useEffect(() => {
    const qs = encodeState(model);
    const url = qs ? `?${qs}` : window.location.pathname;
    window.history.replaceState(null, "", url);
  }, [model]);

  const patch = (p: Partial<WizardModel>) => setModel((m) => ({ ...m, ...p }));

  return (
    <section id="configure" className="my-12 rounded-2xl border border-border bg-card p-6">
      <ol className="mb-6 flex gap-2 text-sm">
        {STEPS.map((s, i) => (
          <li key={s} className={i === step ? "font-semibold text-brand-secondary" : "text-muted-foreground"}>
            {i + 1}. {s}{i < STEPS.length - 1 ? " →" : ""}
          </li>
        ))}
      </ol>
      <div data-testid="wizard-body">
        {/* Step bodies are added in Tasks 10–12; render placeholders keyed by step for now */}
        {step === 0 && <p className="text-muted-foreground">Services step (Task 10)</p>}
        {step === 1 && <p className="text-muted-foreground">Infra step (Task 11)</p>}
        {step === 2 && <p className="text-muted-foreground">Addons step (Task 11)</p>}
        {step === 3 && <p className="text-muted-foreground">Review step (Task 12)</p>}
      </div>
      <div className="mt-6 flex justify-between">
        <Button variant="secondary" disabled={step === 0} onClick={() => setStep((s) => s - 1)}>Back</Button>
        <Button disabled={step === STEPS.length - 1} onClick={() => setStep((s) => s + 1)}>Next</Button>
      </div>
    </section>
  );
}
```
(Step 10–12 replace the placeholder bodies with the real step components, all driven by `model`/`patch`.)

- [ ] **Step 2: Mount in page.tsx (between showcase and footer) + build**

Add `import { Wizard } from "@/components/Wizard";` and `<Wizard />` after `<ServicesShowcase />`.
Run: `pnpm --filter @better-microservices/web build` (Expected: succeeds).

- [ ] **Step 3: Commit**

```bash
git add apps/web && git commit -m "feat(web): wizard shell with URL-synced state + stepper"
```

---

## Task 10: Step 1 — Services (multi-select + filing disabled + dep hints)

**Files:** Create `apps/web/src/components/steps/Services.tsx`; modify `Wizard.tsx`.

- [ ] **Step 1: Services.tsx**

```tsx
import { services } from "@/lib/services";
import { dependencyHints } from "@/lib/deps";
import { Card } from "@/components/ui/card";
import { Checkbox } from "@/components/ui/checkbox";
import { Badge } from "@/components/ui/badge";
import type { WizardModel } from "@/lib/wizard";

export function StepServices({ model, patch, onViewReadme }: {
  model: WizardModel; patch: (p: Partial<WizardModel>) => void; onViewReadme: (slug: string) => void;
}) {
  const toggle = (slug: string) => patch({ services: model.services.includes(slug) ? model.services.filter((s) => s !== slug) : [...model.services, slug] });
  const hints = dependencyHints(model.services);
  return (
    <div>
      <div className="grid gap-3 sm:grid-cols-2">
        {services.map((s) => {
          const checked = model.services.includes(s.slug);
          return (
            <Card key={s.slug} className={`p-4 ${s.disabled ? "opacity-50" : ""}`}>
              <label className="flex items-start gap-3">
                <Checkbox checked={checked} disabled={!!s.disabled} onCheckedChange={() => !s.disabled && toggle(s.slug)} />
                <div className="flex-1">
                  <div className="flex items-center gap-2">
                    <span className="font-mono text-sm text-brand-tertiary">{s.slug}</span>
                    {s.disabled && <Badge variant="secondary">{s.disabled}</Badge>}
                  </div>
                  <p className="mt-1 text-sm text-muted-foreground">{s.blurb}</p>
                  {!s.disabled && (
                    <button type="button" onClick={() => onViewReadme(s.slug)} className="mt-2 text-xs text-brand-secondary hover:underline">View README</button>
                  )}
                </div>
              </label>
            </Card>
          );
        })}
      </div>
      {hints.map((h, i) => (
        <p key={i} className={`mt-3 text-sm ${h.level === "warn" ? "text-accent" : "text-brand-tertiary"}`}>⚠ {h.message}</p>
      ))}
    </div>
  );
}
```

- [ ] **Step 2: Wire into Wizard step 0 (pass model/patch; stub onViewReadme until Task 13)**

In `Wizard.tsx`, import `StepServices` and replace the `step === 0` placeholder with:
```tsx
{step === 0 && <StepServices model={model} patch={patch} onViewReadme={() => {}} />}
```

- [ ] **Step 3: Build check + commit**

Run: `pnpm --filter @better-microservices/web build`.
```bash
git add apps/web && git commit -m "feat(web): step 1 services (multi-select + dep hints)"
```

---

## Task 11: Step 2 Infra + Step 3 Addons

**Files:** Create `apps/web/src/components/steps/{Infra,Addons}.tsx`; modify `Wizard.tsx`.

- [ ] **Step 1: Infra.tsx**

```tsx
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { Switch } from "@/components/ui/switch";
import type { WizardModel, Broker, Orchestration } from "@/lib/wizard";

const BROKERS: Broker[] = ["nats", "kafka", "redis"];
const ORCH: Orchestration[] = ["docker-compose", "k8s-helm", "both"];

export function StepInfra({ model, patch }: { model: WizardModel; patch: (p: Partial<WizardModel>) => void }) {
  return (
    <div className="space-y-6">
      <div>
        <p className="mb-2 text-sm font-semibold">Event bus broker</p>
        <RadioGroup value={model.broker} onValueChange={(v) => patch({ broker: v as Broker })} className="flex gap-4">
          {BROKERS.map((b) => <label key={b} className="flex items-center gap-2 text-sm"><RadioGroupItem value={b} />{b}</label>)}
        </RadioGroup>
      </div>
      <div>
        <p className="mb-2 text-sm font-semibold">Orchestration</p>
        <RadioGroup value={model.orchestration} onValueChange={(v) => patch({ orchestration: v as Orchestration })} className="flex gap-4">
          {ORCH.map((o) => <label key={o} className="flex items-center gap-2 text-sm"><RadioGroupItem value={o} />{o}</label>)}
        </RadioGroup>
      </div>
      <label className="flex items-center gap-3 text-sm"><Switch checked={model.gateway} onCheckedChange={(v) => patch({ gateway: v })} /> API Gateway</label>
      <p className="text-xs text-muted-foreground">Database: postgres (default)</p>
    </div>
  );
}
```

- [ ] **Step 2: Addons.tsx**

```tsx
import { Switch } from "@/components/ui/switch";
import { Checkbox } from "@/components/ui/checkbox";
import { ADDONS, type WizardModel, type Addon, type Ci } from "@/lib/wizard";

export function StepAddons({ model, patch }: { model: WizardModel; patch: (p: Partial<WizardModel>) => void }) {
  const toggleAddon = (a: Addon) => patch({ addons: model.addons.includes(a) ? model.addons.filter((x) => x !== a) : [...model.addons, a] });
  return (
    <div className="space-y-6">
      <label className="flex items-center gap-3 text-sm"><Switch checked={model.observability} onCheckedChange={(v) => patch({ observability: v })} /> Observability (OTel + Grafana/Prometheus)</label>
      <label className="flex items-center gap-3 text-sm"><Switch checked={model.ci === "github-actions"} onCheckedChange={(v) => patch({ ci: (v ? "github-actions" : "none") as Ci })} /> CI (GitHub Actions)</label>
      <div>
        <p className="mb-2 text-sm font-semibold">Addons</p>
        {ADDONS.map((a) => (
          <label key={a} className="mr-4 inline-flex items-center gap-2 text-sm"><Checkbox checked={model.addons.includes(a)} onCheckedChange={() => toggleAddon(a)} />{a}</label>
        ))}
      </div>
    </div>
  );
}
```

- [ ] **Step 3: Wire steps 1 & 2 in Wizard + build + commit**

Replace the `step === 1`/`step === 2` placeholders with `<StepInfra .../>` / `<StepAddons .../>` (pass `model`/`patch`).
Run `pnpm --filter @better-microservices/web build`.
```bash
git add apps/web && git commit -m "feat(web): step 2 infra + step 3 addons"
```

---

## Task 12: Step 4 — Review (sticky command + copy + project tree)

**Files:** Create `apps/web/src/components/CommandBar.tsx`, `apps/web/src/components/steps/Review.tsx`; modify `Wizard.tsx`.

- [ ] **Step 1: CommandBar.tsx (sticky command + copy)**

```tsx
"use client";
import { useState } from "react";
import { Button } from "@/components/ui/button";
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
```

- [ ] **Step 2: Review.tsx (command + tree + docs links)**

```tsx
import { compileCommand } from "@/lib/command";
import { CommandBar } from "@/components/CommandBar";
import type { WizardModel } from "@/lib/wizard";

export function StepReview({ model }: { model: WizardModel }) {
  const tree = [
    `${model.name}/`,
    "  services/", ...model.services.map((s) => `    ${s}/  (submodule)`),
    model.gateway ? "  apps/gateway/" : "",
    "  packages/common/",
    model.orchestration !== "k8s-helm" ? "  docker-compose.yml" : "",
    model.orchestration !== "docker-compose" ? "  helm/" : "",
    "  turbo.json  pnpm-workspace.yaml",
  ].filter(Boolean).join("\n");
  return (
    <div className="space-y-4">
      <CommandBar command={compileCommand(model)} />
      <pre className="overflow-x-auto rounded-lg border border-border bg-muted p-4 font-mono text-xs text-muted-foreground">{tree}</pre>
      <p className="text-sm text-muted-foreground">Docs for your picks: {model.services.map((s) => (
        <a key={s} className="mr-3 text-brand-secondary hover:underline" href={`https://chimeranext.github.io/better-microservices/${s}/`}>{s} ↗</a>
      ))}</p>
    </div>
  );
}
```

- [ ] **Step 3: Wire step 3 in Wizard + build + commit**

Replace the `step === 3` placeholder with `<StepReview model={model} />`.
Run `pnpm --filter @better-microservices/web build` (Expected: succeeds; `out` build includes the compiled command for the default model).
```bash
git add apps/web && git commit -m "feat(web): step 4 review (sticky command + copy + project tree)"
```

---

## Task 13: README drawer (Sheet + markdown, raw-from-main + snapshot fallback)

**Files:** Create `apps/web/src/components/ReadmeDrawer.tsx`, `apps/web/src/lib/readme.ts`; modify `Wizard.tsx`.

- [ ] **Step 1: readme.ts (raw URL + fallback note)**

```ts
export function readmeRawUrl(slug: string): string {
  return `https://raw.githubusercontent.com/chimeranext/better-microservices/main/services/${slug}/README.md`;
}
export function docsUrl(slug: string): string {
  return `https://chimeranext.github.io/better-microservices/${slug}/`;
}
```

- [ ] **Step 2: ReadmeDrawer.tsx**

```tsx
"use client";
import { useEffect, useState } from "react";
import ReactMarkdown from "react-markdown";
import { Sheet, SheetContent, SheetHeader, SheetTitle } from "@/components/ui/sheet";
import { readmeRawUrl, docsUrl } from "@/lib/readme";

export function ReadmeDrawer({ slug, onClose }: { slug: string | null; onClose: () => void }) {
  const [md, setMd] = useState<string>("");
  const [err, setErr] = useState(false);
  useEffect(() => {
    if (!slug) return;
    setMd(""); setErr(false);
    fetch(readmeRawUrl(slug)).then((r) => (r.ok ? r.text() : Promise.reject()))
      .then(setMd).catch(() => setErr(true));
  }, [slug]);
  return (
    <Sheet open={!!slug} onOpenChange={(o) => !o && onClose()}>
      <SheetContent className="w-full overflow-y-auto sm:max-w-xl">
        <SheetHeader><SheetTitle className="font-mono text-brand-tertiary">{slug}</SheetTitle></SheetHeader>
        {err ? (
          <p className="mt-4 text-sm text-muted-foreground">README not available yet (repo is private until launch). <a className="text-brand-secondary" href={slug ? docsUrl(slug) : "#"}>Full docs ↗</a></p>
        ) : (
          <article className="prose prose-invert prose-sm mt-4 max-w-none">
            <ReactMarkdown>{md || "Loading…"}</ReactMarkdown>
            {slug && <a className="text-brand-secondary" href={docsUrl(slug)}>Full docs ↗</a>}
          </article>
        )}
      </SheetContent>
    </Sheet>
  );
}
```

- [ ] **Step 3: Wire the drawer into Wizard (state + StepServices onViewReadme)**

In `Wizard.tsx`: add `const [readme, setReadme] = useState<string | null>(null);`, pass `onViewReadme={setReadme}` to `<StepServices>`, and render `<ReadmeDrawer slug={readme} onClose={() => setReadme(null)} />` at the end.

- [ ] **Step 4: Build check + commit**

Run `pnpm --filter @better-microservices/web build`.
```bash
git add apps/web && git commit -m "feat(web): README drawer (raw-from-main + docs fallback)"
```

---

## Task 14: Full test sweep, component smoke, deploy config

**Files:** Create `apps/web/src/components/Wizard.test.tsx`; modify `apps/web/README.md`, the monorepo CI workflow.

- [ ] **Step 1: Wizard component smoke test (testing-library)**

```tsx
import { describe, it, expect } from "vitest";
import { render, screen, fireEvent } from "@testing-library/react";
import { Wizard } from "./Wizard";

describe("Wizard", () => {
  it("renders the command on the review step", () => {
    render(<Wizard />);
    fireEvent.click(screen.getByText("Next")); // → Infra
    fireEvent.click(screen.getByText("Next")); // → Addons
    fireEvent.click(screen.getByText("Next")); // → Review
    expect(screen.getByTestId("command").textContent).toContain("npx create-better-microservices");
  });
});
```

- [ ] **Step 2: Run it**

Run: `npx vitest run`
Expected: all pass — command(4) + url-state(3) + deps(3) + Wizard(1) = 11.

- [ ] **Step 3: README + deploy**

Write `apps/web/README.md` (run `pnpm --filter @better-microservices/web dev`, the lib modules, and the deploy TODOs: GitHub Pages vs Vercel target; the raw-README fetch needs the repo public — until then the drawer shows the docs fallback). Add a CI step to the monorepo workflow that runs `pnpm --filter @better-microservices/web build` + `test`.

- [ ] **Step 4: Final sweep**

Run: `npx vitest run && pnpm --filter @better-microservices/web build`
Expected: 11 tests pass; static export to `apps/web/out/` succeeds.

- [ ] **Step 5: Commit**

```bash
git add apps/web && git commit -m "feat(web): wizard smoke test + README + deploy config"
```

---

## Self-Review

**Spec coverage (vs OpenSpec proposal/design/tasks):**
- `apps/web` Next.js + Shadcn + Tailwind + TS, workspace/Turbo → Task 1. ✓
- Chimera palette (per design.md tokens section) → Task 2 (shadcn HSL vars + brand hues). ✓
- Marketing shell (hero + 6-service showcase + footer) → Task 8. ✓
- 4-step wizard + progress → Task 9; steps → Tasks 10–12. ✓
- URL-encoded shareable state → Task 6 (codec, tested) + Task 9 (sync). ✓
- Command compiler (exact flag contract from design.md) → Task 5 (tested). ✓
- Service dependency hints (marketplace→payments warn; agentic→payments suggest) → Task 7 (tested) + Task 10. ✓
- README drawer (Sheet, raw README from main, docs-site link, fallback) → Task 13. ✓
- filing-core disabled "2027" → Task 4 data + Task 10 rendering. ✓
- Deploy (static export + CI) → Task 1 (`output: export`) + Task 14. ✓
- **Out of scope (correctly deferred, per proposal):** the `create-better-microservices` CLI (#7); making the repo public (gated — drawer uses the docs fallback until then); per-axis impl detail. Surfaced as deploy TODOs.

**Placeholder scan:** No "TBD/implement later" in code steps. The Wizard step placeholders in Task 9 are explicitly replaced by real components in Tasks 10–12 (each shows the replacement line) — not dangling.

**Type consistency:** `WizardModel` (name, services, db, broker, orchestration, gateway, observability, ci, addons, embed) defined in Task 4, consumed unchanged by `compileCommand` (5), `encodeState/decodeState` (6), every step (10–12), Review (12). `dependencyHints(string[]) → Hint[]` consistent across Task 7 + 10. `compileCommand`/`encodeState`/`decodeState`/`dependencyHints` signatures identical between their test and their consumers.
