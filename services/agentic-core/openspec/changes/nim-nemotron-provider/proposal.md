# Cambio: nim-nemotron-provider

**Change ID:** nim-nemotron-provider
**Fecha:** 2026-06-10
**Branch:** feat/nim-nemotron-provider
**Relacionado:** nvidia-nemoclaw (NM-04 "Adapter para NVIDIA NIM como LLM provider")

## Que

Soporte de primera clase para **NVIDIA NIM** como provider LLM en agentic-core, con
**Nemotron 3 Ultra** (`nvidia/nemotron-3-ultra-550b-a55b`) como modelo de referencia,
configurable desde el `model_config` de una persona YAML sin tocar codigo.

## Por que

- NIM expone un endpoint OpenAI-compatible (`https://integrate.api.nvidia.com/v1`) con
  un solo bearer (`NVIDIA_API_KEY`) para todo el catalogo — agregar modelos es solo config.
- Nemotron 3 Ultra (MoE 550B total / 55B activos, hybrid Mamba-Transformer) esta
  optimizado para agentes de larga duracion con reasoning — el caso de uso central
  de los graph templates de agentic-core.
- Hoy `ReactGraphTemplate._get_model()` solo instancia `ChatAnthropic`; cualquier otro
  provider declarado en una persona se ignora silenciosamente. Este cambio cierra ese gap
  con una factory unica para todos los providers.

## Alcance

### Incluido
- `provider: nvidia` en `ModelConfig` (domain value object) + alias `nemotron`.
- Factory de chat models (`adapters/secondary/llm_factory.py`) que mapea
  `ModelConfig -> BaseChatModel` para anthropic / openai / nvidia / google / ollama /
  azure / custom, con imports lazy y degradacion a `None` si falta el paquete.
- `ReactGraphTemplate._get_model()` delega a la factory (se elimina el branch
  hardcodeado anthropic-only).
- Persona de ejemplo usando NIM (`examples/simple_react_agent/persona-nim.yaml`).
- Tests unitarios con mocks — sin llamadas reales a la API.

### Excluido
- Benchmarks de latencia NIM vs otros providers (NM-03, queda en nvidia-nemoclaw).
- Patrones de coordinacion NemoClaw en LaneOrchestrator (NM-05).
- Cambios al catalogo `ModelRegistry` (models.dev ya lista a nvidia como provider hybrid).
- Self-hosted NIM (solo hosted endpoint; `base_url` ya permite override para on-prem).

## Impacto

- Sin breaking changes: personas existentes siguen funcionando igual.
- `MODEL_ALIASES` gana la clave `nemotron`; el test del set de aliases se actualiza.
- Nueva variable de entorno opcional: `NVIDIA_API_KEY`.
