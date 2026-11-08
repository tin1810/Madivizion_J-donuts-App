import 'package:flutter/widgets.dart';
import 'package:madivizion_jdonuts_app/app/motion/entrance.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/onboarding/donut_art.dart';

/// The overlapping donut circles at the top of onboarding.
class DonutCluster extends StatelessWidget {
  const DonutCluster({required this.animation, super.key});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            for (final spot in _spots)
              _PlacedDonut(
                spot: spot,
                bounds: constraints.biggest,
                animation: animation,
              ),
          ],
        );
      },
    );
  }
}

class _Spot {
  const _Spot({
    required this.art,
    required this.x,
    required this.y,
    required this.diameter,
    required this.start,
  });

  final DonutArt art;
  final double x;
  final double y;
  final double diameter;
  final double start;
}

const List<_Spot> _spots = <_Spot>[
  _Spot(art: DonutArts.chocolate, x: -0.14, y: 0.28, diameter: 0.46, start: 0),
  _Spot(art: DonutArts.purple, x: 0.7, y: 0.16, diameter: 0.42, start: 0.08),
  _Spot(art: DonutArts.honey, x: 0.04, y: 0.58, diameter: 0.34, start: 0.14),
  _Spot(art: DonutArts.berry, x: 0.58, y: 0.56, diameter: 0.3, start: 0.2),
  _Spot(art: DonutArts.pink, x: 0.24, y: 0.12, diameter: 0.52, start: 0.05),
];

class _PlacedDonut extends StatelessWidget {
  const _PlacedDonut({
    required this.spot,
    required this.bounds,
    required this.animation,
  });

  final _Spot spot;
  final Size bounds;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final diameter = bounds.width * spot.diameter;
    return Positioned(
      left: bounds.width * spot.x,
      top: bounds.height * spot.y,
      child: Entrance(
        animation: animation,
        start: spot.start,
        end: spot.start + 0.42,
        begin: const Offset(0, -0.22),
        child: DonutBadge(art: spot.art, size: diameter),
      ),
    );
  }
}
