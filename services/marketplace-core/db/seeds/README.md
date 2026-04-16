# Seed data

Three self-contained seed SQL files — one per reference merchant schema —
that populate the `products` table with sample catalog data.

Each file:

- Is **idempotent** via `ON CONFLICT (slug) DO NOTHING`, so re-runs don't
  blow up a partially-seeded cluster.
- Uses **deterministic UUIDs** (`uuid_generate_v5` on a fixed namespace)
  so the same product keeps the same id across runs, which lets
  integration tests hit stable ids.
- Sets `schema_ref` to the merchant's schema (e.g.
  `schema://vertivo/hortaliza:v1`), matching what the Flutter storefront
  expects.

## Running

Requires `make up` (postgres on localhost:5432) + one-time migration
via `node dist/infrastructure/postgres/migrate.js` or the boot sequence
inside `main.ts`.

```sh
make seed-vertivo       # 20 hortalizas
make seed-habitanexus   # 10 rental properties
make seed-altrupets     # 30 pet supplies
```

Each command uses `psql` to apply its SQL file — no custom migration
framework, so diffs are trivially reviewable.

## Vendor IDs (shared)

One synthetic vendor per merchant, seeded first inside each SQL file:

| Merchant      | Vendor slug     | Vendor UUID                                |
|---------------|-----------------|--------------------------------------------|
| Vertivolatam  | `vertivo`       | `00000000-0000-4a00-8000-000000000001`    |
| HabitaNexus   | `habitanexus`   | `00000000-0000-4a00-8000-000000000002`    |
| AltruPets     | `altrupets`     | `00000000-0000-4a00-8000-000000000003`    |

These ids don't exist in a `vendors` table yet — that schema lands in
a future PR. Tables coming later can hydrate from these FK columns
without changing the seed data.
