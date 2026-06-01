# geospatial-core

**Satellite & aerial land-use / land-cover AI — without cadastral maps.**

`geospatial-core` analyzes Copernicus **Sentinel-2** and **HLS (Harmonized
Landsat-Sentinel-2)** imagery to derive **land use / land cover** and inspect terrain
for any area of interest — *independently of cadastral records or an official avalúo*.
It aggregates results onto Uber's **H3** hexagonal index and exports them for a
**`flutter_maplibre_gl`** map, with **`h3_flutter`** resolving hexagon geometry on the
client.

It is the **8th microservice** in `better-microservices` and the **satellite /
remote-sensing counterpart** to the sibling [`vision-core`](../) (close-range
crop/plant segmentation). Primary consumer: **habitanexus** (long-term housing-rental
marketplace); secondary: AgTech overlap with vision-core.

> Source-available under **BUSL-1.1** (see `LICENSE.md`). © 2026 Andrés (lapc506),
> licensed and published by ChimeraNext Shared Services LLC.

---

## Why "without cadastral maps"?

Cadastral data is often missing, stale, or expensive — especially for informal/rural
lots. Digifarm built a business on exactly this gap for agriculture: *"cadastral data
is the baseline… over time it doesn't reflect what's seeded,"* so they derive field
boundaries from Sentinel-2 instead — and seven EU governments now replace manual
boundary drawing with their layer. geospatial-core does the analogue for housing:
**derive land use from imagery first**, then optionally reconcile with any cadastral
layer that happens to exist.

## What it does

- **Ingest imagery** — Sentinel-2 (10 m, 5-day revisit) and HLS S30/L30 (30 m, ~2–3-day
  revisit, harmonized COG), with Google Earth Engine as an optional broker.
- **Read rasters** — windowed Cloud-Optimized GeoTIFF (COG) reads via **rasterio/GDAL**;
  reproject UTM/MGRS ⇄ EPSG:5367 (CRTM05).
- **Derive land use** — wall-to-wall classifier (NDVI/NDWI/NDBI + supervised RF,
  weak-labelled from ESA WorldCover / Dynamic World / USDA CDL), refined by
  **opengeoai / GeoAI** segmentation (**SAM** footprints, **RF-DETR** objects).
- **Index spatially** — aggregate onto **H3** (res 11 detail ≈ 0.22 ha, res 10/8 rollups).
- **Export for the map** — H3 cell payload (primary) + GeoJSON + MVT, consumed by
  `flutter_maplibre_gl` + `h3_flutter` in habitanexus.

## Architecture

Hexagonal (Explicit Architecture: Hexagonal + DDD + CQRS), mirroring `agentic-core`.
All arrows point inward; infrastructure depends on domain-defined **ports**.

```
adapters/primary (gRPC + REST)
        │
application (commands/queries) ── ports ──┐
        │                                 │
domain (pure value objects, enums)        │ implemented by
                                          ▼
adapters/secondary:
  ImageryProviderPort   → Sentinel2Adapter · HlsAdapter · EarthEngineAdapter
  RasterIOPort          → RasterioCogAdapter (rasterio/GDAL/COG)
  SpatialIndexPort      → H3Adapter (h3-py)
  SegmentationPort      → GeoAiSamAdapter · GeoAiRfDetrAdapter (opengeoai)
  LandUseClassifierPort → IndexThresholdClassifier
  MapTileExportPort     → MapLibreExportAdapter (H3 / GeoJSON / MVT)
```

The no-cadastral pipeline:

```
AOI → ImageryProvider → RasterIO (window + QA mask) → LandUseClassifier
    → Segmentation (refine footprints/objects) → SpatialIndex (H3) → MapTileExport
```

## Key technologies

| Tech | Role |
|---|---|
| **H3** (Uber) | Hexagonal spatial index — server aggregation **and** client geometry |
| [**h3_flutter**](https://pub.dev/packages/h3_flutter) | **Client** side of the H3 contract — resolves cell IDs to boundaries in habitanexus |
| **Copernicus Sentinel-2** | 10 m, 5-day — default for parcel-scale AOIs |
| **HLS (Harmonized Landsat-Sentinel-2)** | 30 m, ~2–3-day, harmonized COG — time-series / municipal scale |
| **rasterio / GDAL** | Windowed COG I/O, reprojection, tiling |
| **opengeoai / GeoAI** | SAM, RF-DETR, segmentation on geospatial rasters |
| **Google Earth Engine** | Optional imagery + weak-label broker |
| **flutter_maplibre_gl** | Map frontend in habitanexus |

## Quickstart

```bash
cd services/geospatial-core
python -m venv .venv && source .venv/bin/activate
pip install -e '.[dev]'            # base + dev (pure; no native geo wheels)
pytest                            # domain + pipeline-wiring tests run without GDAL/H3

# full geospatial stack (needs GDAL/PROJ system libs):
pip install -e '.[geo,imagery,models]'
python examples/derive_parcel_land_use.py
```

The base install deliberately omits the native stack (rasterio/H3/geoai) so the domain
and ports import anywhere; adapters import their native deps lazily.

## habitanexus integration (the render contract)

H3 lives on **both** sides. The server emits **cell IDs + land-use only**; the Flutter
client reconstructs geometry with `h3_flutter` and draws it with `flutter_maplibre_gl`.

Server (`MapTileExportPort`) → `geospatial-core/landuse-h3/v1`:

```jsonc
{
  "schema": "geospatial-core/landuse-h3/v1",
  "resolution": 11,
  "crs": "EPSG:4326",
  "observed_at": "2026-05-20T00:00:00Z",
  "source": { "provider": "sentinel-2", "scene": "T16PHV_20260520" },
  "cells": [
    { "h3": "8b2a1072d2dffff", "class": "built",      "confidence": 0.91, "area_m2": 2150 },
    { "h3": "8b2a1072d2c1fff", "class": "vegetation", "confidence": 0.86, "ndvi": 0.62 }
  ]
}
```

Client (Dart):

```dart
final h3 = await const H3Factory().load();
for (final cell in payload.cells) {
  final boundary = h3.h3ToGeoBoundary(BigInt.parse(cell.h3, radix: 16));
  // add boundary as a Fill/Line layer in flutter_maplibre_gl, colored by cell.class
}
```

Two more representations cover non-H3 consumers: **GeoJSON** (dissolved per-class,
reprojectable to EPSG:5367 for the municipal B2G dashboard) and **MVT** vector tiles for
large AOIs.

### Use cases (grounded in habitanexus)

- **UC-1** No-cadastral land-use inspection of a listing's terrain.
- **UC-2** Independent built-area prior to sanity-check the avalúo-derived canon cap
  (Colombia Ley 820 / México predial) — *advisory, not a legal avalúo*.
- **UC-3** Derived land-use layer where a municipality has no FeatureServer
  (`municipal-dashboard`).
- **UC-4** Dated, immutable terrain snapshot at contract start (owner can't prove
  initial state with recycled photos).
- **UC-5** AgTech vegetation context, handed off to vision-core for close-range.

## Deploy

See `deployment/README.md` (COG/tiling strategy, caching, k8s, provider credentials)
and `deployment/k8s/namespace.yaml`.

## Specs & decisions

- PDR: `openspec/changes/2026-06-01-geospatial-core/proposal.md`
- ADR: `openspec/changes/2026-06-01-geospatial-core/design.md` (imagery & model
  matrices + verdicts, H3 resolution choice, render contract)
- Tasks: `openspec/changes/2026-06-01-geospatial-core/tasks.md`
