import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

/// Paints the bundled catalog and welcome images. Run from the project root.
void main() {
  final root = Directory('assets/catalog');
  root.createSync(recursive: true);
  _welcome(root);
  _products(root);
  _banners(root);
  _shops(root);
  _member(root);
  stdout.writeln('painted ${root.listSync().length} images');
}

void _welcome(Directory root) {
  _save(root, 'welcome_purple.png', _tile(0xFFBFEFFF, _purple()));
  _save(root, 'welcome_chocolate.png', _tile(0xFFF6E2D2, _chocolate()));
  _save(root, 'welcome_sprinkle.png', _tile(0xFFFFE0D4, _pink()));
  _save(root, 'welcome_honey.png', _tile(0xFFFFD56A, _honey()));
}

void _products(Directory root) {
  const paper = 0xFFFFF7F2;
  _save(root, 'p_coconut.png', _tile(paper, _chocolate(cx: 160, cy: 150)));
  _save(root, 'p_strawberry.png', _tile(paper, _pink()));
  _save(root, 'p_mistletoe.png', _tile(paper, _purple(cx: 110, cy: 160)));
  _save(root, 'p_christmas_mix.png', _tile(paper, _honey(cx: 200, cy: 160)));
  _save(root, 'p_santa_cookies.png', _tile(paper, _pink(cx: 160, cy: 170)));
  _save(
    root,
    'p_santa_cookies_2.png',
    _tile(paper, _chocolate(cx: 160, cy: 180, outer: 90)),
  );
  _save(root, 'p_dalgona.png', _glass());
}

void _banners(Directory root) {
  _save(root, 'banner_central.png', _banner(0xFF6C4CFF, 0xFF20D0E8));
  _save(root, 'banner_hot.png', _banner(0xFFFF8A3D, 0xFFFFD56A));
}

void _shops(Directory root) {
  _save(root, 'shop_central.png', _shop(0xFF6C4CFF));
  _save(root, 'shop_junction.png', _shop(0xFF20D0E8));
  _save(root, 'shop_plaza.png', _shop(0xFFF868A0));
  _save(root, 'shop_time.png', _shop(0xFFFFB020));
}

void _member(Directory root) {
  final canvas = _Canvas(320, 320, 0xFFFFD9C8);
  canvas.disk(160, 118, 78, 0xFF4A2C22);
  canvas.disk(160, 150, 62, 0xFFE8B89A);
  canvas.disk(138, 146, 5, 0xFF3A2A28);
  canvas.disk(182, 146, 5, 0xFF3A2A28);
  canvas.fillRect(0, 230, 320, 320, 0xFFF868A0);
  _save(root, 'member_hania.png', canvas);
}

_Canvas _tile(int background, void Function(_Canvas canvas) paint) {
  final canvas = _Canvas(320, 400, background);
  paint(canvas);
  return canvas;
}

void Function(_Canvas canvas) _purple({int cx = 160, int cy = 190}) {
  return (canvas) => _donut(
    canvas,
    cx: cx,
    cy: cy,
    dough: 0xFFF0C8AA,
    frosting: 0xFF8B63F6,
    sprinkles: const [0xFFFFFFFF, 0xFFFFD15C, 0xFFFF8FB8],
  );
}

void Function(_Canvas canvas) _chocolate({
  int cx = 160,
  int cy = 190,
  int outer = 120,
}) {
  return (canvas) => _donut(
    canvas,
    cx: cx,
    cy: cy,
    outer: outer,
    dough: 0xFFD7A07A,
    frosting: 0xFF6A3B2A,
    stripe: 0xFF3E2118,
  );
}

void Function(_Canvas canvas) _pink({int cx = 160, int cy = 200}) {
  return (canvas) => _donut(
    canvas,
    cx: cx,
    cy: cy,
    dough: 0xFFF2C2A0,
    frosting: 0xFFFF7AA8,
    sprinkles: const [0xFFFFFFFF, 0xFFFFD15C, 0xFF5CC8FF, 0xFFFF5C8A],
  );
}

void Function(_Canvas canvas) _honey({int cx = 170, int cy = 210}) {
  return (canvas) =>
      _donut(canvas, cx: cx, cy: cy, dough: 0xFFF3D2A8, frosting: 0xFFFFC14D);
}

void _donut(
  _Canvas canvas, {
  required int cx,
  required int cy,
  required int dough,
  required int frosting,
  int outer = 120,
  int? stripe,
  List<int> sprinkles = const [],
}) {
  canvas.blendDisk(cx + 8, cy + 18, outer, 0x33000000);
  const hole = 38;
  final frostOuter = (outer * 0.86).round();
  final frostInner = (hole * 1.3).round();
  for (var y = cy - outer; y <= cy + outer; y++) {
    for (var x = cx - outer; x <= cx + outer; x++) {
      final dx = x - cx;
      final dy = y - cy;
      final distance = dx * dx + dy * dy;
      if (distance > outer * outer || distance < hole * hole) {
        continue;
      }
      var color = dough;
      final inFrost =
          distance <= frostOuter * frostOuter &&
          distance >= frostInner * frostInner;
      if (inFrost) {
        color = stripe != null && _striped(dx, dy) ? stripe : frosting;
      }
      canvas.dot(x, y, color);
    }
  }
  final spots = _spots(outer, sprinkles);
  for (final spot in spots) {
    canvas.disk(cx + spot.dx, cy + spot.dy, 5, spot.color);
  }
}

bool _striped(int dx, int dy) {
  final turns = (math.atan2(dy, dx) + math.pi) / (math.pi / 5);
  return turns.floor().isEven;
}

