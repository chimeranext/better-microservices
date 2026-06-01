# geospatial-core — satellite & aerial land-use AI without cadastral maps

**Date:** 2026-06-01
**Owner:** Andrés (andres@dojocoding.io)
**Status:** Proposed — scaffolded on branch `chore/geospatial-core-scaffold`, pending review
**Domain:** `geospatial-core` (new 8th service; proposed label `service:geospatial-core`)
**Primary consumer:** `habitanexus` (long-term housing-rental marketplace)
**Secondary:** AgTech overlap with the sibling `vision-core` (close-range crop/plant segmentation)
**Tracking issue:** TBD (open with `service:geospatial-core` + `type:design`)

---

## Why (Problem)

HabitaNexus needs to know **what is actually on a property's terrain** — built area
vs. bare soil vs. vegetation vs. water vs. road — and it needs this **without
depending on a cadastral map or an official avalúo**. Three concrete pains in the
HabitaNexus monorepo motivate this service:

1. **The cadastral-avalúo dependency in the listing flow is a hard blocker in some
   jurisdictions.** The internationalization SOP
   (`docs/site/content/docs/sops/adiciones-internacionalizacion.md`, Adición 1 —
   Colombia, Ley 820/2003 Art. 18) forces:
   > "El propietario debe ingresar el avalúo catastral del inmueble. La plataforma
   > calcula automáticamente el canon máximo permitido y no permite publicar un
   > precio superior."

   and the impact matrix lists for **Fase 1 (Listado)**: *"Avalúo catastral + tope
   canon"* (Colombia) and *"Constancia de predial"* (México). When the owner has no
   current cadastral record — common for informal/rural Costa Rican lots — the flow
   stalls. A satellite-derived **land-use / built-area estimate** gives an
   independent prior to seed or sanity-check that value.

2. **The municipal B2G dashboard already commits to land-use GIS layers, but only
   as *consumed* third-party feeds.** The `municipal-dashboard` spec
   (`openspec/specs/municipal-dashboard/spec.md`) overlays rental data on
   *"capa catastral/Plan Regulador"* and integrates, for San José, the live layer:
   > `mapas.msj.go.cr/.../SIG_SER_RDU2023_08USO_TIERRA_POR_ZONAS/FeatureServer`
   > ("USO TIERRA POR ZONAS" = land-use-by-zones), projection **CRTM05 (EPSG:5367)**.

   That spec depends on each municipality *publishing* a land-use layer. Many small
   municipalities ("San Carlos, Santa Ana, Carrillo, Palmares") do not, or publish a
   stale Plan Regulador. geospatial-core can **derive a land-use layer from imagery**
   for any AOI, filling the gap where no FeatureServer exists.

3. **Owners cannot prove the initial state of a property / terrain.** The owner
   persona José (`docs/site/content/docs/usuarios/propietario-jose-penaranda.md`):
   > "no tiene forma de probar el estado inicial porque nunca documentó con fotos
   > fechadas… Las fotos que tiene son recicladas de publicaciones viejas."

   A **dated satellite/aerial land-use snapshot of the parcel footprint** is an
   immutable, timestamped record of terrain state at contract start — independent of
   the owner's photos and of any cadastral record.

This is a known-good pattern. Digifarm (HPC/AI conference talk, YouTube `Y35-IpEIM5Q`)
built a business precisely because *"cadastral data is kind of the baseline of this…
over time they don't reflect really what's seeded"* — they derive field boundaries
from Sentinel-2 instead, and **seven EU governments now replace manual boundary
drawing with their auto-detected geospatial layer**. SAT-RAKSHAK (GitHub
`kaustubhkulkarni07/SAT-RAKSHAK`) does the analogue for India: derive an answer from
Sentinel SAR and resolve it to the *7/12 land record* by coordinate — i.e. imagery
first, land record second.

## What (Decision)

Create the **8th microservice, `geospatial-core`** — the **satellite / remote-sensing**
counterpart to the sibling `vision-core` (close-range). Where vision-core segments a
plant from a phone photo, geospatial-core segments **land use / land cover from
satellite and aerial rasters** and aggregates it onto a **spatial index (H3)** that
the HabitaNexus Flutter app can render directly over a map.

