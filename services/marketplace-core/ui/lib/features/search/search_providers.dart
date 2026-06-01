import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../adapters/grpc_client.dart';
import '../../generated/marketplace_core.pb.dart';

/// Search query state — a simple string; PR-5 adds faceted filters.
final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = FutureProvider.autoDispose<ProductPage>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.trim().isEmpty) {
    return ProductPage(); // empty state
  }
  final client = ref.watch(storefrontClientProvider);
  final req = SearchRequest()
    ..query = query
    ..limit = 20;
  return client.searchProducts(req);
});
