import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/rewards_board.dart';

/// A plump donut, or an iced coffee framed by its progress arc.
class ChallengeArt extends StatelessWidget {
  const ChallengeArt({required this.challenge, super.key});

  final RewardChallenge challenge;

  @override
  Widget build(BuildContext context) {
    final painter = challenge.artwork == RewardArtwork.coffee
        ? _CoffeePainter(fraction: challenge.fraction)
        : _DonutPainter(fraction: challenge.fraction);
    return CustomPaint(painter: painter);
  }
}

class _DonutPainter extends CustomPainter {
  const _DonutPainter({required this.fraction});

  final double fraction;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final outer = size.shortestSide * 0.46;
    final band = Rect.fromCircle(center: center, radius: outer * 0.72);
    canvas.drawOval(
      Rect.fromCenter(
        center: center.translate(0, outer * 0.15),
        width: outer * 1.5,
        height: outer * 0.35,
      ),
      Paint()..color = AppColors.textPrimary.withValues(alpha: 0.08),
    );
    canvas.drawCircle(center, outer, Paint()..color = AppColors.ringTrack);
    canvas.drawCircle(center, outer * 0.42, Paint()..color = AppColors.surface);
    _icing(canvas, band);
    _sprinkles(canvas, band);
    canvas.drawCircle(center, outer * 0.28, Paint()..color = AppColors.surface);
  }

  void _icing(Canvas canvas, Rect band) {
    final dough = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = band.width * 0.34
      ..strokeCap = StrokeCap.butt
      ..color = AppColors.ringTrack;
    final pink = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = band.width * 0.34
      ..strokeCap = StrokeCap.butt
      ..color = AppColors.rewardRing;
    canvas.drawArc(band, 0, math.pi * 2, false, dough);
    if (fraction <= 0) {
      return;
    }
    canvas.drawArc(band, -math.pi / 2, math.pi * 2 * fraction, false, pink);
  }

  void _sprinkles(Canvas canvas, Rect band) {
    const marks = [
      AppColors.onPrimary,
      AppColors.primary,
      AppColors.badge,
      AppColors.headerStar,
      AppColors.info,
      AppColors.accent,
    ];
    final radius = band.width / 2;
    for (var index = 0; index < 22; index++) {
      final angle = index * math.pi * 2 / 22;
      final onPink = _onPink(angle);
      final at =
          band.center + Offset(math.cos(angle), math.sin(angle)) * radius;
      final paint = Paint()
        ..color = onPink ? marks[index % 3] : marks[index % marks.length]
        ..strokeWidth = 2.2
        ..strokeCap = StrokeCap.round;
      final tangent = Offset(-math.sin(angle), math.cos(angle));
      canvas.drawLine(at - tangent * 3.2, at + tangent * 3.2, paint);
    }
  }

  bool _onPink(double angle) {
    if (fraction >= 1) {
      return true;
    }
    final fromTop = (angle + math.pi / 2) % (math.pi * 2);
    return fromTop <= math.pi * 2 * fraction;
  }

  @override
  bool shouldRepaint(_DonutPainter oldDelegate) =>
      oldDelegate.fraction != fraction;
}

class _CoffeePainter extends CustomPainter {
  const _CoffeePainter({required this.fraction});

  final double fraction;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final arc = Rect.fromCircle(
      center: center.translate(0, 2),
      radius: size.shortestSide * 0.42,
    );
    canvas.drawArc(arc, _arcStart, _arcSweep, false, _arc(AppColors.ringTrack));
    canvas.drawArc(
      arc,
      _arcStart,
      _arcSweep * fraction,
      false,
      _arc(AppColors.headerBell),
    );
    _glass(canvas, center.translate(0, 8), size.shortestSide);
  }

  void _glass(Canvas canvas, Offset center, double side) {
    final glass = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: side * 0.34, height: side * 0.5),
      const Radius.circular(12),
    );
    canvas.save();
    canvas.clipRRect(glass);
    canvas.drawRect(glass.outerRect, Paint()..color = AppColors.coffeeBrew);
    canvas.drawRect(
      glass.outerRect.shift(Offset(0, -side * 0.12)),
      Paint()..color = AppColors.coffeeMilk,
    );
    canvas.drawRect(
      Rect.fromLTWH(glass.left, glass.top, glass.width, glass.height * 0.28),
      Paint()..color = AppColors.coffeeFoam,
    );
    _ice(canvas, center);
    canvas.restore();
    canvas.drawRRect(
      glass,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = AppColors.border,
    );
  }

  void _ice(Canvas canvas, Offset center) {
    final paint = Paint()..color = AppColors.surface.withValues(alpha: 0.85);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center.translate(-6, -8), width: 8, height: 8),
        const Radius.circular(2),
      ),
      paint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center.translate(5, -4), width: 7, height: 7),
        const Radius.circular(2),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(_CoffeePainter oldDelegate) =>
      oldDelegate.fraction != fraction;
}

Paint _arc(Color color) {
  return Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 8
    ..strokeCap = StrokeCap.round
    ..color = color;
}

const double _arcStart = math.pi * 1.02;
const double _arcSweep = math.pi * 1.2;
