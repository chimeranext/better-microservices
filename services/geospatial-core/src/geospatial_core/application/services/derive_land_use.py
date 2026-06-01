"""DeriveLandUseService — the no-cadastral land-use pipeline.

SPDX-License-Identifier: BUSL-1.1

Orchestrates ports only (no concrete adapters) — the hexagonal core:

    AOI
     -> ImageryProviderPort.search_scenes / fetch_cog_assets   (Sentinel-2 | HLS)
     -> RasterIOPort.window_for_aoi / read_window / apply_qa_mask  (rasterio/COG)
     -> LandUseClassifierPort.classify                          (NDVI/NDWI/NDBI + weak labels)
     -> SegmentationPort.segment  (optional refine: SAM footprints / RF-DETR objects)
     -> SpatialIndexPort.polyfill / lat_lng_to_cell / cell_to_parent  (H3)
     -> LandUseObservation  (consumed by MapTileExportPort)

Implementations of the ports are injected; this service is pure orchestration and
fully unit-testable with fakes (mirrors agentic-core's application services).
"""

from __future__ import annotations

from datetime import datetime

from geospatial_core.application.ports import (
    ImageryProviderPort,
    LandUseClassifierPort,
    RasterIOPort,
    SegmentationPort,
    SpatialIndexPort,
)
from geospatial_core.domain.enums import ImageryProvider
from geospatial_core.domain.value_objects import AOI, BandSet, LandUseObservation


class DeriveLandUseService:
    def __init__(
        self,
        *,
        sentinel2: ImageryProviderPort,
        hls: ImageryProviderPort,
        raster_io: RasterIOPort,
        classifier: LandUseClassifierPort,
        spatial_index: SpatialIndexPort,
        segmentation: SegmentationPort | None = None,
        sentinel2_max_aoi_ha: float = 5.0,
    ) -> None:
        self._sentinel2 = sentinel2
        self._hls = hls
        self._raster_io = raster_io
        self._classifier = classifier
        self._index = spatial_index
        self._segmentation = segmentation
        self._s2_max_ha = sentinel2_max_aoi_ha

    def select_provider(self, aoi: AOI, requested: ImageryProvider | None) -> ImageryProviderPort:
        """ADR §2 selection rule: small recent AOI -> Sentinel-2; municipal/multi-date -> HLS."""
        if requested is ImageryProvider.SENTINEL2:
            return self._sentinel2
        if requested is ImageryProvider.HLS:
            return self._hls
        return self._sentinel2 if aoi.approx_area_ha <= self._s2_max_ha else self._hls

    async def derive(
        self,
        aoi: AOI,
        *,
        provider: ImageryProvider | None = None,
        start: datetime | None = None,
        end: datetime | None = None,
        resolution: int = 11,
    ) -> LandUseObservation:
        """Derive a dated land-use observation for an AOI WITHOUT a cadastral map.

        NOTE: Fase-1 scaffold — adapters are skeletons; wiring is the contract under test.
        """
        imagery = self.select_provider(aoi, provider)
        scenes = await imagery.search_scenes(aoi, start, end)
        if not scenes:
            raise LookupError("no clear scene for AOI in window")
        scene = scenes[0]

        bands = BandSet()
        band_uris = await imagery.fetch_cog_assets(scene, bands)
        window = await self._raster_io.window_for_aoi(next(iter(band_uris.values())), aoi)
        stack = await self._raster_io.read_window(band_uris, window, bands)
        # QA mask if the provider exposed a QA asset (HLS/Fmask)
        if "QA" in band_uris:
            stack = await self._raster_io.apply_qa_mask(stack, band_uris["QA"], window)

        _labels = await self._classifier.classify(stack, list(bands.bands))
        # (segmentation refine + H3 aggregation happen here in the real impl)
        _ = self._segmentation  # optional footprint/object refinement
        _ = self._index.polyfill(aoi, resolution)

        return LandUseObservation(cells=(), resolution=resolution, source=scene, built_area_m2=0.0)
