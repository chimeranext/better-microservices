import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_storefront/shared/renderers/basic_renderers.dart';
import 'package:marketplace_storefront/shared/renderers/extension_renderers.dart';
import 'package:marketplace_storefront/shared/renderers/field_dispatcher.dart';
import 'package:marketplace_storefront/shared/renderers/media_renderers.dart';
import 'package:marketplace_storefront/shared/renderers/temporal_renderers.dart';

Future<void> _pumpField(
  WidgetTester tester, {
  required Map<String, dynamic> schema,
  required Object? value,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: renderField(fieldSchema: schema, value: value),
      ),
    ),
  );
}

void main() {
  group('field_dispatcher — base types', () {
    testWidgets('string → StringRenderer', (tester) async {
      await _pumpField(tester, schema: {'type': 'string'}, value: 'hola');
      expect(find.byType(StringRenderer), findsOneWidget);
      expect(find.text('hola'), findsOneWidget);
    });

    testWidgets('number + x-ui-unit → suffix in text', (tester) async {
      await _pumpField(
        tester,
        schema: {'type': 'number', 'x-ui-unit': '°C'},
        value: 22.5,
      );
      expect(find.byType(NumberRenderer), findsOneWidget);
      expect(find.text('22.5 °C'), findsOneWidget);
    });

    testWidgets('integer with no unit', (tester) async {
      await _pumpField(tester, schema: {'type': 'integer'}, value: 42);
      expect(find.text('42'), findsOneWidget);
    });

    testWidgets('boolean true → check icon + Yes', (tester) async {
      await _pumpField(tester, schema: {'type': 'boolean'}, value: true);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.text('Yes'), findsOneWidget);
    });

    testWidgets('boolean false → cancel icon + No', (tester) async {
      await _pumpField(tester, schema: {'type': 'boolean'}, value: false);
      expect(find.byIcon(Icons.cancel_outlined), findsOneWidget);
      expect(find.text('No'), findsOneWidget);
    });

    testWidgets('boolean with custom labels', (tester) async {
      await _pumpField(
        tester,
        schema: {
          'type': 'boolean',
          'x-ui-true-label': 'Certified',
          'x-ui-false-label': 'Conventional',
        },
        value: true,
      );
      expect(find.text('Certified'), findsOneWidget);
    });

    testWidgets('array of primitives → wrap of chips', (tester) async {
      await _pumpField(
        tester,
        schema: {'type': 'array', 'items': {'type': 'string'}},
        value: ['a', 'b', 'c'],
      );
      expect(find.byType(Chip), findsNWidgets(3));
    });

    testWidgets('empty array → em-dash placeholder', (tester) async {
      await _pumpField(tester, schema: {'type': 'array'}, value: []);
      expect(find.text('—'), findsOneWidget);
    });
  });

  group('field_dispatcher — format modifiers', () {
    testWidgets('format:date → DateRenderer (date-only)', (tester) async {
      await _pumpField(
        tester,
        schema: {'type': 'string', 'format': 'date'},
        value: '2026-04-15',
      );
      expect(find.byType(DateRenderer), findsOneWidget);
      expect(find.text('2026-04-15'), findsOneWidget);
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    });

    testWidgets('format:date-time → DateRenderer with time', (tester) async {
      await _pumpField(
        tester,
        schema: {'type': 'string', 'format': 'date-time'},
        value: '2026-04-15T09:30:00Z',
      );
      expect(find.byType(DateRenderer), findsOneWidget);
      expect(find.byIcon(Icons.schedule), findsOneWidget);
      expect(find.textContaining('2026-04-15'), findsOneWidget);
    });

    testWidgets('bad date falls back to raw string', (tester) async {
      await _pumpField(
        tester,
        schema: {'type': 'string', 'format': 'date'},
        value: 'not-a-date',
      );
      expect(find.text('not-a-date'), findsOneWidget);
    });

    testWidgets('format:uri → UrlRenderer', (tester) async {
      await _pumpField(
        tester,
        schema: {'type': 'string', 'format': 'uri'},
        value: 'https://vertivolatam.com',
      );
      expect(find.byType(UrlRenderer), findsOneWidget);
      expect(find.byIcon(Icons.link), findsOneWidget);
    });
  });

  group('field_dispatcher — enums', () {
    testWidgets('string with enum → EnumRenderer', (tester) async {
      await _pumpField(
        tester,
        schema: {'type': 'string', 'enum': ['dog', 'cat']},
        value: 'cat',
      );
      expect(find.byType(EnumRenderer), findsOneWidget);
      expect(find.byType(Chip), findsOneWidget);
      expect(find.text('cat'), findsOneWidget);
    });
  });

  group('field_dispatcher — x-ui-hint extensions', () {
    testWidgets('geo hint → GeoRenderer', (tester) async {
      await _pumpField(
        tester,
        schema: {'type': 'object', 'x-ui-hint': 'geo'},
        value: {'lat': 9.93, 'lng': -84.08},
      );
      expect(find.byType(GeoRenderer), findsOneWidget);
      expect(find.byIcon(Icons.place), findsOneWidget);
      expect(find.text('9.9300, -84.0800'), findsOneWidget);
    });

    testWidgets('geo hint + bad value falls back to raw print', (tester) async {
      await _pumpField(
        tester,
        schema: {'type': 'object', 'x-ui-hint': 'geo'},
        value: 'nope',
      );
      expect(find.text('nope'), findsOneWidget);
    });

    testWidgets('sensor hint on a scalar', (tester) async {
      await _pumpField(
        tester,
        schema: {'x-ui-hint': 'sensor', 'x-ui-unit': '°C'},
        value: 22.5,
      );
      expect(find.byType(SensorRenderer), findsOneWidget);
      expect(find.byIcon(Icons.sensors), findsOneWidget);
      expect(find.text('22.5 °C'), findsOneWidget);
    });

    testWidgets('sensor hint with array of readings → shows latest', (tester) async {
      await _pumpField(
        tester,
        schema: {'x-ui-hint': 'sensor'},
        value: [
          {'value': 20},
          {'value': 22},
        ],
      );
      expect(find.text('22'), findsOneWidget);
    });

    testWidgets('color hint + hex → colored swatch', (tester) async {
      await _pumpField(
        tester,
        schema: {'x-ui-hint': 'color'},
        value: '#0F7B3F',
      );
      expect(find.byType(ColorRenderer), findsOneWidget);
      expect(find.text('#0F7B3F'), findsOneWidget);
    });

    testWidgets('money hint with currency prefix', (tester) async {
      await _pumpField(
        tester,
        schema: {'x-ui-hint': 'money', 'x-ui-currency': 'USD'},
        value: '1250.00',
      );
      expect(find.byType(MoneyRenderer), findsOneWidget);
      expect(find.text('USD 1250.00'), findsOneWidget);
    });

    testWidgets('badge hint wraps the value in a chip', (tester) async {
      await _pumpField(
        tester,
        schema: {'x-ui-hint': 'badge'},
        value: 'featured',
      );
      expect(find.byType(BadgeRenderer), findsOneWidget);
      expect(find.byType(Chip), findsOneWidget);
      expect(find.text('featured'), findsOneWidget);
    });

    testWidgets('image hint with string → ImageRenderer', (tester) async {
      await _pumpField(
        tester,
        schema: {'x-ui-hint': 'image'},
        value: 'https://example.com/a.jpg',
      );
      expect(find.byType(ImageRenderer), findsOneWidget);
      expect(find.byIcon(Icons.image_outlined), findsOneWidget);
    });

    testWidgets('image-gallery hint with list → gallery', (tester) async {
      await _pumpField(
        tester,
        schema: {'x-ui-hint': 'image-gallery'},
        value: ['a.jpg', 'b.jpg'],
      );
      expect(find.byType(ImageGalleryRenderer), findsOneWidget);
    });

    testWidgets('url hint explicit override', (tester) async {
      await _pumpField(
        tester,
        schema: {'x-ui-hint': 'url'},
        value: 'https://lapc506.dev',
      );
      expect(find.byType(UrlRenderer), findsOneWidget);
    });

    testWidgets('unknown type + no hint → FallbackValue', (tester) async {
      await _pumpField(tester, schema: const {}, value: {'nested': 1});
      expect(find.textContaining('nested'), findsOneWidget);
    });
  });
}
