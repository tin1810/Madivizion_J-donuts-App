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
                child: _Slide(banner: widget.banners[index]),
              );
            },
          );
        },
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide({required this.banner});

  final HomeBanner banner;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: banner.title,
      child: Padding(
        padding: const EdgeInsets.only(right: AppSpacing.md),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(AppRadius.md)),
          child: CatalogImage(url: banner.imageUrl),
        ),
      ),
    );
  }
}
