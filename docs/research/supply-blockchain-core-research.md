# supply-blockchain-core — Research & Build/No-Build Memo

> **Status of the service:** `??` (owner-marked, undecided). This is design-input
> research, not a commitment. It produces evidence for a **BUILD / NO-BUILD /
> ALTERNATIVE** recommendation for a proposed agrifood supply-chain traceability
> microservice on blockchain.
>
> **Date:** 2026-06-03 · **Repo:** `chimeranext/better-microservices`
> **Convention:** Explicit Architecture (Hexagonal + DDD) + OpenSpec (PDR/ADR/SOP).

**TL;DR recommendation: NO-BUILD as a standalone service → ALTERNATIVE.**
The traceability bounded context already exists inside **`marketplace-core`**
(`MarketplaceTraceability` gRPC service, `TraceabilityPort`, hash-chain +
Madara/Starknet adapters, Cairo `supply_chain.cairo` targeting ISO 22005/28000).
A second blockchain-trace `-core` would be a bounded-context split with no new
domain. The unmet needs (GS1 EPCIS 2.0 conformance, a grain/commodity domain à la
AgriDigital, sensor/IoT cold-chain capture) are best delivered as **capabilities
inside existing services**, not a new ledger service. Detail and the conditions
under which a BUILD becomes justified are below.

---

## 1. Findings by source

### 1.1 Repo — `marketplace-core` (the decisive internal source)
- A full **traceability bounded context already ships**: `MarketplaceTraceability`
  gRPC service with `RecordOrigin`, `RecordTransfer`, `RecordTransformation`,
  `GetChain` (`proto/marketplace_core.proto` L96–100, 423–445), and a domain
  `TraceabilityPort` (`src/domain/ports/traceability.ts`) with
  `recordOrigin/recordTransfer/recordTransformation/getChain/verifyChain`.
- The three event verbs map **almost 1:1 onto GS1 EPCIS event types**:
  `recordOrigin`≈*commissioning/ObjectEvent*, `recordTransfer`≈*shipping/receiving
  (TransactionEvent)*, `recordTransformation`≈*EPCIS TransformationEvent*. The
  domain model is therefore already EPCIS-shaped without naming it.
- `TraceEvent` carries `id, product_id, event_type, description, from_party,
  to_party, location(GeoLocation), timestamp, record_hash, previous_hash,
  sequence_number, metadata<string,string>` — a **hash-linked append-only chain**
  (record_hash/previous_hash/sequence_number) — exactly the integrity primitive a
  "blockchain-core" would re-introduce.
- **Pluggable ledger** is already a port: README lists `TraceabilityPort` adapters
  `HashChainAdapter (PostgreSQL)` and `MadaraAdapter (Starknet)`. The repo's
  **"appchain"** is this: a **Madara/Starknet (Cairo) appchain**, with planned
  `appchain/contracts/supply_chain.cairo` ("ISO 22005 + ISO 28000") and
  `product_registry.cairo`, configured via `marketplace.toml.template`.
- **Vertivolatam** (the agrifood consumer) is already wired here: README's project
  table sets Vertivolatam → Retail B2B2C / Hortalizas / TRACK inventory /
  Traceability = **Madara/Starknet**. So the appchain *does* cover the blockchain
  need the proposed service targets.
- Standards already claimed: ISO 22005:2007 (feed/food chain traceability),
  ISO 22000:2018, ISO 28000:2022, ISO 28004-2 (`docs/references/`). **Relevance:**
  the bounded context, the ledger abstraction, the appchain, and the agrifood
  consumer all pre-exist — this is the single strongest input to the decision.

### 1.2 Repo — `compliance-core`, `payments-core` (adjacent contexts)
- `compliance-core` already owns an **append-only SHA-256 chained audit log**:
  `proto/compliance/v1/audit.proto`, `domain/services/audit-chain-service.ts`,
  `domain/entities/audit-entry.ts`, `app/ports/audit-log-port.ts` (+ contract &
  fake). 7-year retention is a stated CR AML requirement. **Relevance:** the
  "immutable, tamper-evident record" value proposition of a trace-blockchain is
  *already solved* for compliance events by a hash-chained ledger — no blockchain.
