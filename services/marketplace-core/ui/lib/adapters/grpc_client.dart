import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';

import '../generated/marketplace_core.pbgrpc.dart';
import '../main.dart' show appConfigProvider;

/// gRPC channel provider — one shared channel per app lifecycle. Keeps keepalive
/// on, insecure credentials (we'll harden once TLS lands in a follow-up PR).
final grpcChannelProvider = Provider<ClientChannel>((ref) {
  final config = ref.watch(appConfigProvider);
  final channel = ClientChannel(
    config.grpcHost,
    port: config.grpcPort,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
      idleTimeout: Duration(minutes: 5),
      keepAlive: ClientKeepAliveOptions(pingInterval: Duration(seconds: 30)),
    ),
  );
  ref.onDispose(() async {
    await channel.shutdown();
  });
  return channel;
});

/// Storefront client — wraps the generated gRPC stub. All read-path RPCs
/// (BrowseProducts / GetProductDetail / SearchProducts) flow through here.
final storefrontClientProvider = Provider<MarketplaceStorefrontClient>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  return MarketplaceStorefrontClient(channel);
});
