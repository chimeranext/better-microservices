import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_storefront/app/config.dart';
import 'package:marketplace_storefront/app/theme.dart';
import 'package:marketplace_storefront/shared/json_schema_renderer.dart';

/// High-level smoke tests. Detailed renderer behaviour is covered in
/// `test/shared/**` — here we only verify the top-level widget + app bits.
void main() {
  testWidgets('AppTheme exposes both light and dark themes', (tester) async {
    final light = AppTheme.light();
    final dark = AppTheme.dark();
    expect(light.useMaterial3, isTrue);
    expect(light.brightness, Brightness.light);
    expect(dark.brightness, Brightness.dark);
  });

  testWidgets('JsonSchemaRenderer: empty schema prints a maintainer-friendly note',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: JsonSchemaRenderer(
            schemaRef: 'schema://test:v1',
            schema: {},
            attributes: {},
          ),
        ),
      ),
    );
    expect(find.textContaining('declares no properties'), findsOneWidget);
  });

  testWidgets('JsonSchemaRenderer: renders a populated object schema', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: JsonSchemaRenderer(
              schemaRef: 'schema://test:v1',
              schema: {
                'type': 'object',
                'properties': {
                  'harvestDate': {
                    'type': 'string',
                    'format': 'date',
                    'title': 'Harvest date',
                  },
                  'organic': {'type': 'boolean', 'title': 'Organic'},
                },
              },
              attributes: {'harvestDate': '2026-04-15', 'organic': true},
            ),
          ),
        ),
      ),
    );
    expect(find.text('Harvest date'), findsOneWidget);
    expect(find.text('2026-04-15'), findsOneWidget);
    expect(find.text('Organic'), findsOneWidget);
    expect(find.text('Yes'), findsOneWidget);
  });

  test('AppConfig.fromEnvironment applies defaults when env is empty', () {
    final config = AppConfig.fromEnvironment();
    expect(config.grpcHost, isNotEmpty);
    expect(config.grpcPort, greaterThan(0));
    expect(config.merchantSchemaUrl, contains('schemas'));
  });

  test('AppConfig constructor exposes supplied values', () {
    const config = AppConfig(
      merchantSchemaUrl: 'file:///x.json',
      grpcHost: '127.0.0.1',
      grpcPort: 12345,
    );
    expect(config.merchantSchemaUrl, 'file:///x.json');
    expect(config.grpcHost, '127.0.0.1');
    expect(config.grpcPort, 12345);
  });
}
