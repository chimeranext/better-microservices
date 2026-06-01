import 'package:flutter/material.dart';

/// Centralised theme. Kept deliberately plain so PR-5's schema renderer can
/// inject merchant-specific branding via the `theme` field on Storefront.
abstract final class AppTheme {
  static ThemeData light() => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F7B3F)),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  static ThemeData dark() => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F7B3F),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}
