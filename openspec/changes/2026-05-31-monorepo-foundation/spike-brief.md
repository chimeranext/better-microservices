# Monorepo Foundation — consolidate 6 microservices with preserved history

<!-- Labels (set in GitHub sidebar, NOT in body):
     service:cross-repo · type:spike · size:L · priority:must · component:infra · flag:epic -->

## 👤 HUMAN LAYER

### User Story
As the **owner of better-microservices**, I want **the 6 `lapc506` microservices
consolidated into one `chimeranext/better-microservices` monorepo with their full
git history preserved** so that **any startup can browse, pick, and adopt services
from a single source of truth with unified docs, tracking, and tooling**.

### Background / Why
Each service is its own repo today, checked out flat in a non-git folder. That
fragments docs (cross-service concepts like the eventbus broker analysis are
duplicated), tracking (137 open issues in 3 incompatible taxonomies + 32 OpenSpec
changes), and tooling (no shared build/test). This spike lays the foundation:
structure, history merge, polyglot workspace, OpenSpec governance, and the gated
GitHub migration. Five other sub-projects (licenses, Turbo pipeline, docs site,
OpenSpec hooks, landing page) build on top.

### Analogy
Like moving six separate apartments into one well-organized house: each tenant
(service) keeps their furniture and their memories (git history), but now they
share a front door (remote), a directory board (docs tabs), and a mailbox (issues).

### UX / Visual Reference
Topology: `services/{6 services}/` + `apps/web` + `packages/common` + `docs/site` +
`openspec/`. Docs tabs mirror `habitanexus/monorepo/docs/site` (Material for MkDocs).

### Known Pitfalls & Gotchas
- **`git filter-repo` rewrites from commits, not the working tree** — uncommitted
  work is invisible and would be lost. `agentic-core` has 32 real uncommitted lines
  and `filing-core` 1 untracked dir; both committed first (decided).
- `agentic-core` & `marketplace-core` live on `docs/spike-eventbus-doc` (superset of
  `main`); that branch is the migrated trunk.
- `agentic-core` has 2 extra branches + 3 worktrees — all branches are brought,
  prefixed `agentic-core/`.
- Archiving the origin repos is irreversible-ish — gated behind remote verification.

## 🤖 AGENT LAYER

### Objective
Produce one git repo at `chimeranext/better-microservices` whose history is the
union of the 6 origin repos (each under `services/<name>/`), with a pnpm workspace,
Turbo skeleton, OpenSpec governance, and consolidated issues — then archive origins.

