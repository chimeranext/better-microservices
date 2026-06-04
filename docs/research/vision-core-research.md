# vision-core — Research Synthesis (extension design material)

> **Audience:** NOT a human end-reader — this is design input for extending the
> `vision-core` microservice (phytopathology / pest & disease vision + MLOps) in
> `better-microservices`. It is grounded in the EXACT conventions of
> `services/vision-core/{AGENTS.md,README.md}`, `proto/vision/v1/vision.proto`,
> and `pyproject.toml` (read 2026-06-03).
>
> **vision-core baseline recap (so the hooks below are concrete):**
> - Explicit Architecture (Hexagonal + DDD). Domain is pure Python, zero imports.
>   `VISION_`-prefixed env config. License **BUSL-1.1**. Weights never committed.
> - Ports today: `SegmentationModelPort`, `InferencePort`, `VideoStreamPort`,
>   `ModelRegistryPort`, `ObjectStoragePort`, `DetectionRuntimePort`,
>   `VlmDiagnosisPort`, `CaptureIngestPort`, `ActiveLearningPort`.
> - Secondary adapters: UltralyticsYOLO, RF-DETR, Triton, vLLM, NIM, MQTT,
>   MinIO active-learning, s3fs, OpenCV/GStreamer video, local-fs + Kubeflow registry.
> - Models behind one port: **YOLO26-seg** (edge, AGPL-3.0) vs **RF-DETR-Seg**
>   (cloud, Apache-2.0), chosen at deploy time. VLM (Qwen-VL/LLaVA) always cloud.
> - 3-tier topology: Tier-0 OpenMV FOMO → Tier-1 cloud KServe (Triton+vLLM) →
>   Tier-2 Jetson edge detection. MLOps on Kubeflow (Dask→Katib→Training
>   Operator→KServe), all I/O via s3fs/MinIO.

---

## 1. Per-source findings

### 1.1 GRAPE_YOLO.zip (local dataset)
- **Format:** Ultralytics YOLO **detection** layout (NOT segmentation). `data.yaml`
  declares `nc: 4`, `names: [Grape__BlackRot, Grape__Esca, Grape__Healthy,
  Grape__LeafBlight]`. Origin path points at Kaggle
  `yusufmurtaza01/grape-leaf-diseases`.
- **Splits:** `images/train` 3358 + `labels/train` 3358; `images/val` 837 +
  `labels/val` 837; `test: ''` (empty — **no test split**). 8393 files total,
  ~143 MB.
- **Labels:** YOLO txt, one box per line `class cx cy w h` (normalized). Verified
  samples are class `2` (Healthy) full-frame boxes; some files have 2 boxes.
  **Boxes only — no polygons/masks.**
- **How it maps to vision-core:** A ready per-crop **grape** fine-tune corpus for
  `MODEL_FAMILY_YOLO_SEG` (detection mode) or `RFDETRNano` detection. BUT
  vision-core's thesis is *segmentation* (pixel-accurate `affected_area_percent`);
  these are box labels, so this dataset feeds **detection-only** training or must
  be upgraded to masks (SAM-assisted relabel via ActiveLearning HITL). The
  `Grape__Healthy` class is a useful negative/background class. `class_name`
  values map onto Vertivo `diseaseName` directly. Lacks a test split → the
  Kubeflow pipeline must carve one.

### 1.2 PDF `2603.26306v1.pdf` — ⚠ NOT the expected topic
- **Actual content:** *"Integration Adapter Architecture for Food Traceability
  Blockchain"* (Romão et al., INESC-ID / IST Lisboa, Mar 2026). Hyperledger
  Fabric, permissioned blockchain, Fundão-cherry fruit supply chain pilot.
  **Nothing about computer vision or phytopathology.** The brief implied a
  vision paper; this file is a blockchain-integration paper. Flagged as an open
  question (wrong file, or intentional cross-domain input).
