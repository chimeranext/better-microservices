"""ImageryProviderPort — discover and fetch imagery for an AOI + time window.

SPDX-License-Identifier: BUSL-1.1

Implemented by Sentinel2Adapter (10 m, 5-day), HlsAdapter (30 m, ~2-3 day, COG)
and EarthEngineAdapter (broker over both + weak-label sources). Selection rule
(ADR §2): AOI <= ~5 ha -> Sentinel-2; municipal-scale / multi-date -> HLS.
"""

from __future__ import annotations

from abc import ABC, abstractmethod
from datetime import datetime

from geospatial_core.domain.enums import ImageryProvider
from geospatial_core.domain.value_objects import AOI, BandSet, SourceInfo


class ImageryProviderPort(ABC):
    @property
    @abstractmethod
    def provider(self) -> ImageryProvider: ...

    @abstractmethod
    async def search_scenes(
        self,
        aoi: AOI,
        start: datetime | None = None,
        end: datetime | None = None,
        max_cloud_pct: float = 20.0,
    ) -> list[SourceInfo]:
        """Return candidate clear scenes intersecting the AOI, newest first."""

    @abstractmethod
    async def fetch_cog_assets(
        self, scene: SourceInfo, bands: BandSet
    ) -> dict[str, str]:
        """Resolve band -> COG URI (HTTP-range readable) for a chosen scene."""
