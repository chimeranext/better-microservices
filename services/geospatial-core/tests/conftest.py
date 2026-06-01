"""Shared test fixtures for geospatial-core.

SPDX-License-Identifier: BUSL-1.1
"""

from __future__ import annotations

import pytest

from geospatial_core.domain.value_objects import AOI, LngLat


@pytest.fixture
def small_parcel() -> AOI:
    """A ~0.1 ha parcel footprint near San Jose, CR (WGS84) — triggers Sentinel-2."""
    return AOI(
        ring=(
            LngLat(-84.090, 9.935),
            LngLat(-84.0895, 9.935),
            LngLat(-84.0895, 9.9355),
            LngLat(-84.090, 9.9355),
        ),
        label="listing-demo",
    )
