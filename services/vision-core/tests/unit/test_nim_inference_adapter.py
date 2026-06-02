"""Unit tests for NimInferenceAdapter — the Phase-1 hosted-NIM InferencePort.

The HTTP layer is fully mocked (httpx MockTransport) so no live network is hit.
These assert the adapter (a) POSTs to the right OpenAI-compatible NIM URL with a
Bearer header, (b) injects model_id + forwards the payload, (c) returns the raw
response bytes on 2xx, (d) raises on non-2xx and on an empty api_key, and (e)
reports is_local() False (it is a hosted cloud endpoint).
"""

from __future__ import annotations

import json

import httpx
import pytest

from vision_core.adapters.secondary.nim_inference_adapter import (
    NimInferenceAdapter,
    NimInferenceError,
)

_BASE_URL = "https://integrate.api.nvidia.com/v1"
# Harmless placeholder, never a real credential — only asserts the adapter
# forwards whatever bearer token it is handed.
_FAKE_TOKEN = "x" * 16  # noqa: S105  (test fixture, not a secret)


def _adapter(handler: httpx.MockTransport) -> NimInferenceAdapter:
    client = httpx.AsyncClient(transport=handler)
    return NimInferenceAdapter(
        base_url=_BASE_URL, api_key=_FAKE_TOKEN, client=client
    )


async def test_run_posts_to_chat_completions_with_bearer_and_model_id() -> None:
    captured: dict[str, object] = {}

    def handler(request: httpx.Request) -> httpx.Response:
        captured["url"] = str(request.url)
        captured["auth"] = request.headers.get("authorization")
        captured["body"] = json.loads(request.content)
        return httpx.Response(200, json={"id": "cmpl-1", "choices": []})

    adapter = _adapter(httpx.MockTransport(handler))
    payload = json.dumps(
        {"messages": [{"role": "user", "content": "diagnose"}]}
    ).encode()

    await adapter.run(payload, model_id="meta/llama-3.2-11b-vision-instruct")

    assert captured["url"] == f"{_BASE_URL}/chat/completions"
    assert captured["auth"] == "Bearer " + _FAKE_TOKEN
    body = captured["body"]
    assert isinstance(body, dict)
    # model_id is injected into the request body.
    assert body["model"] == "meta/llama-3.2-11b-vision-instruct"
    # the caller's payload is forwarded.
    assert body["messages"] == [{"role": "user", "content": "diagnose"}]


async def test_run_returns_raw_response_bytes_on_2xx() -> None:
    def handler(_: httpx.Request) -> httpx.Response:
        return httpx.Response(200, json={"choices": [{"text": "ok"}]})

    adapter = _adapter(httpx.MockTransport(handler))
    out = await adapter.run(b"{}", model_id="m")

    assert isinstance(out, bytes)
    assert json.loads(out)["choices"][0]["text"] == "ok"


async def test_run_raises_on_non_2xx() -> None:
    def handler(_: httpx.Request) -> httpx.Response:
        return httpx.Response(401, json={"error": "unauthorized"})

    adapter = _adapter(httpx.MockTransport(handler))
    with pytest.raises(NimInferenceError) as exc:
        await adapter.run(b"{}", model_id="m")
    assert "401" in str(exc.value)


async def test_constructing_with_empty_api_key_raises() -> None:
    with pytest.raises(NimInferenceError):
        NimInferenceAdapter(base_url=_BASE_URL, api_key="")


async def test_is_local_is_false() -> None:
    adapter = _adapter(httpx.MockTransport(lambda r: httpx.Response(200, json={})))
    assert await adapter.is_local() is False


async def test_from_settings_builds_cloud_adapter() -> None:
    from vision_core.config import Settings

    settings = Settings(inference_local=False, nvidia_api_key=_FAKE_TOKEN)
    adapter = NimInferenceAdapter.from_settings(settings)
    assert await adapter.is_local() is False
    await adapter.aclose()


async def test_build_inference_port_selects_nim_when_key_set() -> None:
    from vision_core.config import Settings
    from vision_core.runtime import build_inference_port

    settings = Settings(inference_local=False, nvidia_api_key=_FAKE_TOKEN)
    port = build_inference_port(settings)
    assert isinstance(port, NimInferenceAdapter)
    assert await port.is_local() is False
    await port.aclose()


async def test_build_inference_port_without_key_does_not_pick_nim() -> None:
    from vision_core.config import Settings
    from vision_core.runtime import build_inference_port

    settings = Settings(inference_local=False, nvidia_api_key="")
    with pytest.raises(NotImplementedError):
        build_inference_port(settings)
