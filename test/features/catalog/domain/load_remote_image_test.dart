import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/catalog/data/http_image_fetcher.dart';
import 'package:madivizion_jdonuts_app/features/catalog/data/memory_image_cache.dart';
import 'package:madivizion_jdonuts_app/features/catalog/domain/image_cache.dart';

void main() {
  test('a remote image is downloaded once and then read from cache', () async {
    final fetcher = _CountingFetcher();
    final load = LoadRemoteImage(cache: MemoryImageCache(), fetcher: fetcher);

    final first = await load('https://example.com/donut.png');
    final second = await load('https://example.com/donut.png');

    expect(first, isA<Success<Uint8List>>());
    expect(second, isA<Success<Uint8List>>());
    expect(fetcher.calls, 1);
  });

  test('a failed download is a network failure', () async {
    final load = LoadRemoteImage(
      cache: MemoryImageCache(),
      fetcher: const UnavailableImageFetcher(),
    );

    final result = await load('https://example.com/missing.png');

    expect(result, isA<Failure<Uint8List>>());
    expect((result as Failure<Uint8List>).failure, isA<NetworkFailure>());
  });
}

class _CountingFetcher implements ImageFetcher {
  var calls = 0;

  @override
  Future<Uint8List> fetch(String url) async {
    calls += 1;
    return Uint8List.fromList(const [1, 2, 3]);
  }
}