- **Transferable architectural idea (weak):** Its 5 decoupled modules —
  *Extractors → Transformers → Messaging middleware (queues, tolerate
  intermittent connectivity/traffic spikes) → Blockchain Loader → Status
  Visibility (runtime metrics)* — are a clean ports-&-adapters mediation pattern.
  The **"messaging middleware to tolerate lack of connectivity"** maps onto
  vision-core's constrained-greenhouse-link / MQTT capture ingest reality (store-
  and-forward of captures when the link drops). The **Status Visibility** module
  ≈ an observability/metrics port. Treat as *analogy only*, not a primary source.

### 1.3 PDF `diaf022.pdf` / OUP *in silico Plants* 7(2) — tomato FSPM digital twin
- **License:** Open Access **CC BY 4.0** (Smoleňová et al., 2025, Wageningen UR).
- **Core:** A functional–structural plant (FSP) model of tomato for greenhouse
  **digital twins**; simulates 3D architecture at **organ level**: leaves
  (leaflets, petiole angle, area, dry weight), **internodes/stem** (length,
  thickness — "plant head" / stem thickness 15 cm below apex), **trusses**
  (reproductive), **phytomers** (thermal-time appearance). Plant-level traits:
  height, organ counts, organ dry weight.
- **Phenotyping loop relevant to us:** model is updated from **2D RGB image
  segmentation** (plant-height via thresholding + connected components) → P-spline
  smoothing → **Bayesian optimization** of 4 height params. This is a
  HITL-free image→trait assimilation pipeline.
- **How it maps to vision-core:** Authoritative **anatomical-part taxonomy** for
  the `anatomical_part` field on `Mask` and `Diagnosis.anatomical_parts`:
  `leaf` / `leaflet` / `petiole` / `internode` / `stem` / `truss` / `fruit` /
  `apex/head` / `phytomer`. Validates segmenting *organs* (not whole plant) so
  affected-area % is computed per organ. The Bayesian-opt image→trait pattern
  is a model for an eventual **phenotyping/trait-extraction capability** beyond
  disease (stem-thickness, leaf-area as health proxies). Digital-twin framing
  aligns with Vertivo's autonomous-greenhouse story.

### 1.4 IPPC PDF (`LISTA_PLAGAS_REGLAMENTADAS_2019`) — Costa Rica SFE regulated-pest list
- **What it really is:** Costa Rica's **Lista de Plagas Reglamentadas** (Servicio
  Fitosanitario del Estado / MAG), built per **ISPM/NIMF No. 19** (FAO 2003).
  53 pages. **Highly relevant** — Vertivo is Costa-Rican; this is the legal pest
  taxonomy of the target market.
- **Structure (4 columns per row):** `Nombre preferido` (scientific binomial +
  author/year) · `Grupo común` (taxonomic group) · `Situación` (quarantine
  status, e.g. "Ausente: no hay registros") · `Artículos reglamentados` (host
  crops, e.g. *Vitis vinifera* grape, *Citrus*, *Prunus*, *Allium*).
- **Three regulated lists:** (1) Quarantine pests **absent**; (2) Quarantine pests
  **present, limited distribution, under official control**; (3) **Regulated
  non-quarantine** pests. → a natural `quarantine_status` enum.
- **Taxonomic-group distribution (counted):** Insecta ~296, Fungi ~31, Virus ~54,
  Acari ~20, Nematoda ~18, Bacteria ~14, Viroide ~2, Mollusca ~1. → a natural
  `pest_group` enum: `INSECTA / ACARI / FUNGI / BACTERIA / VIRUS / VIROID /
  NEMATODA / MOLLUSCA / WEED`.
- **How it maps to vision-core:** Source of truth for a **domain pest/disease
  taxonomy value-object** (`PestTaxon`) — scientific name, group, quarantine
  status, host-crop scope. The `Task` enum (`TASK_PEST`, `TASK_DISEASE`) gains a
  controlled vocabulary. `crop_hint` ↔ `Artículos reglamentados` lets the
  ModelRegistry route per-crop. Note: vision-core stays generic (no business
  logic) — so this is a **shared taxonomy value-object / reference table**, with
  Vertivo owning the regulatory/alerting semantics.

### 1.5 supervision — `InferenceSlicer` / SAHI (KEY for small lesions)
- **Mechanism:** Tile a high-res image into overlapping slices, run a `callback`
  per tile returning `sv.Detections`, then merge. Dramatically lifts recall on
  **tiny objects** (early lesions, aphids, mites) vs single-pass.
