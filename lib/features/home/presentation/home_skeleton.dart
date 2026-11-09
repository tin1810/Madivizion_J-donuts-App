import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';

/// Grey blocks for every Home section while Drift is still reading.
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
    final top = MediaQuery.paddingOf(context).top;
    return AnimatedBuilder(
      animation: _sweep,
      builder: (context, _) {
        final align = _sweep.value;
        return ListView(
          key: const Key('home-skeleton'),
          children: [
            _Header(top: top, align: align),
            const SizedBox(height: AppSpacing.md),
            _Banner(align: align),
            _ProductRow(artHeight: 118, align: align),
            _ProductRow(artHeight: 168, align: align),
            _ProductRow(artHeight: 168, align: align),
            _Shops(align: align),
            const SizedBox(height: AppSpacing.lg),
          ],
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.top, required this.align});

  final double top;
  final double align;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.headerWash,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.md,
          top + AppSpacing.sm,
          0,
          AppSpacing.md,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _Bone(height: 56, width: 56, align: align, radius: 28),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Bone(height: 16, width: 120, align: align),
                      const SizedBox(height: AppSpacing.xs),
                      _Bone(height: 12, width: 84, align: align),
                    ],
                  ),
                ),
                _Bone(height: 30, width: 68, align: align, radius: 16),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            _Bone(height: 28, width: 180, align: align, radius: 14),
          ],
        ),
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({required this.align});

  final double align;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: _Bone(height: 160, width: double.infinity, align: align),
    );
  }
}

class _ProductRow extends StatelessWidget {
  const _ProductRow({required this.artHeight, required this.align});

  final double artHeight;
  final double align;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: _Bone(height: 18, width: 150, align: align),
          ),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: artHeight + 28,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              itemCount: 3,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (_, _) =>
                  _Bone(height: artHeight, width: 168, align: align),
            ),
          ),
        ],
      ),
    );
  }
}

class _Shops extends StatelessWidget {
  const _Shops({required this.align});

  final double align;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: ColoredBox(
        color: AppColors.primary.withValues(alpha: 0.35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: _Bone(height: 16, width: 220, align: align),
            ),
            SizedBox(
              height: 160,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                itemCount: 3,
                separatorBuilder: (_, _) =>
                    const SizedBox(width: AppSpacing.sm),
                itemBuilder: (_, _) =>
                    _Bone(height: 148, width: 168, align: align),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}

class _Bone extends StatelessWidget {
  const _Bone({
    required this.height,
    required this.width,
    required this.align,
    this.radius = AppRadius.md,
  });

  final double height;
  final double width;
  final double align;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        gradient: LinearGradient(
          begin: Alignment(-1 + align * 2, 0),
          end: Alignment(align * 2, 0),
          colors: const [AppColors.border, AppColors.surface, AppColors.border],
        ),
      ),
    );
  }
}
