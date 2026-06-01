"""Domain enums for geospatial-core.

SPDX-License-Identifier: BUSL-1.1
"""

from __future__ import annotations

from enum import Enum


class LandUseClass(str, Enum):
    """Shared land-use vocabulary — matches the proto enum and the H3/GeoJSON payload."""

    UNKNOWN = "unknown"
    BUILT = "built"
    BARE_SOIL = "bare_soil"
    VEGETATION = "vegetation"
    WATER = "water"
    ROAD = "road"


class ImageryProvider(str, Enum):
    """Imagery source. Selection rule: AOI <= ~5 ha -> SENTINEL2; municipal/multi-date -> HLS."""

    SENTINEL2 = "sentinel-2"   # 10 m, 5-day revisit
    HLS = "hls"                # 30 m, ~2-3 day revisit, harmonized COG
    EARTH_ENGINE = "earth-engine"  # broker over S2 + HLS + weak-label sources


class ExportFormat(str, Enum):
    """Map-render export formats (see ADR §6)."""

    H3_CELLS = "h3_cells"   # primary; resolved client-side by h3_flutter
    GEOJSON = "geojson"     # dissolved per-class polygons
    MVT = "mvt"             # vector tiles for large AOIs
