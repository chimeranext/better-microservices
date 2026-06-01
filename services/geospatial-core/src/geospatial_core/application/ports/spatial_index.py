"""SpatialIndexPort — H3 hexagonal index (Uber).

SPDX-License-Identifier: BUSL-1.1

Implemented by H3Adapter (h3-py). H3 lives on BOTH sides of the render contract:
the server indexes/aggregates here; the Flutter client resolves cell geometry with
h3_flutter (ADR §3, §6). Default detail res = 11 (~0.22 ha); rollup res = 10/8.
"""

from __future__ import annotations

from abc import ABC, abstractmethod

from geospatial_core.domain.value_objects import AOI, LngLat


class SpatialIndexPort(ABC):
    @abstractmethod
    def lat_lng_to_cell(self, lat: float, lng: float, resolution: int) -> str:
        """Index a coordinate to an H3 cell id (hex string)."""

    @abstractmethod
    def polyfill(self, aoi: AOI, resolution: int) -> list[str]:
        """All H3 cells covering the AOI footprint at the given resolution."""

    @abstractmethod
    def cell_to_boundary(self, h3_id: str) -> list[LngLat]:
        """Resolve a cell id to its polygon boundary (server-side parity with h3_flutter)."""

    @abstractmethod
    def cell_to_parent(self, h3_id: str, parent_resolution: int) -> str:
        """Roll a cell up to a coarser resolution (res 11 -> 10/8)."""

    @abstractmethod
    def grid_disk(self, h3_id: str, k: int) -> list[str]:
        """k-ring neighborhood around a cell."""

    @abstractmethod
    def compact_cells(self, h3_ids: list[str]) -> list[str]:
        """Compact a uniform-resolution set into a minimal mixed-resolution set."""

    @abstractmethod
    def cell_area_m2(self, h3_id: str) -> float:
        """Exact cell area in square meters."""
