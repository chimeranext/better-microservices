import 'package:flutter/material.dart';

import 'basic_renderers.dart';
import 'common.dart';
import 'extension_renderers.dart';
import 'media_renderers.dart';
import 'temporal_renderers.dart';

/// Core dispatch function: given a JSON Schema fragment describing a single
/// field and the value it currently holds, return the widget that renders it.
///
/// Order of resolution:
///   1. `x-ui-hint` custom extension (geo / sensor / image / etc.)
///   2. `format` standard modifier (date / date-time / email / uri / ...)
///   3. Enum short-circuit (string with enum)
///   4. Base `type` (string / number / integer / boolean / array / object)
///
/// This ordering lets schema authors override the default rendering with a
/// hint even on standard types — e.g. `"type": "string", "x-ui-hint": "badge"`
/// turns a plain string into a chip without changing the data shape.
Widget renderField({
  required Map<String, dynamic> fieldSchema,
  required Object? value,
}) {
  final hint = fieldSchema['x-ui-hint'] as String?;
  final format = fieldSchema['format'] as String?;
  final type = fieldSchema['type'] as String?;

  // --- 1. Explicit custom hint wins first ---
  switch (hint) {
    case 'geo':
      return GeoRenderer(value: value);
    case 'sensor':
      return SensorRenderer(
        value: value,
        label: fieldSchema['x-ui-unit'] as String?,
      );
    case 'color':
      return ColorRenderer(value: value);
    case 'money':
      return MoneyRenderer(
        value: value,
        currency: fieldSchema['x-ui-currency'] as String?,
      );
    case 'badge':
      return BadgeRenderer(value: value);
    case 'image':
      return value is String ? ImageRenderer(url: value) : FallbackValue(value: value);
    case 'image-gallery':
      return value is List
          ? ImageGalleryRenderer(urls: value.whereType<String>().toList())
          : FallbackValue(value: value);
    case 'url':
      return value is String ? UrlRenderer(url: value) : FallbackValue(value: value);
  }

  // --- 2. Standard format modifiers ---
  switch (format) {
    case 'date':
      return DateRenderer(value: value);
    case 'date-time':
      return DateRenderer(value: value, includeTime: true);
    case 'uri':
      return value is String ? UrlRenderer(url: value) : FallbackValue(value: value);
  }

  // --- 3. Enum: discrete values → chip ---
  if (fieldSchema['enum'] is List && (fieldSchema['enum'] as List).isNotEmpty) {
    return EnumRenderer(value: value);
  }

  // --- 4. Base type dispatch ---
  switch (type) {
    case 'string':
      return StringRenderer(value: value);
    case 'number':
    case 'integer':
      return NumberRenderer(
        value: value,
        unit: fieldSchema['x-ui-unit'] as String?,
      );
    case 'boolean':
      return BooleanRenderer(
        value: value is bool ? value : null,
        trueLabel: fieldSchema['x-ui-true-label'] as String?,
        falseLabel: fieldSchema['x-ui-false-label'] as String?,
      );
    case 'array':
      return _ArrayFallback(value: value);
  }

  return FallbackValue(value: value);
}

class _ArrayFallback extends StatelessWidget {
  const _ArrayFallback({required this.value});
  final Object? value;
  @override
  Widget build(BuildContext context) {
    if (value is! List || (value as List).isEmpty) {
      return const Text('—');
    }
    final list = value as List;
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: [for (final item in list) Chip(label: Text('$item'))],
    );
  }
}
