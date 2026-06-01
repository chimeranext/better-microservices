# geospatial-core — deployment & COG/tiling notes

**SPDX-License-Identifier:** BUSL-1.1

## Topology

```
flutter_maplibre_gl + h3_flutter (habitanexus client)
        │  gRPC / REST  (H3 cells + GeoJSON + MVT)
        ▼
geospatial-core (Python, hexagonal)
        │  windowed HTTP-range reads (COG)
        ▼
imagery: Copernicus Sentinel-2 (10 m) · NASA HLS S30/L30 (30 m, COG) · GEE broker
weak labels: ESA WorldCover 10 m · Dynamic World · USDA CDL
```

## COG / tiling strategy (see ADR §5)

- **Everything is Cloud-Optimized GeoTIFF.** HLS V2.0 ships COG; derived land-use
  rasters and masks are written COG with overview pyramids so the API and the map
  layer do HTTP-range / windowed reads — never whole-scene downloads.
- **Windowed reads** (`rasterio.windows.Window`) over the AOI bbox + buffer, only the
  bands the classifier needs (B02/B03/B04/B08).
- **Tiled inference** (256/512 px + overlap) for opengeoai SAM/RF-DETR, stitched and
  georeferenced back via the COG transform.
- **QA masking** with the HLS/Fmask QA band (cloud/shadow/water/snow) before classify.
- **Reprojection** to **EPSG:5367 (CRTM05)** for Costa Rica B2G output to align with the
  municipal `08USO_TIERRA_POR_ZONAS` FeatureServer. H3 work stays WGS84.

## Caching

- A **COG cache** (object store, e.g. S3/MinIO) holds derived land-use COGs + MVT tiles
  keyed by `(aoi_hash, scene, h3_resolution)` so repeat reads of a listing's parcel are
  cheap. Treat derived products as immutable per `observed_at` (UC-4 dated snapshot).

## Kubernetes

`k8s/namespace.yaml` is the Fase-1 starting point (mirrors agentic-core's
`k8s/dependencies/namespace.yaml`). Deployment/Service manifests, the COG cache
(object store), and gRPC Health v1 wiring follow the platform sidecar standard — see
`tasks.md` §6.

## Provider credentials (owner decision, ADR §9)

- **GEE-broker-first** (default in `config/settings.py`): needs an Earth Engine service
  account. Simplest, but quota/lock-in.
- **Direct COG-first**: STAC search against Copernicus Data Space + NASA LP DAAC
  (Earthdata login); no GEE quota, more plumbing.
