# ADR — vision-core architecture: hexagonal segmentation engine, model choice, edge/cloud split, vertivolatam contract

**Date:** 2026-06-01
**Domain:** `vision-core`
**Decision:** Hexagonal (Explicit Architecture) Python service exposing four ports
(`SegmentationModelPort`, `VideoStreamPort`, `InferencePort`, `ModelRegistryPort`)
with `UltralyticsYOLOAdapter` + `RFDETRAdapter` behind `SegmentationModelPort`;
primary gRPC + REST/FastAPI adapters; **RF-DETR-Seg as the cloud/accuracy default,
YOLO-seg as the edge/latency default**; Jetson edge + Kubeflow cloud deployment;
gRPC `vision.v1` contract consumed by `vertivolatam`.

> Research sources digested before this ADR are cited inline as `[Sn]` and listed
> in §9.

---

## 1. Architecture — Explicit Architecture (Hexagonal + DDD), mirroring agentic-core

vision-core copies `agentic-core`'s layering exactly so the monorepo stays
consistent: **all arrows point inward**; domain has zero external imports;
application defines port ABCs; adapters implement them.

```
Primary Adapters (gRPC, REST/FastAPI)   — call into →
  Application Layer (Commands, Queries, Ports)   — uses →
    Domain Layer (Image, Frame, Segmentation, Mask, CropLabel — pure)
  Application Layer   ← implemented by —
Secondary Adapters (UltralyticsYOLO, RF-DETR, ModelRegistry, VideoStream, OTel)
```

### Domain (pure, zero deps)
- **Entities:** `SegmentationJob` (a unit of work over an image or video),
  `ModelDescriptor` (id, family, task, version, crop scope).
- **Value objects:** `Image`, `VideoFrame`, `Mask` (polygon/RLE + class + score),
  `Segmentation` (the result: list of masks + image dims + model version +
  derived `affected_area_percent`), `CropLabel`, `BoundingBox`, `Confidence`,
  `Severity`.
- **Events:** `SegmentationCompleted`, `LowConfidenceFlagged`,
  `ModelVersionPromoted`.
- **Domain services:** `AreaQuantifier` (mask pixels → `affected_area_percent`),
  `SeverityScorer` (area + class → `severity` bucket). These are the pure
  functions Vertivo cannot get from classification/detection.

### Application — the four ports (the heart of the ADR)

| Port | Role | Driven adapter(s) |
|---|---|---|
| **`SegmentationModelPort`** | *Driven.* Given an `Image`/`VideoFrame` + `ModelDescriptor`, return a `Segmentation` (masks, labels, scores). The model-family abstraction. | `UltralyticsYOLOAdapter`, `RFDETRAdapter` |
| **`InferencePort`** | *Driven.* Where/how inference runs — local in-process (Jetson/cuDNN/TensorRT), or remote (KServe/Triton in-cluster). Decouples *which model* from *where it executes*. | `LocalTensorRTAdapter` (Jetson), `KServeInferenceAdapter` (cloud) |
| **`VideoStreamPort`** | *Driven.* Open a stream (RTSP/file/device), yield decoded `VideoFrame`s, handle frame sampling/backpressure for real-time vs batch. | `OpenCVVideoStreamAdapter`, `GStreamerJetsonAdapter` |
| **`ModelRegistryPort`** | *Driven.* Resolve/pull/promote model versions per crop; record `aiModelVersion`. Backs reproducible retraining + edge model sync. | `KubeflowModelRegistryAdapter`, `LocalFsModelRegistryAdapter` |

Commands: `SegmentImage`, `SegmentVideo` (streaming), `WarmModel`,
`PromoteModelVersion`. Queries: `ListModels`, `GetModelForCrop`, `HealthCheck`.

**Why two separate ports for "model" and "inference":** the same `rf-detr-seg`
weights run very differently on a Jetson (in-process TensorRT engine, FP16) vs in
the cloud (KServe pod, batched). `SegmentationModelPort` answers *what does this
model output*; `InferencePort` answers *where does the math happen*. Keeping them
orthogonal lets us swap the cloud serving runtime without touching model code and
vice-versa.

### Primary adapters
- **gRPC** (`vision.v1.SegmentationService`) — the canonical contract Vertivo's
  Serverpod backend calls; supports unary `SegmentImage` and server-streaming
  `SegmentVideo`. Mirrors agentic-core's gRPC-first primary adapter.
