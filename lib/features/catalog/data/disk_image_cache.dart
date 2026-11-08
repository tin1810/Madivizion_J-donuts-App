import 'dart:io';
import 'dart:typed_data';

import 'package:madivizion_jdonuts_app/core/error/app_failure.dart';
import 'package:madivizion_jdonuts_app/features/catalog/domain/image_cache.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Image files under the app support directory.
class DiskImageCache implements ImageCache {
  DiskImageCache(this._directory);

  final Directory _directory;

  @override
  Future<Uint8List?> read(String url) async {
    final file = _file(url);
    if (!file.existsSync()) {
      return null;
    }
    try {
      return await file.readAsBytes();
    } on Object {
      throw const CacheFailure();
    }
  }

  @override
  Future<void> write(String url, Uint8List bytes) async {
    try {
      await _file(url).writeAsBytes(bytes, flush: true);
    } on Object {
      throw const CacheFailure();
    }
  }

  File _file(String url) {
    return File(p.join(_directory.path, imageFileName(url)));
  }
}

/// Stable file name for [url]. The address itself is not a safe path.
String imageFileName(String url) {
  var hash = 17;
  for (final unit in url.codeUnits) {
    hash = (hash * 31 + unit) & 0x7fffffff;
  }
  return '$hash.img';
}

/// Creates the image folder beside the local database.
Future<DiskImageCache> openDiskImageCache() async {
  final support = await getApplicationSupportDirectory();
  final directory = Directory(p.join(support.path, 'images'));
  await directory.create(recursive: true);
  return DiskImageCache(directory);
}
