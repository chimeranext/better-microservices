"""Application ports (the hexagonal contract surface).

SPDX-License-Identifier: BUSL-1.1

Every external dependency (imagery providers, rasterio, H3, opengeoai models,
map exporters) is reached only through these abstract ports. Adapters in
``geospatial_core.adapters.secondary`` implement them; the domain never imports them.
"""

from geospatial_core.application.ports.imagery_provider import ImageryProviderPort
from geospatial_core.application.ports.land_use_classifier import LandUseClassifierPort
from geospatial_core.application.ports.map_tile_export import MapTileExportPort
from geospatial_core.application.ports.raster_io import RasterIOPort
from geospatial_core.application.ports.segmentation import SegmentationPort
from geospatial_core.application.ports.spatial_index import SpatialIndexPort

__all__ = [
    "ImageryProviderPort",
    "RasterIOPort",
    "SpatialIndexPort",
    "SegmentationPort",
    "LandUseClassifierPort",
    "MapTileExportPort",
]
