import 'package:flutter/material.dart';

/// Placeholder for the generic JSON Schema-driven field renderer.
///
/// **This is intentionally minimal in PR-4.** PR-5 (#7) replaces the body with
/// the real implementation: resolves `schemaRef` against the registry, walks
/// each field, and emits the right widget per JSON Schema type
/// (`string + format:date-time` → formatted date, `number` → numeric chip,
/// custom `x-vertivo:sensor` → chart, etc.).
///
/// For now it just dumps attributes as a key/value list so PR-4 can prove the
/// end-to-end wiring (gRPC → provider → UI) works.
class JsonSchemaRenderer extends StatelessWidget {
  const JsonSchemaRenderer({
    required this.schemaRef,
    required this.attributes,
    super.key,
  });

  final String schemaRef;
  final Map<String, Object?> attributes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (attributes.isEmpty) {
      return Text(
        'No attributes (schema: $schemaRef).',
        style: theme.textTheme.bodySmall,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Attributes', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        for (final entry in attributes.entries)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 160,
                  child: Text(
                    entry.key,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(child: Text('${entry.value}')),
              ],
            ),
          ),
        const SizedBox(height: 16),
        Text(
          'Schema: $schemaRef',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
