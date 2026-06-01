# better-microservices

> Source-available microservices monorepo — **pick the services your startup needs.**

A curated set of production-grade microservices, each independently selectable, with
a unified docs site, issue tracker, and build tooling. Inspired by the
"pick-your-stack" experience of [create-better-t-stack](https://www.better-t-stack.dev/).

## Services

| Service | What it does | Stack | Status |
|---|---|---|---|
| [`agentic-core`](services/agentic-core) | Agent runtime (LLM orchestration, TUI, tools) | Python · Go · Dart | Active |
| [`compliance-core`](services/compliance-core) | KYC/AML, sanctions screening, audit | Node | Pre-alpha |
| [`filing-core`](services/filing-core) | Regulatory filing automation | Node | Deferred → 2027 |
| [`invoice-core`](services/invoice-core) | E-invoicing (Hacienda CR v4.4, XAdES) | Node | Pre-alpha |
| [`marketplace-core`](services/marketplace-core) | Storefront + schema-driven catalog | Node · appchain · Flutter | Active |
| [`payments-core`](services/payments-core) | Payment gateways, escrow, settlement | Node | Skeleton + adapters |

Each service keeps its **own license** — see the `LICENSE*` file inside each
`services/<name>/`.

## Repository layout

```
services/     # the microservices (one git history per service, preserved)
apps/         # frontends — apps/web is the landing-page selector (Shadcn)
packages/     # shared code/config — packages/common disambiguates cross-service concepts
docs/site/    # Material for MkDocs documentation site (GitHub Pages)
openspec/     # decision records (PDR/ADR) + governance — see openspec/project.md
```

## Tooling

- **Monorepo:** [Turborepo](https://turbo.build) + [pnpm](https://pnpm.io) workspaces (`pnpm@9`).
- **Decisions:** every significant decision is an [OpenSpec](openspec/README.md) change
  (`proposal.md` = PDR, `design.md` = ADR, `tasks.md` = checklist).
- **Polyglot:** non-Node services (`agentic-core`, `filing-core`) expose a thin
  `package.json` so Turbo can orchestrate them alongside the Node services.

## Getting started

```bash
pnpm install
pnpm build      # turbo run build across all services
pnpm test
```

## History

This monorepo consolidates six previously-separate repositories with their **full git
history preserved** (`git log --follow services/<name>/...`). See
[`openspec/changes/2026-05-31-monorepo-foundation`](openspec/changes/2026-05-31-monorepo-foundation/).
