import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/features/rewards/presentation/earn_clipart.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

/// A short burst of sparks from the tapped Earn button.
abstract final class EarnFireworks {
  static void show(BuildContext context) {
    if (AppMotion.resolve(context, _burst) == Duration.zero) {
      return;
    }
    final box = context.findRenderObject();
    final overlay = Overlay.maybeOf(context);
    if (box is! RenderBox || !box.hasSize || overlay == null) {
      return;
    }
    final origin = box.localToGlobal(box.size.center(Offset.zero));
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => _FireworkBurst(
        origin: origin,
        onDone: () {
          if (entry.mounted) {
            entry.remove();
          }
        },
      ),
    );
    overlay.insert(entry);
  }
}

class _FireworkBurst extends StatefulWidget {
  const _FireworkBurst({required this.origin, required this.onDone});

  final Offset origin;
  final VoidCallback onDone;

  @override
  State<_FireworkBurst> createState() => _FireworkBurstState();
}

class _FireworkBurstState extends State<_FireworkBurst>
    with SingleTickerProviderStateMixin {
  late final AnimationController _motion;

  @override
  void initState() {
    super.initState();
    _motion = AnimationController(vsync: this, duration: _burst);
    _motion.forward().whenComplete(widget.onDone);
  }

  @override
  void dispose() {
    _motion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _motion,
        builder: (context, _) {
          return Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _FireworkPainter(
                    origin: widget.origin,
                    progress: _motion.value,
                  ),
                ),
              ),
              _Congratulations(origin: widget.origin, progress: _motion.value),
            ],
          );
        },
      ),
    );
  }
}

class _Congratulations extends StatelessWidget {
  const _Congratulations({required this.origin, required this.progress});

  final Offset origin;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final pop = AppMotion.badgeCurve.transform((progress / 0.22).clamp(0, 1));
    final fade = progress < 0.75
        ? 1.0
        : (1 - (progress - 0.75) / 0.25).clamp(0.0, 1.0);
    return Positioned(
      left: 0,
      right: 0,
      top: math.max(16, origin.dy - 188),
      child: Opacity(
        opacity: fade,
        child: Transform.scale(
          scale: math.max(0, pop),
          child: Center(
            child: _CongratsCard(message: l10n.rewardsCongratulations),
          ),
        ),
      ),
    );
  }
}

class _CongratsCard extends StatelessWidget {
  const _CongratsCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.lg)),
        boxShadow: [
          BoxShadow(
            color: AppColors.rewardRing.withValues(alpha: 0.28),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.md,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const EarnClipart(),
            Text(message, style: _message(context)),
          ],
        ),
      ),
    );
  }

  TextStyle? _message(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium?.copyWith(
      color: AppColors.rewardRing,
      fontWeight: FontWeight.w800,
    );
  }
}

class _FireworkPainter extends CustomPainter {
  const _FireworkPainter({required this.origin, required this.progress});

  final Offset origin;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    for (final spark in _sparks) {
      _paintSpark(canvas, spark);
    }
    final flash = (1 - progress).clamp(0.0, 1.0);
    canvas.drawCircle(
      origin,
      16 * flash,
      Paint()..color = AppColors.surface.withValues(alpha: flash * 0.85),
    );
  }

  void _paintSpark(Canvas canvas, _Spark spark) {
    final local = ((progress - spark.delay) / (1 - spark.delay)).clamp(
      0.0,
      1.0,
    );
    if (local == 0) {
      return;
    }
    final travel = Curves.easeOutCubic.transform(local);
    final fade = (1 - local).clamp(0.0, 1.0);
    final head = _point(spark, travel);
    final tail = _point(spark, travel * 0.62);
    canvas.drawLine(
      tail,
      head,
      Paint()
        ..color = spark.color.withValues(alpha: fade * 0.75)
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(
      head,
      spark.size * (1.15 - local * 0.45),
      Paint()..color = spark.color.withValues(alpha: fade),
    );
  }

  Offset _point(_Spark spark, double travel) {
    return origin +
        Offset(math.cos(spark.angle), math.sin(spark.angle)) *
            spark.distance *
            travel;
  }

  @override
  bool shouldRepaint(_FireworkPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.origin != origin;
  }
}

class _Spark {
  const _Spark(this.angle, this.distance, this.color, this.size, this.delay);

  final double angle;
  final double distance;
  final Color color;
  final double size;
  final double delay;
}

const Duration _burst = Duration(milliseconds: 1600);

const List<_Spark> _sparks = [
  _Spark(0.2, 78, AppColors.rewardRing, 4.2, 0),
  _Spark(0.7, 96, AppColors.tierGold, 3.4, 0.02),
  _Spark(1.2, 70, AppColors.primary, 3.8, 0),
  _Spark(1.7, 108, AppColors.badge, 3.2, 0.04),
  _Spark(2.2, 84, AppColors.accent, 4, 0.01),
  _Spark(2.7, 92, AppColors.headerBell, 3.5, 0.03),
  _Spark(3.2, 74, AppColors.rewardRing, 3.6, 0),
  _Spark(3.8, 110, AppColors.primary, 3.1, 0.05),
  _Spark(4.4, 86, AppColors.tierGold, 4.4, 0.02),
  _Spark(5.0, 98, AppColors.accent, 3.3, 0.01),
  _Spark(5.6, 68, AppColors.badge, 3.7, 0.04),
  _Spark(6.0, 90, AppColors.headerBell, 3.2, 0),
  _Spark(0.45, 46, AppColors.primary, 2.4, 0.12),
  _Spark(1.45, 52, AppColors.rewardRing, 2.2, 0.14),
  _Spark(2.45, 44, AppColors.tierGold, 2.6, 0.1),
  _Spark(3.5, 50, AppColors.accent, 2.3, 0.16),
  _Spark(4.6, 42, AppColors.badge, 2.5, 0.12),
  _Spark(5.5, 48, AppColors.headerBell, 2.2, 0.15),
];
