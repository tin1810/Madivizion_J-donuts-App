import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';

/// Grey blocks while Home is reading Drift. The sweep runs once.
class HomeSkeleton extends StatefulWidget {
  const HomeSkeleton({super.key});

  @override
  State<HomeSkeleton> createState() => _HomeSkeletonState();
}

class _HomeSkeletonState extends State<HomeSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _sweep;

  @override
  void initState() {
    super.initState();
    _sweep = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sweep.duration = AppMotion.resolve(context, AppMotion.entrance);
    if (_sweep.duration == Duration.zero) {
      _sweep.value = 1;
      return;
    }
    if (!_sweep.isAnimating && _sweep.value == 0) {
      _sweep.forward();
    }
  }

  @override
  void dispose() {
    _sweep.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sweep,
      builder: (context, _) {
        return ListView(
          key: const Key('home-skeleton'),
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            _block(height: 72, width: double.infinity, align: _sweep.value),
            const SizedBox(height: AppSpacing.lg),
            _block(height: 150, width: double.infinity, align: _sweep.value),
            const SizedBox(height: AppSpacing.lg),
            _row(_sweep.value),
          ],
        );
      },
    );
  }

  Widget _row(double align) {
    return Row(
      children: [
        _block(height: 160, width: 140, align: align),
        const SizedBox(width: AppSpacing.sm),
        _block(height: 160, width: 140, align: align),
      ],
    );
  }

  Widget _block({
    required double height,
    required double width,
    required double align,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.md)),
        gradient: LinearGradient(
          begin: Alignment(-1 + align * 2, 0),
          end: Alignment(align * 2, 0),
          colors: const [AppColors.border, AppColors.surface, AppColors.border],
        ),
      ),
    );
  }
}
