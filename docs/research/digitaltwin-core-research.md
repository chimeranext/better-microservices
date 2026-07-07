# digitaltwin-core — Research & Design Material

> **Status:** research only (no service code yet). Material for a NEW microservice
> `digitaltwin-core` (digital twin of a crop / greenhouse) to be added to the
> `better-microservices` monorepo, following the same Explicit Architecture
> (Hexagonal + DDD) + OpenSpec governance as `vision-core` and `geospatial-core`.
> **Author context:** andres@dojocoding.io · drafted 2026-06-03.

This service is the **third AgTech sibling**: where `vision-core` does close-range
phytopathology vision and `geospatial-core` does satellite land-use, `digitaltwin-core`
is the **temporal/simulation brain** — it keeps a living virtual model of the crop in
sync with reality (data assimilation) and predicts/controls forward.

---

## 0. How this maps to repo conventions (read first)

Confirmed from `README.md` (root), `openspec/project.md`, `services/vision-core/AGENTS.md`,
`services/vision-core/README.md`, `services/vision-core/proto/vision/v1/vision.proto`,
`services/geospatial-core/README.md`, `services/geospatial-core/pyproject.toml`:

- **Architecture:** Explicit Architecture (Hexagonal + DDD, + CQRS in geospatial).
  Domain is pure Python, zero external imports, no async. Application = port ABCs +
  command/query handlers. Adapters: primary (gRPC + REST/FastAPI), secondary
  (frameworks/IO). "All arrows point inward. Never import concrete adapters in domain
  or application code — only port ABCs."
- **Layout per service:** `proto/<svc>/v1/<svc>.proto`, `src/<svc_core>/{domain,application/{ports,commands,queries},adapters/primary/{grpc,rest},adapters/secondary}/`,
  `config.py` + `runtime.py`, `tests/{unit,integration,e2e}/`, `deployment/`, `examples/`.
- **Stack:** Python ≥3.12, `pyproject.toml` (hatchling), `pydantic` + `pydantic-settings`,
  `grpcio` + `grpcio-tools`, `structlog`; **native/heavy deps go in optional-dependency
  extras** so domain/ports import without them (geospatial pattern: base install omits
  GDAL/H3; adapters import lazily). `dev` extra = pytest + pytest-asyncio + pytest-cov +
  ruff + mypy. Plus a thin `package.json` so Turbo orchestrates the Python service.
- **Config:** env vars with a **service-specific prefix** (`VISION_`, geospatial uses its
  own). digitaltwin-core → **`TWIN_`**.
- **License:** BUSL-1.1 (both siblings). © ChimeraNext Shared Services LLC.
- **Governance:** every contract/data-model/tech decision = an OpenSpec change under
  `openspec/changes/YYYY-MM-DD-slug/` with `proposal.md` (PDR) + `design.md` (ADR) +
  `tasks.md`. A PreToolUse hook FORBIDS dated decision records anywhere but
  `openspec/changes/`. Domain label would be `service:digitaltwin-core`.
- **Boundary rule (critical):** siblings contain **NO consumer-specific business logic**.
  vision-core returns generic segmentation; the consumer (`vertivo_server`, Serverpod/Dart)
  maps to its own domain. digitaltwin-core must follow the same rule: return generic twin
  state / predictions / setpoints; the consumer owns the crop-specific agronomy mapping.
- **Consumer chain already in place (reuse it):** `raspberry`/OpenMV capture → MQTT (EMQX,
  topic `vertivo/{user_id}/greenhouse/{greenhouse_id}/...`) → `vertivo_server` (Serverpod
  ingest) → service gRPC. digitaltwin-core plugs into the **same MQTT/Serverpod spine**.

---

## 1. Per-source findings

### 1.1 Smoleňová et al. 2025 — *Development of a tomato FSPM for digital twin applications* (in silico Plants 7(2) diaf022) — **conceptual core**
`vertivolatam/diaf022.pdf` → `/tmp/diaf022.md`

- **A digital twin = 3 parts** (Wright & Davidson 2020): (a) *a model of the object*,
  (b) *an evolving set of data relating to the object*, (c) *a means of dynamically
  updating/adjusting the model in accordance with the data*. → This trio is literally the
  bounded context: **CropModel + SensorReading stream + AssimilationCycle**.
- **At the core is a Functional-Structural Plant Model (FSPM):** simulates *function*
  (photosynthesis, biomass production & partitioning by organ **sink strength**) **and**
  *structure* (3D organ-level architecture) over time. Uses **L-systems / relational growth
  grammars**, plant = chain of **phytomers** (internode+leaf/truss). FSPM captures cultivar
  variation and structure↔function feedback that per-area process-based crop models cannot.