- **API:** `sv.InferenceSlicer(callback, slice_wh=(w,h), overlap_wh=(px,px)` *or*
  `overlap_ratio_wh=(0.15,0.15)`, `overlap_filter=sv.OverlapFilter.NON_MAX_SUPPRESSION`
  *or* `.NON_MAX_MERGE`, `iou_threshold=…`, `thread_workers=4)` → call
  `slicer(image)`. Default `overlap_wh` ≈ 100 px.
- **Model-agnostic:** callback can wrap Ultralytics (`from_ultralytics`), Roboflow
  Inference (`from_inference`), HF, or **RF-DETR** — anything emitting
  `sv.Detections`. **Works for instance segmentation too** (handles masks).
- **Tuning:** raise overlap when objects span tile borders; `NON_MAX_MERGE`
  reconstructs objects split across tiles (good for elongated lesions);
  `NON_MAX_SUPPRESSION` is cheaper.
- **How it maps to vision-core:** A **domain-level decorator over
  `SegmentationModelPort`** — `SlicingSegmentationModel` that wraps any inner
  model and applies SAHI before returning a `Segmentation`. Mask coords are
  remapped to full-image space so `AreaQuantifier` still works. Toggle by env
  (`VISION_SLICING_ENABLED`, `VISION_SLICE_WH`, `VISION_SLICE_OVERLAP`). Cost:
  N× inferences/frame — use on still photos / batch, not Tier-2 real-time edge.

### 1.6 RF-DETR fine-tuning notebooks (detection + segmentation) + Context7 `/roboflow/rf-detr`
- **Install:** `pip install -q rfdetr>=1.4.0 supervision roboflow`.
- **Model variants (Apache-2.0):** Detection `RFDETR{Nano,Small,Medium,Large,
  XLarge,2XLarge}`; Segmentation `RFDETRSeg{Nano,Small,Medium,Large,XLarge,
  2XLarge}`. Nano/Small are the realistic edge/Jetson candidates.
- **Dataset:** `from roboflow import download_dataset; download_dataset(<universe
  url>, "coco")` → standard `_annotations.coco.json` train/valid/test.
- **Train:** `model.train(dataset_dir=…, epochs=100, batch_size=4,
  grad_accum_steps=4, lr=1e-4, output_dir=…)`. Guidance: keep effective batch
  (`batch_size × grad_accum_steps`) ≈ **16**; fine-tune from COCO-pretrained.
- **Export:** `model.export(format='onnx')` (CPU OK); for TensorRT export ONNX
  then `trtexec --onnx=model.onnx --saveEngine=model.trt --fp16`.
- **Inference:** `model.optimize_for_inference(); dets = model.predict(img,
  threshold=0.5)` → annotate via supervision `MaskAnnotator/PolygonAnnotator/
  BoxAnnotator`. Also `model.deploy_to_roboflow(...)` to host.
- **How it maps to vision-core:** Directly operationalizes the **Kubeflow
  Training Operator** stage: a `RFDETRTrainerAdapter` behind a new
  `ModelTrainingPort` that downloads a COCO dataset from MinIO (ActiveLearning
  output) or Roboflow Universe, trains, exports ONNX→TensorRT, and registers via
  `ModelRegistryPort`. The TensorRT `.engine` is what `LocalTensorRTAdapter`
  consumes on Jetson. Clean Apache-2.0 path that **avoids the YOLO AGPL problem**.

### 1.7 roboflow/inference on Jetson + NVIDIA Container Toolkit
- **Jetson images:** `roboflow/roboflow-inference-server-jetson-<JP>:latest` for
  JetPack 4.5/4.6 (deprecated), 5.1.1, 6.0.0, **6.2.0**. Needs ≥10 GB disk,
  Docker + NVIDIA Container Toolkit; recommended **Orin NX 16 GB+**.
