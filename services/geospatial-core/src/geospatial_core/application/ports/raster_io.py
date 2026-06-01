"""RasterIOPort — windowed COG reads, reprojection, tiling, band math.

SPDX-License-Identifier: BUSL-1.1

Implemented by RasterioCogAdapter (rasterio/GDAL). Reads only the AOI window and
only the needed bands; never materializes a full MGRS tile. Reprojects UTM/MGRS
<-> EPSG:5367 (CRTM05) for Costa Rica B2G output (ADR §5).
"""

from __future__ import annotations

from abc import ABC, abstractmethod
from typing import Any

from geospatial_core.domain.value_objects import AOI, BandSet, RasterWindow


class RasterIOPort(ABC):
    @abstractmethod
    async def window_for_aoi(self, cog_uri: str, aoi: AOI, buffer_px: int = 8) -> RasterWindow:
        """Compute the COG pixel window covering the AOI bbox + buffer."""

    @abstractmethod
    async def read_window(
        self, band_uris: dict[str, str], window: RasterWindow, bands: BandSet
    ) -> Any:
        """Read the window for each band -> a stacked array (adapter-typed, e.g. numpy)."""

    @abstractmethod
    async def apply_qa_mask(self, array: Any, qa_uri: str, window: RasterWindow) -> Any:
        """Mask cloud/shadow/water/snow using the HLS/Fmask QA band before classification."""

    @abstractmethod
    async def reproject(self, array: Any, src_crs: str, dst_crs: str) -> Any:
        """Reproject a derived raster (e.g. to EPSG:5367 for the municipal layer)."""

    @abstractmethod
    async def write_cog(self, array: Any, path: str, crs: str, build_overviews: bool = True) -> str:
        """Persist a derived land-use raster as Cloud-Optimized GeoTIFF with overviews."""