- **Environmental driver stack (the "physics"):** a **greenhouse climate model (KASPRO)**
  computes indoor climate (temp, CO₂, light) from *outdoor weather + greenhouse properties +
  control settings*; a **3D Monte-Carlo light model** traces radiation through the canopy;
  photosynthesis via **Farquhar-von Caemmerer-Berry (FvCB)**. Development is driven by
  **thermal time / degree-days** (phyllochron). → These are the **SimulationModelPort** and
  a **ClimateModelPort**.
- **Synchronization (their data-assimilation flavor) = calibration, not state-overwrite.**
  They adjust *input parameters* (phyllochron, max internode length, logistic curve params)
  via **Bayesian optimization (Gaussian Process)**, bounded by cultivar priors, so the
  virtual plant height tracks image-derived real heights. MAE dropped <3 cm. → motivates a
  **DataAssimilationPort** with *both* parameter-calibration and state-update strategies.
- **The update pipeline is a real 3-step workflow** worth mirroring: (1) image processing
  (segmentation → plant height from 2D camera, HSV threshold + connected components +
  RANSAC stick removal), (2) statistical modeling (P-splines per plant + 2D spatial
  P-splines + linear mixed models → genotype BLUPs, correcting greenhouse microclimate
  gradients), (3) parameter optimization. → **vision-core is the natural supplier of step
  (1)**; digitaltwin-core owns (2)+(3).
- **Maps to a twin:** the paper explicitly frames its contribution as *"the flow of
  information from the real crop to the virtual crop"* — i.e. the **assimilation half**.
  The other half (virtual→real, predictions/setpoints) is our `ControlSetpoint` / prediction
  query. Traits a twin must expose: new-leaf count, **stem/"plant head" thickness**, leaf
  area, leaf dry weight, biomass, predicted yield, resource use (N, water, CO₂, energy).

### 1.2 Petropoulou et al. 2023 — *Lettuce Production in Intelligent Greenhouses* (Sensors 23(6) 2929) — **autonomous greenhouse + DT definition**
`vertivolatam/sensors-23-02929-v2.pdf` → `/tmp/sensors.md`

- **3rd Autonomous Greenhouse Challenge:** 6 high-tech compartments, **lettuce**, goal =
  highest **net profit** under *fully autonomous* control by remote algorithms — decisions
  driven by **time-series sensor data of greenhouse climate + crop images**. Confirms the
  twin's KPI is **economic** (net profit = yield/quality − resource cost), not just biomass.
- **Greenhouse digital twins = "coupled dynamic climate AND crop models"** representing the
  physical+biological+technical system as a virtual reality, usable to **simulate effects of
  different growing conditions & management strategies** on performance indicators and to
  support decision-making. → endorses the **two coupled models** (ClimateModelPort +
  SimulationModelPort) inside one twin.
- **Decision levers controlled:** plant **spacing/density** and **harvest timing** were
  decisive (alongside heating energy, artificial-light electricity, CO₂). → these are
  discrete `ControlSetpoint`/decision events, distinct from continuous climate setpoints.
- **Computer vision as non-invasive sensing:** RealSense **depth cameras** + DeepLabv3+
  (detectron2) → plant height (R²=0.976) & coverage (mIoU=98.2) → a **light-loss indicator**
  (spacing trigger) and **harvest indicator** (fresh-weight MAE 22 g). → vision-derived
  traits are first-class `SensorReading`s into the twin; reinforces vision-core handoff.
- **Maps to a twin:** this is the **control/decision-support output** end. digitaltwin-core
  ingests climate + vision time-series, runs the coupled model, and emits spacing/harvest/
  climate recommendations — exactly the loop this paper automates by hand-built algorithms.

### 1.3 Calvo Vargas et al. 2025 — *IoT en Captura y Análisis de Sonido en Agroindustria* (Revista Agro 3(1)) — **acoustic IoT sensing modality**
`vertivolatam/IoT+...Sonido...pdf` → `/tmp/iot_sonido.md`

- **Systematic literature review** of IoT acoustic monitoring in agroindustry. Dominant
  applications: **pest detection** and **crop-state monitoring via sound**; identified gap =
  little use of AI/ML to *interpret* acoustic data, and underexplored apiculture/ecology.
- **Sensor taxonomy (directly useful for our SensorReading value object):** microphones
  (electret directional, piezoelectric, electret sensors, generic sound sensors — **8 mic
  types**); **environmental sensors most represented (14 types):** temperature, humidity,
  light, **CO₂**, ammonia (**MQ-135**); plus accelerometers, RFID, GPS.
- **Hardware/transport stack matches the existing Vertivo edge spine:** **Arduino Uno**,
  **Raspberry Pi** (Linux), **LoRa** modules, and **MQTT** as the messaging protocol →
  confirms `SensorIngestPort` should speak MQTT and accept heterogeneous multi-modal series.
