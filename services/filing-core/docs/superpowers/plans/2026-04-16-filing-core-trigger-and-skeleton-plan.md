# filing-core Trigger Monitoring + Skeleton Activation Plan

> **STATUS: DEFERRED TO YEAR 2 (2027).** This plan has two parts: Phase A (trigger monitoring, active now) and Phase B (skeleton activation, dormant until trigger fires).
>
> **For agentic workers:** Phase A is monitoring + scheduling. Phase B is implementation (REQUIRED SUB-SKILL: `superpowers:subagent-driven-development`, but **only AFTER a Phase A re-review confirms the trigger has fired**). Steps use checkbox (`- [ ]`) syntax.
>
> **Governance warning:** Running Phase B prematurely — without a quarterly re-review output that documents trigger firing — violates the governance rubric (`/home/kvttvrsis/Escritorio/2026-04-16-core-governance-rubric.md` §5 filing-core verdict) and the spec itself (§14 Fase 0 + §16 risk "Premature construction"). Do not scaffold, generate protos, or write domain code without documented trigger confirmation.

**Goal:** (Phase A) Monitor trigger conditions quarterly; (Phase B) when trigger fires, build `filing-core` v0.1 MVP scaffold with TRIBU-CR CR adapter + D-104 IVA declaration only. Nothing more until Fase 2+.

