import 'package:flutter/material.dart';

import 'renderers/field_dispatcher.dart';

/// Card-shaped product preview for the browse grid.
///
/// The card honours the merchant's schema via `x-ui-browse-fields` — an
/// ordered array of property names to preview. If absent, we fall back to
/// the gRPC `Product` message's built-in fields (title + description +
/// tags), so the card still renders usefully for a "naked" schema.
class ProductBrowseCard extends StatelessWidget {
  const ProductBrowseCard({
    required this.title,
    required this.description,
    required this.tags,
    required this.attributes,
    required this.schema,
    this.onTap,
    super.key,
  });

  final String title;
  final String description;
  final List<String> tags;
  final Map<String, Object?> attributes;
  final Map<String, dynamic> schema;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final previewFields = _resolvePreviewFields();
    final thumbnail = _resolveThumbnail();

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (thumbnail != null)
              SizedBox(
                height: 120,
                child: Container(
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: const Center(
                    child: Icon(Icons.image_outlined, size: 32),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium,
                  ),
                  if (description.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                  if (previewFields.isNotEmpty) ...[
                    const Divider(height: 16),
                    for (final field in previewFields) _previewRow(context, field),
                  ],
                  if (tags.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: [
                        for (final tag in tags.take(3))
                          Chip(
                            label: Text(tag, style: theme.textTheme.bodySmall),
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _previewRow(BuildContext context, String key) {
    final properties = schema['properties'];
    if (properties is! Map) return const SizedBox.shrink();
    final fieldSchema = properties[key];
    if (fieldSchema is! Map) return const SizedBox.shrink();
    final label = (fieldSchema['title'] as String?) ?? key;
    final value = attributes[key];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Expanded(
            child: renderField(
              fieldSchema: Map<String, dynamic>.from(fieldSchema),
              value: value,
            ),
          ),
        ],
      ),
    );
  }

  List<String> _resolvePreviewFields() {
    final preview = schema['x-ui-browse-fields'];
    if (preview is List) {
      return preview.whereType<String>().take(3).toList();
    }
    return const [];
  }

  /// Placeholder hook — a future iteration will pick the first
  /// `x-ui-hint: image` or `format: uri + image/*` field.
  String? _resolveThumbnail() => null;
}
