"""S3fsObjectStorageAdapter — ObjectStoragePort over MinIO/S3 via ``s3fs``.

The data backbone of the MLOps stack. CRITICAL workaround (ISS/Kubeflow case
study, design.md section 6): KServe, Katib and PyTorchJob do NOT integrate with
KFP's native artifact passing, so every pipeline component — and vision-core
itself — reads/writes model weights + COCO-style datasets + captures DIRECTLY
from MinIO/S3 over ``s3fs``, not through KFP outputs/inputs.

Scaffold stub: methods raise NotImplementedError. Real impl (apply Phase 3)
constructs an ``s3fs.S3FileSystem(key=..., secret=..., client_kwargs={
"endpoint_url": MINIO_URL})`` and proxies reads/writes. Requires the 'cloud'
extra (s3fs).
"""

from __future__ import annotations

from vision_core.application.ports import ObjectStoragePort

_NOT_IMPL = (
    "S3fsObjectStorageAdapter is a scaffold stub. Install the 'cloud' extra "
    "(s3fs) and wire the MinIO endpoint in apply Phase 3."
)


class S3fsObjectStorageAdapter(ObjectStoragePort):
    def __init__(
        self,
        *,
        endpoint_url: str = "http://minio.vision-core.svc:9000",
        key: str = "",
        secret: str = "",
    ) -> None:
        self._endpoint_url = endpoint_url
        self._key = key
        self._secret = secret
        # apply Phase 3: self._fs = s3fs.S3FileSystem(key=key, secret=secret,
        #     client_kwargs={"endpoint_url": endpoint_url})

    async def get_bytes(self, ref: str) -> bytes:
        raise NotImplementedError(_NOT_IMPL)

    async def put_bytes(self, ref: str, data: bytes) -> None:
        raise NotImplementedError(_NOT_IMPL)

    async def exists(self, ref: str) -> bool:
        raise NotImplementedError(_NOT_IMPL)

    async def list_prefix(self, prefix: str) -> list[str]:
        raise NotImplementedError(_NOT_IMPL)
