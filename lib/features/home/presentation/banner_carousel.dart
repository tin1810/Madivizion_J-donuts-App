import 'dart:async';

import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/features/catalog/presentation/catalog_image.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/home_feed.dart';

/// Auto-plays banner cards. [interval] is null when motion is disabled.
class BannerCarousel extends StatefulWidget {
  const BannerCarousel({required this.banners, this.interval, super.key});

  final List<HomeBanner> banners;
  final Duration? interval;

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  static const double _fraction = 0.86;

  final ScrollController _scroll = ScrollController();
  Timer? _timer;
  var _index = 0;

  @override
  void initState() {
    super.initState();
    _arm();
  }

  @override
  void didUpdateWidget(BannerCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.interval != widget.interval ||
        oldWidget.banners.length != widget.banners.length) {
      _arm();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scroll.dispose();
    super.dispose();
  }

  void _arm() {
    _timer?.cancel();
    final interval = widget.interval;
    if (interval == null || widget.banners.length < 2) {
      return;
    }
    _timer = Timer.periodic(interval, (_) => _advance());
  }

  void _advance() {
    if (!mounted || !_scroll.hasClients) {
      return;
    }
    final next = (_index + 1) % widget.banners.length;
    _index = next;
    final width = _scroll.position.viewportDimension * _fraction;
    _scroll.animateTo(
      next * width,
      duration: AppMotion.page,
      curve: AppMotion.sharedAxisCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth * _fraction;
          final tail = constraints.maxWidth - width - AppSpacing.md;
          return ListView.builder(
            clipBehavior: Clip.hardEdge,
            controller: _scroll,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(
              left: AppSpacing.md,
              right: tail < 0 ? 0 : tail,
            ),
            itemCount: widget.banners.length,
            itemBuilder: (context, index) {
              return SizedBox(
                key: ValueKey(widget.banners[index].id),
                width: width,
                child: _Slide(
                  banner: widget.banners[index],
                  color: _tones[index % _tones.length],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

const _tones = <Color>[
  AppColors.bannerLead,
  AppColors.bannerSecond,
  AppColors.bannerThird,
  AppColors.bannerFourth,
];

class _Slide extends StatelessWidget {
  const _Slide({required this.banner, required this.color});

  final HomeBanner banner;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final badge = banner.badge;
    return Semantics(
      label: banner.title,
      child: Padding(
        padding: const EdgeInsets.only(right: AppSpacing.sm),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppRadius.lg),
              topRight: Radius.circular(AppRadius.lg),
              // bottomLeft: Radius.circular(AppRadius.md),
              // bottomRight: Radius.circular(AppRadius.lg),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(AppRadius.lg)),
            child: Stack(
              children: [
                const _Sprinkles(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.sm,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (badge != null && badge.isNotEmpty) _Badge(badge),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        banner.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: _title(context),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(AppRadius.md),
                          ),
                          child: CatalogImage(
                            url: banner.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle? _title(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge?.copyWith(
      color: AppColors.onPrimary,
      fontSize: AppTextSize.subtitle,
      fontWeight: FontWeight.w700,
      height: AppTextHeight.tight,
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.badge,
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.pill)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.xxs,
        ),
        child: Text(label, style: _style(context)),
      ),
    );
  }

  TextStyle? _style(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.onPrimary,
      fontSize: AppTextSize.caption,
      fontWeight: FontWeight.w700,
    );
  }
}

class _Sprinkles extends StatelessWidget {
  const _Sprinkles();

  @override
  Widget build(BuildContext context) {
    return const IgnorePointer(
      child: Stack(
        children: [
          _Dash(top: 18, right: 28, turns: 0.2),
          _Dash(top: 46, right: 64, turns: -0.4, pale: true),
          _Dash(top: 28, right: 96, turns: 0.5),
          _Dash(top: 70, right: 22, turns: -0.15, pale: true),
          _Dash(top: 16, left: 150, turns: 0.35, pale: true),
        ],
      ),
    );
  }
}

class _Dash extends StatelessWidget {
  const _Dash({
    required this.top,
    required this.turns,
    this.left,
    this.right,
    this.pale = false,
  });

  final double top;
  final double turns;
  final double? left;
  final double? right;
  final bool pale;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Transform.rotate(
        angle: turns,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: pale ? AppColors.headerStar : AppColors.onPrimary,
            borderRadius: const BorderRadius.all(Radius.circular(2)),
          ),
          child: const SizedBox(width: 10, height: 4),
        ),
      ),
    );
  }
}
