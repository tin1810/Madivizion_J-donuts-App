import 'dart:typed_data';

import 'package:madivizion_jdonuts_app/core/result/result.dart';

/// Bytes already stored for a remote image address.
abstract class ImageCache {
  Future<Uint8List?> read(String url);

  Future<void> write(String url, Uint8List bytes);
}

/// Downloads the bytes for a remote image address.
abstract class ImageFetcher {
  Future<Uint8List> fetch(String url);
}

/// Reads the disk cache, and downloads once when the file is missing.
class LoadRemoteImage {
  const LoadRemoteImage({
    required ImageCache cache,
    required ImageFetcher fetcher,
  }) : _cache = cache,
       _fetcher = fetcher;

  final ImageCache _cache;
  final ImageFetcher _fetcher;

  Future<Result<Uint8List>> call(String url) {
    return Result.capture(() async {
      final cached = await _cache.read(url);
      if (cached != null) {
        return cached;
      }
      final bytes = await _fetcher.fetch(url);
      await _cache.write(url, bytes);
      return bytes;
    });
  }
}

/// Bundled seed art. These files work with no network.
bool isBundledAsset(String url) => url.startsWith('assets/');
