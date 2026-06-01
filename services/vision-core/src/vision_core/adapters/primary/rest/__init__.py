"""REST/FastAPI primary adapter — HTTP/JSON facade over the same commands.

Agrio-style image-upload diagnosis ergonomics for the Vertivo mobile app /
dashboard. The FastAPI app is built lazily so the package imports without FastAPI
installed (extra 'rest').
"""

from __future__ import annotations

from typing import TYPE_CHECKING, Any

if TYPE_CHECKING:
    from vision_core.application.commands import SegmentImageHandler
    from vision_core.application.queries import ListModelsHandler


def create_app(
    *,
    segment_handler: SegmentImageHandler | None = None,
    list_models_handler: ListModelsHandler | None = None,
) -> Any:
    """Build the FastAPI app.

    Routes (apply Phase 3):
      * ``POST /v1/segment``        multipart image upload -> Segmentation JSON
      * ``GET  /v1/models``         list registered models
      * ``GET  /healthz``           liveness
    """

    try:
        from fastapi import FastAPI
    except ImportError as exc:  # pragma: no cover
        raise RuntimeError(
            "REST adapter needs the 'rest' extra: pip install '.[rest]'"
        ) from exc

    app = FastAPI(
        title="vision-core",
        version="0.1.0",
        summary="AgTech image & video segmentation (BUSL-1.1).",
    )

    @app.get("/healthz")
    async def healthz() -> dict[str, str]:
        return {"status": "ok"}

    # POST /v1/segment and GET /v1/models are wired to the handlers in apply
    # Phase 3 (kept out of the scaffold to avoid importing model frameworks).

    return app
