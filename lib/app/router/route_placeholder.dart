import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

class RoutePlaceholder extends StatelessWidget {
  const RoutePlaceholder({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _ComingSoon(),
              const SizedBox(height: AppSpacing.sm),
              Text(title, style: _caption(context)),
            ],
          ),
        ),
      ),
    );
  }
}

TextStyle _caption(BuildContext context) {
  return Theme.of(context).textTheme.bodyMedium!.copyWith(
    color: AppColors.textSecondary,
    fontWeight: FontWeight.w600,
  );
}

class _ComingSoon extends StatefulWidget {
  const _ComingSoon();

  @override
  State<_ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<_ComingSoon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _motion;

  @override
  void initState() {
    super.initState();
    _motion = AnimationController(vsync: this, duration: AppMotion.comingSoon);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final still = AppMotion.resolve(context, AppMotion.comingSoon);
    if (still == Duration.zero) {
      _motion
        ..value = 0
        ..stop();
      return;
    }
    if (!_motion.isAnimating) {
      _motion.repeat();
    }
  }

  @override
  void dispose() {
    _motion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context).comingSoon;
    return AnimatedBuilder(
      animation: _motion,
      builder: (context, child) => _painted(child),
      child: Text(label, style: _letters(context)),
    );
  }

  Widget _painted(Widget? child) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: _shader,
      child: child,
    );
  }

  Shader _shader(Rect bounds) {
    final span = bounds.width * 1.7;
    final start = bounds.left - span * _motion.value;
    return ui.Gradient.linear(
      Offset(start, bounds.center.dy),
      Offset(start + span, bounds.center.dy),
      _run,
      _stops,
      ui.TileMode.repeated,
    );
  }
}

const _run = [
  Color(0xFFFF6AA8),
  Color(0xFFC5A8E8),
  Color(0xFF8EBEF6),
  Color(0xFFFF6AA8),
];

const _stops = [0.0, 0.42, 0.72, 1.0];

TextStyle _letters(BuildContext context) {
  return Theme.of(context).textTheme.headlineMedium!.copyWith(
    color: AppColors.onPrimary,
    fontSize: AppTextSize.headline,
    fontWeight: FontWeight.w800,
    height: AppTextHeight.tight,
  );
}