Core capabilities (Fase 1 scope):

- **Imagery ingest** from Copernicus **Sentinel-2** (10 m, 5-day revisit) and **HLS /
  Harmonized Landsat-Sentinel-2** (30 m, ~2–3-day revisit, COG, harmonized SR), with
  **Google Earth Engine** as an optional broker. (Matrix + verdict in `design.md`.)
- **Raster I/O** via **rasterio/GDAL**, windowed reads against **Cloud-Optimized
  GeoTIFF (COG)**, tiling and reprojection (UTM/MGRS ⇄ CRTM05 EPSG:5367 for CR).
- **Land-use / land-cover derivation** for an AOI **without a cadastral map**:
  segmentation (**opengeoai / GeoAI**: SAM, RF-DETR) + a land-cover classifier
  (NDVI/index thresholds + supervised classifier, weak-labelled from **ESA WorldCover
  / Dynamic World / USDA CDL**) → per-class polygons.
- **Spatial aggregation** onto the **H3** hexagonal index (Uber) for parcel-level
  rollups and stable cell IDs.
- **Map-tile / cell export** as a typed contract the HabitaNexus map consumes: H3 cell
  IDs + per-cell land-use, plus GeoJSON polygons and vector-tile/COG overlays for
  **`flutter_maplibre_gl`**, with **`h3_flutter`** resolving H3 geometry **client-side**
  (see the render contract in `design.md`).
- **gRPC + REST** API (proto-first), packaged like agentic-core (hexagonal `src/`,
  ports/adapters, polyglot-Turbo passthrough).

### HabitaNexus use cases (grounded)

| # | Use case | Grounded in | What geospatial-core returns |
|---|---|---|---|
| UC-1 | **No-cadastral land-use inspection** of a listing's terrain | José persona + Adición 1/Constancia predial blocker | Per-class land-use polygons + H3 rollup + built-area m² estimate for the parcel footprint |
| UC-2 | **Seed/sanity-check the avalúo-derived canon cap** where no cadastral record exists | Adición 1 (Colombia), "Constancia de predial" (México) | Built-vs-unbuilt ratio + land-use class as an independent prior (advisory, **not** a legal avalúo) |
| UC-3 | **Derived land-use layer for the municipal B2G dashboard** where no FeatureServer exists | `municipal-dashboard` spec (`08USO_TIERRA_POR_ZONAS`, EPSG:5367) | Land-use layer (H3/GeoJSON, reprojected to CRTM05) to overlay alongside catastral/Plan Regulador |
| UC-4 | **Dated, immutable terrain snapshot** at contract start | José "fotos recicladas / no puede probar estado inicial" | Timestamped land-use classification of the parcel, archivable as evidence |
| UC-5 | **AgTech overlap** — parcel-scale crop/vegetation context | Sentinel-2 agriculture; sibling vision-core | NDVI/vegetation summary per H3 cell; hand-off contract to vision-core for close-range |

### Out of scope (Fase 1)

- No legal/official avalúo or cadastral certification — outputs are **advisory priors**.
- No SAR/flood pipeline (SAT-RAKSHAK-style Sentinel-1) — deferred.
- No model training infra/HPC — Fase 1 uses pretrained opengeoai/GeoAI models +
  index-threshold classifiers; fine-tuning deferred.
- No shared segmentation contract is *built* in `packages/common` yet — only flagged
  (see `design.md`); vision-core and geospatial-core may later share it.
- No real provider credentials/keys wired — adapters are skeletons with typed ports.

## Impact

- **New service** `services/geospatial-core/` + new domain in `openspec/project.md`
  (proposed `service:geospatial-core` label / `geospatial-core` domain row).
- **New public contract**: `proto/geospatial/v1/*.proto` (gRPC) + REST mirror + the
  H3/GeoJSON **map-render contract** consumed by HabitaNexus.
- **Cross-service**: a future `packages/common` segmentation contract shared with
  `vision-core` (flagged, not built).