- **REST/FastAPI** — an HTTP/JSON facade over the same application commands for
  quick integration, the mobile/dashboard side, and Agrio-style image-upload
  diagnosis ergonomics `[S6]`.

## 2. Model decision — Ultralytics YOLO-seg vs RF-DETR-Seg

### Comparison matrix

Numbers are COCO-benchmark figures digested from the model docs and the YOLO26
vs RF-DETR comparison `[S1][S2][S3]`; AgTech relevance from `[S5][S7][S8]`.

| Dimension | **Ultralytics YOLO-seg** (YOLO26/YOLO11-seg) | **RF-DETR-Seg** (Roboflow) |
|---|---|---|
| Architecture | CNN, anchor-free one-stage | DETR transformer (DINOv2 backbone), NAS-tuned `[S2]` |
| Tasks | detect · **segment** · pose · OBB · classify · track (built-in) `[S3]` | detect · **segment** only `[S1][S3]` |
| Seg accuracy (COCO mask AP50:95) | n 33.9 · s 40.0 · m 44.1 · l 45.5 · x 47.0 `[S4]` | Seg-L **47.1** · Seg-2XL **49.9** `[S1]` |
| Detect accuracy (COCO AP50:95) | n ~40.9 · x ~56 `[S3]` | n 48.0 · **2XL 60.1** (first real-time >60 AP) `[S1][S2]` |
| Small-object / cluttered scene | good | **better** — transformer context `[S2][S3]` |
| Speed (T4 TensorRT, seg) | n **2.1 ms** · m 6.7 ms · x 16.4 ms `[S4]` | n ~2.3 ms (detect) `[S3]`; seg heavier |
| Params (nano) | very small | n ~30.5M `[S3]` (flat n→l) |
| Input res | 640 (all sizes) `[S3]` | per-size 384→880 `[S1][S3]` |
| Edge / Jetson fit | **excellent** — tiny, mature TensorRT path `[S4]` | good — Jetson deploy documented via Roboflow Inference, JetPack 5+ `[S5]` |
| Export | ONNX + TensorRT `[S3][S4]` | ONNX + TensorRT (FP16) `[S1][S5]` |
| **License** | **AGPL-3.0** (copyleft) or paid Enterprise `[S3]` | **Apache-2.0** (Nano→Large); XL/2XL proprietary PML `[S1][S3]` |
| Maturity / ecosystem | very mature, huge community `[S3]` | new (2026), catching up `[S3]` |

### Verdict — tiered default, both behind the port

**There is no single winner; the right model depends on the deployment tier and
on licensing.** We therefore ship **both** behind `SegmentationModelPort` and pick
a **default per tier**:

- **Edge (Jetson, real-time per-frame monitoring) → default `YOLO26-seg` (n/s).**
  It is tiny, fastest (2.1 ms/frame seg on T4-class), and has the most mature
  TensorRT path — the right fit for a greenhouse robot doing continuous, low-cost
  inference. **Caveat:** AGPL-3.0. For Vertivo's *commercial* edge shipment this
  is a licensing decision (Enterprise license vs accept copyleft vs use RF-DETR
  instead) — **flagged to the owner**, not decided here.

- **Cloud (Kubeflow batch crop-health sweeps + the accuracy-critical path) →
  default `rf-detr-seg` (L).** Higher mask accuracy (47.1 vs 45.5 AP50:95),
  markedly better on **small lesions and cluttered canopies** — exactly the
  AgTech failure mode (early-stage disease spots, overlapping leaves) `[S2]` — and
  **Apache-2.0**, so it is commercially clean for the managed cloud product and
  for distributing fine-tuned weights.

This split also de-risks licensing: the Apache-2.0 RF-DETR is always available as
a **drop-in replacement on the edge** if Vertivo declines the YOLO Enterprise
license. The `ModelRegistryPort` records `aiModelVersion` (e.g.
`rf-detr-seg-l@vertivo-lettuce-2026.06`) into Vertivo's `DiseaseDetection.aiModelVersion`.

## 3. Edge (Jetson) vs cloud (Kubeflow) inference split

