import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/json_schema_renderer.dart';
import 'product_detail_providers.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({required this.productId, super.key});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProduct = ref.watch(productDetailProvider(productId));
    return Scaffold(
      appBar: AppBar(title: const Text('Product')),
      body: asyncProduct.when(
        data: (product) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(product.title, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text(product.description),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  for (final tag in product.tags) Chip(label: Text(tag)),
                ],
              ),
              const Divider(height: 32),
              // PR-5 replaces this placeholder with the real JSON Schema
              // renderer that drives the layout from product.schemaRef.
              JsonSchemaRenderer(
                schemaRef: product.schemaRef,
                attributes: {
                  for (final entry in product.attributes.entries)
                    entry.key: entry.value,
                },
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text(err.toString())),
      ),
    );
  }
}
