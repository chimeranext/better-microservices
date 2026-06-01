"""Example — derive a no-cadastral land-use snapshot for a parcel and export the
habitanexus H3 render payload.

SPDX-License-Identifier: BUSL-1.1

This is illustrative (adapters are Fase-1 skeletons). It shows how the ports wire
together and what the client (h3_flutter + flutter_maplibre_gl) receives.

Run after installing the geo extra:
    pip install -e '.[geo,imagery,models]'
    python examples/derive_parcel_land_use.py
"""

from __future__ import annotations

import asyncio

from geospatial_core.domain.value_objects import AOI, LngLat


async def main() -> None:
    # A parcel footprint with NO cadastral record (UC-1) — WGS84 ring.
    parcel = AOI(
        ring=(
            LngLat(-84.0900, 9.9350),
            LngLat(-84.0895, 9.9350),
            LngLat(-84.0895, 9.9355),
            LngLat(-84.0900, 9.9355),
        ),
        label="listing-CR-demo",
    )
    print(f"AOI ~{parcel.approx_area_ha:.3f} ha -> provider rule picks "
          f"{'Sentinel-2' if parcel.approx_area_ha <= 5 else 'HLS'}")

    # In the wired service:
    #   svc = DeriveLandUseService(sentinel2=..., hls=..., raster_io=RasterioCogAdapter(),
    #                              classifier=IndexThresholdClassifier(),
    #                              spatial_index=H3Adapter())
    #   observation = await svc.derive(parcel, resolution=11)
    #   payload = await MapLibreExportAdapter().export_h3_payload(observation)
    #
    # The client consumes payload like:
    expected_payload = {
        "schema": "geospatial-core/landuse-h3/v1",
        "resolution": 11,
        "crs": "EPSG:4326",
        "observed_at": "2026-05-20T00:00:00Z",
        "source": {"provider": "sentinel-2", "scene": "T16PHV_20260520"},
        "cells": [
            {"h3": "8b2a1072d2dffff", "class": "built", "confidence": 0.91, "area_m2": 2150},
            {"h3": "8b2a1072d2c1fff", "class": "vegetation", "confidence": 0.86, "ndvi": 0.62},
        ],
    }
    print("habitanexus payload (h3_flutter resolves cell geometry client-side):")
    print(expected_payload)


if __name__ == "__main__":
    asyncio.run(main())
