import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';

/// One painted donut circle. Colours belong to the illustration, not the UI.
class DonutArt {
  const DonutArt({
    required this.dough,
    required this.frosting,
    this.sprinkles = const <Color>[],
  });

  final Color dough;
  final Color frosting;
  final List<Color> sprinkles;
}

abstract final class DonutArts {
  static const DonutArt chocolate = DonutArt(
    dough: Color(0xFFD7A07A),
    frosting: Color(0xFF6A3B2A),
  );
  static const DonutArt pink = DonutArt(
    dough: Color(0xFFF2C2A0),
    frosting: Color(0xFFFF7AA8),
    sprinkles: <Color>[
      Color(0xFFFFFFFF),
      Color(0xFFFFD15C),
      Color(0xFF5CC8FF),
      Color(0xFFFF5C8A),
    ],
  );
  static const DonutArt purple = DonutArt(
    dough: Color(0xFFF0C8AA),
    frosting: Color(0xFF8B63F6),
    sprinkles: <Color>[Color(0xFFFFFFFF), Color(0xFFFFD15C), Color(0xFFFF8FB8)],
  );
  static const DonutArt honey = DonutArt(
    dough: Color(0xFFF3D2A8),
    frosting: Color(0xFFFFC14D),
  );
  static const DonutArt berry = DonutArt(
    dough: Color(0xFFF2C8B0),
    frosting: Color(0xFFE25B8A),
    sprinkles: <Color>[Color(0xFFFFFFFF), Color(0xFF7DDEFF)],
  );
}

class DonutBadge extends StatelessWidget {
  const DonutBadge({required this.art, required this.size, super.key});

  final DonutArt art;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(painter: DonutPainter(art)),
    );
  }
}

class DonutPainter extends CustomPainter {
  const DonutPainter(this.art);

  final DonutArt art;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final outer = size.shortestSide / 2;
    _shadow(canvas, center, outer);
    _rings(canvas, center, outer);
    _sprinkles(canvas, center, outer);
    _hole(canvas, center, outer);
    _shine(canvas, center, outer);
  }

  void _shadow(Canvas canvas, Offset center, double outer) {
    canvas.drawCircle(
      center.translate(0, outer * 0.08),
      outer * 0.9,
      Paint()
        ..color = AppColors.textPrimary.withValues(alpha: 0.08)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
    );
  }

  void _rings(Canvas canvas, Offset center, double outer) {
    canvas
      ..drawCircle(center, outer, Paint()..color = art.dough)
      ..drawCircle(center, outer * 0.9, Paint()..color = art.frosting);
  }

  void _sprinkles(Canvas canvas, Offset center, double outer) {
    final colors = art.sprinkles;
    if (colors.isEmpty) {
      return;
    }
    for (var index = 0; index < colors.length * 3; index++) {
      _sprinkle(canvas, center, outer, colors[index % colors.length], index);
    }
  }

  void _sprinkle(
    Canvas canvas,
    Offset center,
    double outer,
    Color color,
    int index,
  ) {
    final angle = (index / 8) * math.pi * 2;
    final radius = outer * (index.isEven ? 0.62 : 0.74);
    canvas
      ..save()
      ..translate(
        center.dx + math.cos(angle) * radius,
        center.dy + math.sin(angle) * radius,
      )
      ..rotate(angle);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-6, -1.6, 12, 3.2),
        const Radius.circular(2),
      ),
      Paint()..color = color,
    );
    canvas.restore();
  }

  void _hole(Canvas canvas, Offset center, double outer) {
    canvas.drawCircle(
      center,
      outer * 0.34,
      Paint()..color = AppColors.background,
    );
  }

  void _shine(Canvas canvas, Offset center, double outer) {
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: outer * 0.72),
      -2.4,
      1.1,
      false,
      Paint()
        ..color = AppColors.surface.withValues(alpha: 0.45)
        ..style = PaintingStyle.stroke
        ..strokeWidth = outer * 0.08
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(DonutPainter oldDelegate) => oldDelegate.art != art;
}
