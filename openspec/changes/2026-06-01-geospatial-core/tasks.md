# Tasks — geospatial-core scaffold & Fase 1

**Date:** 2026-06-01
**Domain:** `geospatial-core`
**Change:** `2026-06-01-geospatial-core`
**Status:** Scaffold landed; implementation tasks below are pending.

---

## 0. Scaffold (this change) — DONE

- [x] OpenSpec change: `proposal.md` (PDR), `design.md` (ADR), `tasks.md`
- [x] `services/geospatial-core/` hexagonal skeleton (`src/geospatial_core/{domain,application,adapters/{primary,secondary}}`)
- [x] `pyproject.toml` (SPDX `BUSL-1.1`, rasterio/h3/geoai as extras)
- [x] `proto/geospatial/v1/geospatial.proto` (gRPC LandUseService)
- [x] Application ports: ImageryProvider, RasterIO, SpatialIndex, Segmentation, LandUseClassifier, MapTileExport
- [x] `README.md` (README-first), `LICENSE.md` (BSL 1.1, +5y), `package.json` (Turbo passthrough)
- [x] `deployment/k8s/` (namespace) + COG/tiling notes; `examples/`; `tests/` skeleton

## 1. Domain & contracts

- [ ] Flesh out value objects: `AOI`, `ParcelFootprint`, `H3Cell`, `LandUseClass` enum, `LandUseObservation`, `RasterWindow`, `BandSet`
- [ ] Lock the `LandUseClass` vocabulary across proto enum + GeoJSON + H3 payload
- [ ] Codegen gRPC stubs from `proto/geospatial/v1/geospatial.proto`

## 2. Secondary adapters

- [ ] `RasterioCogAdapter` — windowed COG reads, reprojection (UTM/MGRS ⇄ EPSG:5367), QA masking, overviews
- [ ] `H3Adapter` (h3-py) — latLng→cell, cellToBoundary, polyfill, compact, parent/child, k-ring
- [ ] `Sentinel2Adapter` + `HlsAdapter` + `EarthEngineAdapter` (provider selection rule: ≤5 ha→S2, municipal/multi-date→HLS)
- [ ] `GeoAiSamAdapter`, `GeoAiRfDetrAdapter` (opengeoai tiled GeoTIFF inference)
- [ ] `IndexThresholdClassifier` (NDVI/NDWI/NDBI + weak labels from ESA WorldCover / Dynamic World / USDA CDL)
- [ ] `MapLibreExportAdapter` — H3 cell payload + GeoJSON + MVT/COG

## 3. Application (CQRS)

- [ ] Commands: `DeriveLandUse`, `IndexAOI`, `ExportMapTiles`
- [ ] Queries: `GetLandUseForParcel`, `GetH3Rollup` (res 11 detail, res 10/8 rollup)
- [ ] Wire the no-cadastral pipeline: AOI → imagery → QA mask → classify → segment-refine → H3 index → export

## 4. Primary adapters / API

- [ ] gRPC `LandUseService` server
- [ ] REST mirror
- [ ] Health check (gRPC Health v1, per platform standard)

## 5. HabitaNexus integration

- [ ] Publish the `geospatial-core/landuse-h3/v1` render contract to HabitaNexus
- [ ] Reference Flutter overlay: `h3_flutter` (cellToBoundary) + `flutter_maplibre_gl` fill/line layer
- [ ] UC-3: reproject export to CRTM05 (EPSG:5367) to align with `08USO_TIERRA_POR_ZONAS`

## 6. Tests & deploy

- [ ] Unit tests per port (fakes) + classifier threshold tests
- [ ] Golden test: known AOI → expected land-use H3 rollup
- [ ] k8s manifests beyond namespace (deployment/service); COG cache (object store)
- [ ] CI: ruff + mypy strict + pytest (mirror agentic-core)

## 7. Owner decisions (blockers — see design.md §9)

- [ ] Provider default: GEE-broker-first vs. direct COG-first
- [ ] Legal framing of UC-2 (advisory prior vs. informational only)
- [ ] Confirm `service:geospatial-core` label + `openspec/project.md` domain row
- [ ] Green-light shared `packages/common` segmentation contract with vision-core