- `payments-core` already owns **escrow & settlement** state machines
  (`openspec/changes/escrow-port`, `ReleaseEscrow` use case, reconciliation ledger,
  `customs-bond-port`). **Relevance:** "pay-on-delivery against a verified trace
  event" belongs to payments-core's escrow, not a new ledger service; the trace
  service would only emit the *verification event* payments consumes.
- **Bounded-context verdict:** value of trace-blockchain splits across THREE
  existing contexts (catalog/trace = marketplace, immutable audit = compliance,
  escrow/settlement = payments). A new service would have to import or duplicate
  all three — a Conway's-Law / boundary-leak smell under the repo's own DDD rules.

### 1.3 Walmart/IBM pork & mango pilots (Kamath 2018, JBBA)
- Built on **Hyperledger Fabric** (modular, pluggable consensus + membership). The
  flagship result: mango origin trace **7 days → 2.2 seconds**; pork farm-to-fork
  with smart-tags/barcodes, RFID, slaughterhouse cameras, cold-chain temp/humidity
  + GPS sensors, e-certificates linked to package via **QR code**.
- IBM deliberately reused **open standards: GS1 EPCIS + Core Business Vocabulary
  (CBV)** and **GTIN + production lot/batch**, to avoid proliferating internal data
  formats. **This is the standard the repo's trace model should align to.**
- Recurring lesson, repeated by the principals: *"Blockchain solves business
  problems where **trust** is part of the solution"* and *"is not solving a
  technical problem, it is solving a **social** problem."* I.e. blockchain earns
  its keep when **multiple mutually-distrusting parties** must share one record —
  not when one operator owns the data.
- The hard prerequisite was **multi-party onboarding & governance** ("collaboration,
  collaboration, collaboration"; regulator green-light; every breeder/processor/
  cold-store/DC/retailer needs a value prop to join). The blockchain was the easy
  part; **whole-chain participant adoption** was the moat. **Relevance:** a single
  startup (Vertivo) cannot unilaterally deliver the multi-party trust value; this
  is the core BUILD risk.

### 1.4 Singh et al. 2022 (J. Food Sci. Technol.) — blockchain in agri-food
- Confirms the architecture pattern: **permissioned blockchain + IoT** (QR, RFID,
  online certificates, sensors) as a middle data-capture layer; IBM Food Trust uses
  **private channels** and smart contracts between subsets of members; data unence-
  rypted *within* a channel to allow automated decisions.
- Names the standard frauds traceability targets — mislabeling, dilution/
  substitution, unapproved ingredient/treatment, document absence/falsification —
  with a per-supply-chain-stage table of which fraud each capture point catches.
- **Limitations stated plainly** (the NO-BUILD evidence): (a) immutability makes
  **erroneous entries irreversible** (the "garbage-in stays forever" problem; a
  farmer's wrong non-GMO claim can't be erased); (b) **lost/corrupt private key →
  unusable**; (c) **limited scalability** (block size/interval); (d) **high
  implementation cost**; (e) scarce blockchain talent; (f) data governance/privacy
  unresolved. **Relevance:** these costs are real and recurring; they argue for
  reusing the existing appchain, not standing up a second ledger.
- Critically: blockchain does **not** solve the **oracle / first-mile problem** —
  garbage data entered at the farm is faithfully made immutable. Trust still needs
  off-chain attestation (certs, sensors, KYC of the party). **Relevance:** the
  high-value work is *event capture + party verification*, which is mostly normal
  software, not ledger work.

### 1.5 Blockchain in Agriculture e-book (2022)
- Frames market drivers (food-safety demand, smart-agriculture adoption, gov't
  initiatives, compliance management) and use cases incl. **Halal supply chain**,
  smart food-monitoring/traceability, and **smallholder decentralization** of
  agribusiness resources. Notes blockchains can be public *or* private.
- **Relevance:** reinforces that the differentiated demand is **certification/
  provenance attestation** (organic, Halal, PDO, fair-trade), which is a
  `Certification` + `Provenance` domain concern — and a strong candidate capability
  *if* the appchain is leveraged, but again not a new service by itself.

