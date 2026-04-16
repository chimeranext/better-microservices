import 'package:flutter/material.dart';

/// Geo coordinates — lat/lng object. Placeholder layout (no real map tiles
/// in a spike), but shows the coords next to a pin icon so the intent is
/// visually unambiguous.
class GeoRenderer extends StatelessWidget {
  const GeoRenderer({required this.value, super.key});
  final Object? value;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final parsed = _tryParse(value);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.place, size: 16, color: theme.colorScheme.error),
        const SizedBox(width: 6),
        Text(
          parsed != null
              ? '${parsed.lat.toStringAsFixed(4)}, ${parsed.lng.toStringAsFixed(4)}'
              : '$value',
        ),
      ],
    );
  }

  _Coord? _tryParse(Object? value) {
    if (value is Map) {
      final lat = value['lat'] ?? value['latitude'];
      final lng = value['lng'] ?? value['longitude'];
      if (lat is num && lng is num) {
        return _Coord(lat.toDouble(), lng.toDouble());
      }
    }
    return null;
  }
}

class _Coord {
  const _Coord(this.lat, this.lng);
  final double lat;
  final double lng;
}

/// Sensor reading — renders a single value + label. When given a list of
/// readings, falls back to showing the latest. A real chart widget will come
/// with a sparkline dependency in a follow-up PR.
class SensorRenderer extends StatelessWidget {
  const SensorRenderer({required this.value, this.label, super.key});
  final Object? value;
  final String? label;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final latest = _latestReading(value);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.sensors, size: 16, color: theme.colorScheme.primary),
        const SizedBox(width: 6),
        Text(
          latest != null ? '$latest${label != null ? ' $label' : ''}' : '$value',
        ),
      ],
    );
  }

  Object? _latestReading(Object? value) {
    if (value is num) return value;
    if (value is Map) {
      return value['value'] ?? value['reading'];
    }
    if (value is List && value.isNotEmpty) {
      final last = value.last;
      if (last is Map) return last['value'] ?? last['reading'];
      if (last is num) return last;
    }
    return null;
  }
}

/// Color swatch — accepts `#RRGGBB` or `#RRGGBBAA` strings.
class ColorRenderer extends StatelessWidget {
  const ColorRenderer({required this.value, super.key});
  final Object? value;
  @override
  Widget build(BuildContext context) {
    final color = _tryParse(value);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color ?? Colors.transparent,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text('$value'),
      ],
    );
  }

  Color? _tryParse(Object? value) {
    if (value is String && value.startsWith('#')) {
      final hex = value.substring(1);
      if (hex.length == 6) {
        return Color(int.parse('FF$hex', radix: 16));
      }
      if (hex.length == 8) {
        return Color(int.parse(hex, radix: 16));
      }
    }
    return null;
  }
}

/// Money — schema can hint currency via `x-ui-currency` on the property.
/// Value is expected as a decimal string (matching the server-side Money VO).
class MoneyRenderer extends StatelessWidget {
  const MoneyRenderer({required this.value, this.currency, super.key});
  final Object? value;
  final String? currency;
  @override
  Widget build(BuildContext context) {
    final display = currency != null ? '$currency $value' : '$value';
    return Text(
      display,
      style: const TextStyle(fontWeight: FontWeight.w600),
    );
  }
}

/// Badge — single value shown as a chip; cleaner than a plain string when the
/// data is a status / label.
class BadgeRenderer extends StatelessWidget {
  const BadgeRenderer({required this.value, super.key});
  final Object? value;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Chip(
        label: Text('$value'),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