List<({int dx, int dy, int color})> _spots(int outer, List<int> colors) {
  const angles = <double>[0.4, 1.2, 2.0, 2.8, 3.6, 4.5, 5.3, 6.0];
  return [
    for (var i = 0; i < colors.length && i < angles.length; i++)
      (
        dx: (math.cos(angles[i]) * outer * 0.62).round(),
        dy: (math.sin(angles[i]) * outer * 0.62).round(),
        color: colors[i],
      ),
  ];
}

_Canvas _glass() {
  final canvas = _Canvas(320, 400, 0xFFFFF7F2);
  canvas.disk(160, 250, 70, 0xFFE7D3C4);
  canvas.fillRect(128, 120, 192, 250, 0xFFFFF3E4);
  canvas.fillRect(128, 120, 192, 168, 0xFF8A5A32);
  canvas.fillRect(136, 176, 184, 230, 0xFFFFE3B8);
  return canvas;
}

_Canvas _banner(int left, int right) {
  final canvas = _Canvas(640, 320, left);
  canvas.fillRect(360, 0, 640, 320, right);
  _donut(canvas, cx: 180, cy: 170, dough: 0xFFF0C8AA, frosting: 0xFFFFFFFF);
  return canvas;
}

_Canvas _shop(int awning) {
  final canvas = _Canvas(320, 240, 0xFFE7F7FF);
  canvas.fillRect(40, 90, 280, 240, 0xFFFFF7F2);
  canvas.fillRect(40, 78, 280, 110, awning);
  canvas.fillRect(150, 150, 200, 240, 0xFF6A3B2A);
  canvas.fillRect(70, 130, 120, 180, 0xFFBFEFFF);
  canvas.fillRect(210, 130, 260, 180, 0xFFBFEFFF);
  return canvas;
}

void _save(Directory root, String name, _Canvas canvas) {
  File('${root.path}/$name').writeAsBytesSync(canvas.toPng());
}

class _Canvas {
  _Canvas(this.width, this.height, int background)
    : pixels = Uint32List(width * height) {
    pixels.fillRange(0, pixels.length, background);
  }

  final int width;
  final int height;
  final Uint32List pixels;

  void dot(int x, int y, int color) {
    if (x < 0 || y < 0 || x >= width || y >= height) {
      return;
    }
    pixels[y * width + x] = color;
  }

  void fillRect(int left, int top, int right, int bottom, int color) {
    for (var y = top; y < bottom; y++) {
      for (var x = left; x < right; x++) {
        dot(x, y, color);
      }
    }
  }

  void disk(int cx, int cy, int radius, int color) {
    final reach = radius * radius;
    for (var y = cy - radius; y <= cy + radius; y++) {
      for (var x = cx - radius; x <= cx + radius; x++) {
        final dx = x - cx;
        final dy = y - cy;
        if (dx * dx + dy * dy <= reach) {
          dot(x, y, color);
        }
      }
    }
  }

  void blendDisk(int cx, int cy, int radius, int color) {
    final reach = radius * radius;
    for (var y = cy - radius; y <= cy + radius; y++) {
      for (var x = cx - radius; x <= cx + radius; x++) {
        final dx = x - cx;
        final dy = y - cy;
        if (dx * dx + dy * dy <= reach) {
          _blend(x, y, color);
        }
      }
    }
  }

  void _blend(int x, int y, int source) {
    if (x < 0 || y < 0 || x >= width || y >= height) {
      return;
    }
    final destination = pixels[y * width + x];
    final sa = (source >> 24) & 0xff;
    final inv = 255 - sa;
    final red =
        ((source >> 16) & 0xff) * sa + ((destination >> 16) & 0xff) * inv;
    final green =
        ((source >> 8) & 0xff) * sa + ((destination >> 8) & 0xff) * inv;
    final blue = (source & 0xff) * sa + (destination & 0xff) * inv;
    pixels[y * width + x] =
        0xFF000000 |
        ((red ~/ 255) << 16) |
        ((green ~/ 255) << 8) |
        (blue ~/ 255);
  }

  Uint8List toPng() {
    final raw = BytesBuilder();
    final row = Uint8List(1 + width * 4);
    for (var y = 0; y < height; y++) {
      var index = 1;
      for (var x = 0; x < width; x++) {
        final pixel = pixels[y * width + x];
        row[index++] = (pixel >> 16) & 0xff;
        row[index++] = (pixel >> 8) & 0xff;
        row[index++] = pixel & 0xff;
        row[index++] = (pixel >> 24) & 0xff;
      }
      raw.add(row);
    }
    return _png(width, height, ZLibEncoder().convert(raw.toBytes()));
  }
}

Uint8List _png(int width, int height, List<int> zlib) {
  final header = ByteData(13);
  header
    ..setUint32(0, width)
    ..setUint32(4, height)
    ..setUint8(8, 8)
    ..setUint8(9, 6);
  final bytes = BytesBuilder(copy: false)
    ..add(const [137, 80, 78, 71, 13, 10, 26, 10])
    ..add(_chunk('IHDR', header.buffer.asUint8List()))
    ..add(_chunk('IDAT', zlib))
    ..add(_chunk('IEND', const []));
  return bytes.toBytes();
}

List<int> _chunk(String type, List<int> data) {
  final head = ByteData(4)..setUint32(0, data.length);
  final body = <int>[...type.codeUnits, ...data];
  final crc = ByteData(4)..setUint32(0, _crc(body));
  return [...head.buffer.asUint8List(), ...body, ...crc.buffer.asUint8List()];
}

int _crc(List<int> data) {
  var value = 0xffffffff;
  for (final byte in data) {
    value ^= byte;
    for (var bit = 0; bit < 8; bit++) {
      final mask = -(value & 1);
      value = (value >> 1) ^ (0xedb88320 & mask);
    }
  }
  return value ^ 0xffffffff;
}
