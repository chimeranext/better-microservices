import 'package:flutter/material.dart';

/// Shared field-row layout. Left column is the property label, right column
/// is the rendered value. Keeps a consistent rhythm across every field type.
class FieldRow extends StatelessWidget {
  const FieldRow({
    required this.label,
    required this.child,
    super.key,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

/// Graceful placeholder for values the renderer cannot understand (e.g., a
/// schema declares a type we don't yet support). We show the raw string so
/// nothing gets hidden from the user.
class FallbackValue extends StatelessWidget {
  const FallbackValue({required this.value, super.key});
  final Object? value;
  @override
  Widget build(BuildContext context) {
    return Text('$value');
  }
}

/// Humanise a schema property name: camelCase + snake_case + kebab-case
/// → "Space Separated Title Case". Used when a schema doesn't supply a
/// `title` for a property.
String humaniseKey(String key) {
  if (key.isEmpty) return key;
  final spaced = key
      .replaceAllMapped(
        RegExp(r'([a-z])([A-Z])'),
        (m) => '${m[1]} ${m[2]}',
      )
      .replaceAll(RegExp(r'[_-]'), ' ');
  return spaced
      .split(' ')
      .where((w) => w.isNotEmpty)
      .map((w) => w[0].toUpperCase() + w.substring(1))
      .join(' ');
}
