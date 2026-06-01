"""End-to-end smoke skeleton — full SegmentImage path (gRPC -> handler -> model).

Skipped until apply Phase 3 wires the gRPC server and a real/mock model adapter.
"""

from __future__ import annotations

import pytest


@pytest.mark.skip(reason="apply Phase 3: gRPC server + model wiring not yet present")
async def test_segment_image_end_to_end() -> None:  # pragma: no cover
    ...
