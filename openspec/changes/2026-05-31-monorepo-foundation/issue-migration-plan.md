# Issue Migration Plan (Phase 5)

> **Reviewable plan — nothing is created until you approve.** Consolidates 137 open
> issues + 32 OpenSpec changes from 6 `lapc506` repos into
> `chimeranext/better-microservices`, per the decisions in [`proposal.md`](./proposal.md).

## Summary of what gets created

| Bucket | Source | Result |
|---|---|---|
| Labels | 3 taxonomies | 1 unified taxonomy + `service:*` |
| Milestones | agentic Book-1..5 + per-service Fase roadmaps | per-service milestones |
| `platform` | agentic #90/#84, marketplace #22, payments #36/#37 | **1** merged issue |
| `agentic-core` | 8 open issues (−2 cross-repo) + 8 OpenSpec changes | 6 (1:1) + 8 (change mirrors) = **14** |
| `compliance-core` | 55 task-issues | **~16 epics** (task checklists) |
| `invoice-core` | 50 task-issues | **~16 epics** (task checklists) |
| `marketplace-core` | 5 open issues (−1 cross-repo) | **4** (1:1) |
| `payments-core` | 12 open issues (−2 cross-repo) + open changes w/o issue | **10** (1:1) + mirrors |
| `filing-core` | 7 monitoring issues | **7** (1:1, `status:deferred`) |
| **Total** | | **≈ 65–70 issues** (vs 137 raw) |

## 1. Labels (`gh label create`)

```bash
R=chimeranext/better-microservices
# service:* (domain ownership)
gh label create "service:agentic-core"     -R $R -c "8A63D2" -d "Agent runtime"
gh label create "service:compliance-core"  -R $R -c "B60205" -d "KYC/AML"
gh label create "service:filing-core"      -R $R -c "5319E7" -d "Regulatory filing (deferred)"
gh label create "service:invoice-core"     -R $R -c "0E8A16" -d "E-invoicing"
gh label create "service:marketplace-core" -R $R -c "1D76DB" -d "Storefront"
gh label create "service:payments-core"    -R $R -c "FBCA04" -d "Payments"
gh label create "service:common"           -R $R -c "C2E0C6" -d "Cross-service docs/contracts"
gh label create "service:cross-repo"       -R $R -c "D4C5F9" -d "Spans multiple services"
# type:*
for t in bug:d73a4a chore:fef2c0 feature:0E8A16 improvement:1D76DB spike:5319E7 design:BFD4F2; do
  gh label create "type:${t%%:*}" -R $R -c "${t##*:}"; done
# size:*  priority:*
for s in XS S M L XL; do gh label create "size:$s" -R $R -c "ededed"; done
for p in must:b60205 should:fbca04 could:0e8a16; do gh label create "priority:${p%%:*}" -R $R -c "${p##*:}"; done
# component:* (generic)
for c in transport domain application proto postgres grpc rest observability vault signature queue inbound infra security testing docs; do
  gh label create "component:$c" -R $R -c "c5def5"; done
# scope:* (domain-specific, preserved)  ·  security:*  ·  status/flag
for sc in ondato persona ofac sanctions hacienda-cr helm ci docker reporting; do gh label create "scope:$sc" -R $R -c "fef2c0"; done
for se in pii audit credentials signature; do gh label create "security:$se" -R $R -c "d93f0b"; done
gh label create "status:deferred" -R $R -c "cccccc" -d "Approved but not active"
for f in blocked:b60205 help-wanted:008672 quick-win:0e8a16 epic:5319E7; do gh label create "flag:${f%%:*}" -R $R -c "${f##*:}"; done
```

## 2. Milestones (per service)

```bash
# agentic-core (recreate Book arcs)
for m in "agentic-core Book-1" "agentic-core Book-2" "agentic-core Book-3" "agentic-core Book-4" "agentic-core Book-5"; do
  gh api repos/$R/milestones -f title="$m" >/dev/null; done
# Fase roadmaps (placeholders where future)
gh api repos/$R/milestones -f title="compliance-core Fase 1" >/dev/null
gh api repos/$R/milestones -f title="invoice-core Fase 1"   >/dev/null
gh api repos/$R/milestones -f title="payments-core P0/P1 adapters" >/dev/null
```

## 3. Issue mapping

