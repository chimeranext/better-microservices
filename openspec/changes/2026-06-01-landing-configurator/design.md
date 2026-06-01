# Landing / Configurator — Architecture

**Issue:** _to be created_ (`service:cross-repo`)
**Status:** Modeled 2026-06-01
**Depends on:** `2026-06-01-docs-site` (README-first docs the cards link to); a future
public-repo step; sub-project #7 (the CLI the command invokes).
**PDR:** [`proposal.md`](./proposal.md)

## TL;DR

`apps/web` is a Next.js + Shadcn wizard that is a **command compiler**: every control
maps to a flag of `npx create-better-microservices`. Service cards render the
service's README in a drawer (README-first). Wizard state lives in the URL so configs
are shareable. The CLI that the command runs is sub-project #7.

## Architecture

```
apps/web (Next.js + Shadcn)                     create-better-microservices (#7, npm)
┌─────────────────────────────────┐             ┌─────────────────────────────────┐
│ Hero / marketing shell          │             │ reads flags → scaffolds:        │
│ ┌─ Wizard (4 steps) ──────────┐ │  command    │  my-startup/                    │
│ │ 1 Services  (cards+README)  │ │  ─────────▶ │    services/* (submodules)      │
│ │ 2 Infra     (db/broker/...) │ │  (copyable) │    apps/gateway/ (if --gateway) │
│ │ 3 Addons    (obs/ci/...)    │ │             │    packages/common/             │
│ │ 4 Review    (cmd+tree+copy) │ │             │    docker-compose / helm        │
│ └─────────────────────────────┘ │             │    turbo.json pnpm-workspace    │
│ state ⇄ URL (shareable)         │             └─────────────────────────────────┘
└─────────────────────────────────┘
        │ "View README" → drawer
        ▼ raw.githubusercontent.com/chimeranext/better-microservices/main/services/<name>/README.md
```

## Command contract (the flags the wizard compiles)

| Flag | Source step | Values |
|---|---|---|
| `<project-name>` | header | string |
| `--services` | 1 | csv of the 6 (≥1; `filing-core` disabled) |
| `--db` | 2 | `postgres` (default) |
| `--broker` | 2 | `nats` \| `kafka` \| `redis` |
| `--orchestration` | 2 | `docker-compose` \| `k8s-helm` \| `both` |
| `--gateway` | 2 | boolean |
| `--observability` | 3 | boolean (OTel + Grafana/Prometheus) |
| `--ci` | 3 | `github-actions` \| `none` |
| `--addons` | 3 | csv (`pre-commit`, `dockerfiles`, `env-example`) |
| `--embed` | (review) | `submodule` (default) \| `vendor` |
| `--pm` | (review) | `pnpm` |

## Wizard steps

1. **Services.** 6 cards (filing-core disabled "2027"). Each: name, stack badges,
   one-line purpose, **[View README]** (drawer), **[docs ↗]**. ≥1 required.
   **Dependency hints:** marketplace-core without payments-core → warn (purchase
   events lack settlement); agentic-core checkout → suggests payments-core.
2. **Infra.** Database, Event bus broker (NATS/Kafka/Redis — per the eventbus broker
   analysis in Common), Orchestration target, API Gateway toggle.
3. **Addons.** Observability toggle, CI toggle, extra addons.
4. **Review.** Sticky command bar + **copy**; generated **project tree** preview;
   "what you get" summary; links to each selected service's docs.

## README drawer (README-first)

- Trigger: `[View README]` on any service (and package) card.
- Source: fetch raw `README.md` from `main` (`raw.githubusercontent.com/.../services/<name>/README.md`)
  — single source of truth, always fresh, zero duplication. Requires the repo to be
  public (gated). Until then, a build-time snapshot fallback.
- Render: markdown in a Shadcn `Sheet`/drawer; footer link "Full docs ↗" → the docs
  site service tab (whose index is also the README, per `2026-06-01-docs-site`).

## Tech stack

- **Next.js (App Router) + Shadcn/ui + Tailwind + TypeScript** in `apps/web`.
- **URL-encoded wizard state** (query/hash) → shareable "here's my stack" links (growth loop).
- Static-exportable (Vercel or GitHub Pages). Lives in the monorepo workspace (Turbo).

## What we will NOT build in this change

- The `create-better-microservices` CLI (#7) — only its **command contract** is fixed here.
- Real event-bus/gateway/observability implementations — only exposed as flags.
- Repo-visibility change (gated infra step).

## Open questions deferred (to #7)

- Submodule of a subdirectory is impossible → per-service public **split repos**
  (`git subtree split`, read-only mirrors) vs **whole-monorepo submodule + sparse-checkout**.
- `--embed vendor` (subtree copy) as an offline/BSL-friendly alternative.

## References

- PDR: [`proposal.md`](./proposal.md) · Tasks: [`tasks.md`](./tasks.md)
