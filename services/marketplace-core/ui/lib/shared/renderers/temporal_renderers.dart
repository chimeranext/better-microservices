import 'package:flutter/material.dart';

/// Formats ISO-8601 date strings as `YYYY-MM-DD` (no locale, deterministic for
/// golden tests). `format: date-time` keeps the time component. Bad input is
/// shown verbatim so users can still read it.
class DateRenderer extends StatelessWidget {
  const DateRenderer({
    required this.value,
    this.includeTime = false,
    super.key,
  });
  final Object? value;
  final bool includeTime;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final parsed = _tryParse(value);
    if (parsed == null) {
      return Text('$value');
    }
    final text = includeTime
        ? '${_fmtDate(parsed)} ${_fmtTime(parsed)}'
        : _fmtDate(parsed);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          includeTime ? Icons.schedule : Icons.calendar_today,
          size: 16,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 6),
        Text(text),
      ],
    );
  }

  DateTime? _tryParse(Object? value) {
    if (value is String) {
      return DateTime.tryParse(value);
    }
    return null;
  }

  String _fmtDate(DateTime dt) =>
      '${dt.year.toString().padLeft(4, '0')}-'
      '${dt.month.toString().padLeft(2, '0')}-'
      '${dt.day.toString().padLeft(2, '0')}';

  String _fmtTime(DateTime dt) =>
      '${dt.hour.toString().padLeft(2, '0')}:'
      '${dt.minute.toString().padLeft(2, '0')}';
}
