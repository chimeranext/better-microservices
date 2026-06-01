import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'browse_providers.dart';

class BrowseScreen extends ConsumerWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPage = ref.watch(browseProductsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Browse')),
      body: asyncPage.when(
        data: (page) {
          if (page.products.isEmpty) {
            return const _EmptyState(
              message: 'No products yet. Seed data lands in PR-6 (#8).',
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: page.products.length,
            separatorBuilder: (_, _) => const Divider(),
            itemBuilder: (context, i) {
              final product = page.products[i];
              return ListTile(
                title: Text(product.title),
                subtitle: Text(product.description),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.goNamed(
                  'product_detail',
                  pathParameters: {'id': product.id},
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => _ErrorState(message: err.toString()),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(message, textAlign: TextAlign.center),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
