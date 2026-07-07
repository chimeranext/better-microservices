# Design: nim-nemotron-provider

## Contexto

El seam de modelos en agentic-core es:

```
domain/value_objects/model_config.py   (ModelConfig: provider, model, base_url, api_key_env, fallback)
  -> domain/services/model_resolver.py (cascada sub-agent -> persona -> runtime default)
    -> graph_templates/*.py            (instanciacion del chat model)
```

`ModelResolver` ya resuelve cualquier `ModelConfig` correctamente; el problema esta en
la instanciacion: `ReactGraphTemplate._get_model()` tiene un branch unico
`if mc.provider == "anthropic"`. Los adapters HTTP (`adapters/primary/http_api.py`)
ya usan `ChatOpenAI(base_url=...)` para endpoints OpenAI-compatible — el mismo
mecanismo sirve para NIM.

## Decisiones

### D1 — NIM via `ChatOpenAI`, no SDK propio

NIM habla el wire format OpenAI (`/chat/completions`). `langchain-openai>=0.3` ya es
dependencia del proyecto. Un SDK dedicado (`langchain-nvidia-ai-endpoints`) agregaria
una dependencia nueva sin beneficio para chat basico + tool calling.

Patron adoptado del registry multi-provider de a sibling plugin
(`reviewer-providers.ts`): provider = kind OpenAI-compatible + model slug + api key env
+ base URL; un bearer (`NVIDIA_API_KEY`) autentica todo el catalogo NIM.

### D2 — Modelo de referencia: `nvidia/nemotron-3-ultra-550b-a55b`

Verificado en build.nvidia.com como NIM publico hosted
(https://build.nvidia.com/nvidia/nemotron-3-ultra-550b-a55b). Es el tope de la familia
Nemotron 3 (Nano 30B-A3B < Super 120B-A12B < Ultra 550B-A55B). Alias `nemotron` apunta
a Ultra; Nano/Super se usan declarando el slug completo en el YAML.

### D3 — Factory en `adapters/secondary/`, no en domain

AGENTS.md: el domain es Python puro sin imports externos. La factory importa
`langchain_*`, asi que vive en `adapters/secondary/llm_factory.py` (adapter driven:
implementa la salida hacia el proveedor LLM). Los graph templates (infraestructura,
pueden depender de LangGraph/LangChain) la consumen via import lazy — mismo patron
que ya usan para `langchain_anthropic`.

```python
def build_chat_model(config: ModelConfig) -> BaseChatModel | None
```

- `nvidia`  -> `ChatOpenAI(base_url=config.base_url or NIM_BASE_URL, api_key=env(config.api_key_env or "NVIDIA_API_KEY"), model=...)`
- `openai`  -> `ChatOpenAI(...)` (base_url opcional)
- `custom`  -> `ChatOpenAI(base_url=config.base_url)` (requerido)
- `anthropic` -> `ChatAnthropic(...)` (comportamiento previo, sin cambios)
- `google` / `ollama` / `azure` -> import lazy del paquete correspondiente;
  si falta, warning + `None` (mismo contrato actual de `_get_model()`).
- `extra_params` se pasan como kwargs al constructor.

### D4 — Sin cambios en `ModelResolver` ni `ModelRegistry`

`ModelResolver` es agnostico al provider (solo cascada + fallbacks) — ya funciona.
`ModelRegistry` cataloga desde models.dev, que ya lista `nvidia` como provider
`hybrid`; no se necesita hardcodear el catalogo NIM.

## Configuracion (persona YAML)

```yaml
model_config:
  provider: nvidia
  model: nvidia/nemotron-3-ultra-550b-a55b   # o alias: nemotron
  temperature: 0.6
  max_tokens: 8192
  # base_url: http://nim.interno:8000/v1     # override para NIM self-hosted
  # api_key_env: NVIDIA_API_KEY_STAGING      # default: NVIDIA_API_KEY
```

## Testing

Unit tests con `monkeypatch` de `sys.modules` (fake `langchain_openai` /
`langchain_anthropic`) — se verifica el wiring (base_url, api key env, model id,
temperature, max_tokens, extra_params) sin red ni API keys reales. Se cubre tambien
la degradacion a `None` cuando falta el paquete y el paso de `ModelConfig` con alias.

## Riesgos

- Latencia: Ultra es un lane pesado (~55B activos); para SLOs ajustados conviene
  fallback a `nvidia/nemotron-3-super-120b-a12b` via `fallback:` en el YAML.
- NIM exige coherencia estricta role/content/tool_calls en el wire format OpenAI;
  LangChain ya serializa correctamente, pero los graph templates no deben reordenar
  mensajes manualmente.
