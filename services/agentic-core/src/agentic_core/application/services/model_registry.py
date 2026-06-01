"""Model registry that fetches from models.dev and caches locally.

Categorizes models as:
  - cloud:  API-only, closed weights (e.g. GPT-4o, Grok 4.3, Kimi K2)
  - local:  Open weights, runnable via Ollama/LM Studio/vLLM (e.g. Granite 4.1, DeepSeek)
  - hybrid: Available both as API and local inference (varies by provider)

Shared by the Go TUI, Flutter UI, and any client via GET /api/models.
"""

from __future__ import annotations

import json
import logging
import os
import time
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

import aiohttp

logger = logging.getLogger(__name__)

MODELS_API_URL = "https://models.dev/api.json"
CACHE_TTL = 3600  # 1 hour
LOCAL_PROVIDERS = {
    "ollama": {"name": "Ollama", "api": "http://localhost:11434/v1", "type": "local"},
    "lmstudio": {"name": "LM Studio", "api": "http://127.0.0.1:1234/v1", "type": "local"},
    "vllm": {"name": "vLLM (Sidecar)", "api": "http://127.0.0.1:8000/v1", "type": "local"},
}
WELL_KNOWN_PROVIDERS: dict[str, dict[str, str]] = {
    "openai": {"name": "OpenAI", "type": "cloud"},
    "anthropic": {"name": "Anthropic", "type": "cloud"},
    "google": {"name": "Google", "type": "cloud"},
    "deepseek": {"name": "DeepSeek", "type": "hybrid"},
    "meta": {"name": "Meta", "type": "local"},
    "mistral": {"name": "Mistral", "type": "hybrid"},
    "groq": {"name": "Groq", "type": "cloud"},
    "together": {"name": "Together", "type": "cloud"},
    "openrouter": {"name": "OpenRouter", "type": "cloud"},
    "fireworks-ai": {"name": "Fireworks AI", "type": "cloud"},
    "perplexity": {"name": "Perplexity", "type": "cloud"},
    "cohere": {"name": "Cohere", "type": "cloud"},
    "xai": {"name": "xAI", "type": "cloud"},
    "replicate": {"name": "Replicate", "type": "cloud"},
    "amazon": {"name": "AWS Bedrock", "type": "cloud"},
    "azure": {"name": "Azure", "type": "cloud"},
    "ibm": {"name": "IBM Watsonx", "type": "cloud"},
    "huggingface": {"name": "Hugging Face", "type": "hybrid"},
    "alibaba": {"name": "Alibaba Cloud", "type": "cloud"},
    "nvidia": {"name": "NVIDIA", "type": "hybrid"},
    "scaleway": {"name": "Scaleway", "type": "cloud"},
    "abacus": {"name": "Abacus AI", "type": "cloud"},
    "nano-gpt": {"name": "Nano GPT", "type": "cloud"},
    "ai21": {"name": "AI21", "type": "cloud"},
    "kimi": {"name": "Kimi (Moonshot)", "type": "cloud"},
    "moonshot": {"name": "Moonshot AI", "type": "cloud"},
    "ollama-cloud": {"name": "Ollama Cloud", "type": "hybrid"},
}


@dataclass
class ModelEntry:
    id: str  # "openai/gpt-4o"
    provider: str  # "OpenAI"
    name: str  # "GPT-4o"
    type: str = "cloud"  # "cloud" | "local" | "hybrid"
    tool_call: bool = True
    reasoning: bool = False
    open_weights: bool = False
    api_base: str = ""  # Provider API endpoint if available


