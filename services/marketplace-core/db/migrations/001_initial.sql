-- marketplace-core — initial schema
-- Idempotent: safe to run multiple times. Adapters in this PR only read/write
-- products; variants/collections/vendors/storefronts land in a follow-up PR.

CREATE TABLE IF NOT EXISTS products (
  id            UUID PRIMARY KEY,
  vendor_id     UUID NOT NULL,
  title         TEXT NOT NULL,
  description   TEXT NOT NULL DEFAULT '',
  slug          TEXT NOT NULL UNIQUE,
  status        TEXT NOT NULL,
  product_type  TEXT NOT NULL,
  tags          TEXT[] NOT NULL DEFAULT '{}',
  schema_ref    TEXT NOT NULL,
  attributes    JSONB NOT NULL DEFAULT '{}'::jsonb,
  geo           JSONB,
  created_at    TIMESTAMPTZ NOT NULL,
  updated_at    TIMESTAMPTZ NOT NULL
);

CREATE INDEX IF NOT EXISTS products_vendor_idx     ON products (vendor_id);
CREATE INDEX IF NOT EXISTS products_status_idx     ON products (status);
CREATE INDEX IF NOT EXISTS products_product_type_idx ON products (product_type);
CREATE INDEX IF NOT EXISTS products_tags_gin       ON products USING gin (tags);
CREATE INDEX IF NOT EXISTS products_attributes_gin ON products USING gin (attributes);

-- Cursor pagination requires a stable ordering. `(created_at DESC, id)` is
-- deterministic even when multiple products share a timestamp.
CREATE INDEX IF NOT EXISTS products_cursor_idx
  ON products (created_at DESC, id);
