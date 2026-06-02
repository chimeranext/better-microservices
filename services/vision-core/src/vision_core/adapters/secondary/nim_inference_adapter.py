"""NimInferenceAdapter — InferencePort over NVIDIA's hosted NIM endpoints.

The fastest Phase-1 path to REAL inference with NO local GPU: instead of standing
up a KServe Triton/vLLM InferenceService, call NVIDIA's hosted NIM control plane
at ``https://integrate.api.nvidia.com/v1`` (build.nvidia.com). These are
OpenAI-compatible ``/v1/...`` endpoints fronting the same Triton/VLM runtimes the
in-cluster tier will eventually serve, so the model code above this port is
unchanged when we move from hosted NIM (Phase 1, no GPU) to self-hosted KServe.

Per ``InferencePort`` the wire shape is opaque ``bytes``: ``payload`` is a
pre-serialized OpenAI-style chat-completions request body (a vision/VLM model
takes a chat request whose ``content`` carries the image part); this adapter
injects ``model_id`` as the ``model`` field, POSTs to ``{base_url}/chat/completions``
with a Bearer token, and returns the raw response body bytes for the caller to
parse. SERVER-SIDE ONLY — the api_key is a secret, never expose it client-side.
"""

from __future__ import annotations

import json
from typing import TYPE_CHECKING

import httpx

from vision_core.application.ports import InferencePort

if TYPE_CHECKING:
    from vision_core.config import Settings


class NimInferenceError(RuntimeError):
    """Raised when the hosted NIM endpoint is misconfigured or returns non-2xx."""


class NimInferenceAdapter(InferencePort):
    """Hosted-NIM cloud ``InferencePort`` (Phase 1, no local GPU)."""

    def __init__(
        self,
        *,
        base_url: str,
        api_key: str,
        client: httpx.AsyncClient | None = None,
        timeout: float = 60.0,
    ) -> None:
        if not api_key:
            raise NimInferenceError(
                "NimInferenceAdapter requires a non-empty api_key "
                "(set VISION_NVIDIA_API_KEY). The hosted NIM endpoint is "
                "unusable without a bearer token."
            )
        self._base_url = base_url.rstrip("/")
        self._api_key = api_key
        self._timeout = timeout
        # Allow injecting a client (tests use httpx.MockTransport); otherwise
        # construct a lazily-closed default client.
        self._client = client or httpx.AsyncClient(timeout=timeout)

    @classmethod
    def from_settings(cls, settings: Settings) -> NimInferenceAdapter:
        """Build the adapter from the service ``Settings`` (composition root)."""
        return cls(base_url=settings.nvidia_base_url, api_key=settings.nvidia_api_key)

    async def run(self, payload: bytes, *, model_id: str) -> bytes:
        """POST the OpenAI-compatible request to the hosted NIM; return raw bytes.

        ``payload`` is a serialized chat-completions request body. ``model_id`` is
        injected as the ``model`` field so the call site need only pick a model.
        """
        try:
            body = json.loads(payload) if payload else {}
        except json.JSONDecodeError as exc:
            raise NimInferenceError(
                "payload must be a JSON-serialized OpenAI-compatible request body"
            ) from exc
        if not isinstance(body, dict):
            raise NimInferenceError(
                "payload must decode to a JSON object (the request body)"
            )
        body["model"] = model_id

        url = f"{self._base_url}/chat/completions"
        try:
            resp = await self._client.post(
                url,
                json=body,
                headers={
                    "Authorization": f"Bearer {self._api_key}",
                    "Accept": "application/json",
                },
            )
        except httpx.HTTPError as exc:
            raise NimInferenceError(
                f"hosted NIM request to {url} failed: {exc}"
            ) from exc

        if resp.status_code >= 400:
            raise NimInferenceError(
                f"hosted NIM returned {resp.status_code} for model "
                f"{model_id!r}: {resp.text}"
            )
        return resp.content

    async def is_local(self) -> bool:
        return False

    async def aclose(self) -> None:
        """Close the underlying HTTP client (call at shutdown)."""
        await self._client.aclose()
