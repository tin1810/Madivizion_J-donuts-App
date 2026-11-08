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
  static const double _size = 32;

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
        child: Icon(Icons.check, color: AppColors.onPrimary, size: 18),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2 - 2;
    final track = Paint()
      ..color = AppColors.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    final arc = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas
      ..drawCircle(center, radius, track)
      ..drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        math.pi * 2 * progress.clamp(0, 1),
        false,
        arc,
      );
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
