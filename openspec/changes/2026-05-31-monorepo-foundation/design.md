# Monorepo Foundation — Architecture

**Issue:** [#1](https://github.com/chimeranext/better-microservices/issues/1) (`service:cross-repo`)
**Status:** Design approved 2026-05-31
**Depends on:** nothing (this is the base change)
**PDR:** [`proposal.md`](./proposal.md)

## TL;DR

Build a single git repo whose history is the union of the 6 origin repos, each
rewritten under `services/<name>/`. Add a thin root layer (pnpm workspace, Turbo
skeleton, OpenSpec, docs/apps/packages placeholders). Non-Node services get a thin
`package.json` so Turbo can orchestrate a polyglot tree. Outward-facing steps
(push, issue migration, archiving) are gated behind explicit owner confirmation.

## Decision criteria (git history strategy)

Three options were weighed; any that loses history or corrupts the polyglot tree is
rejected.

## Matrix

| Option | Preserves history | `git log --follow` works | Robust w/ 6 heterogeneous repos | Verdict |
|---|---|---|---|---|
| **`git filter-repo` + merge** | Yes | Yes | Yes — explicit path rewrite per repo | **Accept.** |
| `git subtree` merge | Yes | Partially | Fragile — synthetic merges, awkward w/ many repos | Reject. |
| Fresh copy (drop `.git`) | No | No | N/A | Reject — owner wants history. |

## Target structure

```
better-microservices/                    # git init — single source of truth
├── services/
│   ├── agentic-core/      # ex lapc506/agentic-core      (Python + Go + Dart)
│   ├── compliance-core/   # ex lapc506/compliance-core   (Node)
│   ├── filing-core/       # ex lapc506/filing-core        (deferred)
│   ├── invoice-core/      # ex lapc506/invoice-core       (Node)
│   ├── marketplace-core/  # ex lapc506/marketplace-core  (Node + appchain)
│   └── payments-core/     # ex lapc506/payments-core     (Node)
├── apps/
│   └── web/               # placeholder — landing Shadcn (sub-project #6)
├── packages/
│   └── common/            # placeholder — shared contracts/config (#4 fills docs side)
├── docs/site/             # placeholder — MkDocs Material (sub-project #4)
├── openspec/              # governance + changes (THIS change lives here)
├── .github/workflows/     # CI + Pages placeholders
├── turbo.json             # skeleton (sub-project #3 develops it)
├── pnpm-workspace.yaml     # services/* apps/* packages/*
├── package.json           # root, private, packageManager: pnpm@9
├── .gitignore             # consolidated
└── README.md
```

**Path migration:** each `lapc506/<name>` repo root → `services/<name>/`.

## History consolidation procedure

For each of the 6 repos:

1. **Pre-flight safety gate.** Verify `git status --porcelain` is empty and no
   stashes dangle. `git filter-repo` rewrites from **commits**; uncommitted work is
   invisible to it and would be lost. Resolutions (already decided):
   - `agentic-core`: commit the 32 lines onto `docs/spike-eventbus-doc` first.
   - `filing-core`: commit the untracked `docs/superpowers/plans/` first.
2. **Filter.** Clone each repo (mirror, to carry all refs) into `/tmp/bms-migrate/<name>`
   and run `git filter-repo --to-subdirectory-filter services/<name>/`. All commits
   now sit under `services/<name>/`.
   - `agentic-core` & `marketplace-core`: the migrated trunk is the
     `docs/spike-eventbus-doc` branch (superset of `main`).
   - `agentic-core`: keep all branches (prefix `agentic-core/` to avoid clashes).
3. **Merge.** `git init` the monorepo; for each filtered repo add it as a remote and
   `git merge --allow-unrelated-histories`. Result: one history;
   `git log --follow services/<name>/...` shows each origin's full log.
4. **Root layer.** Commit the new root files (Turbo skeleton, pnpm-workspace,
   package.json, .gitignore, README, docs/apps/packages placeholders, openspec/).

The monorepo is built in a fresh working area; the 6 original folders are not
destructively touched until the result is verified.

## Polyglot workspace

- `pnpm-workspace.yaml` declares `services/*`, `apps/*`, `packages/*`.
- Non-Node services (`agentic-core` Python+Go, `filing-core` skeleton) get a thin
  `package.json` whose `build`/`test`/`lint` scripts passthrough to native tooling
  (`uv`/`pytest`, `go test`). Turbo orchestrates and caches by input hash without
  understanding Python/Go.
- Root `package.json` pins `packageManager: pnpm@9`.

## Architecture (consolidation flow)

```
lapc506/agentic-core ─┐  filter-repo → services/agentic-core/ (all branches)
lapc506/compliance ───┤  filter-repo → services/compliance-core/
lapc506/filing ───────┤  filter-repo → services/filing-core/
lapc506/invoice ──────┼─ merge --allow-unrelated-histories ─→ chimeranext/better-microservices
lapc506/marketplace ──┤  filter-repo → services/marketplace-core/ (spike trunk)
lapc506/payments ─────┘  filter-repo → services/payments-core/
                                              + root layer (turbo, pnpm, openspec, docs)
```

## Issue consolidation (design)

- Create labels: `service:*` (8 domains + `cross-repo`), and the adopted
  `type:/size:/priority:/component:/scope:/security:/status:/flag:` taxonomy.
- Create per-service milestones for Fase roadmaps (placeholders where future).
- **compliance-core / invoice-core:** group the 50/55 task-issues into ~14–16
  epics per service, one per `scope/` area, each epic body carrying the original
  tasks as a `- [ ]` checklist. (~30 issues instead of 105.)
- **agentic-core (8), marketplace-core (5), payments-core (12), filing-core (7):**
  migrate 1:1 with `service:*`; `filing-core` issues get `status:deferred`.
- **OpenSpec changes without a mirror issue** (8 agentic + the open payments ones):
  create mirror issues so every active change has a tracking issue.
- **Cross-repo issues** (agentic #90, marketplace #22, payments #36/#37, agentic
  #84 A2A): merge into **one** `platform` issue (sidecar standards / EventBus /
  gRPC Health v1 contract).

## Gated outward-facing steps

Each requires explicit owner go-ahead at execution time (hard to reverse):

1. **Push** monorepo → `chimeranext/better-microservices`.
2. **Labels + milestones + consolidated issues** creation.
3. **Archive** the 6 `lapc506` repos (read-only) + add a pointer README to each.

## Failure modes considered

| Failure | Mitigation |
|---|---|
| Uncommitted work lost | Pre-flight gate (step 1); commit decided changes first. |
| Caches (`node_modules`, `.venv`) baked into history | Verify they are gitignored before filtering; mirror clone respects `.gitignore` history but confirm no tracked artifacts. |
| Unrelated-history merge confusion | Sequential `--allow-unrelated-histories` + verify `git log --follow` per service. |
| Turbo breaks Python/Go | Thin `package.json` passthrough; native tooling untouched. |
| Wrong/duplicate issues created at scale | Dry-run the issue plan, owner approves the list before any `gh issue create`. |
| Premature archiving | Archive only after remote verification (step 1 confirmed). |

## What we will NOT build in this change

- Real Turbo pipeline (#3), docs content + Pages (#4), enforcement hooks (#5),
  landing page (#6), license resolution (#2). Only skeletons/placeholders here.

## References

- PDR: [`proposal.md`](./proposal.md)
- Checklist: [`tasks.md`](./tasks.md)
- `git filter-repo` docs · the shared ChimeraNext OpenSpec convention
