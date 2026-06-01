"""gRPC server for vision.v1.SegmentationService.

Wires the generated servicer to the application handlers. The generated stubs
(``vision_pb2`` / ``vision_pb2_grpc``) are produced by ``make proto`` into
``generated/`` and are absent in the scaffold, so this module guards the import
and exposes ``serve()`` as the entrypoint to flesh out in apply Phase 3.
"""

from __future__ import annotations

import structlog

logger = structlog.get_logger(__name__)

GRPC_PORT = 50051


async def serve(port: int = GRPC_PORT) -> None:
    """Start the gRPC server.

    Real impl (apply Phase 3):
      * ``grpc.aio.server()`` + ``add_SegmentationServiceServicer_to_server``
      * register grpc_health.v1 + reflection
      * map SegmentImageRequest -> SegmentImageHandler -> SegmentImageResponse
      * map SegmentVideoRequest -> SegmentVideoHandler (server-streaming)
    """

    raise NotImplementedError(
        "gRPC server is a scaffold stub. Run `make proto` to generate stubs into "
        "adapters/primary/grpc/generated/, then implement serve() in apply Phase 3."
    )
