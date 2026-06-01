"""MapTileExportPort — emit the habitanexus render contract.

SPDX-License-Identifier: BUSL-1.1

Implemented by MapLibreExportAdapter. Emits three coordinated representations
(ADR §6): (1) H3 cell payload (primary) — IDs + land-use only, geometry resolved
client-side by h3_flutter; (2) GeoJSON dissolved per-class polygons; (3) MVT/COG
vector tiles for large AOIs. Schema: ``geospatial-core/landuse-h3/v1``.
"""

from __future__ import annotations

from abc import ABC, abstractmethod

from geospatial_core.domain.enums import ExportFormat
from geospatial_core.domain.value_objects import LandUseObservation


class MapTileExportPort(ABC):
    SCHEMA: str = "geospatial-core/landuse-h3/v1"

    @abstractmethod
    async def export_h3_payload(
        self, observation: LandUseObservation, crs: str = "EPSG:4326"
    ) -> dict:
        """Primary payload: schema + resolution + cells[{h3, class, confidence, area_m2, ndvi}]."""

    @abstractmethod
    async def export_geojson(
        self, observation: LandUseObservation, crs: str = "EPSG:4326"
    ) -> bytes:
        """Dissolved per-class GeoJSON FeatureCollection (e.g. reprojected to EPSG:5367 for B2G)."""

    @abstractmethod
    async def export_mvt(
        self, observation: LandUseObservation, tile_url_template: str
    ) -> str:
        """Publish vector tiles for large AOIs; return the MapLibre tile URL template."""

    @abstractmethod
    def supports(self, fmt: ExportFormat) -> bool: ...
