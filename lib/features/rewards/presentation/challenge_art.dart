import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/rewards_board.dart';

/// The coco donut photo, or the americano cup framed by its progress arc.
class ChallengeArt extends StatelessWidget {
  const ChallengeArt({required this.challenge, super.key});

  final RewardChallenge challenge;

  @override
  Widget build(BuildContext context) {
    if (challenge.artwork == RewardArtwork.coffee) {
      return _Americano(fraction: challenge.fraction);
    }
    return _CocoDonut(fraction: challenge.fraction);
  }
}

const _cocoDonut = 'assets/rewards/coco_donut.png';

/// Pale donut, with the finished share shown in color from the top.
class _CocoDonut extends StatelessWidget {
  const _CocoDonut({required this.fraction});

  final double fraction;

  @override
  Widget build(BuildContext context) {
    if (fraction >= 1) {
      return Image.asset(_cocoDonut, fit: BoxFit.contain);
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColorFiltered(colorFilter: _hidden, child: _CocoPhoto()),
        ClipPath(clipper: _SliceClipper(fraction), child: const _CocoPhoto()),
      ],
    );
  }
}

class _CocoPhoto extends StatelessWidget {
  const _CocoPhoto();

  @override
  Widget build(BuildContext context) {
    return Image.asset(_cocoDonut, fit: BoxFit.contain);
  }
}

const _hidden = ColorFilter.matrix(<double>[
  0.35,
  0.35,
  0.35,
  0,
  110,
  0.35,
  0.35,
  0.35,
  0,
  110,
  0.35,
  0.35,
  0.35,
  0,
  110,
  0,
  0,
  0,
  1,
  0,
]);

class _SliceClipper extends CustomClipper<Path> {
  const _SliceClipper(this.fraction);

  final double fraction;

  @override
  Path getClip(Size size) {
    final path = Path()..moveTo(size.width / 2, size.height / 2);
    path.arcTo(Offset.zero & size, -math.pi / 2, math.pi * 2 * fraction, false);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_SliceClipper oldClipper) {
    return oldClipper.fraction != fraction;
  }
}

const _americano = 'assets/rewards/americano.png';

/// Cup photo with the same progress arc drawn around it.
class _Americano extends StatelessWidget {
  const _Americano({required this.fraction});

  final double fraction;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(26, 8, 26, 20),
          child: _AmericanoPhoto(),
        ),
        CustomPaint(
          painter: _CoffeeArcPainter(fraction: fraction),
          child: const SizedBox.expand(),
        ),
      ],
    );
  }
}

class _AmericanoPhoto extends StatelessWidget {
  const _AmericanoPhoto();

  @override
  Widget build(BuildContext context) {
    return Image.asset(_americano, fit: BoxFit.contain);
  }
}

class _CoffeeArcPainter extends CustomPainter {
  const _CoffeeArcPainter({required this.fraction});

  final double fraction;

  @override
  void paint(Canvas canvas, Size size) {
    final arc = Rect.fromCircle(
      center: size.center(Offset.zero).translate(0, 2),
      radius: size.shortestSide * 0.42,
    );
    canvas.drawArc(arc, _arcStart, _arcSweep, false, _arc(AppColors.ringTrack));
    canvas.drawArc(
      arc,
      _arcStart,
      _arcSweep * fraction,
      false,
      _arc(AppColors.headerBell),
    );
  }

  @override
  bool shouldRepaint(_CoffeeArcPainter oldDelegate) =>
      oldDelegate.fraction != fraction;
}

Paint _arc(Color color) {
  return Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 8
    ..strokeCap = StrokeCap.round
    ..color = color;
}

const double _arcStart = math.pi * 1.02;
const double _arcSweep = math.pi * 1.2;
