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
  final PageController _pages = PageController();
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
    _pages.dispose();
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
    if (!mounted || !_pages.hasClients) {
      return;
    }
    final next = (_index + 1) % widget.banners.length;
    _pages.animateToPage(
      next,
      duration: AppMotion.page,
      curve: AppMotion.sharedAxisCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 168,
          child: PageView.builder(
            controller: _pages,
            itemCount: widget.banners.length,
            onPageChanged: (index) => setState(() => _index = index),
            itemBuilder: (context, index) =>
                _Slide(banner: widget.banners[index]),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        _Dots(count: widget.banners.length, index: _index),
      ],
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide({required this.banner});

  final HomeBanner banner;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.md)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CatalogImage(url: banner.imageUrl),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Text(banner.title, style: _title(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle? _title(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium?.copyWith(
      color: AppColors.onPrimary,
      fontWeight: FontWeight.w700,
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: i == index ? AppColors.primary : AppColors.border,
            ),
          ),
      ],
    );
  }
}
