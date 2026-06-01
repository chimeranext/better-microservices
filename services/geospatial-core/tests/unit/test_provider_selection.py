"""Pipeline wiring + provider-selection tests using in-memory fakes (no native deps).

SPDX-License-Identifier: BUSL-1.1
"""

from __future__ import annotations

from datetime import datetime
from typing import Any

import pytest

from geospatial_core.application.services.derive_land_use import DeriveLandUseService
from geospatial_core.domain.enums import ImageryProvider, LandUseClass
from geospatial_core.domain.value_objects import AOI, BandSet, LngLat, SourceInfo


class _FakeImagery:
    def __init__(self, provider: ImageryProvider) -> None:
        self._p = provider

    @property
    def provider(self) -> ImageryProvider:
        return self._p

    async def search_scenes(self, aoi: Any, start=None, end=None, max_cloud_pct=20.0):  # noqa: ANN001
        return [SourceInfo(provider=self._p, scene="T16PHV_20260520", observed_at=datetime(2026, 5, 20))]

    async def fetch_cog_assets(self, scene: Any, bands: BandSet) -> dict[str, str]:  # noqa: ANN001
        return {b: f"cog://{scene.scene}/{b}.tif" for b in bands.bands}


class _FakeRasterIO:
    async def window_for_aoi(self, cog_uri, aoi, buffer_px=8):  # noqa: ANN001
        return object()

    async def read_window(self, band_uris, window, bands):  # noqa: ANN001
        return object()

    async def apply_qa_mask(self, array, qa_uri, window):  # noqa: ANN001
        return array

    async def reproject(self, array, src_crs, dst_crs):  # noqa: ANN001
        return array

    async def write_cog(self, array, path, crs, build_overviews=True):  # noqa: ANN001
        return path


class _FakeClassifier:
    @property
    def classes(self):
        return [LandUseClass.BUILT, LandUseClass.VEGETATION]

    async def classify(self, array, band_order):  # noqa: ANN001
        return object()

    async def confidence(self, array, band_order):  # noqa: ANN001
        return object()


class _FakeIndex:
    def lat_lng_to_cell(self, lat, lng, resolution):  # noqa: ANN001
        return "8b2a1072d2dffff"

    def polyfill(self, aoi, resolution):  # noqa: ANN001
        return ["8b2a1072d2dffff"]

    def cell_to_boundary(self, h3_id):  # noqa: ANN001
        return [LngLat(0, 0)]

    def cell_to_parent(self, h3_id, parent_resolution):  # noqa: ANN001
        return h3_id

    def grid_disk(self, h3_id, k):  # noqa: ANN001
        return [h3_id]

    def compact_cells(self, h3_ids):  # noqa: ANN001
        return h3_ids

    def cell_area_m2(self, h3_id):  # noqa: ANN001
        return 2150.0


def _service() -> DeriveLandUseService:
    return DeriveLandUseService(
        sentinel2=_FakeImagery(ImageryProvider.SENTINEL2),
        hls=_FakeImagery(ImageryProvider.HLS),
        raster_io=_FakeRasterIO(),
        classifier=_FakeClassifier(),
        spatial_index=_FakeIndex(),
        sentinel2_max_aoi_ha=5.0,
    )


def _municipal_aoi() -> AOI:
    return AOI(ring=(LngLat(-84.1, 9.9), LngLat(-84.0, 9.9), LngLat(-84.0, 10.0), LngLat(-84.1, 10.0)))


def test_small_parcel_selects_sentinel2(small_parcel: AOI) -> None:
    svc = _service()
    assert svc.select_provider(small_parcel, None).provider is ImageryProvider.SENTINEL2


def test_large_aoi_selects_hls() -> None:
    svc = _service()
    assert svc.select_provider(_municipal_aoi(), None).provider is ImageryProvider.HLS


def test_explicit_request_overrides_rule(small_parcel: AOI) -> None:
    svc = _service()
    assert svc.select_provider(small_parcel, ImageryProvider.HLS).provider is ImageryProvider.HLS


@pytest.mark.asyncio
async def test_derive_pipeline_runs(small_parcel: AOI) -> None:
    svc = _service()
    obs = await svc.derive(small_parcel, resolution=11)
    assert obs.resolution == 11
    assert obs.source.scene == "T16PHV_20260520"