- **Run:** `docker run -d --runtime nvidia --read-only -p 9001:9001 -v
  ~/.inference/cache:/tmp:rw … roboflow/roboflow-inference-server-jetson-6.2.0`.
  TensorRT via `-e ONNXRUNTIME_EXECUTION_PROVIDERS="[TensorrtExecutionProvider,
  CUDAExecutionProvider,CPUExecutionProvider]"` (first load compiles the engine).
  Or `pip install inference-cli && inference server start` (auto-detect JetPack).
- **NVIDIA Container Toolkit (host prereq):** apt repo + `nvidia-container-toolkit`
  pkgs, then `sudo nvidia-ctk runtime configure --runtime=docker && systemctl
  restart docker`; **containerd** variant (`--runtime=containerd`) is the one
  the **K8s/KServe** edge nodes need; rootless + CDI modes documented.
- **How it maps to vision-core:** Concrete Tier-2 deploy recipe for
  `deployment/jetson/`. Two viable edge runtimes behind `InferencePort` /
  `DetectionRuntimePort`: (a) **self-managed TensorRT** (`LocalTensorRTAdapter`,
  current plan) or (b) **Roboflow Inference server** as a sidecar
  (`RoboflowInferenceAdapter`, HTTP `:9001`). The container-toolkit
  `nvidia-ctk … --runtime=containerd` step is a documented prerequisite for the
  Jetson K8s manifests and the `rbac.yaml` GPU nodes.

### 1.8 Roboflow Train from Google Cloud
- **Gated:** "only available on **Enterprise plans**." It does **not** give you a
  GPU/VM — it exports the dataset in **Google Cloud AutoML** format; you paste
  the link into **GCP Vertex/Vision AutoML** and train there. Pricing/credits =
  GCP's, not documented on the page.
- **Steps:** create dataset version → export "Google Cloud AutoML" → copy link →
  GCP new dataset (e.g. Object Detection) → paste into Cloud Storage destination →
  train in GCP.
- **How it maps to vision-core:** A *cloud-managed* alternative to the
  self-hosted Kubeflow training path — useful as a fallback/bootstrap before the
  in-cluster Katib/Training-Operator pipeline matures, but **Enterprise cost +
  GCP lock-in**. The self-hosted RF-DETR-on-Kubeflow path (1.6) is preferred for
  BUSL/cost reasons; document GCP AutoML only as an escape hatch.

### 1.9 Roboflow Universe datasets (two URLs — pages 403 to bots)
- **`thesis-y6y0i/plant-disease-detection-k6wnw`:** public **Object Detection**
  project, ~**2792** healthy+diseased images, pretrained model + hosted API,
  created May 2023. Exportable COCO/YOLO. (Page hard-blocks scrapers; metadata
  via search.)
- **`plant-disease-detection-rsmgf/plant-disease-detection-v2-2nclk` (model/1):**
  public plant-disease **detection** project + Roboflow-Train model card (mAP/
  precision/recall on its page). Exportable COCO/YOLO. (Also 403 to bots.)
- **Licensing:** Roboflow Universe projects are typically **CC BY 4.0** or
  Public-Domain — **must be confirmed per project before commercial (BUSL) use.**
- **How it maps to vision-core:** Additional per-crop training corpora pullable
  via `download_dataset(<url>, "coco")` straight into the RF-DETR trainer (1.6),
  landing in MinIO via `ObjectStoragePort`. Class names → `Mask.class_name` →
  Vertivo `diseaseName`. Detection-only (box) → same mask-upgrade caveat as
  GRAPE_YOLO.

### 1.10 SkalskiP (Piotr Skalski, Roboflow OSS Lead)
- Maintains **supervision** (40k★, the SAHI/`InferenceSlicer`, annotators,
  metrics lib already implied by vision-core), **roboflow/notebooks** (the RF-DETR
  fine-tune notebooks in 1.6), **rf-detr**, **make-sense** (free annotation tool),
  **vlms-zero-to-hero**.
- **How it maps to vision-core:** These are the upstreams vision-core already
  leans on (RF-DETR adapter, supervision). **make-sense** is a candidate
  annotation UI for the HITL `ActiveLearningPort` agronomist-correction loop;
  **vlms-zero-to-hero** informs the `VlmDiagnosisPort` prompt design.

