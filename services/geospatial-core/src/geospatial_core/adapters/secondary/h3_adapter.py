"""H3Adapter — SpatialIndexPort backed by h3-py.

SPDX-License-Identifier: BUSL-1.1

The server side of the H3 render contract. The Flutter client (habitanexus) mirrors
``cell_to_boundary`` with the ``h3_flutter`` package to draw the overlay (ADR §6).

``h3`` is an optional dependency (see pyproject ``[geo]`` extra); imported lazily so
the package and its ports import without GDAL/H3 native wheels present.
"""

from __future__ import annotations

from geospatial_core.application.ports.spatial_index import SpatialIndexPort
from geospatial_core.domain.value_objects import AOI, LngLat


class H3Adapter(SpatialIndexPort):
    def __init__(self) -> None:
        try:
            import h3  # noqa: F401
        except ImportError as exc:  # pragma: no cover - exercised only without the extra
            raise ImportError("H3Adapter requires the 'geo' extra: pip install geospatial-core[geo]") from exc

    def lat_lng_to_cell(self, lat: float, lng: float, resolution: int) -> str:
        import h3

        return h3.latlng_to_cell(lat, lng, resolution)

    def polyfill(self, aoi: AOI, resolution: int) -> list[str]:
        import h3

        loops = [[p.lat, p.lng] for p in aoi.ring]
        poly = h3.LatLngPoly(loops)
        return list(h3.polygon_to_cells(poly, resolution))

    def cell_to_boundary(self, h3_id: str) -> list[LngLat]:
        import h3

        return [LngLat(lng=lng, lat=lat) for lat, lng in h3.cell_to_boundary(h3_id)]

    def cell_to_parent(self, h3_id: str, parent_resolution: int) -> str:
        import h3

        return h3.cell_to_parent(h3_id, parent_resolution)

    def grid_disk(self, h3_id: str, k: int) -> list[str]:
        import h3

        return list(h3.grid_disk(h3_id, k))

    def compact_cells(self, h3_ids: list[str]) -> list[str]:
        import h3

        return list(h3.compact_cells(h3_ids))

    def cell_area_m2(self, h3_id: str) -> float:
        import h3

        return float(h3.cell_area(h3_id, unit="m^2"))
