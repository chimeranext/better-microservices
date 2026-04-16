# Schema Extensions (`x-ui-*`) Catalog

> The renderer consumes standard JSON Schema 2020-12 plus a small set
> of generic `x-ui-*` extensions. None of them encode merchant names,
> so every consumer (Vertivo, HabitaNexus, AltruPets, …) speaks the
> same vocabulary.

## Why `x-*` instead of a custom schema dialect

- **JSON Schema 2020-12 tolerates unknown keywords by default.** Any
  validator ignores keys it doesn't recognise, so schemas remain
  portable across tools.
- Proliferating merchant-specific dialects (`x-vertivo:sensor`,
  `x-habitanexus:parking`) would force the renderer to ship a case per
  merchant — exactly what the spike is trying to avoid.
- Prefixing with `x-ui-` signals that the extension affects rendering,
  not domain semantics.

## Complete catalog

### `x-ui-hint` (on a property)

Override the default widget selection. Values:

| Value            | Effect                                                            |
|------------------|-------------------------------------------------------------------|
| `geo`            | Map pin + coordinates (expects `{lat, lng}`)                      |
| `sensor`         | Sensor icon + latest reading (scalar, `{value}`, or list thereof) |
| `color`          | Color swatch + hex label (expects `#RRGGBB` or `#RRGGBBAA`)       |
| `money`          | Bold price with optional currency prefix                          |
| `badge`          | Single chip — cleaner than plain text for statuses                |
| `image`          | Single image placeholder                                          |
| `image-gallery`  | Wrap of image tiles (expects `string[]`)                          |
| `url`            | Linked-looking URL (does not launch — see spike limits)           |

### `x-ui-unit` (on a property)

Suffix appended to numeric values and sensor readings.

```json
{ "type": "number", "x-ui-unit": "°C" }        // "22.5 °C"
{ "type": "integer", "x-ui-unit": "m²" }       // "120 m²"
{ "x-ui-hint": "sensor", "x-ui-unit": "°C" }   // "22 °C" with sensor icon
```

### `x-ui-currency` (on a money-hinted property)

Currency code prefix.

```json
{ "type": "string", "x-ui-hint": "money", "x-ui-currency": "USD" }
// → "USD 1250.00"
```

### `x-ui-true-label` / `x-ui-false-label` (on a boolean)

Custom labels for boolean rendering.

```json
{
  "type": "boolean",
  "x-ui-true-label": "Certified organic",
  "x-ui-false-label": "Conventional"
}
```

### `x-ui-order` (on the root schema)

Array of property names that controls display order in the renderer.
Unlisted properties fall through to insertion order.

```json
{
  "type": "object",
  "x-ui-order": ["harvestDate", "greenhouseId", "organic"],
  "properties": { /* ... */ }
}
```

### `x-ui-browse-fields` (on the root schema)

Up to 3 property names shown as preview rows on browse cards. Used by
`ProductBrowseCard`; detail view ignores this.

```json
{
  "type": "object",
  "x-ui-browse-fields": ["bedrooms", "monthlyRent", "locationGeo"],
  "properties": { /* ... */ }
}
```

## Authoring guide — when to add a new hint

Before introducing a new `x-ui-*` key, check that:

1. It's **generic**. Don't name it after your merchant.
2. It answers a **rendering question**, not a domain question. If the
   answer is "our sensors are different from theirs", that's data
   modelling, not a hint.
3. The renderer change is **bounded** — one new widget, one new case
   in the dispatcher. If it grows tentacles across the codebase, the
   hint is probably the wrong abstraction.

Finally: after adding a hint, update `KNOWN_UI_HINTS` in
`tests/schemas/validate.test.ts` so every schema that uses it
continues to validate at CI time.

## Reserved / forbidden prefixes

- `x-merchant-*` — reserved for future merchant-specific metadata
  that *doesn't* affect rendering. Don't use it for rendering hints.
- `x-internal-*` — reserved for server-side fields. Renderer ignores
  everything in this namespace.

## Reference: the three seed schemas

See:

- [`schemas/vertivolatam/hortalizas.v1.json`](../../schemas/vertivolatam/hortalizas.v1.json)
- [`schemas/habitanexus/property.v1.json`](../../schemas/habitanexus/property.v1.json)
- [`schemas/altrupets/pet-supply.v1.json`](../../schemas/altrupets/pet-supply.v1.json)

Every hint in this catalog appears at least once in the three schemas.