### Context Files
- `openspec/changes/2026-05-31-monorepo-foundation/proposal.md` — the PDR (decisions).
- `openspec/changes/2026-05-31-monorepo-foundation/design.md` — the ADR (procedure, matrix).
- `openspec/changes/2026-05-31-monorepo-foundation/tasks.md` — the bite-sized checklist.
- `openspec/project.md` — governance + label taxonomy.
- `habitanexus/monorepo/docs/site/mkdocs.yml` — docs site reference (sub-project #4).

### Acceptance Criteria
- [ ] `better-microservices/` is a single git repo with history preserved per service.
- [ ] `git log --follow services/<name>/...` shows each origin's original history.
- [ ] Topology `services/` + `apps/web` + `packages/common` + `docs/site` + `openspec/` exists.
- [ ] `pnpm-workspace.yaml`, root `package.json` (`pnpm@9`), `turbo.json` skeleton present.
- [ ] Non-Node services (`agentic-core`, `filing-core`) have passthrough `package.json`.
- [ ] No uncommitted work from origin repos was lost.
- [ ] (Gated) Pushed to `chimeranext/better-microservices`.
- [ ] (Gated) Labels + milestones + consolidated issues created.
- [ ] (Gated) 6 `lapc506` repos archived with pointer READMEs.

### Technical Constraints
- History preserved via `git filter-repo --to-subdirectory-filter services/<name>/`
  + `git merge --allow-unrelated-histories` (no subtree, no fresh-copy).
- Build the monorepo in a temp area; do not destructively touch origin folders until verified.
- OpenSpec convention from `dojocoding/dojo-os` (no YAML frontmatter; bold metadata).
- Label taxonomy from `agentic-core` + orthogonal `service:*`.

### Verification Commands
```bash
# History preserved per service
for d in agentic-core compliance-core filing-core invoice-core marketplace-core payments-core; do
  git -C "$ROOT" log --oneline --follow -- "services/$d" | head -3
done
# Workspace resolves
pnpm -C "$ROOT" install --frozen-lockfile=false -r --dry-run || true
# No tracked caches
git -C "$ROOT" ls-files | grep -E 'node_modules/|\.venv/|_cache/' && echo LEAK || echo clean
```

### Agent Strategy
**Mode:** `Worktree` + `Team` (the risky history merge runs solo/sequential; issue
migration fans out per service).

### If Worktree:
- **Isolation reason:** the history rewrite + merge must not touch the working repos
  until verified; build in `/tmp/bms-mono` then swap into `$ROOT`.
- **Merge strategy:** sequential `--allow-unrelated-histories`, verify before swap.

### If Team (Phase 5 issue migration):
- **Lead role:** Coordinator — owns label/milestone creation, approves issue list, no direct mass-create until owner OK.
- **Teammates:** one per service domain → owns that service's issue consolidation
  (compliance/invoice → epics; agentic/marketplace/payments/filing → 1:1 + mirrors).
- **File ownership:** each teammate only touches its `service:*` issues via `gh`.
- **Plan approval required:** yes — owner approves the generated issue plan first.

### Slack Notification
N/A — owner is in-session; report progress inline at each gate.

---

## 🔀 Parallelization Recommendation
**Recommended mechanism:** `Git Worktrees` (Phases 1–4) → `Agent Teams` (Phase 5).
**Reasoning:** the history consolidation is a single coherent sequence with an
irreversible swap — parallelizing it risks corruption (Solo/Worktree, 1x). Issue
migration is cleanly partitionable by service domain with no shared state (Teams,
~3–4x). Push/archive are gated single actions (Solo).
**Size → Mechanism mapping:** L + multi-area → Worktree isolation for the core,
Teams(per-domain) for the fan-out phase.
**Cost estimate:** ~1x for Phases 1–4, ~4x for Phase 5 (6 domain teammates).

---

### Synthesis Additional Comments

**5 Whys:** Why consolidate? → fragmented repos. Why fragmented? → each grew
independently on a personal account. Why does that block the product? → "pick your
services" needs one browseable source. Why now? → before licenses/docs/landing can
sit on top. Why preserve history? → real authorship/decisions live in those commits.

#### MECE Logical Validation
* **Mutually Exclusive:** structure, history, workspace, governance, issues, and
  archiving are non-overlapping work units; each maps to a distinct phase.
* **Collectively Exhaustive:** covers code (filter-repo), tooling (pnpm/Turbo),
  decisions (OpenSpec), tracking (issues/labels/milestones), and origin cleanup
  (archive). License/docs/hooks/landing are explicitly deferred sub-projects.

#### Executive Synthesis (Minto Pyramid)
1. **Answer:** Merge 6 repos into one history-preserving monorepo, then migrate tracking.
2. **Supporting:** `filter-repo` path-rewrite + unrelated-history merge; polyglot
   pnpm/Turbo via thin passthrough; OpenSpec as decision home; gated GitHub steps.
3. **Evidence:** pre-flight showed 2 dirty repos + 2 non-main trunks + extra branches
   — all resolved by explicit owner decisions before any rewrite.

#### Pareto 80/20 Efficiency Review
* 80% of value = structure + preserved history + unified tracker; achieved by Phases 1–5.
* Over-engineering flag avoided: Turbo pipeline, docs content, hooks, landing are
  deferred — not built in this foundation.
* Grouping compliance/invoice's 105 task-issues into ~30 epics is the 20%-effort,
  80%-clarity move.

#### Second-Order Thinking & Risk Assessment
* **Scalability:** adding a 7th service later = one more `services/<name>/` +
  `service:*` label; topology already supports it.
* **Downstream Effects:** archiving origins redirects any external consumers — pointer
  READMEs mitigate; mirror-split was explicitly declined.
* **Future Maintenance:** OpenSpec + unified taxonomy prevent taxonomy drift the
  3-way split would otherwise reintroduce.
