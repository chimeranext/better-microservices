# Monorepo Foundation — consolidate 6 microservices into `chimeranext/better-microservices`

**Date:** 2026-05-31
**Owner:** Andrés (andres@dojocoding.io)
**Status:** Design approved — pending implementation
**Domain:** `platform`
**Tracking issue:** _to be created (`service:cross-repo`)_

---

## Why (Problem)

Six microservices today live as **independent git repos** under
`github.com/lapc506/*`, checked out flat inside a non-git folder. This blocks the
product vision of **better-microservices**: a single place where any startup can
pick the services it needs (à la `create-better-t-stack`). It also fragments:

- **Docs** — each service documents itself in isolation; cross-service concepts
  (e.g. the eventbus broker analysis) are duplicated or ambiguous.
- **Tracking** — 137 open issues across 3 incompatible label taxonomies, plus 32
  OpenSpec changes, with no unified view.
- **Tooling** — no shared build/test orchestration, no shared release story.

## What (Decision)

Consolidate the 6 repos into one monorepo at `chimeranext/better-microservices`
**preserving full git history**, under a `services/` + `apps/` + `packages/` +
`docs/` topology, and make this monorepo the single source of truth.

Fixed decisions (confirmed with owner):

| Decision | Resolution |
|---|---|
| Git history | **Preserve** via `git filter-repo --to-subdirectory-filter services/<name>/` + merge. |
| Origin `lapc506` repos | **Archive** (read-only) after migration. |
| `agentic-core` 32 uncommitted lines | **Commit** before migrating (real work: Helm, vLLM, TUI Go, Dart UI). |
| Trunk ref for `agentic-core` & `marketplace-core` | The **`docs/spike-eventbus-doc`** branch (superset of `main`, holds the eventbus doc). |
| `agentic-core` extra branches | **Bring all branches** (prefixed to avoid clashes). |
| Topology | **`services/` + `apps/` + `packages/common` + `docs/site`**. |
| Workspace manager | **pnpm@9** (unified). |
| Decision records | **OpenSpec** convention (this repo) — PDR/ADR/tasks per change. |
| Issue taxonomy | Adopt `agentic-core`'s + orthogonal `service:*` labels. |
| `compliance-core` / `invoice-core` issues (50/55) | Consolidate into **~14–16 epics per service** (checklist of tasks). |
| Other issues (agentic 8, marketplace 5, payments 12, filing 7) | Migrate **1:1** + mirror issues for OpenSpec changes. |
| `filing-core` | Migrate as **`status:deferred`** (approved but deferred to 2027). |
| Cross-repo issues (sidecar/EventBus/Health) | **Merge into 1 `platform` issue.** |

## Scope

**In scope (this change):** repo structure, git-history consolidation, pnpm
workspace + Turbo skeleton, thin `package.json` passthrough for non-Node services,
OpenSpec governance scaffold, push to remote (gated), label/milestone creation,
consolidated issue migration (gated), archiving origin repos (gated).

**Out of scope (later sub-projects):**
- #2 Per-service licenses (resolve `agentic-core` & `marketplace-core`; normalize BSL).
- #3 Real Turborepo pipeline (this change ships only the skeleton).
- #4 Docs site content + `common` section + GitHub Pages workflow.
- #5 OpenSpec enforcement hooks across all services.
- #6 Landing page (Shadcn microservice selector).

## Open Questions / Non-goals

- Per-service Fase 2–N roadmaps become **placeholder milestones**; not detailed here.
- Mirror-as-split (publishing individual services) is **not** done — owner chose
  archive, monorepo is the only source of truth.

## References

- ADR: [`design.md`](./design.md)
- Tasks: [`tasks.md`](./tasks.md)
- Convention source: `dojocoding/dojo-os` `openspec/`
- Docs site reference: `habitanexus/monorepo/docs/site/` (Material for MkDocs)
