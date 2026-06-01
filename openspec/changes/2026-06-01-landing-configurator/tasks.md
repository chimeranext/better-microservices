# Landing / Configurator — Tasks

> Implementation checklist for [`proposal.md`](./proposal.md) / [`design.md`](./design.md).
> Owner directive: build with an **agent team per axis** (services/infra/addons cards,
> command compiler, README drawer). Status: **design done; implementation not started.**

## Phase 0 — Design
- [x] PDR (proposal.md), ADR (design.md), tasks.md
- [x] Command contract fixed
- [ ] Create tracking issue (`service:cross-repo`, `type:feature`, `flag:epic`)

## Phase 1 — Scaffold `apps/web`
- [ ] Next.js (App Router) + TS in `apps/web`, wired into pnpm workspace + Turbo.
- [ ] Shadcn/ui + Tailwind init; base theme (dark/light), Inter + JetBrains Mono.
- [ ] Marketing shell: hero + 6-services showcase + footer.

## Phase 2 — Wizard shell & state
- [ ] 4-step wizard component (Services → Infra → Addons → Review) with progress.
- [ ] **URL-encoded state** (shareable configs) ⇄ wizard model.
- [ ] Command compiler: wizard model → `npx create-better-microservices …` string.

## Phase 3 — Step content (agent team per axis)
- [ ] Step 1 Services: 6 cards (filing-core disabled "2027"), multi-select, dependency hints.
- [ ] Step 2 Infra: db · broker (NATS/Kafka/Redis) · orchestration · gateway toggle.
- [ ] Step 3 Addons: observability · ci · extra addons.
- [ ] Step 4 Review: sticky command + copy · generated project-tree preview · docs links.

## Phase 4 — README drawer (README-first)
- [ ] `[View README]` on service/package cards → Shadcn `Sheet` rendering markdown.
- [ ] Source raw `README.md` from `main` (fallback: build-time snapshot until repo public).
- [ ] "Full docs ↗" link to the docs-site service tab.

## Phase 5 — Deploy
- [ ] Static export + deploy target (Vercel or GitHub Pages alongside the docs site).
- [ ] CI job in the monorepo workflow.

## Gated / dependencies
- [ ] 🚧 Make repo public source-available (for raw README fetch + submodules).
- [ ] ⏳ Sub-project #7: the `create-better-microservices` CLI the command invokes.