### 1.6 IBM `PublicRegulationFabric-Food-IBPV20` (Hyperledger Fabric reference)
- **Stack:** Hyperledger Fabric **v2.0**, Go **chaincode**, Node/Express + Fabric
  SDK backend, Vue frontend, Docker/K8s deploy.
- **Chaincode fns:** `createProductListing`, `transferListing`, `checkProducts`
  (exempt-status / hazard-analysis verification), `updateExemptedList`,
  `read_everything`.
- **Orgs/roles (4):** Supplier, Importer, Retailer, Regulator — each an MSP/peer
  org; a multi-org Fabric network with a regulator participant.
- **Assets:** `ProductListingContract` (listingId, productIds, supplierId, owner,
  status FSM: `INITIALREQUEST → EXEMPTCHECKREQ → CHECKCOMPLETED |
  HAZARDANALYSISCHECKREQ`) and `Product` (productId, quantity, originCountry).
- Models **FDA Foreign Supplier Verification** — i.e. a **regulatory-compliance**
  flow, not pure provenance; and notably **no EPCIS/GS1** in the actual code.
- **Relevance:** good reference for *Fabric org/peer/chaincode/asset-FSM* shape **if**
  Fabric is ever chosen — but it shows the canonical pattern is multi-org +
  regulator, which the repo's single-tenant Starknet appchain does **not** require,
  underscoring that Fabric would be heavier than what Vertivo needs.

### 1.7 AgriDigital (grain/commodity SaaS) — reference domain model
- **Grower/Buyer portals** with shared **Accounts, Invoices, Deliveries,
  Inventory**; grower-side **Orders, Prices, Dashboard**; buyer-side **Contracts,
  Dashboard**. Mobile/tablet field access.
- **Cash Price** = {commodity, grade, season, location/site} (+ optional quantity,
  start/end). **Matching mechanism:** a delivery matching {season, grade, location}
  **auto-generates a Contract** at the posted price — no per-trade negotiation.
- **Delivery** = {deliveryNumber, transferNumber, deliveryDate, commodity,
  primaryGrade, tonnes, season, counterparty, buyer, site, vehicleReg, type,
  status(transferred/warehoused)}; deliveries can be **warehoused** then
  **transferred** (split into A/B partial lots, ≤20 tickets/transfer); link to
  contracts (internal or external).
- **Inventory** = {commodity, primaryGrade, tonnes, storage location/warehouse,
  season, organisation, port zone}; grower retains ownership; transfers via
  contract screen or manual warehouse transfer. **Storage dashboard:** stock on
  hand per site/commodity, daily inbound volumes, truck dwell time, ownership per
  commodity/season, fee structures (shrink, carry, receival, out-turn, location
  differentials).
- **International org connect:** invite external counterparties by email; they
  receive Contracts/Deliveries/Invoices — i.e. **multi-org marketplace**, not a
  ledger feature.
- **Relevance (the key SaaS-vs-ledger split):** *Contracts, Prices, Price-matching,
  Inventory positions, Storage fees, Invoices, Deliveries* are **ordinary
  relational SaaS** — they belong in `marketplace-core` (catalog/inventory/
  transaction) + `invoice-core` + `payments-core`. Only the **custody handoff trail
  + provenance/certification attestation across distrusting parties** is a candidate
  for a ledger — and that is the already-existing `TraceabilityPort`.

### 1.8 IAAS (iaas.org.sg)
- "International Association for Agricultural Sustainability" — a **professional
  membership/networking body** (academia/industry/investment matchmaking; journals;
  $50–$4,000/yr tiers). Spotlight content is **sustainability/circular-economy/agri-
  innovation events**; **no** blockchain/traceability/standards focus.
- **Relevance:** low technical relevance; a potential **distribution/standards-
  community** channel only. Not an input to architecture.

---

## 2. BUILD vs NO-BUILD analysis

