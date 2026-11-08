import 'dart:typed_data';

import 'package:madivizion_jdonuts_app/features/catalog/domain/image_cache.dart';

/// Cache that lives in memory. Widget tests use it instead of the disk.
class MemoryImageCache implements ImageCache {
  final Map<String, Uint8List> _files = {};

  @override
  Future<Uint8List?> read(String url) async => _files[url];

  @override
  Future<void> write(String url, Uint8List bytes) async {
    _files[url] = bytes;
  }
}
