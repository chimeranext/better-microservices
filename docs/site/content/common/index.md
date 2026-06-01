# Common — Material transversal

La pestaña **Common** reúne documentación que **no pertenece a un único
servicio**, sino que es compartida o transversal a varios de ellos. En un
monorepo de microservicios independientemente seleccionables, parte del material
(contratos de plataforma, decisiones del bus de eventos, estándares de sidecar)
aplica a más de un servicio a la vez. Duplicar ese material en cada
`services/<name>/docs/` provoca **divergencia silenciosa**: una copia se edita y
las demás quedan obsoletas.

Esta sección es la **fuente canónica única** para ese material, con procedencia
explícita hacia los servicios afectados.

## ¿Qué cuenta como "Common"?

| Criterio | Ejemplo |
|---|---|
| El documento **describe varios servicios a la vez** | Análisis del bus de eventos (une marketplace, payments, invoice, compliance) |
| Existe **duplicado idéntico** en varios `services/*/docs/` | `eventbus-broker-analysis.md` (md5 idéntico en 5 servicios) |
| Define un **contrato de plataforma** que todos consumen | Estándares de sidecar, gRPC Health v1, adaptador EventBus (dominio `platform`) |

Esto mapea a los dominios no desplegables `common` y `platform` definidos en
`openspec/project.md`.

## Contenido

| Documento | Origen | Por qué es Common |
|---|---|---|
| [Análisis del Bus de Eventos](eventbus-broker-analysis.md) | Duplicado idéntico en `agentic-core`, `compliance-core`, `invoice-core`, `marketplace-core`, `payments-core` (`docs/architecture/`) | Decisión de broker que acopla 4 servicios internos + pasarelas + apps Dart |

!!! note "Procedencia"
    Cada documento consolidado conserva una cabecera `provenance` con el md5 del
    original y las rutas exactas de las copias por servicio. Si un servicio
    necesita una variante propia, debe **bifurcarla explícitamente** dentro de su
    `docs/`, no editar la copia Common.
