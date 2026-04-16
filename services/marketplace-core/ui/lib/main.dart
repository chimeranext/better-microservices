import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/config.dart';
import 'app/router.dart';
import 'app/theme.dart';

/// Exposed so tests can inject a different AppConfig without touching
/// Platform.environment.
final appConfigProvider = Provider<AppConfig>(
  (ref) => throw UnimplementedError('appConfigProvider must be overridden in main'),
);

void main() {
  final config = AppConfig.fromEnvironment();
  runApp(
    ProviderScope(
      overrides: [appConfigProvider.overrideWithValue(config)],
      child: const MarketplaceStorefrontApp(),
    ),
  );
}

class MarketplaceStorefrontApp extends ConsumerWidget {
  const MarketplaceStorefrontApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Marketplace Storefront',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: appRouter,
    );
  }
}
