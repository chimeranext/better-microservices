"""Domain value objects for geospatial-core.

SPDX-License-Identifier: BUSL-1.1

Pure, dependency-free. H3 geometry is always WGS84 (lat/lng) as H3 requires.
"""

from __future__ import annotations

from dataclasses import dataclass, field
from datetime import datetime

from geospatial_core.domain.enums import ImageryProvider, LandUseClass


@dataclass(frozen=True)
class LngLat:
    lng: float
    lat: float


@dataclass(frozen=True)
class AOI:
    """Area of interest — a parcel footprint or a municipal boundary (WGS84)."""

    ring: tuple[LngLat, ...]
    label: str = ""

    @property
    def approx_area_ha(self) -> float:
        """Shoelace area in hectares (planar approx; adapters use a projected CRS for exactness)."""
        if len(self.ring) < 3:
            return 0.0
        # ~111_320 m per degree lat; lng scaled by cos(lat). Coarse — for the provider-selection rule only.
        import math

        lat0 = self.ring[0].lat
        mx = 111_320.0 * math.cos(math.radians(lat0))
        my = 110_540.0
        pts = [(p.lng * mx, p.lat * my) for p in self.ring]
        s = 0.0
        for i in range(len(pts)):
            x1, y1 = pts[i]
            x2, y2 = pts[(i + 1) % len(pts)]
            s += x1 * y2 - x2 * y1
        return abs(s) / 2.0 / 10_000.0


@dataclass(frozen=True)
class BandSet:
    """The bands a classifier needs (Sentinel-2/HLS nomenclature)."""

    bands: tuple[str, ...] = ("B02", "B03", "B04", "B08")  # blue, green, red, NIR


@dataclass(frozen=True)
class RasterWindow:
    """A windowed read region against a COG (row/col offsets + size)."""

    col_off: int
    row_off: int
    width: int
    height: int


@dataclass(frozen=True)
class SourceInfo:
    provider: ImageryProvider
    scene: str
    observed_at: datetime


@dataclass(frozen=True)
class H3Cell:
    """An H3 cell ID + its land-use observation. The client resolves geometry via h3_flutter."""

    h3: str  # 64-bit H3 id (hex string)
    land_use: LandUseClass
    confidence: float
    area_m2: float = 0.0
    ndvi: float | None = None


@dataclass(frozen=True)
class LandUseObservation:
    """A dated land-use derivation for an AOI (the immutable snapshot, UC-4)."""

    cells: tuple[H3Cell, ...]
    resolution: int
    source: SourceInfo
    built_area_m2: float = 0.0
    polygons: tuple = field(default_factory=tuple)  # dissolved per-class GeoJSON-like polys
