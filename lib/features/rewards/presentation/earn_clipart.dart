import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';

/// Party poppers, a gift, and stars shown with the congratulations card.
class EarnClipart extends StatelessWidget {
  const EarnClipart({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 196,
      height: 64,
      child: CustomPaint(painter: _ClipartPainter()),
    );
  }
}

class _ClipartPainter extends CustomPainter {
  const _ClipartPainter();

  @override
  void paint(Canvas canvas, Size size) {
    _popper(canvas, const Offset(18, 46), 1);
    _popper(canvas, Offset(size.width - 18, 46), -1);
    _gift(canvas, Offset(size.width / 2, 34));
    _star(canvas, const Offset(52, 16), 8, AppColors.tierGold);
    _star(canvas, Offset(size.width - 54, 18), 7, AppColors.primary);
    _star(canvas, Offset(size.width / 2, 8), 5, AppColors.accent);
  }

  void _popper(Canvas canvas, Offset tip, double direction) {
    final cone = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(tip.dx - 16 * direction, tip.dy - 28)
      ..lineTo(tip.dx - 4 * direction, tip.dy - 24)
      ..close();
    canvas.drawPath(cone, Paint()..color = AppColors.headerBell);
    for (var index = 0; index < _confetti.length; index++) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: tip + Offset((10 + index * 8) * direction, -30 - index * 4),
            width: 6,
            height: 4,
          ),
          const Radius.circular(1),
        ),
        Paint()..color = _confetti[index],
      );
    }
  }

  void _gift(Canvas canvas, Offset center) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 28, height: 22),
        const Radius.circular(4),
      ),
      Paint()..color = AppColors.rewardRing,
    );
    canvas.drawRect(
      Rect.fromCenter(center: center, width: 6, height: 22),
      Paint()..color = AppColors.tierGold,
    );
    canvas.drawCircle(
      center.translate(0, -14),
      5,
      Paint()..color = AppColors.tierGold,
    );
  }

  void _star(Canvas canvas, Offset center, double radius, Color color) {
    final path = Path();
    for (var index = 0; index < 10; index++) {
      final angle = -math.pi / 2 + index * math.pi / 5;
      final reach = index.isEven ? radius : radius * 0.45;
      final point = center + Offset(math.cos(angle), math.sin(angle)) * reach;
      if (index == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    canvas.drawPath(path..close(), Paint()..color = color);
  }

  @override
  bool shouldRepaint(_ClipartPainter oldDelegate) => false;
}

const List<Color> _confetti = [
  AppColors.primary,
  AppColors.rewardRing,
  AppColors.tierGold,
  AppColors.accent,
];
