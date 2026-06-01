"""RasterioCogAdapter — RasterIOPort backed by rasterio/GDAL (skeleton).

SPDX-License-Identifier: BUSL-1.1

Windowed COG reads, QA masking, reprojection (UTM/MGRS <-> EPSG:5367) and
COG writing with overviews (ADR §5). ``rasterio`` is an optional dependency
(``[geo]`` extra); imported lazily.

Fase-1: method bodies are stubs raising NotImplementedError so the contract and
wiring are testable before the native stack is provisioned.
"""

from __future__ import annotations

from typing import Any

from geospatial_core.application.ports.raster_io import RasterIOPort
from geospatial_core.domain.value_objects import AOI, BandSet, RasterWindow


class RasterioCogAdapter(RasterIOPort):
    def __init__(self) -> None:
        try:
            import rasterio  # noqa: F401
        except ImportError as exc:  # pragma: no cover
            raise ImportError(
                "RasterioCogAdapter requires the 'geo' extra: pip install geospatial-core[geo]"
            ) from exc

    async def window_for_aoi(self, cog_uri: str, aoi: AOI, buffer_px: int = 8) -> RasterWindow:
        raise NotImplementedError("Fase 1 scaffold — see openspec/changes/2026-06-01-geospatial-core/tasks.md")

    async def read_window(
        self, band_uris: dict[str, str], window: RasterWindow, bands: BandSet
    ) -> Any:
        raise NotImplementedError("Fase 1 scaffold")

    async def apply_qa_mask(self, array: Any, qa_uri: str, window: RasterWindow) -> Any:
        raise NotImplementedError("Fase 1 scaffold")

    async def reproject(self, array: Any, src_crs: str, dst_crs: str) -> Any:
        raise NotImplementedError("Fase 1 scaffold")

    async def write_cog(self, array: Any, path: str, crs: str, build_overviews: bool = True) -> str:
        raise NotImplementedError("Fase 1 scaffold")
