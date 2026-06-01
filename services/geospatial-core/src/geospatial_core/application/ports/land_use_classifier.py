"""LandUseClassifierPort — per-pixel/per-segment land-use class.

SPDX-License-Identifier: BUSL-1.1

Implemented by IndexThresholdClassifier (NDVI/NDWI/NDBI thresholds + a supervised
RF weak-labelled from ESA WorldCover / Dynamic World / USDA CDL). This produces the
wall-to-wall base layer every use case needs (ADR §4).
"""

from __future__ import annotations

from abc import ABC, abstractmethod
from typing import Any

from geospatial_core.domain.enums import LandUseClass


class LandUseClassifierPort(ABC):
    @property
    @abstractmethod
    def classes(self) -> list[LandUseClass]: ...

    @abstractmethod
    async def classify(self, array: Any, band_order: list[str]) -> Any:
        """Classify a stacked band array -> a per-pixel LandUseClass label array."""

    @abstractmethod
    async def confidence(self, array: Any, band_order: list[str]) -> Any:
        """Per-pixel confidence array aligned with ``classify`` output."""
