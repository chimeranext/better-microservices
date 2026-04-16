import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/json_schema_renderer.dart';
import '../../shared/schema_registry_provider.dart';
import 'product_detail_providers.dart';

/// Product detail — schema-driven attributes pane plus the gRPC Product
/// message's built-in fields (title, description, tags).
class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({required this.productId, super.key});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProduct = ref.watch(productDetailProvider(productId));
    final asyncSchema = ref.watch(merchantSchemaProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Product')),
      body: asyncProduct.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text(err.toString())),
        data: (product) => asyncSchema.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text('Schema load failed: $err')),
          data: (merchant) => ListView(
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
              JsonSchemaRenderer(
                schemaRef: product.schemaRef.isNotEmpty
                    ? product.schemaRef
                    : merchant.url,
                schema: merchant.schema,
                attributes: {
                  for (final e in product.attributes.entries) e.key: e.value,
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
