import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_storefront/app/config.dart';
import 'package:marketplace_storefront/app/theme.dart';
import 'package:marketplace_storefront/shared/json_schema_renderer.dart';

/// Smoke-level widget tests. We don't boot the full app — that would open a
/// real gRPC channel (with keepalive timers) and the test framework complains
/// about pending timers on teardown. Integration tests against `make up` will
/// cover the wiring end-to-end in a follow-up PR.
void main() {
  testWidgets('AppTheme exposes both light and dark themes', (tester) async {
    final light = AppTheme.light();
    final dark = AppTheme.dark();
    expect(light.useMaterial3, isTrue);
    expect(light.brightness, Brightness.light);
    expect(dark.brightness, Brightness.dark);
  });

  testWidgets('JsonSchemaRenderer shows empty-state copy when no attributes', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: JsonSchemaRenderer(
            schemaRef: 'schema://test:v1',
            attributes: {},
          ),
        ),
      ),
    );
    expect(find.textContaining('No attributes'), findsOneWidget);
    expect(find.textContaining('schema://test:v1'), findsOneWidget);
  });

  testWidgets('JsonSchemaRenderer renders each attribute as a labelled row', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: JsonSchemaRenderer(
            schemaRef: 'schema://test:v1',
            attributes: {'harvestDate': '2026-04-15', 'organic': true},
          ),
        ),
      ),
    );
    expect(find.text('harvestDate'), findsOneWidget);
    expect(find.text('2026-04-15'), findsOneWidget);
    expect(find.text('organic'), findsOneWidget);
    expect(find.text('true'), findsOneWidget);
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
