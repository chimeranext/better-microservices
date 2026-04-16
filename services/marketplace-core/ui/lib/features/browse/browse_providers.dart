import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../adapters/grpc_client.dart';
import '../../generated/marketplace_core.pb.dart';

/// Fetches the first browse page. PR-5 will extend this with cursor-based
/// pagination and filter state; for now it's a one-shot "give me the catalog".
final browseProductsProvider = FutureProvider.autoDispose<ProductPage>((ref) async {
  final client = ref.watch(storefrontClientProvider);
  final req = BrowseRequest()..limit = 20;
  return client.browseProducts(req);
});