### 2.1 What real problem does agri blockchain traceability solve?
From Walmart/IBM and Singh: it collapses recall investigation from **days to
seconds**, enables **surgical recalls** (discard one lot, not a product line),
deters **fraud** (mislabeling, substitution, fake organic/PDO/Halal), and creates a
**shared source of truth among parties who don't trust each other** (farmer ↔
processor ↔ logistics ↔ retailer ↔ regulator). The recurring lesson: blockchain's
value is **social/trust**, realized **only with multi-party adoption**; the ledger
itself is the easy part.

### 2.2 What of the AgriDigital model is plain SaaS vs genuinely needs a ledger?
| Concern | Plain relational SaaS (no chain) | Needs ledger / tamper-evidence |
|---|---|---|
| Contracts, price posting, **price-matching** | ✅ marketplace-core transaction/catalog | — |
| Inventory positions, warehouse, storage fees | ✅ marketplace-core inventory | — |
| Deliveries, transfers, split lots | ✅ marketplace-core + transaction saga | the **custody handoff fact** is what you'd anchor |
| Invoices, settlement, escrow | ✅ invoice-core / payments-core | — |
| **Provenance / origin claims** | metadata in DB | ✅ if shown to outside parties/consumers |
| **Certifications** (organic, Halal, PDO, fair-trade) | DB record | ✅ tamper-evident attestation is the differentiator |
| **Custody chain across distrusting orgs** | DB (single-trust) | ✅ the genuine blockchain case |
| Tamper-evident audit | — | ✅ **already** a hash-chain in compliance-core |

**Most of AgriDigital is ordinary DB-backed SaaS.** The only genuinely
ledger-shaped slice is *cross-org custody + provenance/certification attestation* —
and even that is satisfiable with **DB + signatures (hash-chain)** unless and until
**multiple independent organizations** must co-write one record.

### 2.3 Overlap with existing services
- **marketplace-core (appchain):** ~80% overlap. The `MarketplaceTraceability`
  service, `TraceabilityPort`, hash-chain + **Madara/Starknet appchain**, Cairo
  `supply_chain.cairo` (ISO 22005/28000), and the Vertivolatam wiring already
  *are* the proposed service. The repo's "appchain" **does** cover blockchain.
- **compliance-core (audit):** the SHA-256 **append-only chained audit log** already
  delivers tamper-evidence for compliance/KYC events (7-yr retention). The
  "immutability" selling point is partly already met without a chain.
- **payments-core (escrow/settlement):** owns escrow release & reconciliation;
  pay-on-verified-delivery is a payments concern consuming a trace **event**, not a
  new service.

A standalone `supply-blockchain-core` would therefore **split an existing bounded
context** and force cross-context imports — a DDD boundary violation by the repo's
own governance.

### 2.4 Recommendation — **NO-BUILD (standalone) → ALTERNATIVE**
**Do not create `supply-blockchain-core`.** Instead:

1. **Promote EPCIS conformance inside `marketplace-core`** (OpenSpec change under
   `service:marketplace-core`): rename/extend the three trace verbs to explicit
   **GS1 EPCIS 2.0** event types (Object/Aggregation/Transaction/Transformation +
   the *what/when/where/why* dimensions: `epc`, `bizStep`, `disposition`,
   `readPoint`, `bizLocation`), keeping `record_hash/previous_hash` integrity.
2. **Add `Lot/Batch`, `Certification`, `Provenance` value objects** to the trace
   domain (GTIN + lot, cert issuer/scheme/expiry). This is the differentiated agri
   value (organic/Halal/PDO) the e-book flags.
3. **Reuse the existing Madara/Starknet appchain** as the `TraceabilityPort` ledger
   adapter; keep `HashChainAdapter (PostgreSQL)` as the default. **Do not add
   Hyperledger Fabric** — it implies a multi-org network Vertivo does not yet have.
4. **Emit a `TraceEventVerified` domain event** to the EventBus so payments-core
   (escrow release) and compliance-core (audit) consume it — integration over
   duplication.
5. **Keep grain/commodity SaaS (contracts, prices, inventory, deliveries) in
   marketplace-core + invoice-core + payments-core** — they are relational, not
   ledger.

