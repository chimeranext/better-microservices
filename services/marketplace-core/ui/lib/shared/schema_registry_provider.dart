import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart' show appConfigProvider;

/// A parsed merchant schema + its originating URL (for attribution in the UI
/// footer + bug reports).
class MerchantSchema {
  const MerchantSchema({required this.url, required this.schema});
  final String url;
  final Map<String, dynamic> schema;
}

/// Loads the merchant schema pointed to by `MERCHANT_SCHEMA_URL`. Accepts
/// `file://` (packaged assets, local mounts) and `http(s)://` URLs.
///
/// Returned as an `AsyncValue<MerchantSchema>` so screens can show an empty
/// state while the schema is being fetched; the whole UI is schema-driven,
/// so blocking rendering until it lands is correct behaviour.
final merchantSchemaProvider =
    FutureProvider<MerchantSchema>((ref) async {
  final config = ref.watch(appConfigProvider);
  final url = config.merchantSchemaUrl;
  final jsonStr = await _load(url);
  final parsed = jsonDecode(jsonStr);
  if (parsed is! Map) {
    throw FormatException('Schema at $url did not decode as a JSON object');
  }
  return MerchantSchema(url: url, schema: Map<String, dynamic>.from(parsed));
});

Future<String> _load(String url) async {
  final uri = Uri.parse(url);
  if (uri.scheme == 'file' || uri.scheme.isEmpty) {
    final path = uri.scheme.isEmpty ? url : uri.toFilePath();
    return File(path).readAsString();
  }
  if (uri.scheme == 'http' || uri.scheme == 'https') {
    final client = HttpClient();
    try {
      final request = await client.getUrl(uri);
      final response = await request.close();
      if (response.statusCode != 200) {
        throw HttpException('Failed to fetch schema: ${response.statusCode}', uri: uri);
      }
      return response.transform(utf8.decoder).join();
    } finally {
      client.close();
    }
  }
  throw UnsupportedError('Unsupported schema URL scheme: ${uri.scheme}');
}
