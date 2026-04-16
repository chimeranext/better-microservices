-- Vertivolatam — 20 hortalizas frescas
-- Seed data for the Vertivo storefront. Idempotent: re-runs skip existing slugs.

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

BEGIN;

-- Namespace UUID for slug-derived ids (stable across runs).
-- uuid_generate_v5(namespace, slug) → deterministic UUID.
-- Vendor: vertivo (hardcoded so future vendors table can FK to this id).

INSERT INTO products (
  id, vendor_id, title, description, slug, status, product_type,
  tags, schema_ref, attributes, geo, created_at, updated_at
) VALUES
  (uuid_generate_v5('00000000-0000-0000-0000-000000000001'::uuid, 'lechuga-romana-organica'),
   '00000000-0000-4a00-8000-000000000001'::uuid,
   'Lechuga Romana Orgánica',
   'Lechuga Romana cosechada el mismo día, sin pesticidas.',
   'lechuga-romana-organica', 'ACTIVE', 'hortaliza',
   ARRAY['lechuga', 'organico', 'fresco'],
   'schema://vertivo/hortaliza:v1',
   '{"harvestDate":"2026-04-15","greenhouseId":"gh-01","sensorReadings":[20.1,22.3,21.8],"originGeo":{"lat":9.93,"lng":-84.08},"organic":true,"blockchainQrUrl":"https://ver.tiv.o/q/lrom01"}'::jsonb,
   '{"lat":9.93,"lng":-84.08,"address":"Sabanilla","city":"San Jose","state":"SJ","country":"CR"}'::jsonb,
   NOW() - INTERVAL '1 day', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000001'::uuid, 'tomate-cherry'),
   '00000000-0000-4a00-8000-000000000001'::uuid,
   'Tomate Cherry',
   'Tomates cherry dulces, ideales para ensaladas.',
   'tomate-cherry', 'ACTIVE', 'hortaliza',
   ARRAY['tomate', 'fresco'], 'schema://vertivo/hortaliza:v1',
   '{"harvestDate":"2026-04-14","greenhouseId":"gh-01","sensorReadings":[19.5,21.2],"originGeo":{"lat":9.93,"lng":-84.08},"organic":false,"blockchainQrUrl":"https://ver.tiv.o/q/tch01"}'::jsonb,
   '{"lat":9.93,"lng":-84.08,"address":"Sabanilla","city":"San Jose","state":"SJ","country":"CR"}'::jsonb,
   NOW() - INTERVAL '2 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000001'::uuid, 'albahaca-fresca'),
   '00000000-0000-4a00-8000-000000000001'::uuid,
   'Albahaca Fresca',
   'Albahaca recién cortada con aroma intenso.',
   'albahaca-fresca', 'ACTIVE', 'hierba',
   ARRAY['albahaca', 'hierba'], 'schema://vertivo/hortaliza:v1',
   '{"harvestDate":"2026-04-15","greenhouseId":"gh-02","organic":true}'::jsonb,
   NULL, NOW() - INTERVAL '3 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000001'::uuid, 'kale-baby'),
   '00000000-0000-4a00-8000-000000000001'::uuid,
   'Kale Baby',
   'Hojas tiernas de kale, sabor suave.',
   'kale-baby', 'ACTIVE', 'hortaliza',
   ARRAY['kale', 'fresco'], 'schema://vertivo/hortaliza:v1',
   '{"harvestDate":"2026-04-14","greenhouseId":"gh-02","organic":true}'::jsonb,
   NULL, NOW() - INTERVAL '4 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000001'::uuid, 'espinaca-organica'),
   '00000000-0000-4a00-8000-000000000001'::uuid,
   'Espinaca Orgánica', 'Espinaca de invernadero, rica en hierro.',
   'espinaca-organica', 'ACTIVE', 'hortaliza',
   ARRAY['espinaca', 'organico'], 'schema://vertivo/hortaliza:v1',
   '{"harvestDate":"2026-04-13","greenhouseId":"gh-03","organic":true}'::jsonb,
   NULL, NOW() - INTERVAL '5 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000001'::uuid, 'rucula'),
   '00000000-0000-4a00-8000-000000000001'::uuid,
   'Rúcula', 'Rúcula fresca con notas picantes.',
   'rucula', 'ACTIVE', 'hortaliza',
   ARRAY['rucula'], 'schema://vertivo/hortaliza:v1',
   '{"harvestDate":"2026-04-13","greenhouseId":"gh-03"}'::jsonb,
   NULL, NOW() - INTERVAL '6 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000001'::uuid, 'pepino-japones'),
   '00000000-0000-4a00-8000-000000000001'::uuid,
   'Pepino Japonés', 'Pepino tierno, piel fina, ideal crudo.',
   'pepino-japones', 'ACTIVE', 'hortaliza',
   ARRAY['pepino'], 'schema://vertivo/hortaliza:v1',
   '{"harvestDate":"2026-04-12","greenhouseId":"gh-04","organic":false}'::jsonb,
   NULL, NOW() - INTERVAL '7 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000001'::uuid, 'chile-dulce-rojo'),
   '00000000-0000-4a00-8000-000000000001'::uuid,
   'Chile Dulce Rojo', 'Chile dulce de invernadero en color vibrante.',
   'chile-dulce-rojo', 'ACTIVE', 'hortaliza',
   ARRAY['chile'], 'schema://vertivo/hortaliza:v1',
   '{"harvestDate":"2026-04-12","greenhouseId":"gh-04"}'::jsonb,
   NULL, NOW() - INTERVAL '8 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000001'::uuid, 'zucchini'),
   '00000000-0000-4a00-8000-000000000001'::uuid,
   'Zucchini', 'Zucchini tiernos para saltear.',
   'zucchini', 'ACTIVE', 'hortaliza',
   ARRAY['zucchini'], 'schema://vertivo/hortaliza:v1',
   '{"harvestDate":"2026-04-11","greenhouseId":"gh-05","organic":true}'::jsonb,
   NULL, NOW() - INTERVAL '9 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000001'::uuid, 'cilantro'),
   '00000000-0000-4a00-8000-000000000001'::uuid,
   'Cilantro', 'Cilantro recién cortado, raíz incluida.',
   'cilantro', 'ACTIVE', 'hierba',
   ARRAY['cilantro'], 'schema://vertivo/hortaliza:v1',
   '{"harvestDate":"2026-04-15","greenhouseId":"gh-05"}'::jsonb,
   NULL, NOW() - INTERVAL '10 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000001'::uuid, 'menta'),
   '00000000-0000-4a00-8000-000000000001'::uuid,
   'Menta', 'Menta aromática para té e infusiones.',
   'menta', 'ACTIVE', 'hierba',
   ARRAY['menta'], 'schema://vertivo/hortaliza:v1',
   '{"harvestDate":"2026-04-14","greenhouseId":"gh-06","organic":true}'::jsonb,
   NULL, NOW() - INTERVAL '11 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000001'::uuid, 'perejil-crespo'),
   '00000000-0000-4a00-8000-000000000001'::uuid,
   'Perejil Crespo', 'Perejil fresco para guarniciones.',
   'perejil-crespo', 'ACTIVE', 'hierba',
   ARRAY['perejil'], 'schema://vertivo/hortaliza:v1',
   '{"harvestDate":"2026-04-13","greenhouseId":"gh-06"}'::jsonb,
   NULL, NOW() - INTERVAL '12 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000001'::uuid, 'brocoli'),
   '00000000-0000-4a00-8000-000000000001'::uuid,
   'Brócoli', 'Brócoli de cabeza firme.',
   'brocoli', 'ACTIVE', 'hortaliza',
   ARRAY['brocoli'], 'schema://vertivo/hortaliza:v1',
   '{"harvestDate":"2026-04-10","greenhouseId":"gh-07"}'::jsonb,
   NULL, NOW() - INTERVAL '13 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000001'::uuid, 'coliflor'),
   '00000000-0000-4a00-8000-000000000001'::uuid,
   'Coliflor', 'Coliflor de grano cerrado.',
   'coliflor', 'ACTIVE', 'hortaliza',
   ARRAY['coliflor'], 'schema://vertivo/hortaliza:v1',
   '{"harvestDate":"2026-04-10","greenhouseId":"gh-07"}'::jsonb,
   NULL, NOW() - INTERVAL '14 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000001'::uuid, 'repollo-morado'),
   '00000000-0000-4a00-8000-000000000001'::uuid,
   'Repollo Morado', 'Repollo morado crujiente para ensaladas.',
   'repollo-morado', 'ACTIVE', 'hortaliza',
   ARRAY['repollo'], 'schema://vertivo/hortaliza:v1',
   '{"harvestDate":"2026-04-09","greenhouseId":"gh-08"}'::jsonb,
   NULL, NOW() - INTERVAL '15 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000001'::uuid, 'apio'),
   '00000000-0000-4a00-8000-000000000001'::uuid,
   'Apio', 'Apio de tallo largo y firme.',
   'apio', 'ACTIVE', 'hortaliza',
   ARRAY['apio'], 'schema://vertivo/hortaliza:v1',
   '{"harvestDate":"2026-04-09","greenhouseId":"gh-08"}'::jsonb,
   NULL, NOW() - INTERVAL '16 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000001'::uuid, 'zanahoria-baby'),
   '00000000-0000-4a00-8000-000000000001'::uuid,
   'Zanahoria Baby', 'Zanahorias miniatura dulces y tiernas.',
   'zanahoria-baby', 'ACTIVE', 'hortaliza',
   ARRAY['zanahoria'], 'schema://vertivo/hortaliza:v1',
   '{"harvestDate":"2026-04-08","greenhouseId":"gh-09"}'::jsonb,
   NULL, NOW() - INTERVAL '17 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000001'::uuid, 'rabano'),
   '00000000-0000-4a00-8000-000000000001'::uuid,
   'Rábano', 'Rábano rojo crujiente.',
   'rabano', 'ACTIVE', 'hortaliza',
   ARRAY['rabano'], 'schema://vertivo/hortaliza:v1',
   '{"harvestDate":"2026-04-08","greenhouseId":"gh-09"}'::jsonb,
   NULL, NOW() - INTERVAL '18 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000001'::uuid, 'acelga'),
   '00000000-0000-4a00-8000-000000000001'::uuid,
   'Acelga', 'Acelga de hoja verde intensa.',
   'acelga', 'ACTIVE', 'hortaliza',
   ARRAY['acelga'], 'schema://vertivo/hortaliza:v1',
   '{"harvestDate":"2026-04-07","greenhouseId":"gh-10","organic":true}'::jsonb,
   NULL, NOW() - INTERVAL '19 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000001'::uuid, 'tomillo'),
   '00000000-0000-4a00-8000-000000000001'::uuid,
   'Tomillo', 'Tomillo fresco para marinados.',
   'tomillo', 'ACTIVE', 'hierba',
   ARRAY['tomillo'], 'schema://vertivo/hortaliza:v1',
   '{"harvestDate":"2026-04-07","greenhouseId":"gh-10","organic":true}'::jsonb,
   NULL, NOW() - INTERVAL '20 days', NOW())
ON CONFLICT (slug) DO NOTHING;

COMMIT;
