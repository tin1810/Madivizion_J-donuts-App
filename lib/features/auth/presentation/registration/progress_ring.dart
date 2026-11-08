import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';

/// Registration progress. The last step morphs the full ring into a check.
class ProgressRing extends StatefulWidget {
  const ProgressRing({
    required this.progress,
    required this.checked,
    super.key,
  });

  final double progress;
  final bool checked;

  @override
  State<ProgressRing> createState() => _ProgressRingState();
}

class _ProgressRingState extends State<ProgressRing>
    with SingleTickerProviderStateMixin {
  static const double _size = 36;

  late final AnimationController _motion;
  late Animation<double> _value;
  CurvedAnimation? _curve;

  @override
  void initState() {
    super.initState();
    _motion = AnimationController(vsync: this, duration: AppMotion.ring);
    _value = AlwaysStoppedAnimation<double>(widget.progress);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _motion.duration = AppMotion.resolve(context, AppMotion.ring);
  }

  @override
  void didUpdateWidget(ProgressRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress == widget.progress) {
      return;
    }
    _curve?.dispose();
    _curve = CurvedAnimation(parent: _motion, curve: AppMotion.enterCurve);
    _value = Tween<double>(
      begin: _value.value,
      end: widget.progress,
    ).animate(_curve!);
    _motion.forward(from: 0);
  }

  @override
  void dispose() {
    _curve?.dispose();
    _motion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: _size,
      child: AnimatedBuilder(
        animation: _motion,
        builder: (context, child) {
          final shown = _value.value;
          return CustomPaint(
            painter: _RingPainter(progress: shown),
            child: _Check(visible: widget.checked && shown >= 1),
          );
        },
      ),
    );
  }
}

class _Check extends StatelessWidget {
  const _Check({required this.visible});

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: AppMotion.resolve(context, AppMotion.fast),
      child: const DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.accent,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(Icons.check, color: AppColors.onPrimary, size: 18),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.shortestSide * 0.30;
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - stroke) / 2;
    final cyan = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;
    final pink = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;
    final rect = Rect.fromCircle(center: center, radius: radius);
    // Pink starts at 12 o'clock and grows clockwise. Phone is a short arc.
    final amount = progress.clamp(0.0, 1.0).toDouble();
    final pinkDegrees = (72 + (amount - 0.25) * 396).clamp(36.0, 360.0);
    final pinkSweep = _rad(pinkDegrees.toDouble());
    canvas
      ..drawArc(rect, _rad(270), pinkSweep, false, pink)
      ..drawArc(
        rect,
        _rad(270) + pinkSweep,
        math.pi * 2 - pinkSweep,
        false,
        cyan,
      );
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

double _rad(double degrees) => degrees * math.pi / 180;