### 3.1 Platform — 1 merged issue (`service:cross-repo` + `service:platform`)
**Title:** `[platform] Sidecar standards contract: gRPC Health v1 + structlog + OTel + EventBus adapter`
Absorbs: agentic #90, agentic #84 (A2A), marketplace #22, payments #36 (AgenticCheckoutPort), payments #37 (marketplace events). Body links all five originals.
Labels: `service:cross-repo` · `type:feature` · `size:L` · `priority:must` · `component:transport`.

### 3.2 agentic-core (14)
- **6 × 1:1** (`service:agentic-core`, keep original labels + Book milestones):
  - #83 Zensical docs site · #85 LLM-as-Judge · #86 Guardrails · #87 Contractor Pattern · #88 Reasoning Templates · #89 Chain of Debates
- **8 × OpenSpec change mirrors** (`service:agentic-core` · `type:feature`), one per change with no issue:
  `agent-intelligence` · `claw-code-patterns` · `docs-infrastructure` · `gemini-cli-patterns` · `genui-integration` · `nvidia-nemoclaw` · `standalone-agent-studio` · `tui-ralph-patterns`. Body links `services/agentic-core/openspec/changes/<slug>/`.

### 3.3 compliance-core (~16 epics, `service:compliance-core` · `flag:epic` · milestone "Fase 1")
One epic per `scope/`, body = `- [ ]` checklist of its source tasks (Task NN):
`proto` (T22-23) · `postgres` (T24-26) · `repositories` (T27-30) · `persona` (T31-38) ·
`ondato` (T39-42) · `ofac` (T43-46) · `sanctions` (T47-48) · `audit` (T49-52) ·
`grpc` (T53-54) · `services` (T55-57) · `rest` (T58-59) · `webhooks` (T60) ·
`observability` (T61-64) · `docker` (T65-68) · `helm` (T69-71) · `docs` (T72-75).
(+ folds open `domain` task #19/T15 into `repositories`.)

### 3.4 invoice-core (~16 epics, `service:invoice-core` · `flag:epic` · milestone "Fase 1")
One epic per `scope/`, body = checklist of source tasks:
`domain` (T11-21) · `use-cases` (T26-32) · `postgres` (T35-37) · `vault` (T40) ·
`signature` (T39,T41) · `hacienda-cr` (T33-34) · `queue` (T42) · `inbound` (T44) ·
`app/middleware` (T31) · `proto` (T34) · `grpc` (T43,45,46) · `rest` (T47) ·
`server` (T48,50) · `observability` (T41) · `docker` (T49,51,52) · `helm` (T53,55,56,54) ·
`docs` (T56-59) · `ci` (T60). _(Epics consolidated to ~16; exact task lists pulled from source at creation.)_

### 3.5 marketplace-core (4 × 1:1, `service:marketplace-core`)
#18 live-compose integration tests · #19 Flutter CI jobs · #20 remaining Storefront RPCs + Admin · #21 real widgets behind feature flags. (`type:improvement`/`feature`.)

### 3.6 payments-core (10 × 1:1 + change mirrors, `service:payments-core`)
1:1 (title `(P0/P1/P2/deferred)` → `priority:*`/`status:deferred`):
#29 Tilopay P1 · #30 Stripe Agentic P1 · #31 dLocal P2 · #32 Apple/Google Pay P2 ·
#33 Revolut · #34 Convera · #35 Ripple/XRPL · #38 Customs duty (deferred) ·
#39 Customs bond (deferred) · #44 Publish events.v1 to buf.build.
Mirrors: any of the 24 OpenSpec changes still open without an issue.

### 3.7 filing-core (7 × 1:1, `service:filing-core` · `status:deferred`)
#1-#7 Phase A trigger-monitoring. Keep #4 (pinned trigger status) pinned. **No implementation work** — service deferred to 2027.

## 4. Execution approach (when approved)

Agent team, **one teammate per service domain** (the `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS`
path), each owning only its `service:*` issues via `gh`:
1. Coordinator creates labels + milestones (idempotent).
2. Each teammate reads its source issues from `lapc506/<service>` and creates the
   mapped issues (epics carry full task checklists pulled from source).
3. Coordinator creates the single `platform` issue and cross-links the five originals.
4. Dry-run count check vs. this plan before declaring done.

## 5. Open choices for you
- Add a back-reference comment on each `lapc506` source issue pointing to its new
  monorepo issue? (default: **yes**, for traceability before archiving.)
- Close the `lapc506` source issues after mirroring, or leave them (they freeze on
  archive anyway)? (default: **leave** — archive freezes them.)
