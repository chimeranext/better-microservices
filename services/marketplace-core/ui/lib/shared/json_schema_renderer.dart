import 'package:flutter/material.dart';

import 'renderers/common.dart';
import 'renderers/field_dispatcher.dart';

/// Generic JSON Schema-driven renderer. Walks the object schema's `properties`
/// map, and for each property emits a `FieldRow` whose right-hand widget is
/// chosen by [renderField].
///
/// The whole point of the spike: this widget has zero domain knowledge. The
/// same binary renders hortalizas frescas (Vertivo), rental property listings
/// (HabitaNexus), or pet supplies (AltruPets) — only the schema changes.
class JsonSchemaRenderer extends StatelessWidget {
  const JsonSchemaRenderer({
    required this.schemaRef,
    required this.schema,
    required this.attributes,
    super.key,
  });

  /// Merchant-registered identifier — shown in the footer so maintainers can
  /// see at a glance which schema drove a given render in screenshots and
  /// bug reports.
  final String schemaRef;

  /// Parsed JSON Schema document. We expect an object schema with a
  /// `properties` map; anything else degrades to an empty render.
  final Map<String, dynamic> schema;

  /// Attribute values keyed by property name. Typically comes from
  /// `product.attributes` (a `Map<String, String>` from gRPC, decoded into
  /// the richer types the schema calls for).
  final Map<String, Object?> attributes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final properties = schema['properties'];

    if (properties is! Map || properties.isEmpty) {
      return Text(
        'Schema declares no properties (ref: $schemaRef).',
        style: theme.textTheme.bodySmall,
      );
    }

    final propertyOrder = _resolveOrder(schema, properties);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Attributes', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        for (final key in propertyOrder)
          FieldRow(
            label: _propertyLabel(properties[key] as Map<String, dynamic>, key),
            child: renderField(
              fieldSchema: Map<String, dynamic>.from(
                properties[key] as Map<String, dynamic>,
              ),
              value: attributes[key],
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

  /// Property order: explicit `x-ui-order` array wins, then the `required`
  /// array, then the insertion order of `properties` itself.
  List<String> _resolveOrder(
    Map<String, dynamic> schema,
    Map properties,
  ) {
    final keys = properties.keys.cast<String>().toList();
    final explicit = schema['x-ui-order'];
    if (explicit is List) {
      final explicitKeys = explicit.whereType<String>().toList();
      final remaining = keys.where((k) => !explicitKeys.contains(k));
      return [...explicitKeys.where(keys.contains), ...remaining];
    }
    final required = schema['required'];
    if (required is List) {
      final requiredKeys = required.whereType<String>().toList();
      final remaining = keys.where((k) => !requiredKeys.contains(k));
      return [...requiredKeys.where(keys.contains), ...remaining];
    }
    return keys;
  }

  String _propertyLabel(Map<String, dynamic> propertySchema, String key) {
    final title = propertySchema['title'];
    if (title is String && title.isNotEmpty) return title;
    return humaniseKey(key);
  }
}
