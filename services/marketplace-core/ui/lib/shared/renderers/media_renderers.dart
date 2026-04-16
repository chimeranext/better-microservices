import 'package:flutter/material.dart';

/// Single image. The current widget is intentionally a placeholder — rendering
/// real network images needs a loader + cache + error state that's out of
/// scope for the spike. We display the URL + a thumbnail silhouette so layout
/// decisions (e.g. card sizing) stay honest.
class ImageRenderer extends StatelessWidget {
  const ImageRenderer({required this.url, this.height = 120, super.key});
  final String url;
  final double height;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_outlined, size: 32, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              url,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

/// Gallery of image URLs laid out as a wrap of fixed-size tiles. Avoids the
/// sizing gymnastics a horizontal `ListView` would require inside another
/// scrollable — important because the renderer is always embedded in one.
class ImageGalleryRenderer extends StatelessWidget {
  const ImageGalleryRenderer({required this.urls, super.key});
  final List<String> urls;
  @override
  Widget build(BuildContext context) {
    if (urls.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final url in urls)
          SizedBox(
            width: 160,
            child: ImageRenderer(url: url),
          ),
      ],
    );
  }
}

/// URL — rendered as a Material `InkWell` that highlights on hover. We don't
/// launch the URL here (that needs `url_launcher`, which is desktop-finicky).
class UrlRenderer extends StatelessWidget {
  const UrlRenderer({required this.url, super.key});
  final String url;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.link, size: 16, color: theme.colorScheme.primary),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            url,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: theme.colorScheme.primary,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
