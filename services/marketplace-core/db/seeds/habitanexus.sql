-- HabitaNexus — 10 rental properties
-- Seed data for the HabitaNexus storefront. Idempotent.

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

BEGIN;

INSERT INTO products (
  id, vendor_id, title, description, slug, status, product_type,
  tags, schema_ref, attributes, geo, created_at, updated_at
) VALUES
  (uuid_generate_v5('00000000-0000-0000-0000-000000000002'::uuid, 'apt-101-sabanilla'),
   '00000000-0000-4a00-8000-000000000002'::uuid,
   'Apartamento 101 — Sabanilla',
   'Apartamento amoblado, 2 habitaciones, parqueo techado.',
   'apt-101-sabanilla', 'ACTIVE', 'rental',
   ARRAY['apartment', 'furnished'], 'schema://habitanexus/property:v1',
   '{"bedrooms":2,"bathrooms":1.5,"areaM2":85,"monthlyRent":"950.00","includesUtilities":false,"parking":true,"deposit":"950.00","availableFrom":"2026-05-01","locationGeo":{"lat":9.93,"lng":-84.08},"propertyType":"apartment","primaryColor":"#0F7B3F"}'::jsonb,
   '{"lat":9.93,"lng":-84.08,"address":"Sabanilla","city":"San Jose","state":"SJ","country":"CR"}'::jsonb,
   NOW() - INTERVAL '1 day', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000002'::uuid, 'casa-escazu-grande'),
   '00000000-0000-4a00-8000-000000000002'::uuid,
   'Casa familiar — Escazú',
   'Casa de 3 habitaciones con jardín trasero.',
   'casa-escazu-grande', 'ACTIVE', 'rental',
   ARRAY['house', 'family'], 'schema://habitanexus/property:v1',
   '{"bedrooms":3,"bathrooms":2.5,"areaM2":180,"monthlyRent":"2100.00","includesUtilities":false,"parking":true,"deposit":"2100.00","availableFrom":"2026-06-01","locationGeo":{"lat":9.92,"lng":-84.13},"propertyType":"house"}'::jsonb,
   '{"lat":9.92,"lng":-84.13,"address":"Escazu","city":"San Jose","state":"SJ","country":"CR"}'::jsonb,
   NOW() - INTERVAL '2 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000002'::uuid, 'studio-barrio-amon'),
   '00000000-0000-4a00-8000-000000000002'::uuid,
   'Studio — Barrio Amón',
   'Studio histórico renovado en el centro.',
   'studio-barrio-amon', 'ACTIVE', 'rental',
   ARRAY['studio', 'historic'], 'schema://habitanexus/property:v1',
   '{"bedrooms":1,"bathrooms":1,"areaM2":40,"monthlyRent":"650.00","includesUtilities":true,"parking":false,"deposit":"650.00","availableFrom":"2026-05-15","locationGeo":{"lat":9.94,"lng":-84.08},"propertyType":"studio"}'::jsonb,
   '{"lat":9.94,"lng":-84.08,"address":"Barrio Amon","city":"San Jose","state":"SJ","country":"CR"}'::jsonb,
   NOW() - INTERVAL '3 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000002'::uuid, 'loft-rohrmoser'),
   '00000000-0000-4a00-8000-000000000002'::uuid,
   'Loft industrial — Rohrmoser',
   'Loft de techos altos y diseño industrial.',
   'loft-rohrmoser', 'ACTIVE', 'rental',
   ARRAY['loft'], 'schema://habitanexus/property:v1',
   '{"bedrooms":1,"bathrooms":1,"areaM2":65,"monthlyRent":"1100.00","includesUtilities":false,"parking":true,"deposit":"1100.00","availableFrom":"2026-05-01","locationGeo":{"lat":9.95,"lng":-84.11},"propertyType":"loft"}'::jsonb,
   '{"lat":9.95,"lng":-84.11,"address":"Rohrmoser","city":"San Jose","state":"SJ","country":"CR"}'::jsonb,
   NOW() - INTERVAL '4 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000002'::uuid, 'apt-centro-heredia'),
   '00000000-0000-4a00-8000-000000000002'::uuid,
   'Apartamento — Centro Heredia',
   'Cerca de universidades y comercios.',
   'apt-centro-heredia', 'ACTIVE', 'rental',
   ARRAY['apartment', 'student'], 'schema://habitanexus/property:v1',
   '{"bedrooms":2,"bathrooms":1,"areaM2":70,"monthlyRent":"750.00","includesUtilities":false,"parking":false,"deposit":"750.00","availableFrom":"2026-07-01","locationGeo":{"lat":9.99,"lng":-84.11},"propertyType":"apartment"}'::jsonb,
   '{"lat":9.99,"lng":-84.11,"address":"Heredia Centro","city":"Heredia","state":"H","country":"CR"}'::jsonb,
   NOW() - INTERVAL '5 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000002'::uuid, 'casa-playa-tamarindo'),
   '00000000-0000-4a00-8000-000000000002'::uuid,
   'Casa de playa — Tamarindo',
   'Casa a 100m del mar, piscina privada.',
   'casa-playa-tamarindo', 'ACTIVE', 'rental',
   ARRAY['house', 'beach'], 'schema://habitanexus/property:v1',
   '{"bedrooms":4,"bathrooms":3,"areaM2":220,"monthlyRent":"3500.00","includesUtilities":false,"parking":true,"deposit":"7000.00","availableFrom":"2026-06-15","locationGeo":{"lat":10.30,"lng":-85.84},"propertyType":"house"}'::jsonb,
   '{"lat":10.30,"lng":-85.84,"address":"Tamarindo","city":"Tamarindo","state":"G","country":"CR"}'::jsonb,
   NOW() - INTERVAL '6 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000002'::uuid, 'studio-montes-oca'),
   '00000000-0000-4a00-8000-000000000002'::uuid,
   'Studio — Montes de Oca',
   'Studio minimalista cerca de la UCR.',
   'studio-montes-oca', 'ACTIVE', 'rental',
   ARRAY['studio', 'student'], 'schema://habitanexus/property:v1',
   '{"bedrooms":1,"bathrooms":1,"areaM2":35,"monthlyRent":"550.00","includesUtilities":true,"parking":false,"deposit":"550.00","availableFrom":"2026-05-20","locationGeo":{"lat":9.94,"lng":-84.05},"propertyType":"studio"}'::jsonb,
   '{"lat":9.94,"lng":-84.05,"address":"Montes de Oca","city":"San Jose","state":"SJ","country":"CR"}'::jsonb,
   NOW() - INTERVAL '7 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000002'::uuid, 'apt-ejecutivo-santa-ana'),
   '00000000-0000-4a00-8000-000000000002'::uuid,
   'Apartamento ejecutivo — Santa Ana',
   'Torre corporativa con gimnasio y piscina.',
   'apt-ejecutivo-santa-ana', 'ACTIVE', 'rental',
   ARRAY['apartment', 'luxury'], 'schema://habitanexus/property:v1',
   '{"bedrooms":2,"bathrooms":2,"areaM2":110,"monthlyRent":"1800.00","includesUtilities":false,"parking":true,"deposit":"3600.00","availableFrom":"2026-05-01","locationGeo":{"lat":9.93,"lng":-84.17},"propertyType":"apartment"}'::jsonb,
   '{"lat":9.93,"lng":-84.17,"address":"Santa Ana","city":"San Jose","state":"SJ","country":"CR"}'::jsonb,
   NOW() - INTERVAL '8 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000002'::uuid, 'casa-cartago'),
   '00000000-0000-4a00-8000-000000000002'::uuid,
   'Casa tradicional — Cartago',
   'Casa de 3 habitaciones con patio interior.',
   'casa-cartago', 'ACTIVE', 'rental',
   ARRAY['house'], 'schema://habitanexus/property:v1',
   '{"bedrooms":3,"bathrooms":2,"areaM2":150,"monthlyRent":"900.00","includesUtilities":false,"parking":true,"deposit":"900.00","availableFrom":"2026-06-01","locationGeo":{"lat":9.86,"lng":-83.92},"propertyType":"house"}'::jsonb,
   '{"lat":9.86,"lng":-83.92,"address":"Cartago Centro","city":"Cartago","state":"C","country":"CR"}'::jsonb,
   NOW() - INTERVAL '9 days', NOW()),

  (uuid_generate_v5('00000000-0000-0000-0000-000000000002'::uuid, 'loft-curridabat'),
   '00000000-0000-4a00-8000-000000000002'::uuid,
   'Loft moderno — Curridabat',
   'Loft con balcón y vista a la montaña.',
   'loft-curridabat', 'ACTIVE', 'rental',
   ARRAY['loft'], 'schema://habitanexus/property:v1',
   '{"bedrooms":1,"bathrooms":1,"areaM2":55,"monthlyRent":"850.00","includesUtilities":false,"parking":true,"deposit":"850.00","availableFrom":"2026-05-10","locationGeo":{"lat":9.91,"lng":-84.03},"propertyType":"loft"}'::jsonb,
   '{"lat":9.91,"lng":-84.03,"address":"Curridabat","city":"San Jose","state":"SJ","country":"CR"}'::jsonb,
   NOW() - INTERVAL '10 days', NOW())
ON CONFLICT (slug) DO NOTHING;

COMMIT;