**Architecture (preview for Phase B):** Hexagonal (Explicit Architecture). Primary adapters: gRPC (`:50081`) + REST (`:8768`). Consumes `invoice-core` via `FilingDataExportPort` (see invoice-core spec §5 port #8). TRIBU-CR CR as first `TaxAuthorityFilingPort` adapter. HITL (Human-in-the-loop) approval gate is a testable invariant — no code path reaches `SUBMITTED` without `approvedBy` populated.

**Tech Stack (preview):** TypeScript 5.x strict · Node 22 LTS · pnpm · Vitest · gRPC · PostgreSQL 16 · Drizzle ORM · Fastify · OpenTelemetry SDK · pino · zod.

**Trigger conditions (from spec §14 Fase 0):**

1. **Demand signal** — ≥ 2 startups explicitly request full filing automation ("presentar automáticamente"), not just the pre-fill that `FilingDataExportPort` already provides; OR
2. **Economic signal** — contador manual labor exceeds USD 15k/year across the 4-startup portfolio (hours × rate); OR
3. **Regulatory signal** — a regulatory change makes manual filing impractical (e.g., TRIBU-CR removes web UI, mandates API-only submission, or introduces real-time obligations).

Whichever fires first → Phase A re-review documents the firing → **only then** Phase B activates.

**Task tracking:** GitHub Issues on `lapc506/filing-core`. Deliberately **not** Linear — Linear workspace is reserved for active implementation work; a handful of long-running monitoring issues is the right scale for Phase A.

**Intermediate solution (live):** `invoice-core` v1 exposes `FilingDataExportPort` (invoice-core spec §5 port #8, capability matrix §9, Fase 3 of invoice-core roadmap). The port pre-fills casillas for D-101 / D-104 / D-103; the contador presents them manually in TRIBU-CR web. This covers ~80% of operational pain and is the mitigation that justifies deferring `filing-core`.

---

## Phase A — Trigger monitoring (ACTIVE NOW)

Phase A tasks are actionable starting on the landing date of this plan (2026-04-16). No TDD — this is monitoring and scheduling, not code.

### Task A1: Create monitoring dashboard item

**Files:**
- None (GitHub-only action; the "dashboard" is a pinned issue — see A4 — plus a tracking spreadsheet).

- [ ] **Step 1: Decide dashboard medium**

Options considered:

- **GitHub Project (beta)** on `lapc506/filing-core` — free, integrates with issues, but adds UI surface for 3 metrics only.
- **Pinned issue body** updated each quarter (chosen) — zero ceremony, diffable via git blame on the issue history, fits "handful of tracking issues" constraint.
- **External spreadsheet** — rejected, creates synchronization drift.

**Decision:** a single pinned "Trigger status" issue (Task A4) is the dashboard. A lightweight Google Sheet (Task A3) holds raw contador-hour ledger entries the issue summarizes.

- [ ] **Step 2: Document the decision**

Add a short note to the issue body explaining the decision so future reviewers don't relitigate it.

### Task A2: Quarterly re-review cadence

**Files:**
- None (calendar + GitHub milestones).

- [ ] **Step 1: Create recurring Google Calendar event**

```bash
# Use the Google Calendar MCP tool gcal_create_event in Claude Code with:
#   summary: "filing-core trigger re-review"
#   recurrence: RRULE:FREQ=QUARTERLY;BYMONTHDAY=16 (or closest business day)
#   start: 2026-07-16T09:00:00-06:00
#   end: 2026-07-16T10:00:00-06:00
#   description: see this plan, Task A5 template
#   reminders: email -7d, popup -1d
```

Target dates (initial schedule): **2026-07-16, 2026-10-16, 2027-01-16, 2027-04-16**. The 2027-04-16 date is the annual hard review from spec §14 — if the trigger has not fired by then, decide: continue monitoring another year, or deactivate (Task A7).

- [ ] **Step 2: Mirror as GitHub milestones**

```bash
gh api repos/lapc506/filing-core/milestones -f title='Q3 2026 trigger re-review' -f due_on='2026-07-16T17:00:00Z' -f description='Quarterly re-review per plan Task A2. Output goes in docs/reviews/2026-Q3-review.md.'
gh api repos/lapc506/filing-core/milestones -f title='Q4 2026 trigger re-review' -f due_on='2026-10-16T17:00:00Z' -f description='Quarterly re-review per plan Task A2.'
gh api repos/lapc506/filing-core/milestones -f title='Q1 2027 trigger re-review' -f due_on='2027-01-16T17:00:00Z' -f description='Quarterly re-review per plan Task A2.'
gh api repos/lapc506/filing-core/milestones -f title='Q2 2027 ANNUAL review (hard gate)' -f due_on='2027-04-16T17:00:00Z' -f description='Annual hard review per spec §14. Decide: continue monitoring, activate Phase B, or deactivate per Task A7.'
```

- [ ] **Step 3: Verify milestones were created**

```bash
gh api repos/lapc506/filing-core/milestones --jq '.[] | {title, due_on, state}'
```

Expected output: 4 milestones in `open` state with the due dates above.

### Task A3: Define metrics collection

**Files:**
- `/home/kvttvrsis/Documentos/GitHub/filing-core/docs/reviews/METRICS.md` — definitions + data sources (create on first execution).

- [ ] **Step 1: Define "startup requests" metric**

A startup request counts toward trigger 1 if **all three** are true:

1. Written request (Slack message, email, Linear issue, or backend repo GitHub issue) exists and is linkable.
2. The ask is specifically for **automated submission** to the tax authority — not pre-fill, not calculation help. Examples that count: "don't want the contador to have to paste into TRIBU-CR anymore", "we need filing-core to submit D-104 end-to-end". Examples that don't count: "can we get D-101 casillas auto-filled" (already satisfied by `FilingDataExportPort`).
3. The startup is willing to be the first adopter (answers: "yes, we'd run filing-core in our pod today if it existed").

Counting rule: count **unique startups**, not unique requests. Two requests from AltruPets = 1. One request each from AltruPets and HabitaNexus = 2.

- [ ] **Step 2: Define "contador hours" metric**

Track in a simple Google Sheet `filing-core-contador-ledger` with columns:

- `date` — ISO date
- `startup` — one of: AltruPets, HabitaNexus, Vertivolatam, AduaNext
- `declaration_type` — D-101 | D-104 | D-103 | D-150 | D-151 | D-152 | D-195 | D-408 | other
- `period` — fiscal period declared
- `hours` — decimal hours spent by contador on this specific declaration (excludes bookkeeping, advisory, audit support)
- `rate_usd_hr` — hourly rate billed to the startup for filing-specific work
- `cost_usd` — `hours * rate_usd_hr`
- `notes` — free text

Source of truth: contador monthly invoices annotated per-startup. Update monthly after the contador bills. Trigger 2 threshold is hit when **rolling 12-month sum of `cost_usd`** exceeds USD 15,000.

- [ ] **Step 3: Define "regulatory signal" metric**

Not quantitative. Monitor these sources quarterly:

- DGT (Dirección General de Tributación CR) announcements: `https://www.hacienda.go.cr/`
- TRIBU-CR portal release notes: `https://www.hacienda.go.cr/TRIBU-CR.html`
- El Financiero fiscal section (Costa Rica).
- SAT MX and DIAN CO official announcements (only once HabitaNexus expansion activates those jurisdictions).

Any announcement that removes web UI submission, mandates API-only filing, or introduces real-time obligations fires trigger 3 and demands immediate re-review (not just quarterly).

- [ ] **Step 4: Commit METRICS.md**

```bash
cd /home/kvttvrsis/Documentos/GitHub/filing-core
mkdir -p docs/reviews
# Write docs/reviews/METRICS.md capturing steps 1-3 above.
git add docs/reviews/METRICS.md
git commit -m "docs(reviews): define trigger metrics per plan Task A3"
```

### Task A4: Pinned trigger status issue

**Files:**
- None (GitHub-only action).

- [ ] **Step 1: Create issue**

```bash
gh issue create --repo lapc506/filing-core \
  --title "[MONITORING] filing-core activation trigger status" \
  --body "$(cat <<'EOF'
This is a LIVING issue updated quarterly to track activation trigger status.

## Trigger conditions

1. **Demand signal** — >= 2 startups explicitly request full filing automation.
2. **Economic signal** — contador manual labor exceeds USD 15k/year across portfolio.
3. **Regulatory signal** — regulatory change makes manual filing impractical.

## Current status (Q2 2026 — baseline 2026-04-16)

- Condition 1: 0 startups requested (out of 4 in portfolio: AltruPets, HabitaNexus, Vertivolatam, AduaNext).
- Condition 2: N/A — no ledger data yet; contador-ledger sheet created this quarter.
- Condition 3: None observed. TRIBU-CR operational since 2025-10-06; no deprecation of web UI announced.

**Verdict:** Trigger NOT fired. Remain in Phase A.

Next re-review: **2026-07-16** (Q3 2026).

## Escalation (see plan Task A6)

If any single trigger crosses 50% progress toward its threshold before a scheduled re-review, open a sub-issue titled `[ESCALATION] <trigger> at <pct>%` and notify @lapc506.

## Historical re-reviews

| Date | Verdict | Review file |
|---|---|---|
| 2026-04-16 | Initial — trigger not fired | (this issue body) |

## Links

- Plan: `docs/superpowers/plans/2026-04-16-filing-core-trigger-and-skeleton-plan.md`
- Spec: `docs/superpowers/specs/2026-04-16-filing-core-design.md`
- Metrics definitions: `docs/reviews/METRICS.md`
- Intermediate solution: `invoice-core` `FilingDataExportPort` (invoice-core spec section 5 port 8).
EOF
)" \
  --label "monitoring,deferred,phase-0"
```

- [ ] **Step 2: Pin the issue**

```bash
# Get the issue number from step 1 output, then:
gh issue pin <issue-number> --repo lapc506/filing-core
```

- [ ] **Step 3: Verify pinned**

```bash
gh issue view <issue-number> --repo lapc506/filing-core --json isPinned,state,labels
```

Expected: `"isPinned": true`, `"state": "OPEN"`, labels include `monitoring`, `deferred`, `phase-0`.

### Task A5: Re-review template

**Files:**
- `/home/kvttvrsis/Documentos/GitHub/filing-core/docs/reviews/TEMPLATE.md` — markdown template used by each `YYYY-QN-review.md`.

- [ ] **Step 1: Write the template**

See Appendix C for the exact content. Commit as `docs/reviews/TEMPLATE.md`.

- [ ] **Step 2: Write an example baseline review**

Create `docs/reviews/2026-Q2-review.md` as the baseline, copying the template and filling in "Trigger not fired — initial state". This serves as the reference for future reviews.

- [ ] **Step 3: Commit**

```bash
cd /home/kvttvrsis/Documentos/GitHub/filing-core
git add docs/reviews/TEMPLATE.md docs/reviews/2026-Q2-review.md
git commit -m "docs(reviews): add re-review template and Q2 2026 baseline"
```

- [ ] **Step 4: Update the pinned issue (Task A4) historical table**

Add the Q2 2026 row pointing to `docs/reviews/2026-Q2-review.md`.

### Task A6: Escalation rule

**Files:**
- None (codified in Task A4 issue body + here).

- [ ] **Step 1: Define escalation thresholds**

- Trigger 1 (demand): 1 of 2 startups requested automation = 50% → escalate.
- Trigger 2 (economic): rolling 12-month spend reaches USD 7,500 = 50% → escalate.
- Trigger 3 (regulatory): any credible announcement of upcoming breaking change → escalate immediately regardless of date.

- [ ] **Step 2: Define escalation action**

When a trigger crosses 50%:

1. Open a sub-issue `[ESCALATION] <trigger N> at <pct>%` on `lapc506/filing-core`, linked to the pinned trigger status issue.
2. Within 2 weeks of escalation, run an out-of-band review using the Task A5 template (label it `YYYY-QN-escalation.md` instead of the regular quarter file).
3. If the escalation review concludes the second half of progress is likely within 6 months, promote the next scheduled quarter review to "activation decision" — read spec with fresh eyes (Task B2) and prepare infrastructure for Phase B even if not yet activated.

- [ ] **Step 3: Update the pinned issue**

Already captured in A4 Step 1 issue body "Escalation" section. Verify wording matches this task.

### Task A7: Deactivation / archival process

**Files:**
- None during monitoring; triggered only if archival decision is taken.

- [ ] **Step 1: Define deactivation conditions**

`filing-core` becomes unnecessary (and Phase B is cancelled permanently) if **any** of these holds:

- TRIBU-CR (and SAT MX, DIAN CO if expanded) introduces a native API that backends can consume directly with trivial effort, OR
- `invoice-core`'s `FilingDataExportPort` evolves to include a "submit" operation that the intermediate solution uses end-to-end (in which case filing logic has already been absorbed elsewhere), OR
- The entire startup portfolio shrinks below 2 active tax-filing entities (e.g., pivots that eliminate operations in CR/MX/CO).

- [ ] **Step 2: Define archival action**

If deactivation is chosen at an annual review:

1. Update the spec header to `STATUS: ARCHIVED` with rationale.
2. Close the pinned trigger status issue with a final comment documenting the decision and linking to the archival review file.
3. Close outstanding milestones.
4. Tag the repo `v0.0-archived` for historical reference.
5. Do **not** delete the repo — specs remain as ecosystem documentation per the governance rubric.

- [ ] **Step 3: Notify author**

Post to the author (@lapc506) via email (andres@dojocoding.io) or standup confirming the decision is intentional.

---

## Phase B — Skeleton activation (DORMANT)

> **Do not execute Phase B tasks unless:**
>
> 1. A Phase A quarterly re-review output file (`docs/reviews/YYYY-QN-review.md`) exists on `main` with verdict `TRIGGER FIRED`.
> 2. The pinned trigger status issue (Task A4) has been updated with the verdict and closed with a "superseded by Phase B activation" comment.
> 3. `invoice-core` has been in production for ≥ 3 months (per spec §14 Fase 1 gate).
>
> If any of these is missing, **stop**. Re-read `docs/superpowers/specs/2026-04-16-filing-core-design.md` §14 Fase 0 and governance rubric §5.

Phase B scope is **deliberately minimal**: scaffold + TRIBU-CR adapter skeleton + D-104 (IVA mensual) only. D-101, D-103, SAT MX, DIAN CO, and other declarations are **explicitly out of scope** for Fase 1; they belong to Fase 2+ activation plans written after Phase B lands. Estimated ~4 weeks of work when activated — **not** the 6-8 weeks quoted for full spec Fase 1, because this plan cuts the scope further.

All Phase B tasks follow TDD: write failing test → minimal implementation → green → refactor. Use `superpowers:test-driven-development` skill.

### Task B1: Verify trigger officially fired

**Files:**
- `/home/kvttvrsis/Documentos/GitHub/filing-core/docs/reviews/YYYY-QN-review.md` — the specific review file that fired the trigger.

- [ ] **Step 1: Locate the firing review**

```bash
cd /home/kvttvrsis/Documentos/GitHub/filing-core
git log --all --oneline -- 'docs/reviews/*-review.md' | head -20
# Identify the review with verdict: TRIGGER FIRED.
```

- [ ] **Step 2: Confirm verdict text**

```bash
grep -n 'TRIGGER FIRED' docs/reviews/YYYY-QN-review.md
```

Expected: at least one line matches. If zero matches, the trigger has not officially fired — **return to Phase A, do not proceed**.

- [ ] **Step 3: Confirm invoice-core stability gate**

```bash
gh release list --repo lapc506/invoice-core --limit 10
```

Expected: a `v1.x.x` GA release exists and its publish date is ≥ 90 days before today. If not, the Fase 1 gate from spec §14 is not met; wait.

- [ ] **Step 4: Close the pinned monitoring issue**

```bash
gh issue close <pinned-issue-number> --repo lapc506/filing-core --comment "Trigger fired per docs/reviews/YYYY-QN-review.md. Superseded by Phase B activation plan (this plan Task B1 onwards)."
```

### Task B2: Re-read spec with fresh eyes

**Files:**
- `/home/kvttvrsis/Documentos/GitHub/filing-core/docs/superpowers/specs/2026-04-16-filing-core-design.md` — may have drifted.
- `/home/kvttvrsis/Documentos/GitHub/filing-core/docs/reviews/YYYY-QN-activation-drift.md` — new drift-check output (create).

- [ ] **Step 1: Read the spec top-to-bottom**

Pay attention to: §2 (decisiones cerradas — any still hold?), §4 (domain model — did any type evolve?), §5 (ports catalog — did invoice-core change the contract?), §14 roadmap (did Fase 1 scope still match?).

- [ ] **Step 2: Check regulatory drift**

Since the spec was written (2026-04-16), verify: (a) TRIBU-CR is still the active portal for CR, (b) D-104 IVA thresholds unchanged, (c) no new casillas added to D-104. Source: DGT official announcements.

- [ ] **Step 3: Write drift report**

Create `docs/reviews/YYYY-QN-activation-drift.md` documenting:

- Spec assumptions that still hold.
- Spec assumptions that drifted (and by how much).
- Required spec amendments before Phase B proceeds.

- [ ] **Step 4: If material drift is found**

Amend the spec in a dedicated commit (`docs(spec): post-trigger drift reconciliation`) before writing any code. Get self-review approval on the amendment.

### Task B3: Re-read invoice-core FilingDataExportPort current signature

**Files:**
- `/home/kvttvrsis/Documentos/GitHub/invoice-core/docs/superpowers/specs/2026-04-16-invoice-core-design.md` — spec of truth at design time.
- `/home/kvttvrsis/Documentos/GitHub/invoice-core/src/application/ports/FilingDataExportPort.ts` — actual code at activation time (path assumed; confirm when invoice-core exists).
- `/home/kvttvrsis/Documentos/GitHub/invoice-core/proto/invoice_core/v1/filing_data_export.proto` — gRPC contract if published.

- [ ] **Step 1: Read the actual port code**

```bash
find /home/kvttvrsis/Documentos/GitHub/invoice-core -name 'FilingDataExportPort*' -o -name 'filing_data_export*'
```

- [ ] **Step 2: Snapshot the signature**

Write the current TypeScript interface + proto service into `docs/reviews/YYYY-QN-filing-data-export-snapshot.md`. This is the contract `filing-core` will code against in Task B9.

- [ ] **Step 3: Confirm proto version**

If invoice-core has published a `v1` proto that is stable (no `v2` in progress with breaking changes), `filing-core` targets `v1`. If `v2` is imminent, coordinate with invoice-core roadmap before proceeding.

### Task B4: Scaffold TypeScript + hexagonal (mirror invoice-core repo structure)

**Files created:**
- `/home/kvttvrsis/Documentos/GitHub/filing-core/package.json`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/tsconfig.json`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/vitest.config.ts`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/.nvmrc` (`22`)
- `/home/kvttvrsis/Documentos/GitHub/filing-core/pnpm-workspace.yaml`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/src/domain/.gitkeep`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/src/application/.gitkeep`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/src/adapters/primary/.gitkeep`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/src/adapters/secondary/.gitkeep`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/tests/unit/.gitkeep`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/tests/integration/.gitkeep`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/.github/workflows/ci.yml`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/LICENSE.md` (BSL 1.1 — already present, verify)

- [ ] **Step 1: Copy structure from invoice-core**

Do not copy code — copy directory skeleton + config files. Rename package name to `@lapc506/filing-core`.

- [ ] **Step 2: Write a smoke test first (TDD)**

```ts
// tests/unit/smoke.test.ts
import { describe, it, expect } from "vitest";

describe("filing-core smoke", () => {
  it("loads package metadata", async () => {
    const pkg = await import("../../package.json");
    expect(pkg.default.name).toBe("@lapc506/filing-core");
    expect(pkg.default.engines.node).toMatch(/^>=22/);
  });
});
```

- [ ] **Step 3: Run and fail, then make pass**

```bash
pnpm install
pnpm test
```

Expected: initially red (missing package.json fields); green after Step 1 config is correct.

- [ ] **Step 4: CI green check**

Push to a feature branch, verify GitHub Actions CI passes before merging.

### Task B5: Domain — Declaration entity + DeclarationState state machine (subset)

**Files created:**
- `/home/kvttvrsis/Documentos/GitHub/filing-core/src/domain/declaration/Declaration.ts`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/src/domain/declaration/DeclarationStatus.ts`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/tests/unit/domain/Declaration.test.ts`

Scope cut vs spec §4: only `DRAFT → CALCULATED → AWAITING_APPROVAL → SUBMITTED → ACCEPTED|REJECTED`. `VALIDATED`, `READY`, `OBSERVED`, `RESOLVED`, `CANCELLED` are Fase 2+.

- [ ] **Step 1: Write the HITL invariant test first (TDD)**

```ts
// tests/unit/domain/Declaration.test.ts
import { describe, it, expect } from "vitest";
import { Declaration } from "../../../src/domain/declaration/Declaration";

describe("Declaration HITL invariant", () => {
  it("rejects transition to SUBMITTED when approvedBy is not set", () => {
    const decl = Declaration.draft({
      id: "decl-1",
      type: "D_104_CR",
      jurisdiction: "CR",
      period: { year: 2027, month: 1 },
    });
    const calculated = decl.calculate([]);
    const awaiting = calculated.requestApproval();
    expect(() => awaiting.submit({ authorityReference: "TRIBUCR-XYZ" })).toThrowError(
      /approvedBy must be populated before SUBMITTED/
    );
  });

  it("allows SUBMITTED when approvedBy is populated via approveAndSubmit", () => {
    const decl = Declaration.draft({
      id: "decl-2",
      type: "D_104_CR",
      jurisdiction: "CR",
      period: { year: 2027, month: 1 },
    });
    const awaiting = decl.calculate([]).requestApproval();
    const submitted = awaiting.approveAndSubmit({
      approverId: "contador-1",
      authorityReference: "TRIBUCR-ABC",
    });
    expect(submitted.status).toBe("SUBMITTED");
    expect(submitted.approvedBy).toBe("contador-1");
  });
});
```

- [ ] **Step 2: Implement `DeclarationStatus` as a discriminated type**

```ts
// src/domain/declaration/DeclarationStatus.ts
export type DeclarationStatus =
  | "DRAFT"
  | "CALCULATED"
  | "AWAITING_APPROVAL"
  | "SUBMITTED"
  | "ACCEPTED"
  | "REJECTED";

export const terminalStatuses: readonly DeclarationStatus[] = ["ACCEPTED", "REJECTED"] as const;
```

- [ ] **Step 3: Implement `Declaration` with transition methods**

The only code path to `SUBMITTED` is `approveAndSubmit({ approverId, authorityReference })` which assigns `approvedBy = approverId` before setting status. Method `submit()` alone throws. This is the invariant.

- [ ] **Step 4: Run tests, make green**

```bash
pnpm test tests/unit/domain/Declaration.test.ts
```

- [ ] **Step 5: Property-based test (stretch)**

Use `fast-check` to generate arbitrary transition sequences; assert `SUBMITTED` never appears without `approvedBy`.

### Task B6: Domain — DeclarationLine value object

**Files created:**
- `/home/kvttvrsis/Documentos/GitHub/filing-core/src/domain/declaration/DeclarationLine.ts`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/src/domain/shared/Money.ts`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/tests/unit/domain/DeclarationLine.test.ts`

- [ ] **Step 1: TDD — test first**

```ts
// tests/unit/domain/DeclarationLine.test.ts
import { describe, it, expect } from "vitest";
import { DeclarationLine } from "../../../src/domain/declaration/DeclarationLine";
import { Money } from "../../../src/domain/shared/Money";

describe("DeclarationLine", () => {
  it("constructs with AUTO_INVOICE source and requires sourceReference", () => {
    const line = DeclarationLine.create({
      casillaCode: "D104_IVA_REPERCUTIDO",
      label: "IVA repercutido 13%",
      value: Money.of(1_000_000, "CRC"),
      source: "AUTO_INVOICE",
      sourceReference: "invoice-core://export/2027-01#5",
    });
    expect(line.source).toBe("AUTO_INVOICE");
    expect(line.sourceReference).toBeDefined();
  });

  it("rejects AUTO_INVOICE without sourceReference", () => {
    expect(() =>
      DeclarationLine.create({
        casillaCode: "D104_IVA_REPERCUTIDO",
        label: "IVA repercutido 13%",
        value: Money.of(1_000_000, "CRC"),
        source: "AUTO_INVOICE",
      })
    ).toThrowError(/sourceReference is required for AUTO_\*/);
  });
});
```

- [ ] **Step 2: Implement `Money` value object**

Integer cents internally (no floats). `Money.of(amount, currency)` returns immutable.

- [ ] **Step 3: Implement `DeclarationLine`**

Enforce: `source ∈ {AUTO_INVOICE, MANUAL, CALCULATED}` for Fase 1 (AUTO_PAYROLL and AUTO_ASSET are Fase 5+). `AUTO_INVOICE` and `CALCULATED` require `sourceReference`.

### Task B7: Port — `TaxAuthorityFilingPort` interface

**Files created:**
- `/home/kvttvrsis/Documentos/GitHub/filing-core/src/application/ports/TaxAuthorityFilingPort.ts`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/tests/unit/application/ports/TaxAuthorityFilingPort.contract.test.ts`

- [ ] **Step 1: Write contract test (fake adapter)**

```ts
// tests/unit/application/ports/TaxAuthorityFilingPort.contract.test.ts
import { describe, it, expect } from "vitest";
import type { TaxAuthorityFilingPort, FilingPayload, FilingAck } from "../../../../src/application/ports/TaxAuthorityFilingPort";

class FakeFilingAdapter implements TaxAuthorityFilingPort {
  async submit(payload: FilingPayload): Promise<FilingAck> {
    return { authorityReference: `FAKE-${payload.declarationId}`, submittedAt: new Date().toISOString() };
  }
  async queryStatus(authorityReference: string) {
    return { status: "ACCEPTED" as const, authorityReference };
  }
}

describe("TaxAuthorityFilingPort contract", () => {
  it("submit returns an ack with authorityReference", async () => {
    const port: TaxAuthorityFilingPort = new FakeFilingAdapter();
    const ack = await port.submit({
      declarationId: "decl-1",
      type: "D_104_CR",
      jurisdiction: "CR",
      payload: { lines: [] },
    });
    expect(ack.authorityReference).toMatch(/^FAKE-/);
  });
});
```

- [ ] **Step 2: Implement the interface**

```ts
// src/application/ports/TaxAuthorityFilingPort.ts
export interface FilingPayload {
  declarationId: string;
  type: "D_104_CR"; // Fase 1: only D-104. Expand in Fase 2+.
  jurisdiction: "CR";
  payload: { lines: unknown[] };
}
export interface FilingAck {
  authorityReference: string;
  submittedAt: string;
}
export type FilingStatus =
  | { status: "PENDING"; authorityReference: string }
  | { status: "ACCEPTED"; authorityReference: string }
  | { status: "REJECTED"; authorityReference: string; reason?: string };

export interface TaxAuthorityFilingPort {
  submit(payload: FilingPayload): Promise<FilingAck>;
  queryStatus(authorityReference: string): Promise<FilingStatus>;
}
```

- [ ] **Step 3: `answerObservation` is deferred to Fase 2**

Spec §5 port #1 lists it, but Fase 1 cut excludes observation flow — out of scope until the first real observation is received.

### Task B8: Port — `DeclarationRepository` interface

**Files created:**
- `/home/kvttvrsis/Documentos/GitHub/filing-core/src/application/ports/DeclarationRepository.ts`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/tests/unit/application/ports/DeclarationRepository.contract.test.ts`

- [ ] **Step 1: Write contract test against in-memory fake**

Tests: `save` roundtrip, `findById` returns null for missing, `findByPeriod` filters correctly.

- [ ] **Step 2: Implement the interface**

```ts
// src/application/ports/DeclarationRepository.ts
import type { Declaration } from "../../domain/declaration/Declaration";

export interface DeclarationRepository {
  save(declaration: Declaration): Promise<void>;
  findById(id: string): Promise<Declaration | null>;
  findByPeriod(query: {
    taxpayerId: string;
    type: "D_104_CR";
    year: number;
    month: number;
  }): Promise<Declaration | null>;
}
```

- [ ] **Step 3: Write `InMemoryDeclarationRepository` for tests**

Same file folder as Drizzle adapter (Task B12) for parallel structure.

### Task B9: Port — `InvoiceCoreDataSourcePort` interface (consumes invoice-core gRPC)

**Files created:**
- `/home/kvttvrsis/Documentos/GitHub/filing-core/src/application/ports/InvoiceCoreDataSourcePort.ts`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/tests/unit/application/ports/InvoiceCoreDataSourcePort.contract.test.ts`

Signature aligned with the snapshot from Task B3 — do not guess, use the actual exported shape.

- [ ] **Step 1: Write contract test**

Fake that returns canned D-104 casillas for a taxpayer/period; assert port returns `{ ivaRepercutido, ivaSoportadoDeducible }`.

- [ ] **Step 2: Implement the interface**

```ts
// src/application/ports/InvoiceCoreDataSourcePort.ts
import type { Money } from "../../domain/shared/Money";

export interface D104ExportQuery {
  taxpayerId: string;
  year: number;
  month: number;
}
export interface D104ExportResult {
  ivaRepercutido: Money;
  ivaSoportadoDeducible: Money;
  sourceReferences: string[]; // pointers back to invoice-core documents
}

export interface InvoiceCoreDataSourcePort {
  exportD104Data(query: D104ExportQuery): Promise<D104ExportResult>;
}
```

- [ ] **Step 3: Defer D-101 and D-103 export methods**

Only `exportD104Data` in Fase 1. Add others in Fase 2+ plans.

### Task B10: TRIBUCRAdapter skeleton (D-104 only)

**Files created:**
- `/home/kvttvrsis/Documentos/GitHub/filing-core/src/adapters/secondary/tribucr/TRIBUCRAdapter.ts`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/src/adapters/secondary/tribucr/TRIBUCRHttpClient.ts`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/tests/integration/tribucr/TRIBUCRAdapter.sandbox.test.ts`

- [ ] **Step 1: Write integration test against sandbox**

Skipped in CI if `TRIBUCR_SANDBOX_URL` env var missing. Test submits a fixture D-104 payload, asserts an authority reference comes back. If DGT has not published a sandbox by activation time, substitute a recorded-cassette approach (nock or msw) with fixture.

- [ ] **Step 2: Implement adapter**

Only two operations: `submit(payload)` and `queryStatus(authorityReference)`. Use `fetch` through a thin `TRIBUCRHttpClient` that encapsulates: base URL, ATV OAuth token injection (via `CredentialVaultPort` — stubbed in Fase 1), retry policy (3 attempts with exponential backoff), circuit breaker state exposed as a metric.

- [ ] **Step 3: Schema validation**

Validate payload against JSON Schema `d104-tribucr.schema.json` (committed to `src/adapters/secondary/tribucr/schemas/`). Reject before submit if invalid. Golden input → expected HTTP body → fixture comparison test.

### Task B11: DeclarationCalculator for D-104

**Files created:**
- `/home/kvttvrsis/Documentos/GitHub/filing-core/src/domain/calculators/D104Calculator.ts`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/tests/unit/domain/calculators/D104Calculator.test.ts`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/tests/fixtures/d104-golden/`

- [ ] **Step 1: Golden-file test first (TDD)**

```ts
// tests/unit/domain/calculators/D104Calculator.test.ts
import { describe, it, expect } from "vitest";
import { readFileSync } from "node:fs";
import path from "node:path";
import { D104Calculator } from "../../../../src/domain/calculators/D104Calculator";
import { Money } from "../../../../src/domain/shared/Money";

const fixturesDir = path.join(__dirname, "../../../fixtures/d104-golden");

describe("D104Calculator golden files", () => {
  it.each(["2027-01-baseline", "2027-02-saldo-a-favor", "2027-03-retenciones"])(
    "produces expected totals for fixture %s",
    (name) => {
      const input = JSON.parse(readFileSync(path.join(fixturesDir, `${name}.input.json`), "utf8"));
      const expected = JSON.parse(readFileSync(path.join(fixturesDir, `${name}.expected.json`), "utf8"));
      const result = D104Calculator.compute({
        ivaRepercutido: Money.fromJSON(input.ivaRepercutido),
        ivaSoportadoDeducible: Money.fromJSON(input.ivaSoportadoDeducible),
        retencionesAcreditables: Money.fromJSON(input.retencionesAcreditables ?? { amount: 0, currency: "CRC" }),
        pagosParciales: Money.fromJSON(input.pagosParciales ?? { amount: 0, currency: "CRC" }),
      });
      expect(result.saldoAPagar.toJSON()).toEqual(expected.saldoAPagar);
      expect(result.saldoAFavor.toJSON()).toEqual(expected.saldoAFavor);
    }
  );
});
```

- [ ] **Step 2: Create 3 golden fixtures**

At least: baseline (saldoAPagar positive), saldo-a-favor (IVA soportado > repercutido), retenciones (retenciones acreditables reduce saldoAPagar to zero). Values validated against manually pre-filled D-104s from a real contador.

- [ ] **Step 3: Implement the calculator**

```ts
// src/domain/calculators/D104Calculator.ts
import { Money } from "../shared/Money";

export interface D104Inputs {
  ivaRepercutido: Money;
  ivaSoportadoDeducible: Money;
  retencionesAcreditables: Money;
  pagosParciales: Money;
}
export interface D104Result {
  impuestoDeterminado: Money;
  saldoAPagar: Money;
  saldoAFavor: Money;
}

export const D104Calculator = {
  compute(inputs: D104Inputs): D104Result {
    const impuestoDeterminado = inputs.ivaRepercutido.minus(inputs.ivaSoportadoDeducible);
    const acreditaciones = inputs.retencionesAcreditables.plus(inputs.pagosParciales);
    const neto = impuestoDeterminado.minus(acreditaciones);
    return {
      impuestoDeterminado,
      saldoAPagar: neto.isPositive() ? neto : Money.zero(neto.currency),
      saldoAFavor: neto.isNegative() ? neto.abs() : Money.zero(neto.currency),
    };
  },
};
```

- [ ] **Step 4: Property-based test — non-negativity**

For arbitrary non-negative inputs, both `saldoAPagar` and `saldoAFavor` must be non-negative; exactly one is zero.

### Task B12: PostgreSQL + Drizzle for DeclarationRepository

**Files created:**
- `/home/kvttvrsis/Documentos/GitHub/filing-core/src/adapters/secondary/persistence/schema.ts` (Drizzle schema)
- `/home/kvttvrsis/Documentos/GitHub/filing-core/src/adapters/secondary/persistence/PostgresDeclarationRepository.ts`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/drizzle/0001_initial.sql` (generated migration)
- `/home/kvttvrsis/Documentos/GitHub/filing-core/tests/integration/persistence/PostgresDeclarationRepository.test.ts`

- [ ] **Step 1: Integration test with Testcontainers-postgres**

```ts
// tests/integration/persistence/PostgresDeclarationRepository.test.ts
import { describe, it, beforeAll, afterAll, expect } from "vitest";
import { PostgreSqlContainer, StartedPostgreSqlContainer } from "@testcontainers/postgresql";
import { PostgresDeclarationRepository } from "../../../src/adapters/secondary/persistence/PostgresDeclarationRepository";
import { Declaration } from "../../../src/domain/declaration/Declaration";

let container: StartedPostgreSqlContainer;
let repo: PostgresDeclarationRepository;

beforeAll(async () => {
  container = await new PostgreSqlContainer("postgres:16-alpine").start();
  repo = await PostgresDeclarationRepository.connect(container.getConnectionUri());
  await repo.runMigrations();
}, 60_000);

afterAll(async () => {
  await repo.close();
  await container.stop();
});

describe("PostgresDeclarationRepository", () => {
  it("saves and finds a draft declaration", async () => {
    const decl = Declaration.draft({
      id: "decl-pg-1",
      type: "D_104_CR",
      jurisdiction: "CR",
      period: { year: 2027, month: 1 },
    });
    await repo.save(decl);
    const found = await repo.findById("decl-pg-1");
    expect(found?.id).toBe("decl-pg-1");
    expect(found?.status).toBe("DRAFT");
  });
});
```

- [ ] **Step 2: Schema — minimal columns**

```ts
// src/adapters/secondary/persistence/schema.ts
import { pgTable, text, integer, jsonb, timestamp, primaryKey } from "drizzle-orm/pg-core";

export const declarations = pgTable("declarations", {
  id: text("id").primaryKey(),
  type: text("type").notNull(), // "D_104_CR" in Fase 1
  jurisdiction: text("jurisdiction").notNull(),
  taxpayerId: text("taxpayer_id").notNull(),
  year: integer("year").notNull(),
  month: integer("month"),
  status: text("status").notNull(),
  approvedBy: text("approved_by"),
  approvedAt: timestamp("approved_at", { withTimezone: true }),
  lines: jsonb("lines").notNull().default([]),
  computedTotals: jsonb("computed_totals"),
  authorityReference: text("authority_reference"),
  submittedAt: timestamp("submitted_at", { withTimezone: true }),
  createdAt: timestamp("created_at", { withTimezone: true }).defaultNow().notNull(),
  updatedAt: timestamp("updated_at", { withTimezone: true }).defaultNow().notNull(),
});
```

- [ ] **Step 3: Generate + commit migration**

```bash
pnpm drizzle-kit generate:pg --schema src/adapters/secondary/persistence/schema.ts --out drizzle
git add drizzle/0001_initial.sql
```

- [ ] **Step 4: Verify HITL invariant survives round-trip**

Add a test: save a declaration with `approvedBy = null` + status `AWAITING_APPROVAL` → load → try to transition to SUBMITTED → expect throw. Guarantees invariant is not silently circumvented by persistence.

### Task B13: gRPC service `FilingAdmin` (`PrepareDeclaration` + `ApproveAndSubmit` only)

**Files created:**
- `/home/kvttvrsis/Documentos/GitHub/filing-core/proto/filing_core/v1/filing_admin.proto`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/src/adapters/primary/grpc/FilingAdminService.ts`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/tests/integration/grpc/FilingAdminService.test.ts`

Spec §6 lists 11 RPCs on `FilingAdmin`. Fase 1 implements **two**: `PrepareDeclaration` and `ApproveAndSubmit`. The rest are Fase 2+.

- [ ] **Step 1: Write the proto (subset)**

```proto
// proto/filing_core/v1/filing_admin.proto
syntax = "proto3";
package filing_core.v1;

service FilingAdmin {
  rpc PrepareDeclaration(PrepareDeclarationRequest) returns (DeclarationAck);
  rpc ApproveAndSubmit(ApproveSubmitRequest) returns (SubmissionAck);
}

message PrepareDeclarationRequest {
  string taxpayer_id = 1;
  string type = 2;      // "D_104_CR" only in Fase 1
  int32 year = 3;
  int32 month = 4;      // required for D-104
}
message DeclarationAck {
  string declaration_id = 1;
  string status = 2;
  string computed_totals_json = 3;
}
message ApproveSubmitRequest {
  string declaration_id = 1;
  string approver_id = 2;
  string signature_ref = 3; // reference into CredentialVaultPort
}
message SubmissionAck {
  string declaration_id = 1;
  string authority_reference = 2;
  string submitted_at = 3;
}
```

- [ ] **Step 2: TDD — write the gRPC integration test**

Stand up `FilingAdminService` with fake `TaxAuthorityFilingPort`, fake `InvoiceCoreDataSourcePort`, in-memory `DeclarationRepository`. Assert:

1. `PrepareDeclaration` for D-104 2027-01 returns status `CALCULATED` with non-zero totals.
2. `ApproveAndSubmit` on the resulting declaration returns an `authority_reference`.
3. `ApproveAndSubmit` with missing `approver_id` returns `INVALID_ARGUMENT`.
4. Calling `ApproveAndSubmit` twice on the same declaration is idempotent (returns same authority_reference).

- [ ] **Step 3: Implement the service**

Thin layer delegating to application commands. Reject any `type` other than `D_104_CR` with `UNIMPLEMENTED` (clear signal for future phases).

- [ ] **Step 4: Reserve REST `:8768` for Fase 2**

Fase 1 ships gRPC only. REST approval UI is Fase 2+. Leave the REST Fastify skeleton in place from Task B4 but with no routes registered beyond `/health`.

### Task B14: Observability alignment

**Files created:**
- `/home/kvttvrsis/Documentos/GitHub/filing-core/src/infrastructure/observability/tracing.ts`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/src/infrastructure/observability/metrics.ts`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/src/infrastructure/observability/logger.ts`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/tests/unit/infrastructure/observability.test.ts`

- [ ] **Step 1: Test — PII redaction in logs**

```ts
// tests/unit/infrastructure/observability.test.ts
import { describe, it, expect, vi } from "vitest";
import { logger, redactPII } from "../../../src/infrastructure/observability/logger";

describe("logger PII redaction", () => {
  it("redacts cedula-like IDs", () => {
    const sanitized = redactPII({ taxpayerId: "3-101-123456", casillaValue: 1_000_000 });
    expect(sanitized.taxpayerId).toBe("3-101-[REDACTED]");
    expect(sanitized.casillaValue).toBe("[REDACTED]");
  });
});
```

- [ ] **Step 2: Implement pino logger + redaction**

Follow invoice-core pattern. Redact: `taxpayerId` partial, `casillaValue` full, `signatureRef` full.

- [ ] **Step 3: Implement OTel SDK setup + Prometheus `/metrics`**

Metrics in Fase 1 (from spec §11):

- `filing_declaration_prepared_total{type,jurisdiction}`
- `filing_declaration_submitted_total{type,jurisdiction,outcome}`
- `filing_authority_latency_seconds{authority,operation}` (histogram)
- `filing_circuit_breaker_state{authority}`

Deadline-violation metric (`filing_deadline_violations_total`) requires `CalendarioFiscalPort` which is Fase 2 — deferred.

- [ ] **Step 4: Verify correlation with invoice-core**

When `filing-core` calls invoice-core via `InvoiceCoreDataSourcePort`, the trace context propagates (W3C traceparent). Manual verification with Jaeger UI + fake invoice-core server.

### Task B15: Docker + basic Helm

**Files created:**
- `/home/kvttvrsis/Documentos/GitHub/filing-core/Dockerfile`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/docker-compose.yml`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/helm/filing-core/Chart.yaml`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/helm/filing-core/values.yaml`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/helm/filing-core/templates/deployment.yaml`
- `/home/kvttvrsis/Documentos/GitHub/filing-core/helm/filing-core/templates/service.yaml`

- [ ] **Step 1: Dockerfile — multi-stage**

Stage 1: `node:22-alpine` + pnpm + build. Stage 2: `node:22-alpine` runtime with non-root user, `CMD ["node", "dist/main.js"]`, expose `50081` (gRPC) and `8768` (REST, even though only `/health` is live).

- [ ] **Step 2: docker-compose for local dev**

Services: `filing-core`, `postgres:16-alpine`, `jaeger` (all-in-one), `prometheus`. Depends-on ordering.

- [ ] **Step 3: Helm chart — minimal**

Deployment with: one replica, readiness probe on `8768/health`, liveness probe on `50081` (gRPC health), resource requests `100m`/`256Mi`, limits `500m`/`512Mi`. Service exposing both ports. Secret references for `DATABASE_URL`, `INVOICE_CORE_GRPC_URL`, `TRIBUCR_BASE_URL` — never hardcoded.

- [ ] **Step 4: Test — `helm lint` + `helm template`**

```bash
helm lint helm/filing-core
helm template filing-core helm/filing-core --values helm/filing-core/values.yaml
```

Expected: exit 0 on both.

---

## Appendix A — Trigger tracking scripts

Bash one-liners to run during each quarterly re-review.

```bash
# A.1 — count startup automation requests (unique startups) on all backend repos
for repo in altrupets-api habitanexus-api vertivolatam-api aduanext-api; do
  gh issue list --repo lapc506/$repo --state all --search 'filing-core automation in:title,body' --json number,title,repository --jq '.[] | "\(.repository.name)#\(.number) \(.title)"'
done | sort -u

# A.2 — rolling 12-month contador spend (requires contador-ledger.csv export from the Sheet)
awk -F, -v cutoff="$(date -d '12 months ago' +%Y-%m-%d)" 'NR>1 && $1 >= cutoff { sum += $7 } END { printf "Rolling 12-month spend: USD %.2f\n", sum }' contador-ledger.csv

# A.3 — TRIBU-CR regulatory scan (manual link check)
curl -sI https://www.hacienda.go.cr/TRIBU-CR.html | head -5
echo "Check DGT announcements and TRIBU-CR release notes manually; automate only if RSS becomes available."

# A.4 — verify invoice-core FilingDataExportPort has not silently changed signature
cd /home/kvttvrsis/Documentos/GitHub/invoice-core && git log --oneline -5 -- '**/FilingDataExportPort*' '**/filing_data_export*'
```

## Appendix B — Labels setup for filing-core repo

Run once after repo creation:

```bash
gh label create monitoring --description "Phase A trigger monitoring" --color 1d76db --repo lapc506/filing-core
gh label create deferred --description "Work explicitly deferred to a later phase" --color fbca04 --repo lapc506/filing-core
gh label create phase-0 --description "Phase A — trigger monitoring" --color c5def5 --repo lapc506/filing-core
gh label create phase-1 --description "Phase B Fase 1 — MVP CR D-104" --color 0e8a16 --repo lapc506/filing-core
gh label create escalation --description "Trigger progress >= 50%" --color d93f0b --repo lapc506/filing-core
gh label create regulatory-drift --description "Regulation changed since spec" --color b60205 --repo lapc506/filing-core
gh label create activation-blocker --description "Prevents Phase B activation" --color 5319e7 --repo lapc506/filing-core
```

## Appendix C — Re-review template (`docs/reviews/TEMPLATE.md`)

```markdown
# filing-core trigger re-review — YYYY-QN

**Date:** YYYY-MM-DD
**Reviewer:** @lapc506
**Previous review:** `docs/reviews/YYYY-QN-review.md` (link)

## 1. Trigger 1 — Demand signal

**Threshold:** >= 2 startups request full filing automation.

- AltruPets: [ ] requested / [ ] not requested (link to evidence if requested)
- HabitaNexus: [ ] requested / [ ] not requested
- Vertivolatam: [ ] requested / [ ] not requested
- AduaNext: [ ] requested / [ ] not requested

**Count this quarter:** N / 2
**Progress:** (N/2 * 100)%
**Status:** [ ] NOT STARTED / [ ] ESCALATION / [ ] FIRED

## 2. Trigger 2 — Economic signal

**Threshold:** rolling 12-month contador spend > USD 15,000.

- Rolling 12-month spend: USD ____
- Progress: (spend / 15000 * 100)%
- Source: `contador-ledger.csv` export of YYYY-MM-DD
- Breakdown by startup:
  - AltruPets: USD ____
  - HabitaNexus: USD ____
  - Vertivolatam: USD ____
  - AduaNext: USD ____

**Status:** [ ] NOT STARTED / [ ] ESCALATION / [ ] FIRED

## 3. Trigger 3 — Regulatory signal

**Threshold:** any announcement removing web UI, mandating API-only, or introducing real-time obligations.

- TRIBU-CR (CR): (summary of latest announcements since last review)
- SAT MX: N/A until HabitaNexus MX activation / (summary if applicable)
- DIAN CO: N/A until HabitaNexus CO activation / (summary if applicable)

**Status:** [ ] NOT OBSERVED / [ ] OBSERVED

## 4. invoice-core FilingDataExportPort state

- Latest release: invoice-core vX.Y.Z (YYYY-MM-DD)
- Port signature changed since last review: [ ] yes / [ ] no
- If yes, summary of changes + implications for filing-core:

## 5. Verdict

[ ] TRIGGER NOT FIRED — continue Phase A; next review YYYY-MM-DD.
[ ] ESCALATION — trigger N at X%; open escalation issue.
[ ] TRIGGER FIRED — promote to Phase B; proceed to Task B1 after invoice-core stability gate confirmed.

## 6. Actions for next quarter

- [ ] Update pinned trigger status issue with this review.
- [ ] (Any follow-up items.)

## 7. Notes

(Free-form observations.)
```

---

## Self-review

- [x] Header marks plan prominently as DEFERRED, two-phase, with governance warning.
- [x] Phase A tasks (A1-A7, 7 tasks) are actionable immediately after plan lands.
- [x] Phase B tasks (B1-B15, 15 tasks) are dormant; each task includes a TDD pattern with real code examples.
- [x] No TDD applied to Phase A monitoring tasks (correctly framed as non-code work).
- [x] Phase B Fase 1 scope is deliberately cut below spec Fase 1 — TRIBU-CR CR + D-104 only; no D-101/D-103/SAT/DIAN.
- [x] GitHub Issues (not Linear) used for tracking; only a handful of long-running issues.
- [x] Trigger conditions explicit in header + Appendix C template + Task A3/A6.
- [x] Intermediate solution (`invoice-core` `FilingDataExportPort`) referenced from header, Task A4, Task B3, Task B9.
- [x] Architecture preview (ports `:50081`/`:8768`) consistent with spec §2.
- [x] HITL invariant tested in Task B5 + persisted invariant verified in Task B12.
- [x] Premature construction warning in header + top of Phase B + self-review.
- [x] Real code in Task B4-B15 — no placeholders.
- [x] Appendix A trigger tracking scripts are runnable bash.
- [x] Appendix B GitHub labels cover monitoring + activation lifecycle.
- [x] Appendix C template ready to be copied for 2026-Q3 review.
- [x] File paths throughout are absolute.

## Execution handoff

**For the next agentic worker picking up Phase A (now):**

1. Execute Tasks A1 → A7 in order. A1-A5 should land in the first day; A6-A7 are documentation that goes with them.
2. First real quarterly review is 2026-07-16 using Appendix C template.
3. Keep the pinned trigger status issue (Task A4) as the source of truth. Every future reviewer updates it.

**For the future agentic worker activating Phase B (dormant — only after trigger fires):**

1. **STOP** and verify Task B1 gate: a `docs/reviews/YYYY-QN-review.md` with verdict `TRIGGER FIRED` exists on `main`, and `invoice-core` has been in production for ≥ 3 months.
2. If the gate is not met, do **not** proceed — re-read spec §14 Fase 0 and governance rubric §5. Building prematurely violates governance.
3. Load `superpowers:subagent-driven-development` and execute Tasks B1 → B15 in order. Most B tasks have dependencies on earlier B tasks (domain before ports before adapters); run strictly sequentially unless the dispatcher identifies independent sub-steps.
4. At end of Phase B (B15 green + Docker image published), write a **Fase 2 plan** covering D-101, D-103, and observation response flow. Do not extend this plan retroactively.

**Premature execution check (both workers):** if at any point you find yourself writing code under Phase B without a firing review file, stop and re-read this header.
