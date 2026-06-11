"""Unit tests for the chat-model factory (nim-nemotron-provider).

All provider SDKs are faked via sys.modules — no network, no real API keys.
"""
from __future__ import annotations

import sys
import types

import pytest

from agentic_core.adapters.secondary.llm_factory import (
    NIM_BASE_URL,
    build_chat_model,
)
from agentic_core.domain.value_objects.model_config import ModelConfig


class _FakeChatModel:
    def __init__(self, **kwargs):
        self.kwargs = kwargs


def _fake_module(class_name: str) -> types.ModuleType:
    mod = types.ModuleType("fake")
    setattr(mod, class_name, _FakeChatModel)
    return mod


@pytest.fixture
def fake_openai(monkeypatch):
    monkeypatch.setitem(sys.modules, "langchain_openai", _fake_module("ChatOpenAI"))


@pytest.fixture
def fake_anthropic(monkeypatch):
    monkeypatch.setitem(
        sys.modules, "langchain_anthropic", _fake_module("ChatAnthropic"),
    )


# --- NVIDIA NIM ---


def test_nvidia_defaults_to_nim_endpoint(fake_openai, monkeypatch):
    monkeypatch.setenv("NVIDIA_API_KEY", "fake-key")
    mc = ModelConfig(
        provider="nvidia",
        model="nvidia/nemotron-3-ultra-550b-a55b",
        temperature=0.6,
        max_tokens=8192,
    )
    llm = build_chat_model(mc)
    assert isinstance(llm, _FakeChatModel)
    assert llm.kwargs["base_url"] == NIM_BASE_URL
    assert llm.kwargs["api_key"] == "fake-key"
    assert llm.kwargs["model"] == "nvidia/nemotron-3-ultra-550b-a55b"
    assert llm.kwargs["temperature"] == 0.6
    assert llm.kwargs["max_tokens"] == 8192


def test_nvidia_alias_nemotron_resolves_to_ultra(fake_openai, monkeypatch):
    monkeypatch.setenv("NVIDIA_API_KEY", "fake-key")
    llm = build_chat_model(ModelConfig(model="nemotron"))
    assert llm.kwargs["model"] == "nvidia/nemotron-3-ultra-550b-a55b"
    assert llm.kwargs["base_url"] == NIM_BASE_URL


def test_nvidia_custom_key_env(fake_openai, monkeypatch):
    monkeypatch.delenv("NVIDIA_API_KEY", raising=False)
    monkeypatch.setenv("NVIDIA_API_KEY_STAGING", "staging-k")
    mc = ModelConfig(
        provider="nvidia",
        model="nvidia/nemotron-3-super-120b-a12b",
        api_key_env="NVIDIA_API_KEY_STAGING",
    )
    llm = build_chat_model(mc)
    assert llm.kwargs["api_key"] == "staging-k"


def test_nvidia_self_hosted_base_url_override(fake_openai, monkeypatch):
    monkeypatch.setenv("NVIDIA_API_KEY", "fake-key")
    mc = ModelConfig(
        provider="nvidia",
        model="nvidia/nemotron-3-nano-30b-a3b",
        base_url="http://nim.internal:8000/v1",
    )
    llm = build_chat_model(mc)
    assert llm.kwargs["base_url"] == "http://nim.internal:8000/v1"


def test_nvidia_missing_key_warns_but_builds(fake_openai, monkeypatch, caplog):
    monkeypatch.delenv("NVIDIA_API_KEY", raising=False)
    llm = build_chat_model(ModelConfig(model="nemotron"))
    assert isinstance(llm, _FakeChatModel)
    assert "api_key" not in llm.kwargs
    assert any("NVIDIA NIM" in r.message for r in caplog.records)


def test_nvidia_extra_params_and_top_p_forwarded(fake_openai, monkeypatch):
    monkeypatch.setenv("NVIDIA_API_KEY", "fake-key")
    mc = ModelConfig(
        provider="nvidia",
        model="nvidia/nemotron-3-ultra-550b-a55b",
        top_p=0.95,
        extra_params={"frequency_penalty": 0.1},
    )
    llm = build_chat_model(mc)
    assert llm.kwargs["top_p"] == 0.95
    assert llm.kwargs["frequency_penalty"] == 0.1


# --- Other providers (regression: factory keeps previous behavior) ---


def test_anthropic_uses_chat_anthropic(fake_anthropic):
    mc = ModelConfig(provider="anthropic", model="claude-sonnet-4-6")
    llm = build_chat_model(mc)
    assert isinstance(llm, _FakeChatModel)
    assert llm.kwargs["model"] == "claude-sonnet-4-6"
    assert "base_url" not in llm.kwargs


def test_openai_without_base_url(fake_openai, monkeypatch):
    monkeypatch.setenv("OPENAI_API_KEY", "fake-key")
    llm = build_chat_model(ModelConfig(provider="openai", model="gpt-4o"))
    assert "base_url" not in llm.kwargs
    assert llm.kwargs["model"] == "gpt-4o"


def test_custom_requires_base_url(fake_openai):
    llm = build_chat_model(ModelConfig(provider="custom", model="any"))
    assert llm is None


def test_custom_with_base_url(fake_openai):
    mc = ModelConfig(
        provider="custom", model="any", base_url="http://localhost:1234/v1",
    )
    llm = build_chat_model(mc)
    assert llm.kwargs["base_url"] == "http://localhost:1234/v1"


def test_missing_package_returns_none(monkeypatch):
    monkeypatch.setitem(sys.modules, "langchain_google_genai", None)
    mc = ModelConfig(provider="google", model="gemini-2.5-pro")
    assert build_chat_model(mc) is None


# --- Integration with ReactGraphTemplate._get_model ---


def test_react_template_resolves_nim_model(fake_openai, monkeypatch):
    monkeypatch.setenv("NVIDIA_API_KEY", "fake-key")
    from agentic_core.graph_templates.react import ReactGraphTemplate

    template = ReactGraphTemplate(model_config=ModelConfig(model="nemotron"))
    llm = template._get_model()
    assert isinstance(llm, _FakeChatModel)
    assert llm.kwargs["model"] == "nvidia/nemotron-3-ultra-550b-a55b"
    assert llm.kwargs["base_url"] == NIM_BASE_URL
