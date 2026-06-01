"""Example: the gRPC call vertivolatam's Serverpod backend makes.

After `make proto`, the generated stubs live in
vision_core.adapters.primary.grpc.generated. This sketches the unary SegmentImage
call and the Segmentation -> DiseaseDetection field mapping (Vertivo-side).
"""

from __future__ import annotations

# from vision_core.adapters.primary.grpc.generated import vision_pb2, vision_pb2_grpc
# import grpc


def segment_image(image_url: str, *, crop: str = "lettuce") -> None:
    """Pseudo-code for the Vertivo client (real stubs after `make proto`)."""
    # channel = grpc.insecure_channel("vision-core.vision-core.svc:50051")
    # stub = vision_pb2_grpc.SegmentationServiceStub(channel)
    # req = vision_pb2.SegmentImageRequest(
    #     image=vision_pb2.ImageInput(url=image_url, mime_type="image/jpeg"),
    #     task=vision_pb2.TASK_DISEASE,
    #     crop_hint=crop,
    # )
    # seg = stub.SegmentImage(req).segmentation
    #
    # Vertivo maps the result onto a DiseaseDetection row:
    #   diseaseName/diseaseType <- seg.masks[0].class_name
    #   confidence              <- seg.masks[0].confidence
    #   affectedAreaPercent     <- seg.affected_area_percent
    #   severity                <- seg.severity
    #   anatomicalParts         <- [m.anatomical_part for m in seg.masks]
    #   aiModelVersion          <- seg.model_version
    #   imageUrl                <- seg.image_ref
    ...


if __name__ == "__main__":
    segment_image("https://vertivo.example/greenhouse/42/frame.jpg")
