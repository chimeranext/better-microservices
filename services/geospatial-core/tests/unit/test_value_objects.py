"""Domain value-object tests (pure, no native deps).

SPDX-License-Identifier: BUSL-1.1
"""

from __future__ import annotations

from geospatial_core.domain.enums import ExportFormat, LandUseClass
from geospatial_core.domain.value_objects import AOI, LngLat


def test_landuse_vocabulary_is_stable() -> None:
    # The render contract + proto enum depend on these exact string values.
    assert {c.value for c in LandUseClass} == {
        "unknown", "built", "bare_soil", "vegetation", "water", "road",
    }


def test_export_formats() -> None:
    assert ExportFormat.H3_CELLS.value == "h3_cells"


def test_aoi_area_small_parcel(small_parcel: AOI) -> None:
    # ~0.1 ha demo parcel must fall under the 5 ha Sentinel-2 threshold.
    assert 0.0 < small_parcel.approx_area_ha < 5.0


def test_aoi_area_municipal_scale() -> None:
    big = AOI(ring=(LngLat(-84.1, 9.9), LngLat(-84.0, 9.9), LngLat(-84.0, 10.0), LngLat(-84.1, 10.0)))
    assert big.approx_area_ha > 5.0
