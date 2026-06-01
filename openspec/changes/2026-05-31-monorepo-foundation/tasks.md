# Monorepo Foundation — Tasks

> Implementation checklist for [`proposal.md`](./proposal.md) / [`design.md`](./design.md).
> Phases marked **🚧 GATED** require explicit owner go-ahead (outward-facing / hard to reverse).
> `$ROOT` = `/home/kvttvrsis/Documentos/GitHub/chimeranext/better-microservices`.

## Status (2026-05-31)

- ✅ **Phase 0** — OpenSpec scaffold + change docs + spike brief.
- ✅ **Phase 1** — pre-flight commits (`agentic-core` 32 lines, `filing-core` plans); all repos clean; no cache leaks.
- ✅ **Phase 2** — filter-repo + merge → `/tmp/bms-mono`, 223 commits, history preserved, 19 agentic branches.
- ✅ **Phase 3** — root layer (pnpm/Turbo/OpenSpec/placeholders) + **swap**: `$ROOT` is now the monorepo clone.
- ✅ **Phase 4** — pushed to `chimeranext/better-microservices` (main + 19 branches); remote verified.
- ✅ **Phase 5** — labels (70) + milestones (8) + **68 issues** created (epics + 1:1 + mirrors + platform #2 + foundation #1); back-references on source issues.
- ✅ **Phase 6** — 6 `lapc506` repos archived (read-only) with README pointers. Note: monorepo issue #18 (filing Task A4) should be pinned manually via the GitHub UI.

**Sub-project #1 SHIPPED 2026-06-01.** Next: #2 licenses · #3 Turbo pipeline · #4 docs site · #5 OpenSpec hooks · #6 landing page.

## Phase 0 — Spec & scaffold (local, safe)

- [x] `openspec/project.md` (governance)
- [x] `openspec/README.md` (index)
- [x] `openspec/changes/2026-05-31-monorepo-foundation/{proposal,design,tasks}.md`
- [x] Spike brief draft → `spike-brief.md`
- [ ] Remove legacy `docs/superpowers/specs/2026-05-31-monorepo-foundation-design.md` (content now lives in this change)

## Phase 1 — Pre-flight safety gate (per repo)

- [ ] Re-verify each repo is clean before filtering:
  ```bash
  for d in agentic-core compliance-core filing-core invoice-core marketplace-core payments-core; do
    echo "== $d =="; git -C "$ROOT/$d" status --porcelain; git -C "$ROOT/$d" stash list
  done
  ```
- [ ] **agentic-core** — commit the 32 lines of real work onto the trunk branch:
  ```bash
  git -C "$ROOT/agentic-core" add -A
  git -C "$ROOT/agentic-core" commit -m "feat: vLLM Helm values, model registry, TUI components, settings UI

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
  ```
- [ ] **filing-core** — commit the untracked plans dir:
  ```bash
  git -C "$ROOT/filing-core" add docs/superpowers/plans
  git -C "$ROOT/filing-core" commit -m "docs(plans): add filing-core trigger and skeleton plan

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
  ```
- [ ] Confirm caches are gitignored (no tracked `node_modules`, `.venv`, `*_cache`):
  ```bash
  for d in agentic-core compliance-core filing-core invoice-core marketplace-core payments-core; do
    git -C "$ROOT/$d" ls-files | grep -E 'node_modules/|\.venv/|_cache/' && echo "LEAK in $d" || echo "$d clean"
  done
  ```

## Phase 2 — History consolidation

- [ ] Prepare build area: `rm -rf /tmp/bms-migrate && mkdir -p /tmp/bms-migrate`
- [ ] Mirror-clone + filter each repo (path-prefix under `services/<name>/`):
  ```bash
  for d in agentic-core compliance-core filing-core invoice-core marketplace-core payments-core; do
    git clone --mirror "$ROOT/$d/.git" "/tmp/bms-migrate/$d.git"
    ( cd "/tmp/bms-migrate/$d.git" && git filter-repo --force --to-subdirectory-filter "services/$d/" )
  done
  ```
- [ ] Build the monorepo history in a fresh area and merge each trunk:
  ```bash
  rm -rf /tmp/bms-mono && git init /tmp/bms-mono && cd /tmp/bms-mono
  git commit --allow-empty -m "chore: initialize better-microservices monorepo

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
  # trunk ref per service: spike branch for agentic & marketplace, main for the rest
  declare -A TRUNK=( [agentic-core]=docs/spike-eventbus-doc [marketplace-core]=docs/spike-eventbus-doc \
    [compliance-core]=main [filing-core]=main [invoice-core]=main [payments-core]=main )
  for d in agentic-core compliance-core filing-core invoice-core marketplace-core payments-core; do
    git remote add "$d" "/tmp/bms-migrate/$d.git"
    git fetch "$d"
    git merge --allow-unrelated-histories --no-edit "$d/${TRUNK[$d]}"
  done
  ```
- [ ] Bring **all** of agentic-core's branches (prefixed) without polluting trunk:
  ```bash
  cd /tmp/bms-mono
  git fetch agentic-core 'refs/heads/*:refs/heads/agentic-core/*'
  ```
- [ ] Drop the temp remotes: `for d in ...; do git remote remove "$d"; done`
- [ ] Verify history per service:
  ```bash
  for d in agentic-core compliance-core filing-core invoice-core marketplace-core payments-core; do
    echo "== $d =="; git -C /tmp/bms-mono log --oneline --follow -- "services/$d" | head -3
  done
  ```

## Phase 3 — Root layer (local, safe)

- [ ] Add root files in `/tmp/bms-mono`: `pnpm-workspace.yaml`, `package.json`
  (`packageManager: pnpm@9`, private), `turbo.json` (skeleton), consolidated
  `.gitignore`, `README.md`.
- [ ] Add placeholders: `apps/web/.gitkeep`, `packages/common/.gitkeep`,
  `docs/site/.gitkeep`, `.github/workflows/.gitkeep`.
- [ ] Copy in the `openspec/` scaffold authored in Phase 0.
- [ ] Thin `package.json` passthrough for `services/agentic-core` and
  `services/filing-core` (`build`/`test`/`lint` → native tooling).
- [ ] Commit the root layer.
- [ ] Swap `/tmp/bms-mono` into `$ROOT` (replace the 6 nested-repo folders with the
  consolidated tree), preserving the already-authored `openspec/` + this change.

## Phase 4 — Push to remote 🚧 GATED

- [ ] `git -C "$ROOT" remote add origin https://github.com/chimeranext/better-microservices.git`
- [ ] Confirm with owner, then push trunk + all branches:
  ```bash
  git -C "$ROOT" push -u origin HEAD:main
  git -C "$ROOT" push origin 'refs/heads/agentic-core/*'
  ```
- [ ] Verify the remote tree + `git log --follow` for a sample service.

## Phase 5 — Labels, milestones & consolidated issues 🚧 GATED

- [ ] Create the label taxonomy (`service:*` + adopted dimensions) on
  `chimeranext/better-microservices` via `gh label create`.
- [ ] Create per-service milestones (Fase roadmaps; placeholders where future).
- [ ] Generate the **issue migration plan** as a reviewable file; owner approves the
  full list before any creation.
- [ ] compliance-core / invoice-core → ~14–16 epics each (checklist of tasks).
- [ ] agentic / marketplace / payments / filing → 1:1 (`filing-core` = `status:deferred`).
- [ ] Mirror issues for OpenSpec changes lacking one.
- [ ] One merged `platform` issue for the cross-repo sidecar/EventBus/Health contract.

## Phase 6 — Archive origin repos 🚧 GATED

- [ ] After remote verification, per `lapc506/<name>`: add a README pointer to the
  monorepo, then `gh repo archive lapc506/<name> --yes`.

## Verification (done = all checked)

- [ ] `$ROOT` is one git repo; `git log --follow services/<name>/...` shows each origin's history.
- [ ] Topology matches design; pnpm-workspace + Turbo skeleton + openspec present.
- [ ] Non-Node services have passthrough `package.json`.
- [ ] Pushed to `chimeranext/better-microservices` (post-gate).
- [ ] Consolidated issues + labels created (post-gate).
- [ ] 6 `lapc506` repos archived (post-gate).
- [ ] No uncommitted work from origin repos was lost.
