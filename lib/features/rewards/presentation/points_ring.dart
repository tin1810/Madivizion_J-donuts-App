import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/features/catalog/domain/catalog_product.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

/// Pink points ring. [reveal] runs from 0 to 1 while the number counts up.
class PointsRing extends StatelessWidget {
  const PointsRing({required this.points, required this.reveal, super.key});

  final int points;
  final Animation<double> reveal;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: _size,
      child: AnimatedBuilder(
        animation: reveal,
        builder: (context, _) {
          return CustomPaint(
            painter: _RingPainter(reveal: reveal.value),
            child: Center(
              child: _Label(points: points, reveal: reveal),
            ),
          );
        },
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.points, required this.reveal});

  final int points;
  final Animation<double> reveal;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AnimatedBuilder(
      animation: reveal,
      builder: (context, _) {
        final shown = (points * reveal.value).round();
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(l10n.rewardsTotalPoints, style: _caption(context)),
            Text(formatMmkAmount(shown), style: _points(context)),
          ],
        );
      },
    );
  }

  TextStyle? _caption(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.rewardRing,
      fontSize: AppTextSize.caption,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle? _points(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge?.copyWith(
      color: AppColors.rewardRing,
      fontSize: AppTextSize.subtitle,
      fontWeight: FontWeight.w700,
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({required this.reveal});

  final double reveal;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: size.width / 2 - _stroke / 2,
    );
    canvas.drawArc(
      rect,
      _gapCenter - _gap / 2,
      _gap,
      false,
      _band(AppColors.ringTrack),
    );
    canvas.drawArc(
      rect,
      _pinkStart,
      _pinkSweep * reveal,
      false,
      _band(AppColors.rewardRing),
    );
    _sprinkles(canvas, rect);
  }

  void _sprinkles(Canvas canvas, Rect rect) {
    final paint = Paint()
      ..color = AppColors.onPrimary
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;
    final drawn = _pinkSweep * reveal;
    if (drawn < 0.3) {
      return;
    }
    const count = 22;
    for (var index = 0; index < count; index++) {
      final angle = _pinkStart + drawn * (index + 0.5) / count;
      final radius = rect.width / 2;
      final center =
          rect.center + Offset(math.cos(angle), math.sin(angle)) * radius;
      final tangent = Offset(-math.sin(angle), math.cos(angle));
      final length = index.isEven ? 7.0 : 5.0;
      canvas.drawLine(
        center - tangent * length,
        center + tangent * length,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) {
    return oldDelegate.reveal != reveal;
  }
}

const double _size = 208;
const double _stroke = 50;
const double _gapCenter = -math.pi * 0.62;
const double _gap = math.pi * 0.72;
const double _pinkStart = _gapCenter + _gap / 2;
const double _pinkSweep = math.pi * 2 - _gap;

Paint _band(Color color) {
  return Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = _stroke
    ..strokeCap = StrokeCap.round
    ..color = color;
}