### 1.11 YouTube `-OvpdLAElFA`
- Title: *"RF-DETR: How to Train SOTA for Object Detection on a Custom Dataset |
  Step-by-step guide"* (Roboflow/Skalski). Channel/description otherwise not
  scrapeable. Same workflow as 1.6 in video form — **no new facts**; noted for
  completeness.

---

## 2. Recommended new capabilities for vision-core

1. **SAHI / small-object slicing** as a composable wrapper over any
   `SegmentationModelPort` — the single highest-value addition for early-stage
   lesions, aphids, mites, spider-mite stippling in cluttered canopy. (1.5)
2. **In-cluster RF-DETR(-Seg) fine-tuning** (Nano/Small for edge, Medium+ for
   cloud) driven from MinIO/Roboflow-Universe COCO datasets, exporting
   ONNX→TensorRT and auto-registering — the Apache-2.0, BUSL-clean training path.
   (1.1, 1.6, 1.9)
3. **IPPC/SFE pest & disease taxonomy** as a shared domain value-object
   (`PestTaxon`: scientific name, group, quarantine status, host crops) + a
   `pest_group` / `quarantine_status` vocabulary. (1.4)
4. **Organ-level anatomical taxonomy** (`AnatomicalPart`) grounded in the tomato
   FSPM — leaf/leaflet/petiole/internode/stem/truss/fruit/apex — so affected-area
   % is per-organ, not per-plant. (1.3)
5. **Roboflow Inference server** as an alternative edge/Jetson runtime adapter
   (HTTP `:9001`, TensorRT EP) behind `DetectionRuntimePort`, complementing the
   self-managed `LocalTensorRTAdapter`. (1.7)
6. **Jetson + NVIDIA Container Toolkit deploy recipe** (`--runtime nvidia`,
   `nvidia-ctk … --runtime=containerd` for the K8s edge nodes) for
   `deployment/jetson/`. (1.7)
7. **GCP Vertex/Vision AutoML** as a *documented fallback* training escape-hatch
   (Enterprise/cost-gated). (1.8)
8. **(stretch) Store-and-forward capture buffering** on the constrained
   greenhouse link, inspired by the blockchain-adapter messaging-middleware
   pattern. (1.2)

---

## 3. Concrete architecture hooks (repo-convention names)

### New ports (`application/ports/`)
- **`ModelTrainingPort`** — `train(dataset_ref, base_model, hparams) ->
  TrainedModelRef`. Drives the Kubeflow Training-Operator stage. Adapter:
  `RFDETRTrainerAdapter` (secondary), optional `GcpAutoMLTrainerAdapter`.
- **`DatasetCatalogPort`** — `pull(source_uri, format="coco") -> DatasetRef`,
  resolving MinIO and Roboflow-Universe URLs. Adapter:
  `RoboflowUniverseDatasetAdapter`, `MinioDatasetAdapter` (may reuse
  `ObjectStoragePort`).
- *(Optional)* **`MetricsVisibilityPort`** — runtime metrics export (the
  blockchain-paper "Status Visibility" analogy); likely satisfied by existing
  OTEL deps instead of a new port — leave as open question.

### New / changed secondary adapters (`adapters/secondary/`)
- **`SlicingSegmentationModel(SegmentationModelPort)`** — DECORATOR wrapping an
  inner `SegmentationModelPort`; applies `sv.InferenceSlicer`, remaps masks to
  full-image coords, returns merged `Segmentation`. (Domain stays pure; this
  adapter owns the supervision import.)
- **`RoboflowInferenceAdapter(DetectionRuntimePort)`** — HTTP client to the
  `roboflow-inference-server-jetson` sidecar (`:9001`, TensorRT EP).
- **`RFDETRTrainerAdapter(ModelTrainingPort)`**, **`RoboflowUniverseDatasetAdapter
  (DatasetCatalogPort)`**.

### New domain value-objects (`domain/`, pure)
- **`AnatomicalPart`** (enum: LEAF, LEAFLET, PETIOLE, INTERNODE, STEM, TRUSS,
  FRUIT, APEX, WHOLE_PLANT) — replaces the free-string `anatomical_part`.
