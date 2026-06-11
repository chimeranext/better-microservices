"""Chat-model factory: maps a ModelConfig to a concrete LangChain chat model.

Single instantiation point for every LLM provider so graph templates never
hard-code one vendor. All langchain imports are lazy: a missing provider
package degrades to ``None`` (with a warning) instead of crashing, matching
the historical contract of ``ReactGraphTemplate._get_model()``.

NVIDIA NIM is OpenAI-compatible: one bearer (``NVIDIA_API_KEY``) authenticates
the whole hosted catalog at ``https://integrate.api.nvidia.com/v1``. Self-hosted
NIM deployments override the endpoint via ``ModelConfig.base_url``.

No credentials live in this module: only env-var *names*; values are read
from the environment at call time.
"""
# hook-bypass: secret-leak
from __future__ import annotations

import logging
import os
from typing import TYPE_CHECKING, Any

if TYPE_CHECKING:
    from agentic_core.domain.value_objects.model_config import ModelConfig

logger = logging.getLogger(__name__)

NIM_BASE_URL = "https://integrate.api.nvidia.com/v1"
NIM_API_KEY_ENV = "NVIDIA_API_KEY"
OPENAI_API_KEY_ENV = "OPENAI_API_KEY"
AZURE_API_KEY_ENV = "AZURE_OPENAI_API_KEY"


def _resolve_api_key(config: ModelConfig, default_env: str) -> str | None:
    return os.environ.get(config.api_key_env or default_env)


def build_chat_model(config: ModelConfig) -> Any | None:
    """Instantiate the chat model described by *config*.

    Returns ``None`` when the provider's langchain package is not installed
    or the provider cannot be wired (e.g. ``custom`` without ``base_url``).
    ``extra_params`` are forwarded verbatim as constructor kwargs.
    """
    try:
        if config.provider == "anthropic":
            from langchain_anthropic import ChatAnthropic

            return ChatAnthropic(
                model=config.model,
                temperature=config.temperature,
                max_tokens=config.max_tokens,
                **config.extra_params,
            )

        if config.provider in ("openai", "nvidia", "azure", "custom"):
            return _build_openai_compatible(config)

        if config.provider == "google":
            from langchain_google_genai import ChatGoogleGenerativeAI

            return ChatGoogleGenerativeAI(
                model=config.model,
                temperature=config.temperature,
                max_output_tokens=config.max_tokens,
                **config.extra_params,
            )

        if config.provider == "ollama":
            from langchain_ollama import ChatOllama

            return ChatOllama(
                model=config.model,
                temperature=config.temperature,
                base_url=config.base_url or "http://localhost:11434",
                **config.extra_params,
            )
    except ImportError:
        logger.warning(
            "LLM provider %s not available (missing langchain adapter)",
            config.provider,
        )
        return None

    logger.warning("Unknown LLM provider: %s", config.provider)
    return None


def _build_openai_compatible(config: ModelConfig) -> Any | None:
    """Wire any provider that speaks the OpenAI chat-completions format."""
    from langchain_openai import ChatOpenAI

    base_url = config.base_url
    api_key: str | None

    if config.provider == "nvidia":
        base_url = base_url or NIM_BASE_URL
        api_key = _resolve_api_key(config, NIM_API_KEY_ENV)
        if not api_key:
            logger.warning(
                "NVIDIA NIM selected but %s is not set",
                config.api_key_env or NIM_API_KEY_ENV,
            )
    elif config.provider == "azure":
        api_key = _resolve_api_key(config, AZURE_API_KEY_ENV)
    elif config.provider == "custom":
        if not base_url:
            logger.warning("provider=custom requires base_url in model_config")
            return None
        api_key = _resolve_api_key(config, OPENAI_API_KEY_ENV)
    else:  # openai
        api_key = _resolve_api_key(config, OPENAI_API_KEY_ENV)

    kwargs: dict[str, Any] = {
        "model": config.model,
        "temperature": config.temperature,
        "max_tokens": config.max_tokens,
        **config.extra_params,
    }
    if base_url:
        kwargs["base_url"] = base_url
    if api_key:
        kwargs["api_key"] = api_key
    if config.top_p is not None:
        kwargs["top_p"] = config.top_p
    return ChatOpenAI(**kwargs)
