import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/features/catalog/data/disk_image_cache.dart';

void main() {
  test('writes an image and reads that same file back', () async {
    final directory = Directory.systemTemp.createTempSync('jdonuts-images');
    addTearDown(() => directory.deleteSync(recursive: true));
    final cache = DiskImageCache(directory);
    final bytes = Uint8List.fromList(const [9, 8, 7, 6]);

    await cache.write('https://cdn.example/donut.png', bytes);

    expect(await cache.read('https://cdn.example/donut.png'), bytes);
    expect(await cache.read('https://cdn.example/other.png'), isNull);
  });
}
