# vision-core — real-time + batch image & video SEGMENTATION for AgTech

**Date:** 2026-06-01
**Owner:** Andrés (Luis Andrés Peña Castillo, GitHub: lapc506, andres@dojocoding.io)
**Status:** Proposed — scaffold on branch `chore/vision-core-scaffold`; pending review/merge
**Domain:** `vision-core` (new 7th service) · touches `common` (gRPC/REST contract), `platform` (gRPC Health, OTel)
**Tracking issue:** _to open_ with `service:vision-core` + `type:feature` + `size:XL` (decompose).
**Primary consumer:** `vertivolatam` (Vertivo) AgTech product.

---

## Why (Problem)

`vertivolatam` already ships a **phytopathology** domain in its Serverpod backend
(`apps/vertivo_server/lib/src/phytopathology/`) with persisted entities —
`DiseaseDetection`, `PestIdentification`, `NutritionalDeficiency`,
`TreatmentRecommendation` — but **no engine that actually produces those
detections from imagery**. The `DiseaseDetection` row carries
`confidence`, `severity`, `affectedAreaPercent`, `anatomicalParts`, `imageUrl`,
and `aiModelVersion` fields that are today **written by hand / left null**: the
backend records detections but cannot compute them.

Each Vertivo micro-greenhouse has an embedded agronomist robot (Raspberry Pi +
sensors) and a camera. The product promises "fitopatología AI" (README) and
real-time, autonomous crop care for users with **zero agronomy knowledge**. That
promise requires a vision engine that can:

- **Segment** plant imagery to locate disease lesions, pests, and nutritional
  deficiency patterns at the pixel level (not just a whole-image class) so
  `affectedAreaPercent` and `anatomicalParts` can be computed.
- Run **at the edge** (on/near the greenhouse robot) for real-time monitoring
  without round-tripping every frame to the cloud, and **in batch** in the cloud
  for periodic crop-health sweeps and model retraining.
- Be **retrainable per crop** — Vertivo grows specific species (lettuce, basil,
  tomato, etc.); a generic model is not accurate enough, so crop-specific
  fine-tuning on captured datasets is a first-class requirement.

No existing service in `better-microservices` does computer vision. `agentic-core`
has a `MediaPort.describe_image` for LLM-based captioning, but that is generic
multimodal description, not pixel-accurate segmentation with quantified affected
area, severity, and a retrainable per-crop model registry. This is a distinct
capability that warrants its own service.

## What (Decision)

Create **`vision-core`**, the 7th microservice: a source-available, hexagonal
(Explicit Architecture) Python service for **image & video segmentation for
AgTech** — crop/plant disease identification, pest detection, plant-species ID,
and crop monitoring. It is built README-first, mirrors the `agentic-core`
Python-stack conventions (hexagonal `src/`, ports/adapters, proto, deployment,
BSL 1.1), and exposes a stable gRPC + REST contract that `vertivolatam` consumes.

vision-core is **domain-agnostic at its core and AgTech-shaped at its edges**: the
domain models segmentation generically (an image/frame → masks + labels +
quantified area), while adapters and the default model registry are tuned for
plant phytopathology. Like `agentic-core`, **no `vertivolatam`-specific business
logic lives in vision-core** — Vertivo owns the mapping from a `Segmentation`
result to a `DiseaseDetection` row.

### Why segmentation (not just classification or detection)

Vertivo's persisted contract needs **`affectedAreaPercent`** (what fraction of
the leaf/plant is diseased) and **`anatomicalParts`** (which parts are affected).
Whole-image **classification** ("this plant has powdery mildew") cannot produce
either. **Bounding-box detection** localizes but over-counts area (boxes include
healthy pixels). Only **instance/semantic segmentation** yields pixel-accurate
masks from which affected-area % and per-part involvement are computed directly.
Segmentation is therefore the core primitive; detection falls out of it for free
(every mask has a box), and classification is the trivial reduction.

### Candidate models (verdict in `design.md`)

Two state-of-the-art segmentation-capable model families are evaluated and **both
are supported behind a port** so the choice is deployment-time, not baked in:

- **Ultralytics YOLO (segmentation)** — `YOLO26-seg` / `YOLO11-seg`: CNN,
  tiny, fast, cheap edge fit; **AGPL-3.0** (copyleft) or paid Enterprise.
- **RF-DETR (Roboflow)** — `rf-detr-seg`: DETR transformer, higher accuracy on
  small objects / cluttered scenes (first real-time detector >60 AP on COCO);
  **Apache-2.0** for Nano→Large.

The ADR (`design.md`) selects a **default per deployment tier** (edge vs cloud)
with a comparison matrix and a licensing-aware verdict.

## Scope

**In scope**
- This OpenSpec change (`proposal.md` PDR + `design.md` ADR + `tasks.md`).
- `services/vision-core/` scaffold: README-first README.md, `pyproject.toml`
  (SPDX `BUSL-1.1`), hexagonal `src/vision_core/` skeleton (domain, application
  with the four ports, primary gRPC + REST/FastAPI adapters, secondary
  Ultralytics + RF-DETR + model-registry adapters), `proto/vision/v1/`, `tests/`
  skeleton, `deployment/` (k8s manifests + Kubeflow pipeline stub + Jetson
  Dockerfile/notes), `examples/`, `LICENSE.md` (BSL 1.1), thin Turbo
  `package.json`.
- The gRPC/REST **contract** `vertivolatam` will consume (`vision.v1`).

**Out of scope (deferred to apply phases — see `tasks.md`)**
- Real model weights, training runs, and a populated model registry. The scaffold
  ships **port ABCs + stub adapters that raise `NotImplementedError`**, not a
  running inference server.
- The actual Kubeflow cluster, Jetson hardware provisioning, and CI wiring.
- `vertivolatam`-side integration code (the Serverpod → vision-core gRPC client
  lives in the Vertivo repo, not here).
- Choosing AGPL vs Apache as the **shipped** default for Vertivo's commercial
  edge deployment — flagged as an **owner decision** (licensing) in `tasks.md`.

## Risks / Trade-offs

- **Licensing is load-bearing.** Ultralytics YOLO is **AGPL-3.0**: shipping it on
  a Vertivo commercial edge device may trigger copyleft / require an Enterprise
  license. RF-DETR (Nano→Large) is Apache-2.0 and commercially safe. The
  port-based design lets Vertivo pick, but the **default** is an owner call.
- **Edge vs cloud split** adds operational surface (two inference paths, model
  sync). Justified by real-time latency needs + bandwidth at the greenhouse.
- **Per-crop accuracy** requires a labeled-dataset + retraining loop (Kubeflow)
  that Vertivo must feed; cold-start accuracy on a generic model will be modest
  until crop-specific fine-tuning runs.
- **Scaffold ≠ working service.** This change delivers contracts and structure;
  inference is stubbed. Set expectations accordingly in the tracking issue.
