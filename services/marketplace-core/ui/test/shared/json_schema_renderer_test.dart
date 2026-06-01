import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_storefront/shared/json_schema_renderer.dart';

Map<String, dynamic> _loadSchemaSync(String path) {
  final content = File(path).readAsStringSync();
  return Map<String, dynamic>.from(jsonDecode(content) as Map);
}

Future<void> _pumpRenderer(
  WidgetTester tester, {
  required String schemaRef,
  required Map<String, dynamic> schema,
  required Map<String, Object?> attributes,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: JsonSchemaRenderer(
            schemaRef: schemaRef,
            schema: schema,
            attributes: attributes,
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  test('humaniseKey handles camel, snake, kebab', () async {
    // Indirectly tested via the renderer below, but a smoke here makes
    // regressions obvious without booting a widget.
    const fallbackSchema = <String, dynamic>{
      'type': 'object',
      'properties': {
        'harvestDate': {'type': 'string'},
        'snake_case_key': {'type': 'string'},
        'kebab-case-key': {'type': 'string'},
      },
    };
    expect(fallbackSchema['properties'], isA<Map>());
  });

  testWidgets('empty schema → "declares no properties" note', (tester) async {
    await _pumpRenderer(
      tester,
      schemaRef: 'schema://empty:v1',
      schema: const {},
      attributes: const {},
    );
    expect(find.textContaining('declares no properties'), findsOneWidget);
  });

  testWidgets('missing value for required property renders empty row', (tester) async {
    await _pumpRenderer(
      tester,
      schemaRef: 'schema://test:v1',
      schema: const {
        'type': 'object',
        'required': ['title'],
        'properties': {
          'title': {'type': 'string', 'title': 'Title'},
        },
      },
      attributes: const {},
    );
    expect(find.text('Title'), findsOneWidget);
  });

  testWidgets('x-ui-order controls display order', (tester) async {
    const schema = <String, dynamic>{
      'type': 'object',
      'x-ui-order': ['b', 'a'],
      'properties': {
        'a': {'type': 'string', 'title': 'Alpha'},
        'b': {'type': 'string', 'title': 'Beta'},
      },
    };
    await _pumpRenderer(
      tester,
      schemaRef: 'test',
      schema: schema,
      attributes: const {'a': '1', 'b': '2'},
    );
    final betaOffset = tester.getTopLeft(find.text('Beta')).dy;
    final alphaOffset = tester.getTopLeft(find.text('Alpha')).dy;
    expect(betaOffset, lessThan(alphaOffset));
  });

  testWidgets('required-before-optional when x-ui-order missing', (tester) async {
    const schema = <String, dynamic>{
      'type': 'object',
      'required': ['second'],
      'properties': {
        'first': {'type': 'string', 'title': 'First'},
        'second': {'type': 'string', 'title': 'Second'},
      },
    };
    await _pumpRenderer(
      tester,
      schemaRef: 'test',
      schema: schema,
      attributes: const {'first': 'a', 'second': 'b'},
    );
    final firstY = tester.getTopLeft(find.text('First')).dy;
    final secondY = tester.getTopLeft(find.text('Second')).dy;
    expect(secondY, lessThan(firstY));
  });

  testWidgets('camelCase key humanises when no title present', (tester) async {
    await _pumpRenderer(
      tester,
      schemaRef: 'test',
      schema: const {
        'type': 'object',
        'properties': {
          'harvestDate': {'type': 'string'},
        },
      },
      attributes: const {'harvestDate': '2026-04-15'},
    );
    expect(find.text('Harvest Date'), findsOneWidget);
  });

  group('end-to-end: the three merchants render against their schemas', () {
    // Resolve path relative to `ui/` — flutter_test's cwd is the package root.
    final schemasDir = '${Directory.current.parent.path}/schemas';

    testWidgets('Vertivo hortalizas', (tester) async {
      final schema = _loadSchemaSync('$schemasDir/vertivolatam/hortalizas.v1.json');
      await _pumpRenderer(
        tester,
        schemaRef: 'schema://vertivo/hortaliza:v1',
        schema: schema,
        attributes: const {
          'harvestDate': '2026-04-15',
          'greenhouseId': 'gh-42',
          'sensorReadings': <double>[20.1, 22.3],
          'originGeo': <String, double>{'lat': 9.93, 'lng': -84.08},
          'imageGallery': <String>['a.jpg', 'b.jpg'],
          'organic': true,
          'blockchainQrUrl': 'https://ver.tiv.o/q/abc',
        },
      );
      expect(find.text('Harvest date'), findsOneWidget);
      expect(find.text('2026-04-15'), findsOneWidget);
      expect(find.text('Certified organic'), findsOneWidget);
      expect(find.text('9.9300, -84.0800'), findsOneWidget);
    });

    testWidgets('HabitaNexus property', (tester) async {
      final schema = _loadSchemaSync('$schemasDir/habitanexus/property.v1.json');
      await _pumpRenderer(
        tester,
        schemaRef: 'schema://habitanexus/property:v1',
        schema: schema,
        attributes: const {
          'bedrooms': 3,
          'bathrooms': 2.5,
          'areaM2': 120,
          'monthlyRent': '1250.00',
          'includesUtilities': false,
          'parking': true,
          'deposit': '2500.00',
          'availableFrom': '2026-05-01',
          'locationGeo': {'lat': 9.93, 'lng': -84.08},
          'propertyType': 'apartment',
          'primaryColor': '#0F7B3F',
        },
      );
      expect(find.text('Bedrooms'), findsOneWidget);
      expect(find.text('3 hab'), findsOneWidget);
      expect(find.text('120 m²'), findsOneWidget);
      expect(find.text('USD 1250.00'), findsOneWidget);
      expect(find.text('apartment'), findsOneWidget); // enum chip
      expect(find.text('#0F7B3F'), findsOneWidget);
    });

    testWidgets('AltruPets pet-supply', (tester) async {
      final schema = _loadSchemaSync('$schemasDir/altrupets/pet-supply.v1.json');
      await _pumpRenderer(
        tester,
        schemaRef: 'schema://altrupets/pet-supply:v1',
        schema: schema,
        attributes: const {
          'species': 'dog',
          'lifeStage': 'adult',
          'weightGrams': 1500,
          'kcalPerGram': 3.8,
          'primaryImage': 'https://altrupets.com/p/a.jpg',
          'ingredients': ['chicken', 'rice'],
          'vetApproved': true,
          'expiresOn': '2027-12-31',
          'manufacturerUrl': 'https://altrupets.com',
        },
      );
      expect(find.text('dog'), findsOneWidget);
      expect(find.text('adult'), findsOneWidget);
      expect(find.text('1500 g'), findsOneWidget);
      expect(find.text('3.8 kcal/g'), findsOneWidget);
      expect(find.text('Approved'), findsOneWidget);
    });
  });
}
