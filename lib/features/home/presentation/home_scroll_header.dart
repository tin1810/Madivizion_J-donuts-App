import 'package:flutter/material.dart';

/// Scrolls the member header, bell, and banner off the top of Home.
class HomeScrollHeader extends SliverPersistentHeaderDelegate {
  HomeScrollHeader({required this.extent, required this.child});

  final double extent;
  final Widget child;

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => 0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final shown = (1 - shrinkOffset / extent).clamp(0.0, 1.0);
    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.topCenter,
        minHeight: extent,
        maxHeight: extent,
        child: Opacity(opacity: shown, child: child),
      ),
    );
  }

  @override
  bool shouldRebuild(HomeScrollHeader oldDelegate) {
    return oldDelegate.extent != extent || oldDelegate.child != child;
  }
}
