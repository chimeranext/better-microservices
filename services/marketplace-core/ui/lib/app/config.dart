import 'dart:io' show Platform;

/// Runtime configuration read from environment at startup.
///
/// `MERCHANT_SCHEMA_URL` is the key switch that makes this storefront generic:
/// swapping it (file:// or https://) changes every merchant-specific rendering
/// decision without any code change. PR-6 ships the three demo schemas.
class AppConfig {
  const AppConfig({
    required this.merchantSchemaUrl,
    required this.grpcHost,
    required this.grpcPort,
  });

  final String merchantSchemaUrl;
  final String grpcHost;
  final int grpcPort;

  static AppConfig fromEnvironment() {
    final env = Platform.environment;
    return AppConfig(
      merchantSchemaUrl: env['MERCHANT_SCHEMA_URL'] ??
          'file:///schemas/vertivolatam/hortalizas.v1.json',
      grpcHost: env['GRPC_HOST'] ?? 'localhost',
      grpcPort: int.tryParse(env['GRPC_PORT'] ?? '') ?? 50051,
    );
  }
}
