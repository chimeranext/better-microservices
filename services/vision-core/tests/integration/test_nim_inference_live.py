"""LIVE smoke test for the hosted-NIM InferencePort (NVIDIA integrate.api).

SKIPPED unless ``VISION_NVIDIA_API_KEY`` is set, so it never fails CI when the
key is absent. Proves real reachability of the hosted NIM control plane by
listing models at ``{base_url}/models`` with the configured Bearer token.
"""

from __future__ import annotations

import os

import httpx
import pytest

from vision_core.config import load_settings

pytestmark = pytest.mark.skipif(
    not os.environ.get("VISION_NVIDIA_API_KEY"),
    reason="live NIM smoke test: set VISION_NVIDIA_API_KEY to run",
)


async def test_nim_models_endpoint_reachable() -> None:
    settings = load_settings()
    assert settings.nvidia_api_key, "VISION_NVIDIA_API_KEY must be set"

    async with httpx.AsyncClient(timeout=30.0) as client:
        resp = await client.get(
            f"{settings.nvidia_base_url}/models",
            headers={"Authorization": f"Bearer {settings.nvidia_api_key}"},
        )

    assert resp.status_code == 200, resp.text
    body = resp.json()
    # OpenAI-compatible listing: {"object": "list", "data": [{"id": ...}, ...]}.
    assert isinstance(body.get("data"), list)