**Reconsider BUILD only if** a real **multi-party consortium** materializes
(several independent producers/processors/retailers/a regulator each running a
node) where the Starknet appchain is insufficient and a **permissioned Fabric
network with a regulator MSP** (per the IBM reference) is genuinely required. Until
then, a separate ledger service is **over-engineering**.

---

## 3. IF it is built anyway — design sketch

> Use this section only if the multi-party-consortium condition in §2.4 is met.
> Default remains: build it as a **capability in marketplace-core**, not a service.

### 3.1 Bounded context
**Provenance & Custody** — *"the verifiable history of physical agrifood lots as
they change custody and accrue certifications across organizations."* Upstream of
catalog (marketplace-core), audit (compliance-core), settlement (payments-core).
Ubiquitous language: **Lot, TraceabilityEvent, Custody/Handoff, Certification,
Provenance, Party, ReadPoint**. It owns *events & attestations*, **not** orders,
prices, or money.

### 3.2 Domain model (entities / value objects)
- **Lot/Batch** (aggregate root): `gtin`, `lotNumber`, `commodity`, `grade`,
  `season`, `quantity{value,uom}`, `parentLotIds[]` (for split/merge), `status`.
- **TraceabilityEvent** (GS1 EPCIS-aligned): `eventType ∈
  {Object, Aggregation, Transaction, Transformation}`, `epcList[]`, `bizStep`,
  `disposition`, `readPoint`, `bizLocation(GeoLocation)`, `eventTime`,
  `recordTime`, `sourceParty`, `destParty`, `recordHash`, `previousHash`,
  `sequenceNumber`, `metadata`.
- **Custody/Handoff**: `fromParty`, `toParty`, `lotId`, `transferEventId`,
  `conditions` (cold-chain temp/humidity readings — the IoT capture layer).
- **Certification**: `scheme` (Organic/Halal/PDO/FairTrade), `issuer`,
  `certId`, `validFrom/To`, `attestationHash`, `evidenceURI`.
- **Provenance** (read model/projection): the resolved chain for a Lot →
  origin + custody path + certifications + integrity flag.
- **Party**: producer/processor/logistics/retailer/regulator (KYB'd via
  compliance-core — do **not** re-implement identity).

### 3.3 Ports & adapters (Hexagonal)
| Port (application) | Purpose | Adapters (secondary) |
|---|---|---|
| **LedgerPort** | anchor/verify events on a ledger | `StarknetAppchainAdapter` (Madara/Cairo — **reuse repo appchain**); `HashChainAdapter` (Postgres, default); `FabricAdapter` (only if consortium) |
| **EventCapturePort** | ingest field events (QR/RFID/sensor/manual) | `QRScanAdapter`, `RFIDAdapter`, `IoTSensorAdapter` (cold-chain), `ManualEntryAdapter` |
| **VerificationPort** | resolve + integrity-check a Lot's chain | `ChainVerifierAdapter` (hash continuity), `EPCISQueryAdapter` |
| **CertificationPort** | attach/verify certificates | `CertRegistryAdapter`, `IssuerWebhookAdapter` |
| **PartyDirectoryPort** | resolve/verify parties | → **compliance-core** (KYB) via gRPC, not local |
Primary adapters: gRPC server, REST/webhook ingest for scanners/sensors.
Domain stays pure (no framework imports); only port ABCs cross the boundary.

### 3.4 gRPC contract — `proto/supplychain/v1/`
```
service SupplyChainTrace {
  rpc CaptureEvent(CaptureEventRequest) returns (TraceabilityEvent);     // EPCIS capture
  rpc CommissionLot(CommissionLotRequest) returns (Lot);                 // ObjectEvent/commission
  rpc RecordHandoff(RecordHandoffRequest) returns (TraceabilityEvent);   // Transaction/shipping+receiving
  rpc TransformLot(TransformLotRequest) returns (Lot);                   // TransformationEvent
  rpc AttachCertification(AttachCertificationRequest) returns (Certification);
  rpc GetProvenance(GetProvenanceRequest) returns (Provenance);          // EPCIS query
  rpc VerifyChain(VerifyChainRequest) returns (VerifyChainResponse);
}
// messages: Lot, TraceabilityEvent (EPCIS what/when/where/why + record_hash/
// previous_hash/sequence_number), Custody, Certification, Provenance, Party.
```
Mirror marketplace-core's existing `TraceEvent` fields for migration compatibility;
add the EPCIS dimensions (`biz_step`, `disposition`, `read_point`, `epc_list`).