| Concern | **Edge — NVIDIA Jetson (cuDNN/TensorRT)** | **Cloud — Kubeflow on k8s** |
|---|---|---|
| Trigger | Real-time, per-frame, on/near the greenhouse robot | Batch sweeps, on-demand high-accuracy re-check, retraining |
| Model | YOLO26-seg n/s (default), TensorRT FP16/INT8 engine | RF-DETR-Seg L (default), KServe/Triton |
| Latency goal | single-digit→tens of ms/frame, no network round-trip | seconds, throughput-oriented |
| Why edge | bandwidth at the greenhouse, autonomy, privacy; mirrors SeeTree (Jetson TX2) / Bilberry weed-recognition on Jetson `[S7]` | heavy models, GPU pooling, reproducible retraining `[S8]` |
| cuDNN role | underlies the TensorRT engine — GPU-accelerated conv/attention primitives for low-latency embedded inference `[S9]` | same primitives, server GPUs |
| Runtime | `LocalTensorRTAdapter` + `GStreamerJetsonAdapter` | `KServeInferenceAdapter` + `KubeflowModelRegistryAdapter` |

**Rule:** edge does *real-time triage* (flag a suspect frame fast); cloud does
*authoritative diagnosis + retraining*. A low-confidence edge result
(`LowConfidenceFlagged`) escalates the frame to the cloud RF-DETR path — the same
edge-fast / cloud-authoritative pattern the NVIDIA AgTech examples use (Jetson
local inference, GPU cloud for the heavy lifting) `[S7]`.

## 4. Image vs video segmentation handling

- **Image** — unary `SegmentImage`: one `Image` → one `Segmentation`. Used for
  user-uploaded diagnosis photos (Agrio-style) `[S6]` and per-snapshot greenhouse
  checks.
- **Video** — `VideoStreamPort` decodes a stream into `VideoFrame`s; the
  application **samples** frames (configurable stride / keyframe / motion-gated)
  rather than segmenting every frame, then runs the same `SegmentationModelPort`.
  Server-streaming `SegmentVideo` returns a `Segmentation` per sampled frame.
  Real-time on edge uses GStreamer hardware decode on Jetson; batch in cloud uses
  OpenCV. Tracking (object IDs across frames) is delegated to YOLO's built-in
  trackers when the YOLO adapter is active `[S3]`; RF-DETR path is per-frame.

## 5. vertivolatam integration contract

Vertivo's Serverpod backend (`apps/vertivo_server/lib/src/phytopathology/`) is the
client. It already persists `DiseaseDetection` / `PestIdentification` /
`NutritionalDeficiency` with fields that map **1:1** onto a `Segmentation`:

| `vision.v1` field (response) | Vertivo `DiseaseDetection` field | Produced by |
|---|---|---|
| `masks[].class_name` | `diseaseName` / `diseaseType` | model labels |
| `masks[].confidence` | `confidence` | model score |
| `affected_area_percent` | `affectedAreaPercent` | `AreaQuantifier` (mask pixels) |
| `severity` | `severity` | `SeverityScorer` |
| `masks[].anatomical_part` | `anatomicalParts` | label taxonomy |
| `image_ref` | `imageUrl` | passthrough |
| `model_version` | `aiModelVersion` | `ModelRegistryPort` |

**Contract (gRPC `vision.v1.SegmentationService`):**
- `rpc SegmentImage(SegmentImageRequest) returns (SegmentImageResponse)` — unary.
  Request: image bytes **or** URL, `crop_hint`, `task` (disease|pest|deficiency|
  species), `model_pref`. Response: `Segmentation` (repeated `Mask`,
  `affected_area_percent`, `severity`, `model_version`, `trace_id`).
- `rpc SegmentVideo(SegmentVideoRequest) returns (stream SegmentationResponse)` —
  server-streaming for real-time/edge.
- `rpc ListModels` / `GetModelForCrop` / `HealthCheck` (gRPC Health v1, per
  `platform` convention).
- **REST mirror** `POST /v1/segment` (multipart image upload) for the mobile app /
  dashboard, Agrio-style ergonomics `[S6]`.

vision-core returns **generic segmentation**; **Vertivo owns** the mapping to its
domain rows (which `class_name` is which `diseaseType`, what `TreatmentRecommendation`
to suggest). No Vertivo business logic enters vision-core — same boundary rule as
agentic-core.

