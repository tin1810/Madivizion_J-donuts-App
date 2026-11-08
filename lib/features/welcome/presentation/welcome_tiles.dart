import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/motion/entrance.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/features/catalog/presentation/catalog_image.dart';

/// The four welcome donut tiles, sliding in one after another.
class WelcomeTiles extends StatelessWidget {
  const WelcomeTiles({required this.animation, super.key});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: _tile(0, _Tiles.purple, const Offset(-0.15, 0.2)),
              ),
              const SizedBox(height: AppSpacing.sm),
              Expanded(
                child: _tile(1, _Tiles.sprinkle, const Offset(-0.15, 0.28)),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: _tile(2, _Tiles.chocolate, const Offset(0.15, 0.2)),
                ),
                const SizedBox(height: AppSpacing.sm),
                Expanded(
                  flex: 4,
                  child: _tile(3, _Tiles.honey, const Offset(0.15, 0.28)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _tile(int index, String url, Offset begin) {
    final start = index * 0.1;
    return Entrance(
      animation: animation,
      start: start,
      end: start + 0.42,
      begin: begin,
      child: _Tile(url: url),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(AppRadius.pill)),
      child: CatalogImage(url: url),
    );
  }
}

abstract final class _Tiles {
  static const purple = 'assets/catalog/welcome_purple.png';
  static const chocolate = 'assets/catalog/welcome_chocolate.png';
  static const sprinkle = 'assets/catalog/welcome_sprinkle.png';
  static const honey = 'assets/catalog/welcome_honey.png';
}
