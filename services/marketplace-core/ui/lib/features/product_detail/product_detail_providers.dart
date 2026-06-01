import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../adapters/grpc_client.dart';
import '../../generated/marketplace_core.pb.dart';

/// Fetches a single product by id. The response includes the schema_ref that
/// PR-5's renderer will use to decide how to display attributes.
final productDetailProvider =
    FutureProvider.autoDispose.family<Product, String>((ref, id) async {
  final client = ref.watch(storefrontClientProvider);
  final req = GetProductRequest()..id = id;
  return client.getProductDetail(req);
});