- **`PestTaxon`** (frozen dataclass: `scientific_name`, `group: PestGroup`,
  `quarantine_status: QuarantineStatus`, `host_crops: tuple[str,...]`).
- **`PestGroup`** (INSECTA, ACARI, FUNGI, BACTERIA, VIRUS, VIROID, NEMATODA,
  MOLLUSCA, WEED) · **`QuarantineStatus`** (QUARANTINE_ABSENT,
  QUARANTINE_PRESENT_CONTROLLED, REGULATED_NON_QUARANTINE, UNREGULATED).
- **`SliceConfig`** (slice_wh, overlap, overlap_filter, iou_threshold) — config
  VO consumed by the slicing decorator.

### New domain events (follow existing event naming)
- `ModelTrainingStarted` / `ModelTrainingCompleted` / `ModelTrainingFailed`
  (carry `dataset_ref`, `model_version`, metrics).
- `DatasetPulled` (source_uri → minio_ref).
- `SlicingApplied` (n_tiles, n_merged_masks) — observability of SAHI runs.
- (Existing `CorrectionSubmitted` / retrain-trigger already covers the HITL edge.)

### `proto/vision/v1/vision.proto` changes
- **Add `enum PestGroup` and `enum QuarantineStatus`**; add optional
  `PestGroup pest_group` + `QuarantineStatus quarantine_status` +
  `repeated string host_crops` to **`Mask`** and/or a new **`PestTaxonomy`**
  message referenced by `Mask`.
- **Promote `anatomical_part`** on `Mask` and `Diagnosis.anatomical_parts` from
  free `string` to a new **`enum AnatomicalPart`** (keep string alias for
  Vertivo back-compat — additive, do not renumber existing fields).
- **Add slicing controls** to `SegmentImageRequest`: `bool enable_slicing`,
  `uint32 slice_w`, `uint32 slice_h`, `float slice_overlap` (new field numbers).
- **New `TrainingService`** (or extend an MLOps service): `StartTraining`,
  `GetTrainingStatus`, `ListDatasets` — backing the `ModelTrainingPort` /
  `DatasetCatalogPort`. Keep additive; never renumber existing fields.
- Extend `ModelDescriptor.license` enum-ish string to explicitly enumerate
  `"Apache-2.0" | "AGPL-3.0" | "Enterprise" | "CC-BY-4.0"` (dataset provenance).

### `pyproject.toml` dependency changes
- Add to the **`rfdetr`** extra (or a new **`training`** extra):
  `rfdetr>=1.4.0`, `supervision>=0.25`, `roboflow>=1.1` (dataset pull).
  *(supervision is currently implied but not pinned — pin it; it owns
  `InferenceSlicer`.)*
- New **`training`** extra: `roboflow`, `supervision`, plus existing
  `kfp` from the `cloud` extra.
- **Jetson edge** stays as today (tensorrt/pycuda from JetPack, not PyPI); add a
  doc note for the optional `inference-cli` / `roboflow-inference-server` sidecar
  (Docker, not a Python dep).
- Add `supervision.*` to the mypy `ignore_missing_imports` override block
  (mirrors the existing `rfdetr.*` / `ultralytics.*` entries).

---

## 4. Risks / licensing

- **YOLO AGPL-3.0 vs RF-DETR Apache-2.0:** GRAPE_YOLO + Ultralytics adapter pull
  AGPL into any **commercial edge ship** (owner-gated per AGENTS.md). RF-DETR
  (incl. Seg, Nano→2XLarge) is **Apache-2.0** → the clean edge/cloud default.
  Recommendation reaffirmed: ship **RF-DETR** on commercial edge; keep YOLO
  behind the port for internal/benchmark use only.
- **Dataset licensing:** GRAPE_YOLO originates from a Kaggle dataset — confirm its
  license before commercial training. Roboflow Universe projects are typically
  **CC BY 4.0 / Public Domain** but **must be verified per project**; CC-BY
  requires attribution, which can complicate a BUSL-1.1 shipped model. Track
  dataset provenance in `ModelDescriptor`.
