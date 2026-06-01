"""SegmentationPort — mask/instance segmentation of a raster window.

SPDX-License-Identifier: BUSL-1.1

Implemented by GeoAiSamAdapter (SAM / SamGeo / GroundedSAM — footprint extraction)
and GeoAiRfDetrAdapter (RF-DETR — instance objects). Hybrid, classifier-first
(ADR §4): the classifier makes the wall-to-wall base layer; segmentation refines
built/water footprints and counts discrete structures.
"""

from __future__ import annotations

from abc import ABC, abstractmethod
from dataclasses import dataclass
from typing import Any

from geospatial_core.domain.value_objects import LngLat


@dataclass(frozen=True)
class Segment:
    """A class-agnostic (SAM) or named (RF-DETR) segment with geometry + score."""

    geometry: tuple[LngLat, ...]
    score: float
    label: str | None = None  # named for RF-DETR; None for class-agnostic SAM


class SegmentationPort(ABC):
    @property
    @abstractmethod
    def model_name(self) -> str: ...

    @abstractmethod
    async def segment(
        self, array: Any, transform: Any, text_prompt: str | None = None
    ) -> list[Segment]:
        """Segment a (tiled, georeferenced) raster window into georeferenced Segments.

        ``text_prompt`` engages GroundedSAM/CLIP zero-shot extraction when supported.
        """
