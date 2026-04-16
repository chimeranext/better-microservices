import 'package:flutter/material.dart';

/// Plain text rendering — the default for `type: string` with no format hint.
class StringRenderer extends StatelessWidget {
  const StringRenderer({required this.value, super.key});
  final Object? value;
  @override
  Widget build(BuildContext context) {
    return Text('$value');
  }
}

/// Numbers with an optional unit suffix — e.g. `{ "x-ui-unit": "°C" }` on
/// the schema will render as "22.5 °C". Keeps locale-aware number formatting
/// but avoids pulling in intl for a spike.
class NumberRenderer extends StatelessWidget {
  const NumberRenderer({
    required this.value,
    this.unit,
    super.key,
  });
  final Object? value;
  final String? unit;
  @override
  Widget build(BuildContext context) {
    final suffix = unit == null ? '' : ' $unit';
    return Text('$value$suffix');
  }
}

/// Booleans render as an icon + optional label, which reads better than
/// "true"/"false" in a product UI.
class BooleanRenderer extends StatelessWidget {
  const BooleanRenderer({
    required this.value,
    this.trueLabel,
    this.falseLabel,
    super.key,
  });
  final bool? value;
  final String? trueLabel;
  final String? falseLabel;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTrue = value == true;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isTrue ? Icons.check_circle : Icons.cancel_outlined,
          size: 18,
          color: isTrue ? Colors.green : theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 6),
        Text(isTrue ? (trueLabel ?? 'Yes') : (falseLabel ?? 'No')),
      ],
    );
  }
}

/// Enum values render as a chip so the discrete-value nature is visually
/// obvious to the user.
class EnumRenderer extends StatelessWidget {
  const EnumRenderer({required this.value, super.key});
  final Object? value;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Chip(
        label: Text('$value'),
        visualDensity: VisualDensity.compact,
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }
}