class ModelRegistry:
    """Fetches, caches, and serves the model catalog from models.dev."""

    def __init__(
        self,
        api_url: str = MODELS_API_URL,
        cache_dir: str | None = None,
        ttl: int = CACHE_TTL,
    ) -> None:
        self._api_url = api_url
        self._ttl = ttl
        self._entries: list[ModelEntry] = []
        self._last_fetch: float = 0
        self._cache_path = self._resolve_cache_path(cache_dir)

    def _resolve_cache_path(self, cache_dir: str | None) -> Path:
        if cache_dir:
            return Path(cache_dir) / "models.json"
        xdg = os.environ.get("XDG_CACHE_HOME")
        if xdg:
            return Path(xdg) / "agentic-core" / "models.json"
        home = os.environ.get("HOME", "")
        if home and home != "/nonexistent" and os.path.isdir(home):
            return Path(home) / ".cache" / "agentic-core" / "models.json"
        return Path("/tmp/agentic-cache") / "models.json"

    @property
    def entries(self) -> list[ModelEntry]:
        if not self._entries or (time.time() - self._last_fetch > self._ttl):
            self._try_load_cache()
        return list(self._entries)

    @property
    def count(self) -> int:
        return len(self.entries)

    async def refresh(self) -> None:
        await self._fetch()
        self._save_cache()

    def list_models(self, tool_call_only: bool = True) -> list[dict[str, Any]]:
        result = []
        for e in self.entries:
            if tool_call_only and not e.tool_call:
                continue
            result.append({
                "id": e.id,
                "provider": e.provider,
                "name": e.name,
                "type": e.type,
                "tool_call": e.tool_call,
                "reasoning": e.reasoning,
                "open_weights": e.open_weights,
                "api_base": e.api_base,
            })
        return result

    def format_for_picker(self) -> list[dict[str, str]]:
        return [
            {
                "id": e.id,
                "display": self._format_display(e),
                "provider": e.provider,
                "type": e.type,
            }
            for e in self.entries
            if e.tool_call
        ]

    def _format_display(self, e: ModelEntry) -> str:
        tag = {"cloud": "\u2601", "local": "\ud83d\udcbb", "hybrid": "\u2601\ud83d\udcbb"}.get(e.type, "")
        return f"{e.id} -- {e.name}  {tag}"

    def _try_load_cache(self) -> None:
        try:
            if not self._cache_path.exists():
                return None
            data = json.loads(self._cache_path.read_text())
            fetched_at = data.get("fetched_at", 0)
            if time.time() - fetched_at > self._ttl:
                return None
            self._entries = [ModelEntry(**e) for e in data.get("entries", [])]
            self._last_fetch = fetched_at
            logger.debug("Loaded %d models from cache", len(self._entries))
        except Exception:
            logger.debug("Failed to load model cache", exc_info=True)

    def _save_cache(self) -> None:
        try:
            self._cache_path.parent.mkdir(parents=True, exist_ok=True)
            data = {
                "fetched_at": self._last_fetch,
                "entries": [
                    {
                        "id": e.id,
                        "provider": e.provider,
                        "name": e.name,
                        "type": e.type,
                        "tool_call": e.tool_call,
                        "reasoning": e.reasoning,
                        "open_weights": e.open_weights,
                        "api_base": e.api_base,
                    }
                    for e in self._entries
                ],
            }
            self._cache_path.write_text(json.dumps(data, indent=2))
            logger.debug("Saved %d models to cache", len(self._entries))
        except Exception:
            logger.warning("Failed to save model cache", exc_info=True)

    async def _fetch(self) -> None:
        try:
            async with aiohttp.ClientSession() as session:
                async with session.get(self._api_url, timeout=aiohttp.ClientTimeout(total=30)) as resp:
                    if resp.status != 200:
                        logger.warning("models.dev returned %d", resp.status)
                        return
                    data = await resp.json()
        except Exception as exc:
            logger.warning("Failed to fetch models from %s: %s", self._api_url, exc)
            return

        entries: list[ModelEntry] = []
        seen: set[str] = set()

        for provider_id, provider in data.items():
            provider_meta = WELL_KNOWN_PROVIDERS.get(provider_id, {"name": provider_id, "type": "cloud"})
            provider_name = provider_meta["name"]
            api_base = provider.get("api", "")

            models = provider.get("models", {})
            for model_id, model in models.items():
                tool_call = model.get("tool_call", False)
                if not tool_call:
                    continue
                full_id = f"{provider_id}/{model_id}"
                if full_id in seen:
                    continue
                seen.add(full_id)

                open_weights = model.get("open_weights", False)

                # Determine type: open_weights → local, cloud API → cloud, both → hybrid
                if open_weights:
                    if provider_meta["type"] == "cloud":
                        model_type = "local"
                    else:
                        model_type = provider_meta["type"]
                else:
                    model_type = "cloud"

                entries.append(ModelEntry(
                    id=full_id,
                    provider=provider_name,
                    name=model.get("name", model_id),
                    type=model_type,
                    tool_call=tool_call,
                    reasoning=model.get("reasoning", False),
                    open_weights=open_weights,
                    api_base=api_base,
                ))

        entries.sort(key=lambda e: (e.type, e.provider, e.name))
        self._entries = entries
        self._last_fetch = time.time()
        cloud = sum(1 for e in entries if e.type == "cloud")
        local = sum(1 for e in entries if e.type == "local")
        hybrid = sum(1 for e in entries if e.type == "hybrid")
        logger.info("Fetched %d models: %d cloud, %d local, %d hybrid",
                     len(entries), cloud, local, hybrid)