### 3.5 Stack decision — appchain vs Fabric
- **Default: reuse the repo's Madara/Starknet appchain** (Cairo
  `supply_chain.cairo`) + Postgres hash-chain default adapter. Single-tenant,
  already integrated, no new infra, Vertivo already points at it.
- **Hyperledger Fabric** (per IBM reference: Go chaincode, MSP-per-org Supplier/
  Importer/Retailer/Regulator, channels, asset FSM) **only** for a true permissioned
  **multi-org consortium with a regulator participant**. Heavy: ordering service,
  CA/MSP, channel governance — matches Singh's "high cost / scarce talent" warnings.
- **Standards:** target **GS1 EPCIS 2.0 + CBV** (the IBM/Walmart choice) and keep
  the **ISO 22005/28000** mapping already in marketplace-core docs.
- Language/runtime: TypeScript + gRPC + Zod, to match marketplace/payments/
  compliance and share `packages/common`.

---

## 4. Risks & open questions

### Risks
- **Bounded-context split (highest):** duplicates marketplace-core's trace context;
  forces imports from compliance (audit) + payments (escrow) → Conway/DDD violation.
- **Over-engineering:** for a single operator, **DB + signatures (hash-chain)
  already gives tamper-evidence** (compliance-core proves this). Blockchain adds
  cost without the multi-party trust benefit (Walmart's whole point).
- **Oracle / first-mile (Singh):** chain faithfully immortalizes *wrong* farm data;
  value depends on off-chain attestation + party KYC, which is normal software.
- **Immutability hazard:** irreversible erroneous entries; need
  correction/compensation-event semantics, not deletes.
- **Fabric cost/complexity (Singh):** ordering/CA/MSP/channels, scarce talent, block
  size/interval scalability limits, high implementation cost.
- **Key management:** lost/corrupt node private key ⇒ unusable ledger.
- **Adoption moat (Walmart):** the value needs every party (farm→retail→regulator)
  onboarded; a single startup can't unilaterally deliver it.
- **GTM relevance:** IAAS offers community/standards reach but zero technical
  traceability tooling.

### Open questions
1. Is there a **real multi-org consortium** today (≥2 independent orgs willing to run
   nodes), or only Vertivo? (Decides appchain-capability vs Fabric-service.)
2. Does Vertivo need **consumer-facing provenance** (QR-to-story) or only internal
   recall speed? (Decides public verification surface.)
3. Which **certification schemes** matter (organic/Halal/PDO/fair-trade)? Are issuers
   willing to sign attestations?
4. Is **cold-chain IoT capture** (temp/humidity/GPS) in scope now, and what hardware
   (the `apps/raspberry`/OpenMV edge already in the vertivo repo)?
5. Regulatory driver in CR/LatAm equivalent to FDA FSVP that would *mandate* a
   regulator node?
6. Migration: extend marketplace-core's `TraceEvent` in place, or version a new
   `proto/supplychain/v1`? (Recommend extend-in-place to avoid a fork.)
7. Who owns the **correction-event** semantics for immutable bad data?

---

## Appendix — source ledger
- Repo: `services/marketplace-core/{proto/marketplace_core.proto,
  src/domain/ports/traceability.ts, README.md, docs/references/}`;
  `services/compliance-core/.../audit-*`; `services/payments-core/openspec/changes/escrow-port`.
- PDFs: Kamath 2018 *Food Traceability on Blockchain: Walmart's Pork & Mango Pilots
  with IBM* (JBBA 1(1)); Singh et al. 2022 *J. Food Sci. Technol.*; *Blockchain in
  Agriculture* e-book (2022).
- Web: IBM `PublicRegulationFabric-Food-IBPV20`; AgriDigital knowledge base
  (portals, cash price, inventory, deliveries, storage dashboard, intl org);
  iaas.org.sg (membership, spotlight).
