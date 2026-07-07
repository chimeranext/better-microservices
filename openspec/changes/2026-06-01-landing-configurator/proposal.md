# Landing / Configurator — "pick your microservices" builder (Shadcn)

**Date:** 2026-06-01
**Owner:** Andrés (hello@chimeranext.dev)
**Status:** Modeled — pending implementation
**Domain:** `platform` (lives in `apps/web`)
**Tracking issue:** _to be created (`service:cross-repo`)_

---

## Why (Problem)

`better-microservices` lets any startup pick the services it needs, but there is no
front door. We need a landing page that — like [create-better-t-stack](https://www.better-t-stack.dev/) —
turns "which services do I want?" into a concrete, copyable scaffold command, and
lets a developer **investigate each service (README-first) before choosing it**.

## What (Decision)

Build `apps/web`: a Next.js + **Shadcn/ui** landing whose core is a **4-step wizard**
("Services → Infra → Addons → Review") that compiles, live, the command:

```
npx create-better-microservices <name> --services … --db … --broker … \
  --orchestration … [--gateway] [--observability] --ci … [--addons …]
```

Each **service card** has a **"View README" drawer** (renders the service's raw
`README.md` inline) plus a **"docs ↗"** link to the docs site — so picking is an
informed decision, preserving the README-first experience of the old separate repos.

| Decision | Resolution |
|---|---|
| Selector output | A **CLI command** (better-t-stack style). |
| What the CLI scaffolds | A **Turbo monorepo** embedding selected services as **git submodules** of the public repo. |
| Distribution | Monorepo becomes **public source-available** (BSL retained). *(Gated future step.)* |
| Layout | **4-step wizard** (Services → Infra → Addons → Review). |
| Configurator axes (v1) | services · database · orchestration · **event bus** · **API gateway** · **observability** · **CI + addons**. |
| README access | **Inline drawer** (raw `README.md` from `main`) **+ link to docs site**. |
| README coverage | Every service AND every internal package must have a README (3 gaps being filled in `2026-06-01-docs-site`). |
| Web stack | Next.js (App Router) + Shadcn/ui + Tailwind + TS; **wizard state encoded in the URL** (shareable configs). |
| Implementation | **Agent team per axis** (owner directive) when building. |

## Scope

**In scope (this change = the web configurator):** `apps/web` wizard, the **command
contract** (the flags), the README drawer, shareable-URL state, service-dependency
hints, marketing shell (hero, services showcase).

**Out of scope:**
- **#7 `create-better-microservices` CLI** — the scaffolder the command invokes is its
  own sub-project (submodule mechanics: per-service split repos vs whole-monorepo
  sparse-checkout = open question there).
- Making the repo public (gated infra step).
- Per-axis implementation detail (event bus options, gateway impl) beyond exposing them as flags.

## Open Questions / Non-goals

- `filing-core` is deferred → shown as a disabled card labeled "2027".
- Submodule-of-a-subdirectory is not possible; #7 decides per-service split repos vs sparse-checkout.

## References

- ADR: [`design.md`](./design.md) · Tasks: [`tasks.md`](./tasks.md)
- Inspiration: better-t-stack.dev · AmanVarshney01/create-better-t-stack
- Docs site (README-first): `openspec/changes/2026-06-01-docs-site/`
