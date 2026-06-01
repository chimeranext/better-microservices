import { readFileSync } from "node:fs";
import { resolve } from "node:path";
import { describe, expect, it } from "vitest";
import { z } from "zod";

/**
 * Validate the three reference schemas against a minimal JSON Schema 2020-12
 * meta-model. Ajv-with-draft-2020 would give a more authoritative check, but
 * it pulls a ~400KB dep and ajv keeps breaking its own API between majors.
 * The rules below cover every constraint we actually rely on in the Flutter
 * renderer — anything we don't yet care about is not worth policing.
 */

const SchemaRoot = z.object({
  $schema: z.string().url().optional(),
  $id: z.string().optional(),
  title: z.string(),
  type: z.literal("object"),
  properties: z.record(z.string(), z.record(z.string(), z.unknown())),
  required: z.array(z.string()).optional(),
  description: z.string().optional(),
  // Custom UI extensions used by the renderer (PR-5).
  "x-ui-order": z.array(z.string()).optional(),
  "x-ui-browse-fields": z.array(z.string()).optional(),
});

const KNOWN_FIELD_TYPES = ["string", "number", "integer", "boolean", "array", "object"];
const KNOWN_UI_HINTS = [
  "geo",
  "sensor",
  "color",
  "money",
  "badge",
  "image",
  "image-gallery",
  "url",
];
const KNOWN_FORMATS = ["date", "date-time", "uri", "email"];

const schemaFiles = [
  "schemas/vertivolatam/hortalizas.v1.json",
  "schemas/habitanexus/property.v1.json",
  "schemas/altrupets/pet-supply.v1.json",
];

// Tests run from repo root via vitest. Locate schemas relative to cwd.
const repoRoot = process.cwd();

interface ParsedSchema {
  path: string;
  schema: z.infer<typeof SchemaRoot>;
}

function parseSchema(relativePath: string): ParsedSchema {
  const full = resolve(repoRoot, relativePath);
  const content = readFileSync(full, "utf-8");
  const json = JSON.parse(content);
  return { path: relativePath, schema: SchemaRoot.parse(json) };
}

describe("reference schemas — structural validity", () => {
  for (const path of schemaFiles) {
    it(`${path} conforms to our Draft 2020-12 subset`, () => {
      expect(() => parseSchema(path)).not.toThrow();
    });
  }
});

describe("reference schemas — semantic consistency", () => {
  for (const path of schemaFiles) {
    describe(path, () => {
      const parsed = parseSchema(path);
      const schema = parsed.schema;
      const properties = schema.properties;
      const propertyNames = Object.keys(properties);

      it("every required field has a matching property", () => {
        for (const req of schema.required ?? []) {
          expect(propertyNames).toContain(req);
        }
      });

      it("x-ui-order only references declared properties", () => {
        const order = schema["x-ui-order"] ?? [];
        for (const key of order) {
          expect(propertyNames).toContain(key);
        }
      });

      it("x-ui-browse-fields only references declared properties", () => {
        const preview = schema["x-ui-browse-fields"] ?? [];
        for (const key of preview) {
          expect(propertyNames).toContain(key);
        }
      });

      it("each property uses a known type + known x-ui-hint + known format", () => {
        for (const [name, propSchema] of Object.entries(properties)) {
          const type = propSchema.type as string | undefined;
          if (type) {
            expect(KNOWN_FIELD_TYPES, `property ${name} has unknown type "${type}"`).toContain(
              type,
            );
          }
          const hint = propSchema["x-ui-hint"] as string | undefined;
          if (hint) {
            expect(KNOWN_UI_HINTS, `property ${name} has unknown x-ui-hint "${hint}"`).toContain(
              hint,
            );
          }
          const format = propSchema.format as string | undefined;
          if (format) {
            expect(KNOWN_FORMATS, `property ${name} has unknown format "${format}"`).toContain(
              format,
            );
          }
        }
      });
    });
  }
});
