"""Runtime settings for geospatial-core.

SPDX-License-Identifier: BUSL-1.1
"""

from __future__ import annotations

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_prefix="GEOSPATIAL_", env_file=".env", extra="ignore")

    # H3 resolutions (ADR §3)
    h3_detail_resolution: int = 11   # ~0.22 ha parcel-interior
    h3_rollup_resolution: int = 10   # ~1.5 ha parcel-cluster
    h3_municipal_resolution: int = 8  # ~0.74 km2 district heatmap

    # Imagery provider selection rule (ADR §2): AOI <= threshold ha -> Sentinel-2, else HLS
    sentinel2_max_aoi_ha: float = 5.0
    max_cloud_pct: float = 20.0

    # CRS for Costa Rica B2G output (municipal 08USO_TIERRA_POR_ZONAS layer)
    cr_b2g_crs: str = "EPSG:5367"  # CRTM05

    # Provider default: "earth-engine" broker or "direct" COG access (owner decision, ADR §9)
    default_provider: str = "earth-engine"