- **Acoustic feature engineering:** **MFCC (Mel-Frequency Cepstral Coefficients)** is the
  standard front-end + ML classifiers. → an **acoustic stream is just another typed
  `SensorReading` channel** (audio/feature vectors) the twin can assimilate, e.g. for an
  early **pest-pressure** state variable feeding the simulation/alerting.
- **Maps to a twin:** acoustic IoT broadens `SensorIngestPort` beyond climate+vision to a
  **multi-modal sensor fabric** (climate, depth-vision, audio). Pest pressure derived from
  sound is a candidate exogenous forcing/disturbance on the crop model (couples conceptually
  back to vision-core's pest detection).

### 1.4 WUR — *Data Assimilation in the Digital Future Farm* (research project) — **the architectural pattern**
https://research.wur.nl/en/projects/data-assimilation-in-the-digital-future-farm-... (fetched OK)

- **Data assimilation (DA) defined:** crop/farm models *"are not perfect and deviate from
  the actual situation"*; DA corrects them by combining **uncertain observations with
  uncertain model outputs into a weighted (optimal) estimate**. This is the canonical
  "means of dynamically updating the model" from §1.1.
- **Primary method: Ensemble Kalman Filter (EnKF)** — represents model uncertainty as an
  **ensemble of model runs** rather than a single prediction (proven in operational weather
  forecasting). → directly shapes `DataAssimilationPort` adapters (EnKF/ensemble; plus
  Bayesian-calibration from §1.1; plus particle filter, see §1.6).
- **Operates across multiple models** (grass/crop production, water & nutrient management,
  livestock) inside the **Digital Future Farm** framework — i.e. DA is a *cross-model
  service*, supporting our choice to make assimilation its own port/aggregate, not baked
  into one model.
- **Integrates satellite observations from AgroDataCube** for operational real-time DA, and
  validated with **WOFOST + GRAS2007** that EnKF **reduces error on predicted outputs**.
- **Maps to a twin:** this is the **reference architecture** for `digitaltwin-core`'s update
  loop — `AssimilationCycle` = (forecast step: run ensemble of CropModel) → (observe:
  SensorReadings) → (analysis: EnKF weighting) → (updated TwinState). It also justifies the
  **AgroDataCubePort** secondary adapter and the geospatial-core boundary.

### 1.5 WUR — *AgroDataCube* (agro-geospatial API) — **external data adapter candidate**
https://agrodatacube.wur.nl/ (fetched OK)

- **What it is:** large collection of open + derived data for agri-food apps (NL-centric,
  WUR-maintained), exposed as a **REST API** (token auth; GET/POST, POST for complex geom).
- **Data:** agricultural **parcels & crops** (by location/year/crop-type), **soil** codes,
  **weather** (temperature, precipitation, windspeed), **satellite indices incl. NDVI**
  (recomputed across satellites), **elevation/rasters** (GeoTIFF). Output **GeoJSON**,
  default CRS **EPSG:28992** (Dutch RD), client-selectable (e.g. EPSG:4326). Query by **WKT
  polygon** AOI + params + pagination.
- **Maps to a twin / boundary note:** AgroDataCube supplies **weather forcing + soil context
  + NDVI history** = exogenous inputs the crop model needs. **BUT** it overlaps heavily with
  `geospatial-core`'s remit (Sentinel-2/HLS, NDVI, H3, parcels). **Decision: the twin should
  NOT re-implement satellite/parcel ingestion.** Prefer consuming `geospatial-core` for
  imagery-derived layers; treat `AgroDataCubePort` as an *optional weather/soil-forcing*
  adapter only (NL/where available), not the primary geospatial path. (We're CRTM05/Costa
  Rica-centric per geospatial-core; AgroDataCube is NL-bound — so it's a pattern reference +
  weather fallback, not a core dependency.)

### 1.6 WUR — *Winner 4th Autonomous Greenhouse Challenge* (news) — **supporting context**
https://www.wur.nl/en/news/winner-4th-autonomous-greenhouse-challenge-announced (fetched OK)

- Algorithms took **full control** of the greenhouse: **lighting, heating, CO₂, water
  supply, plant density, harvest timing** — over a full growing cycle (dwarf tomatoes;
  winning team IDEAS / Zhejiang, mixed tech + horticulture expertise).
- Confirms the **control surface** (the setpoints a twin's `ControlPort` would emit) and that
  teams blend ML + horticultural domain knowledge. Low simulation/DT detail in the news item
  itself (it's an outcome announcement).
- **Maps to a twin:** consolidates the canonical **ControlSetpoint vocabulary**
  (temperature, CO₂, light intensity/duration, irrigation/water, density/spacing,
  harvest-timing).

### 1.7 edepot.wur.nl/238571 — **FAILED to extract**
- WebFetch #1 = **HTTP 403**; retry = the PDF is an **image-only / Adobe-Illustrator
  scanned** document (no text layer), so markdown extraction yielded only binary metadata
  (Canon EOS camera, print workflow) — **no usable technical text**.
- **Mitigation:** a targeted web search around the likely topic (WUR + data assimilation +
  WOFOST + remote sensing) surfaced the relevant body of work below; treat 238571 as an
  **open follow-up** (re-acquire a text PDF or the citation).
- **Adjacent literature confirmed (for DA method palette):** assimilating remotely-sensed
  **LAI / GPP / soil moisture** (Sentinel-1/2, UAV) into **WOFOST** via **EnKF**,
  **recalibration/re-initialization**, and **particle filters** improves yield/biomass/soil
  -moisture estimates. → strengthens `DataAssimilationPort` adapter set (EnKF, particle
  filter, recalibration) and the **CropModelPort → WOFOST-like** option alongside FSPM.
  Sources: ScienceDirect S1161030122001046; MDPI Agronomy 14(9):1920; research.wur.nl
  "potential-performances-of-remotely-sensed-lai-assimilation-in-wofost".

---

## 2. Bounded context: `digitaltwin-core`

### 2.1 What it IS
A **temporal simulation + data-assimilation engine** that maintains a **living virtual
representation (twin) of a crop/greenhouse over its lifecycle**: it (a) holds one or more
**crop/plant simulation models** (FSPM and/or process-based WOFOST-like) coupled with a
**greenhouse climate model**, (b) **ingests multi-modal sensor time-series** (climate,
vision-derived traits, acoustic) plus exogenous forcing (weather, soil), (c) runs
**assimilation cycles** that fuse observations with model forecasts (EnKF / ensemble /
particle filter / Bayesian recalibration) to keep the twin synchronized, and (d) **predicts
forward** (biomass, yield, resource use, growth traits) and **proposes/forecasts control
setpoints & decision events** (climate setpoints, irrigation, spacing/density, harvest
timing). It returns **generic twin state + predictions + setpoint recommendations**; the
consumer maps them to its own agronomy.

### 2.2 What it is NOT (frontiers)
- **NOT vision/perception.** It does **not** run segmentation/VLM/pest-detection on images.
  It **consumes** vision-core's outputs (plant height, coverage, affected-area %, pest/disease
  detections) as `SensorReading`s. Frontier: *pixels & masks live in vision-core; time-series
  state & simulation live here.*
- **NOT satellite/remote-sensing/land-use.** It does **not** ingest Sentinel-2/HLS rasters,
  do H3 indexing, or derive land cover. It **consumes** geospatial-core for AOI/imagery-derived
  layers (NDVI, parcel/terrain context) as exogenous forcing. AgroDataCube is at most an
  optional weather/soil fallback, deliberately scoped tiny to avoid duplicating geospatial-core.
- **NOT the actuator/PLC.** It **recommends/forecasts** setpoints; it does **not** directly
  drive greenhouse hardware. Actuation stays with the consumer's orchestrator
  (`vertivo_server` + the Raspberry/custom orchestrator over MQTT). `ControlPort` is an
  *outbound recommendation/publish* boundary, optionally write-back, never the control loop's
  safety authority.
- **NOT the consumer's business logic.** No Vertivo-specific disease taxonomy, alerts,
  treatment plans, pricing, or persistence of consumer rows — same rule vision/geospatial obey.
- **NOT the raw IoT broker.** EMQX/MQTT infra is the platform/edge spine; the twin only
  *subscribes/ingests* through `SensorIngestPort`.

### 2.3 Boundary summary

| Concern | Owner |
|---|---|
| Image/video → masks, disease, pest, plant height-from-image | **vision-core** |
| Satellite/aerial → land-use, NDVI, H3 cells, parcels/terrain | **geospatial-core** |
| Time-series state, crop simulation, assimilation, predictions, setpoint recommendations | **digitaltwin-core** |
| Disease taxonomy, alerts, treatment, actuation, persistence, $ | **consumer (`vertivo_server`)** |
| MQTT/EMQX broker, edge capture, OTel, gRPC Health | **platform / edge** |

### 2.4 Domain model (pure, no external imports)

**Aggregates / Entities**
- **`Twin`** (aggregate root) — identity of a specific physical unit
  (`greenhouse_id` / `plant_id` / `crop_cycle_id`); owns its current `TwinState`, its bound
  `CropModel`, and the history of `AssimilationCycle`s. Lifecycle: *provisioned → growing →
  harvested → archived*.
- **`TwinState`** — the time-stamped state vector at instant *t*: growth/architecture traits
  (leaf count, **stem/plant-head thickness**, leaf area, biomass, height), physiological
  state (developmental stage / thermal-time accumulated), resource accounting (N, water, CO₂,
  energy), uncertainty (per-variable variance / ensemble spread), `provenance` (which
  assimilation cycle produced it).
- **`CropModel`** — descriptor + parameter set of the simulation model bound to a twin
  (`ModelKind`: FSPM | PROCESS_BASED(WOFOST-like) | AGENT_BASED; cultivar params, calibration
  bounds, version). Distinct from the *runtime* that executes it (a port/adapter).
- **`AssimilationCycle`** — one forecast→observe→analysis round: inputs
  (prior `TwinState`, the `SensorReading`s used, the method), outputs (posterior `TwinState`,
  innovation/residuals, updated parameters), `assimilated_at`, `method`.
- **`SensorReading`** — a single typed observation: `channel` (TEMP, RH, CO₂, PAR/light,
  EC, pH, soil-moisture, **PLANT_HEIGHT**, **COVERAGE**, AFFECTED_AREA_PCT, PEST_PRESSURE,
  **ACOUSTIC_MFCC**, …), `value`/`vector`, `unit`, `observed_at`, `source`
  (climate-sensor | vision-core | acoustic | geospatial | agrodatacube), `quality`/confidence.
- **`ControlSetpoint`** — a recommended/forecast control action: `kind`
  (TEMP_SETPOINT, CO2_SETPOINT, LIGHT_INTENSITY, LIGHT_DURATION, IRRIGATION,
  PLANT_DENSITY/SPACING, HARVEST_TIMING), target value, valid-from/to, `rationale`,
  expected-effect (predicted Δyield / Δresource), `confidence`.
- **`Prediction`** — forward simulation result: target variable (yield, biomass, harvest
  date, resource use), horizon, trajectory + uncertainty band, `scenario` ref.

**Value Objects**
- `TimeSeriesPoint` (instant + value + unit); `Trait` (name+value+unit); `ThermalTime`
  (degree-days, base temp); `ResourceLedger` (N/water/CO₂/energy); `Uncertainty`
  (mean+variance / ensemble); `ClimateConditions` (T/RH/CO₂/PAR at a time); `Cultivar`
  (id + parameter priors + bounds); `Scenario` (a what-if forcing/management plan);
  `Innovation` (observation−forecast residual); `GreenhouseProperties` (transmissivity,
  geometry — climate-model inputs).

**Domain Events**
- `TwinProvisioned`, `SensorReadingIngested`, `AssimilationCycleCompleted`
  (carries innovation/uncertainty reduction), `TwinStateUpdated`, `ModelDriftDetected`
  (forecast−observation divergence past threshold), `ModelRecalibrated`,
  `SetpointRecommended`, `PredictionIssued`, `HarvestRecommended`, `CropCycleClosed`.

**Pure domain services**
- `ThermalTimeAccumulator` (degree-day integration), `AssimilationAnalysis`
  (pure math: combine prior + observation given gains — adapter supplies the heavy ensemble
  runs), `DriftDetector` (innovation vs threshold), `ResourceEfficiencyScorer`
  (yield per unit input), `SetpointProposer` (state+prediction → candidate setpoints,
  policy-pure). (Mirrors vision-core's pure `AreaQuantifier`/`SeverityScorer`.)

---

## 3. Ports & adapters (proposed)

> Convention: ports are ABCs in `application/ports/`; **domain/application import only the
> ABCs**. Heavy deps (simulation, timeseries, filters, MQTT) live in optional extras and are
> imported lazily by secondary adapters — exactly geospatial-core's base-vs-extras split.

### Secondary (outbound) ports

| Port (ABC) | Role | Adapter(s) | Extra |
|---|---|---|---|
| **`SimulationModelPort`** | *what the crop model computes*: `(CropModel, ClimateConditions, horizon) → state trajectory`. Runs forward sim (incl. ensemble member runs for DA). | `FspmAdapter` (L-system/relational-growth-grammar tomato FSPM, §1.1), `WofostAdapter` (process-based, `pcse`/WOFOST, §1.4/1.7), `AgentBasedAdapter` (optional, §1.1 Kalanchoe/wheat) | `sim` |
| **`ClimateModelPort`** | indoor climate from outdoor weather + greenhouse props + control settings (KASPRO-style, §1.1). | `GreenhouseClimateAdapter`, `PassthroughClimateAdapter` (when sensors already give indoor climate) | `sim` |
| **`DataAssimilationPort`** | fuse observations + model forecast → posterior state/params. | `EnsembleKalmanAdapter` (EnKF, §1.4), `ParticleFilterAdapter` (§1.7), `BayesianCalibrationAdapter` (GP/Bayesian-opt parameter calibration, §1.1) | `assimilation` |
| **`SensorIngestPort`** | subscribe/pull multi-modal sensor time-series. | `MqttSensorIngestAdapter` (EMQX, the existing `vertivo/{user}/greenhouse/{gh}/...` spine, §1.3), `TimeseriesQueryAdapter` (read history) | `ingest` |
| **`TimeSeriesStorePort`** | persist/query sensor + state series. | `TimescaleDbAdapter` (TimescaleDB/Postgres) or `InfluxDbAdapter` | `tsdb` |
| **`VisionTraitsPort`** | pull crop traits from vision-core gRPC (height/coverage/affected-area/pest) as `SensorReading`s. | `VisionCoreGrpcAdapter` (consumes `vision.v1`) | `clients` |
| **`GeoContextPort`** | pull AOI/imagery-derived forcing (NDVI, terrain, parcel) from geospatial-core. | `GeospatialCoreGrpcAdapter` | `clients` |
| **`AgroDataCubePort`** | *optional* weather/soil forcing (REST, WKT AOI, GeoJSON, §1.5). Scoped small to avoid geospatial overlap. | `AgroDataCubeRestAdapter` | `clients` |
| **`ControlPort`** | publish/recommend setpoints back to the orchestrator (outbound only; not the safety loop). | `MqttSetpointPublishAdapter`, `NoopControlAdapter` (advisory mode) | `ingest` |
| **`ModelRegistryPort`** | resolve/version crop models & cultivar params per crop. | `LocalFsModelRegistryAdapter` (mirrors vision-core) | — |

### Primary (inbound) adapters
- **gRPC** (`adapters/primary/grpc/`) — serves `digitaltwin.v1` (§4). Platform gRPC Health v1.
- **REST/FastAPI** (`adapters/primary/rest/`) — thin mirror (e.g. `POST /v1/twins/{id}/assimilate`,
  `GET /v1/twins/{id}/state`, `POST /v1/twins/{id}/predict`) for non-gRPC consumers (same
  pattern as vision-core's REST mirror).

### Suggested tech stack
- **Simulation:** **`pcse`** (Python Crop Simulation Environment / WOFOST) for the
  process-based path; a custom/L-system **FSPM** engine for the architectural path (the
  diaf022 model is research code — likely a port/wrapper). Keep both behind
  `SimulationModelPort`, chosen at deploy time (vision-core's "two model families, one port"
  pattern).
- **Data assimilation:** **`filterpy`** / **`pyEnKF`-style** ensemble Kalman; **particle
  filter**; **`scikit-optimize`/`BoTorch`** Gaussian-Process Bayesian calibration.
- **Time-series:** **TimescaleDB** (Postgres hypertables — fits the repo's Postgres
  familiarity) as default; InfluxDB alt behind the port.
- **Ingest/transport:** **MQTT (EMQX)** via `asyncio-mqtt`/`paho`, reusing the existing
  Vertivo topic scheme; `pydantic` models parse the orchestrator JSON
  (`device_id`, `greenhouse_id`, `timestamp`, `value/ref`) — mirror vision-core's MQTT parser.
- **Numerics:** `numpy`/`scipy` (extras only; domain stays pure).
- **Config:** `TWIN_` env prefix (`TWIN_MODEL_KIND=fspm`, `TWIN_ASSIMILATION=enkf`,
  `TWIN_TSDB_DSN=...`, `TWIN_MQTT_URL=...`, `TWIN_VISION_GRPC=...`, `TWIN_GEO_GRPC=...`).

---

## 4. Proposed gRPC contract — `proto/digitaltwin/v1/digitaltwin.proto`

Generic twin state / predictions / setpoints in & out; the consumer (`vertivo_server`) maps
to its own agronomy — same boundary rule as `vision.v1`. Consumed Dart-side via grpc-dart
over the same `.proto` (single source of truth), with a REST mirror fallback.

**Services**
- **`TwinService`** — lifecycle & state.
  - `ProvisionTwin(ProvisionTwinRequest) → Twin` — bind a greenhouse/plant to a `CropModel`+cultivar.
  - `GetTwinState(GetTwinStateRequest) → TwinState` — current (or at-time) state vector + uncertainty.
  - `GetStateHistory(GetStateHistoryRequest) → stream TwinState` — assimilated trajectory.
  - `ListModels(ListModelsRequest) → ListModelsResponse` / `GetModelForCrop(...) → ModelDescriptor`.
  - `HealthCheck(HealthCheckRequest) → HealthCheckResponse` (platform gRPC Health v1).
- **`IngestService`** — observations in.
  - `SubmitSensorReading(SubmitSensorReadingRequest) → SubmitSensorReadingResponse` — one/batch typed reading(s) (climate / vision-trait / acoustic), mirrors vision-core's `SubmitCapture` (ref+metadata, MQTT-shaped).
  - `StreamSensorReadings(stream SensorReading) → IngestAck` — high-rate client-stream.
- **`AssimilationService`** — the update loop.
  - `RunAssimilationCycle(RunAssimilationCycleRequest) → AssimilationCycleResult` — forecast→observe→analysis; returns posterior `TwinState`, `Innovation`, uncertainty reduction, `drift` flag.
  - `StreamAssimilationEvents(StreamRequest) → stream AssimilationEvent` — `AssimilationCycleCompleted` / `ModelDriftDetected` / `ModelRecalibrated`.
- **`PredictionService`** — forward simulation / what-if.
  - `Predict(PredictRequest) → PredictionResponse` — target (yield/biomass/harvest-date/resource-use), horizon, optional `Scenario` (management plan) → trajectory + uncertainty band.
- **`ControlService`** — setpoint recommendations out (advisory).
  - `RecommendSetpoints(RecommendSetpointsRequest) → SetpointPlan` — list of `ControlSetpoint`s (temp/CO₂/light/irrigation/density/harvest) + rationale + expected effect.
  - `StreamSetpointRecommendations(StreamRequest) → stream ControlSetpoint`.

**Key messages** (sketch — generic, consumer maps to own domain)
- `Twin { string twin_id; string greenhouse_id; uint32 plant_id; string crop_cycle_id; ModelDescriptor model; string cultivar; State lifecycle; }`
- `enum ModelKind { MODEL_KIND_UNSPECIFIED; FSPM; PROCESS_BASED; AGENT_BASED; }`
- `enum SensorChannel { CHANNEL_UNSPECIFIED; TEMP; RH; CO2; PAR; EC; PH; SOIL_MOISTURE; PLANT_HEIGHT; COVERAGE; AFFECTED_AREA_PCT; PEST_PRESSURE; ACOUSTIC_MFCC; }`
- `SensorReading { SensorChannel channel; oneof v { double value; FloatVector vector; } string unit; double observed_at_unix; string source; float quality; string trace_id; }`
- `TwinState { repeated Trait traits; double thermal_time_dd; ResourceLedger resources; repeated Uncertainty uncertainty; double observed_at_unix; string provenance_cycle_id; string trace_id; }` where `Trait { string name; double value; string unit; }`
- `AssimilationCycleResult { TwinState posterior; double innovation_norm; double uncertainty_reduction; bool drift_detected; string method; string trace_id; }`
- `enum SetpointKind { SETPOINT_UNSPECIFIED; TEMP; CO2; LIGHT_INTENSITY; LIGHT_DURATION; IRRIGATION; PLANT_DENSITY; HARVEST_TIMING; }`
- `ControlSetpoint { SetpointKind kind; double target; string unit; double valid_from_unix; double valid_to_unix; string rationale; double expected_delta_yield; ResourceLedger expected_resource_delta; float confidence; }`
- `Prediction { string target; double horizon_hours; repeated TimeSeriesPoint trajectory; repeated Uncertainty band; string scenario_id; }`
- `ModelDescriptor { string id; ModelKind kind; string version; repeated string crop_scope; string license; }` (mirrors vision-core's `ModelDescriptor`.)

---

## 5. Risks

1. **FSPM is research-grade, not a library.** The diaf022 tomato FSPM is bespoke
   (L-systems + Monte-Carlo light + FvCB), not a pip-installable engine. Building/porting it
   is a large effort. **Mitigation:** start with `WofostAdapter` (`pcse`, mature, EnKF-proven)
   behind `SimulationModelPort`; FSPM as a later adapter. Ship the *architecture* first.
2. **Boundary erosion vs geospatial-core (AgroDataCube overlap).** AgroDataCube provides
   NDVI/parcels/weather that geospatial-core also covers. Risk of two satellite paths.
   **Mitigation:** geo data flows via `GeoContextPort`→geospatial-core; AgroDataCube scoped to
   *weather/soil fallback only*, NL-bound, optional extra.
3. **Boundary erosion vs vision-core.** Tempting to run image processing here (the diaf022
   pipeline does segmentation). **Mitigation:** strictly consume vision-core traits as
   `SensorReading`s; no pixels in this service.
4. **Data assimilation is hard to get right.** EnKF/particle filters need careful covariance
   inflation, observation-error models, and ensemble sizing; naive impls diverge.
   **Mitigation:** keep `AssimilationAnalysis` math pure+unit-tested; validate on
   replay/OSSE before live; expose method as config.
5. **Compute cost of ensembles.** Forward-running an FSPM/WOFOST ensemble (N members) per
   cycle per twin can be heavy at scale. **Mitigation:** async job model, configurable
   ensemble size, surrogate/emulator option, per-twin scheduling.
6. **Time-series scale & retention.** Multi-modal high-rate ingestion (climate+vision+audio)
   across many greenhouses. **Mitigation:** TimescaleDB hypertables + downsampling/continuous
   aggregates; store acoustic as features (MFCC) not raw audio.
7. **Control safety / liability.** Emitting setpoints near actuation could cause crop loss if
   trusted blindly. **Mitigation:** `ControlPort` is **advisory/outbound** by default;
   actuation authority stays with the consumer's orchestrator; HITL gate for harvest/density.
8. **Cultivar/crop generality.** diaf022 is tomato; the Challenge papers are lettuce/dwarf
   tomato. Parameter priors are crop-specific. **Mitigation:** `Cultivar` value object +
   `ModelRegistryPort` per-crop resolution (vision-core's `GetModelForCrop` pattern).
9. **No native CR/tropical greenhouse models.** KASPRO/WOFOST are NL/temperate-calibrated;
   Vertivo is Costa-Rica hydroponic indoor. **Mitigation:** recalibration via
   `BayesianCalibrationAdapter`; flag as research item.
10. **Lost source (edepot 238571).** Image-only PDF + 403; method palette inferred from
    adjacent literature. **Mitigation:** re-acquire a text version / proper citation.

## 6. Open questions for design

1. **Unit of twinning:** per-**plant** (FSPM, organ-level, matches diaf022 + Vertivo's
   `plant_id`) or per-**compartment/crop** (process-based, matches the Challenge net-profit
   KPI)? Likely *both*, selected by `ModelKind` — confirm the default for Vertivo.
2. **Assimilation cadence:** event-driven (on each `SensorReadingIngested`), scheduled
   (daily, per diaf022), or drift-triggered? Probably hybrid — define the policy.
3. **State-update vs parameter-calibration:** diaf022 deliberately calibrates *parameters*
   (not states) to keep model coherence; EnKF updates *states*. Which is canonical, and can
   `DataAssimilationPort` expose both without leaking strategy into the domain?
4. **Who owns the FSPM port/implementation?** Reuse a WUR/research codebase (licensing?) vs
   build minimal in-house vs WOFOST-only at launch. Affects the whole `sim` extra.
5. **Time-series DB choice:** TimescaleDB (Postgres alignment) vs InfluxDB — and is it owned
   by this service or a shared platform store?
6. **Does `ControlPort` ever write back?** Advisory-only forever, or an opt-in closed loop
   (and if so, what safety/HITL gate)? Defines whether actuation crosses the boundary.
7. **Relationship to vision-core's `CaptureIngestService`:** does the twin subscribe to the
   same MQTT topics directly, or only consume vision-core's *post-inference* traits via gRPC?
   (Affects coupling + whether raw captures ever reach this service.)
8. **Geo dependency direction:** is `geospatial-core` a hard runtime dependency for forcing
   data, or optional (twin runs on local climate sensors alone)? Define the degraded mode.
9. **CRS / locale:** AgroDataCube is EPSG:28992/NL; geospatial-core is CRTM05/CR. Confirm the
   twin stays CRS-agnostic (it consumes derived scalars, not rasters) — likely yes.
10. **Acoustic modality scope for v1:** is pest-pressure-from-sound (§1.3) in the first
    cut, or deferred? It's the least-mature input and may be a Phase-2 `SensorChannel`.
11. **Scenario/what-if API depth:** how rich is `Scenario` (full management plan vs single
    setpoint override) for `PredictionService.Predict`?

---

## 7. Sources

| # | Source | Access | Local artifact |
|---|---|---|---|
| 1.1 | Smoleňová et al. 2025, *Tomato FSPM for digital twin* (in silico Plants 7(2) diaf022) | OK (PDF + web) | `vertivolatam/diaf022.pdf` → `/tmp/diaf022.md` |
| 1.2 | Petropoulou et al. 2023, *Lettuce in Intelligent Greenhouses* (Sensors 23(6) 2929) | OK (PDF) | `vertivolatam/sensors-23-02929-v2.pdf` → `/tmp/sensors.md` |
| 1.3 | Calvo Vargas et al. 2025, *IoT en Captura y Análisis de Sonido en Agroindustria* (Revista Agro 3(1)) | OK (PDF) | `vertivolatam/IoT+...Sonido...pdf` → `/tmp/iot_sonido.md` |
| 1.4 | WUR — *Data Assimilation in the Digital Future Farm* | OK | research.wur.nl/en/projects/data-assimilation-in-the-digital-future-farm-... |
| 1.5 | WUR — *AgroDataCube* | OK | https://agrodatacube.wur.nl/ |
| 1.6 | WUR — *Winner 4th Autonomous Greenhouse Challenge* | OK | https://www.wur.nl/en/news/winner-4th-autonomous-greenhouse-challenge-announced |
| 1.7 | edepot.wur.nl/238571 | **FAILED** (403 then image-only PDF) | inferred via web search (WOFOST/EnKF/particle-filter LAI/GPP assimilation) |
| — | research.wur.nl/en/datasets/ | **FAILED** (HTTP 403) | not retrieved |
