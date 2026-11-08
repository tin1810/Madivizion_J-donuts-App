import 'dart:io';
import 'dart:typed_data';

import 'package:madivizion_jdonuts_app/core/error/app_failure.dart';
import 'package:madivizion_jdonuts_app/features/catalog/domain/image_cache.dart';

/// Downloads one image. A missing or failed response is a [NetworkFailure].
class HttpImageFetcher implements ImageFetcher {
  const HttpImageFetcher();

  @override
  Future<Uint8List> fetch(String url) async {
    final client = HttpClient();
    try {
      final request = await client.getUrl(Uri.parse(url));
      final response = await request.close().timeout(
        const Duration(seconds: 8),
      );
      if (response.statusCode != HttpStatus.ok) {
        throw const NetworkFailure();
      }
      return await _bytes(response);
    } on AppFailure {
      rethrow;
    } on Object {
      throw const NetworkFailure();
    } finally {
      client.close(force: true);
    }
  }
}

Future<Uint8List> _bytes(HttpClientResponse response) async {
  final builder = await response.fold<BytesBuilder>(
    BytesBuilder(copy: false),
    (builder, chunk) => builder..add(chunk),
  );
  return builder.takeBytes();
}

/// Used when the app has no disk cache, so a remote load fails closed.
class UnavailableImageFetcher implements ImageFetcher {
  const UnavailableImageFetcher();

  @override
  Future<Uint8List> fetch(String url) {
    throw const NetworkFailure();
  }
}
