import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_storefront/shared/json_schema_browse.dart';

Future<void> _pumpCard(
  WidgetTester tester, {
  required String title,
  required String description,
  required List<String> tags,
  required Map<String, Object?> attributes,
  required Map<String, dynamic> schema,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: 320,
          child: ProductBrowseCard(
            title: title,
            description: description,
            tags: tags,
            attributes: attributes,
            schema: schema,
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('renders title + description + tags', (tester) async {
    await _pumpCard(
      tester,
      title: 'Organic lettuce',
      description: 'Fresh, crisp, from the greenhouse',
      tags: const ['fresh', 'local', 'organic'],
      attributes: const {},
      schema: const {'type': 'object', 'properties': {}},
    );
    expect(find.text('Organic lettuce'), findsOneWidget);
    expect(find.text('Fresh, crisp, from the greenhouse'), findsOneWidget);
    expect(find.byType(Chip), findsNWidgets(3));
  });

  testWidgets('tags are truncated to 3', (tester) async {
    await _pumpCard(
      tester,
      title: 't',
      description: '',
      tags: const ['a', 'b', 'c', 'd', 'e'],
      attributes: const {},
      schema: const {'type': 'object', 'properties': {}},
    );
    expect(find.byType(Chip), findsNWidgets(3));
  });

  testWidgets('x-ui-browse-fields drives preview rows', (tester) async {
    await _pumpCard(
      tester,
      title: 'Apt 101',
      description: 'Downtown',
      tags: const [],
      attributes: const {'bedrooms': 3, 'monthlyRent': '1250.00'},
      schema: const {
        'type': 'object',
        'x-ui-browse-fields': ['bedrooms', 'monthlyRent'],
        'properties': {
          'bedrooms': {'type': 'integer', 'title': 'Bedrooms'},
          'monthlyRent': {
            'type': 'string',
            'title': 'Rent',
            'x-ui-hint': 'money',
            'x-ui-currency': 'USD',
          },
        },
      },
    );
    expect(find.text('Bedrooms'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('Rent'), findsOneWidget);
    expect(find.text('USD 1250.00'), findsOneWidget);
  });

  testWidgets('tapping the card invokes onTap', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 320,
            child: ProductBrowseCard(
              title: 't',
              description: '',
              tags: const [],
              attributes: const {},
              schema: const {},
              onTap: () => tapped = true,
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.byType(ProductBrowseCard));
    expect(tapped, isTrue);
  });

  testWidgets('preview skips fields whose schema entry is missing', (tester) async {
    await _pumpCard(
      tester,
      title: 't',
      description: '',
      tags: const [],
      attributes: const {'x': 1},
      schema: const {
        'type': 'object',
        'x-ui-browse-fields': ['x', 'missing'],
        'properties': {
          'x': {'type': 'integer', 'title': 'X'},
        },
      },
    );
    expect(find.text('X'), findsOneWidget);
  });
}