## 6. Training / fine-tuning pipeline (Kubeflow) for crop-specific datasets

Kubeflow Pipelines model the retraining loop as a containerized DAG `[S8]`:
`ingest (labeled crop images) → preprocess/augment → train (YOLO-seg or
RF-DETR-seg) → evaluate (mask mAP gate) → export (ONNX→TensorRT FP16/INT8) →
register (ModelRegistryPort, tagged per crop) → (manual gate) promote → sync to
edge`. Katib handles HPO; KServe serves the cloud model `[S8]`. Each promoted
version gets a registry id used as `aiModelVersion`. Retraining re-runs on new
captured/labeled greenhouse imagery, giving per-crop accuracy that a generic COCO
model cannot. A pipeline **stub** (`deployment/kubeflow/pipeline.py`) is scaffolded;
real runs are an apply-phase task.

## 7. Why not reuse agentic-core's MediaPort

`agentic-core.MediaPort.describe_image` is LLM multimodal captioning — a sentence
about an image. It cannot emit pixel masks, `affected_area_percent`, per-part
involvement, a retrainable per-crop model registry, or run a TensorRT engine on a
Jetson. Different primitive, different lifecycle (model training vs prompt) →
separate service. They compose: agentic-core can *narrate* a vision-core
`Segmentation` to the user.

## 8. Consequences

- ➕ Vertivo's phytopathology fields stop being null — vision-core computes them.
- ➕ Licensing-flexible: Apache-2.0 RF-DETR always available; YOLO optional.
- ➕ Edge real-time + cloud authoritative, with a clean escalation path.
- ➖ Two inference runtimes + model-sync = more ops surface.
- ➖ Scaffold ships stubs; cold-start accuracy waits on per-crop retraining.
- ⚠️ **Owner decision:** the *shipped* edge default's license (YOLO AGPL/Enterprise
  vs RF-DETR Apache) — see `tasks.md`.

## 9. Research sources

- **[S1]** RF-DETR GitHub (roboflow/rf-detr) — seg variants, COCO Seg AP50:95
  (Seg-L 47.1, Seg-2XL 49.9), per-size input res, Apache-2.0 Nano→Large.
- **[S2]** arXiv 2511.09554 *RF-DETR: Neural Architecture Search for Real-Time
  Detection Transformers* — NAS, nano 48.0 AP, first real-time >60 AP on COCO,
  beats D-FINE / GroundingDINO; transformer context helps small/cluttered objects.
- **[S3]** YouTube `MgbP5szEBDo` (YOLO26 vs RF-DETR) — task coverage, model sizes,
  AGPL vs Apache licensing, qualitative seg quality (RF-DETR sharper boundaries),
  speed/params trade-off. **Transcript takeaways:** YOLO26 (Ultralytics, Jan 2026)
  = fast/cheap/most tasks/AGPL-3.0; RF-DETR (transformer) = more accurate esp.
  small objects & context, Apache-2.0 (nano→large), the practical pick when
  accuracy matters; for 90%+ of commercial projects you need detection or
  segmentation, which both cover.
- **[S4]** Ultralytics docs — YOLO26-seg mask mAP + T4 TensorRT seg latency table,
  ONNX/TensorRT export.
- **[S5]** Roboflow blog — deploy RF-DETR to NVIDIA Jetson (Roboflow Inference
  server, JetPack 5+, Python 3.12+, TensorRT FP16).
- **[S6]** Agrio Agriculture / image-diagnosis API — image→diagnoses with
  confidence + context-aware treatment; the REST image-upload ergonomics model.
- **[S7]** NVIDIA AgTech blog — SeeTree (Jetson TX2 image processing), Bilberry
  (Jetson weed recognition, −92% chemicals), University of Florida smart sprayers,
  Beewise — edge Jetson inference + GPU cloud training split.
- **[S8]** iamondemand / Kubeflow — Pipelines as containerized DAGs, Katib HPO,
  KServe serving, reproducible continuous retraining.
- **[S9]** NVIDIA cuDNN — GPU-accelerated DNN primitives (conv/attention/pooling)
  underpinning TensorRT low-latency inference on embedded Jetson GPUs.
- **[S10]** arXiv 2509.25164 *YOLO26: Architectural Enhancements & Benchmarking* —
  YOLO family progression and real-time detection benchmarking context.