- **Roboflow paid surfaces:** Roboflow **Train-from-GCP is Enterprise-only**;
  hosted Inference API / `deploy_to_roboflow` / hosted models can incur per-call
  cost and external dependency. Self-hosted (Kubeflow + `LocalTensorRTAdapter` /
  self-run inference server) keeps BUSL control and avoids per-inference fees.
- **Jetson viability:** README already flags **Orin Nano scarcity**; Roboflow's
  own recommendation is **Orin NX 16 GB+**, i.e. the cheap Orin Nano may be
  under-spec for RF-DETR-Seg + SAHI. SAHI multiplies inference cost N× → **not
  for Tier-2 real-time**; gate it to still-photo/batch. First-load TensorRT
  compilation adds cold-start latency on device.
- **Source-mismatch risk:** `2603.26306v1.pdf` is a **blockchain** paper, not
  vision — if a specific vision result was expected from it, the citation is
  wrong. `haoshi` PDF is a **business accelerator** sales kit, **not** edge-AI
  silicon — there is **no hardware accelerator option** to evaluate from it.
- **BUSL-1.1 propagation:** any vendored training/inference code must respect both
  vision-core's BUSL and the upstream Apache/AGPL terms; keep adapters as thin
  wrappers over pip deps (don't vendor).

---

## 5. Open questions for design

1. **Wrong PDF?** Was `2603.26306v1` (food-traceability blockchain) meant to be a
   vision paper, or is the blockchain/traceability angle a real future input
   (e.g. provenance of disease detections on-chain)? Confirm intent.
2. **No hardware tier from haoshi:** the accelerator sales kit is a startup
   *program*, not silicon. Is there a separate edge-accelerator (Hailo / RK3588 /
   Jetson-alt) the team actually wants evaluated as a Tier-2 option?
3. **Detection→segmentation gap:** GRAPE_YOLO and the Universe datasets are
   **box-only**, but vision-core's value prop is masks (affected-area %). Do we
   (a) SAM-assisted relabel to masks via the HITL loop, (b) run RF-DETR-Seg's
   COCO-pretrained mask head and only fine-tune boxes, or (c) accept detection-
   only for these crops initially?
4. **Where does SAHI live** — domain decorator, application-layer policy, or
   adapter-only? (Proposed: secondary-adapter decorator to keep domain pure.)
   And what's the env-driven default (off at edge, on for batch photos)?
5. **Taxonomy ownership:** does `PestTaxon`/`AnatomicalPart` belong in vision-core
   (shared, generic) or stay in Vertivo (business)? AGENTS.md says vision-core
   has *no product business logic* — is a controlled vocabulary "business"? Lean:
   ship the *enums/VOs* (generic) here, keep regulatory/alerting in Vertivo.
6. **Training port surface:** expose training over gRPC (`TrainingService`) or
   keep it Kubeflow-pipeline-only (no proto change)? Adds attack surface vs
   programmability for Vertivo-triggered retrains.
7. **Roboflow coupling:** how much to depend on Roboflow's hosted stack
   (`deploy_to_roboflow`, hosted inference) vs fully self-hosted given BUSL + cost?
8. **Dataset-license gating:** add a CI/registry check that blocks promoting a
   model whose training datasets aren't license-cleared for commercial ship?
9. **Stem-thickness / phenotyping trait extraction** (from the FSPM paper) — in
   scope for vision-core (a `TASK_PHENOTYPE`?) or out of scope?

---

### Source index
- Local: `GRAPE_YOLO.zip`, `2603.26306v1.pdf`, `diaf022.pdf`,
  `LISTA_PLAGAS_REGLAMENTADAS_2019.pdf` (Costa Rica SFE), haoshi accelerator kit.
- Web/docs: supervision InferenceSlicer/SAHI; roboflow/notebooks RF-DETR
  detection+segmentation fine-tune; roboflow/inference Jetson install; NVIDIA
  Container Toolkit install guide; Roboflow Train-from-GCP; Roboflow Universe
  `plant-disease-detection-k6wnw` & `…-v2-2nclk`; OUP *in silico Plants* diaf022;
  SkalskiP GitHub; YouTube `-OvpdLAElFA`.
- Context7: `/roboflow/rf-detr`, `/roboflow/supervision`, `/roboflow/inference`.
