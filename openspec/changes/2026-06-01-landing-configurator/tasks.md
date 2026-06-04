# Landing / Configurator — Tasks

> Implementation checklist for [`proposal.md`](./proposal.md) / [`design.md`](./design.md).
> Owner directive: build with an **agent team per axis** (services/infra/addons cards,
> command compiler, README drawer). Status: **implemented as a single-page "builder" (better-t-stack /new layout) — PR #73.**

## Phase 0 — Design
- [x] PDR (proposal.md), ADR (design.md), tasks.md
- [x] Command contract fixed
- [ ] Create tracking issue (`service:cross-repo`, `type:feature`, `flag:epic`)

## Phase 1 — Scaffold `apps/web`
- [x] Next.js (App Router) + TS in `apps/web` (static export), wired into pnpm workspace + Turbo.
- [x] Shadcn/ui + Tailwind init; **Chimera palette** theme (dark), Sora + Inter + JetBrains Mono.
- [x] Marketing shell at `/`: hero + 6-services showcase + footer + "Build your stack →" CTA to `/new`.

## Phase 2 — Builder shell & state (pivoted from a 4-step wizard → single-page builder at `/new`)
- [x] Single-page **builder** at `/new` (better-t-stack /new layout): sticky sidebar + category sections + Randomize/Reset/Share.
- [x] **URL-encoded state** (shareable configs) ⇄ model (`encodeState`/`decodeState`, defaults omitted).
- [x] Command compiler: model → `npx create-better-microservices …` (live + Copy); project name validated/sanitized (clipboard-injection hardening).

## Phase 3 — Category sections (cards per axis)
- [x] Services: 6 cards (filing-core disabled "2027"), multi-select, dependency hints.
- [x] Infra: database · broker (NATS/Kafka/Redis) · orchestration · gateway (cards, with "No X" options).
- [x] Addons: observability · ci · extra addons · embed (submodule/vendor).
- [x] PREVIEW tab: project-tree preview + docs links; sidebar SELECTED STACK chips; Randomize.

## Phase 4 — README drawer (README-first)
- [x] "View README" on builder service cards → Shadcn `Sheet` rendering markdown (`react-markdown`).
- [x] Source raw `README.md` from `main`; falls back to the docs-site link until the repo is public.
- [x] "Full docs ↗" link to the docs-site service tab.

## Phase 5 — Deploy
- [x] Static export (`output: 'export'` → `apps/web/out/`).
- [x] CI job in the monorepo workflow (`.github/workflows/web.yml`: build + test).
- [ ] Pick the deploy target (Vercel vs GitHub Pages) and wire the publish step.

## Gated / dependencies
- [ ] 🚧 Make repo public source-available (for raw README fetch + submodules).
- [ ] ⏳ Sub-project #7: the `create-better-microservices` CLI the command invokes.
