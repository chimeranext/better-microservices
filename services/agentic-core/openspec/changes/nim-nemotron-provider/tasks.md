# Tasks: nim-nemotron-provider

## Domain (HIGH)
- [ ] **NIMP-01** `provider: nvidia` en `ProviderType` + alias `nemotron` en `MODEL_ALIASES`
- [ ] **NIMP-02** Actualizar tests de `ModelConfig` (provider nvidia, alias, set de aliases)

## Adapters (HIGH)
- [ ] **NIMP-03** `adapters/secondary/llm_factory.py` — `build_chat_model(ModelConfig)` multi-provider
- [ ] **NIMP-04** `ReactGraphTemplate._get_model()` delega a la factory
- [ ] **NIMP-05** Tests unitarios de la factory con mocks (sin API real)

## Docs & Examples (MEDIUM)
- [ ] **NIMP-06** Persona de ejemplo `examples/simple_react_agent/persona-nim.yaml`
- [ ] **NIMP-07** Marcar NM-04 como cubierto en `openspec/changes/nvidia-nemoclaw/tasks.md`

## Validation (HIGH)
- [ ] **NIMP-08** `pytest` suite completa verde
- [ ] **NIMP-09** `ruff check` verde
