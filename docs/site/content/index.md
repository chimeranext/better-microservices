# better-microservices

**Monorepo de microservicios source-available, seleccionables de forma independiente.**

---

## Qué es

`better-microservices` reúne seis servicios que cualquier startup puede adoptar
por separado. Cada servicio conserva su propia licencia y ciclo de vida, pero
comparten un repositorio, un tracker de issues, **una convención de registro de
decisiones** (OpenSpec) y **este sitio de documentación**.

> Una pestaña por servicio + una pestaña **Common** para el material transversal.

---

## Los seis servicios

| Servicio | Stack | Estado | Qué hace |
|---|---|---|---|
| [agentic-core](agentic-core/site/docs/index.md) | Python · Go (TUI) · Dart (UI) | Activo | Runtime de agentes con adaptadores (REST, WebSocket, A2A, Ollama, WhatsApp) |
| [compliance-core](compliance-core/superpowers/specs/2026-04-16-compliance-core-design.md) | Node (pnpm) | Pre-alpha (Fase 1) | Motor de cumplimiento normativo |
| [filing-core](filing-core/superpowers/specs/2026-04-16-filing-core-design.md) | Node (skeleton) | Diferido → 2027 | Presentación automatizada de trámites/declaraciones |
| [invoice-core](invoice-core/superpowers/specs/2026-04-16-invoice-core-design.md) | Node (pnpm) | Pre-alpha (Fase 1) | Facturación electrónica |
| [marketplace-core](marketplace-core/design/standalone-mode.md) | Node · appchain · Flutter | Activo | Marketplace con esquemas JSON, reputación y modo standalone |
| [payments-core](payments-core/content/index.md) | Node (pnpm) | Skeleton + adapters | Pagos, escrow, donaciones (Stripe, OnvoPay) |

---

## Cómo navegar

- **Una pestaña por servicio** en la barra superior. Cada pestaña agrupa, en
  secciones, la documentación que vive en el propio `docs/` de ese servicio
  (specs, planes, arquitectura, referencias, API).
- **Common** — material que pertenece a varios servicios a la vez o que está
  duplicado entre ellos; consolidado una sola vez con procedencia explícita.
  Empieza por [Common → Bus de Eventos](common/eventbus-broker-analysis.md).
- **Buscador** (arriba a la derecha, en español) para saltar a cualquier página.

!!! info "Agregación sin duplicación"
    Las páginas de cada servicio **no se copian** a este sitio: se enlazan por
    *symlink* desde `services/<name>/docs/`. La fuente de verdad sigue siendo el
    `docs/` de cada servicio. Ver el ADR
    `openspec/changes/2026-06-01-docs-site/design.md`.

---

## Convención de decisiones

Cada cambio vive en `openspec/changes/<YYYY-MM-DD-slug>/` con los registros que
amerite: **PDR** (`proposal.md`, qué/para quién/por qué), **ADR** (`design.md`,
qué tecnología/cómo) y **`tasks.md`**. Ver `openspec/project.md`.
