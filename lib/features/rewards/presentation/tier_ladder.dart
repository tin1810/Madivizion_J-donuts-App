import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/motion/entrance.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/rewards_board.dart';

/// Silver, Gold, and Platinum appear in order. The current rung is marked,
/// and the line toward the next tier fills with [reveal].
class TierLadder extends StatelessWidget {
  const TierLadder({
    required this.tiers,
    required this.currentTierId,
    required this.reveal,
    super.key,
  });

  final List<RewardTier> tiers;
  final String currentTierId;
  final Animation<double> reveal;

  @override
  Widget build(BuildContext context) {
    final current = tiers.indexWhere((tier) => tier.id == currentTierId);
    return SizedBox(
      height: _row * tiers.length,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            width: _rail,
            top: 0,
            bottom: 0,
            child: AnimatedBuilder(
              animation: reveal,
              builder: (context, _) {
                return CustomPaint(
                  painter: _RungLine(
                    count: tiers.length,
                    current: current,
                    reveal: reveal.value,
                  ),
                  size: Size(_rail, _row * tiers.length),
                );
              },
            ),
          ),
          Column(
            children: [
              for (var index = 0; index < tiers.length; index++)
                Entrance(
                  animation: reveal,
                  start: index * 0.16,
                  end: 0.34 + index * 0.16,
                  child: _Rung(
                    tier: tiers[index],
                    current: tiers[index].id == currentTierId,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Rung extends StatelessWidget {
  const _Rung({required this.tier, required this.current});

  final RewardTier tier;
  final bool current;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _row,
      child: Row(
        children: [
          _Badge(tier: tier, current: current),
          Expanded(
            child: _Caption(tier: tier, current: current),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.tier, required this.current});

  final RewardTier tier;
  final bool current;

  @override
  Widget build(BuildContext context) {
    final asset = _badgeAsset(tier.id);
    return SizedBox(
      height: _row,
      width: _rail,
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: current
                ? Border.all(color: AppColors.rewardRing, width: 2)
                : null,
          ),
          child: asset == null
              ? const SizedBox.square(dimension: _badge)
              : Image.asset(asset, width: _badge, height: _badge),
        ),
      ),
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption({required this.tier, required this.current});

  final RewardTier tier;
  final bool current;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _row,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tier.name, style: _name(context)),
            Text(
              tier.caption,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: _note(context),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle? _name(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: current ? AppColors.rewardRing : AppColors.textPrimary,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle? _note(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.textSecondary,
      fontSize: AppTextSize.caption,
      height: AppTextHeight.tight,
    );
  }
}

class _RungLine extends CustomPainter {
  const _RungLine({
    required this.count,
    required this.current,
    required this.reveal,
  });

  final int count;
  final int current;
  final double reveal;

  @override
  void paint(Canvas canvas, Size size) {
    if (count < 2) {
      return;
    }
    final row = size.height / count;
    final x = size.width / 2;
    final top = row / 2;
    final bottom = size.height - row / 2;
    canvas.drawLine(
      Offset(x, top),
      Offset(x, bottom),
      Paint()
        ..color = AppColors.ringTrack
        ..strokeWidth = 2,
    );
    if (current < 0 || current >= count - 1) {
      return;
    }
    final from = top + row * current;
    final next = from + row;
    canvas.drawLine(
      Offset(x, from),
      Offset(x, from + (next - from) * _towardNext * reveal),
      Paint()
        ..color = AppColors.rewardRing
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_RungLine oldDelegate) {
    return oldDelegate.count != count ||
        oldDelegate.current != current ||
        oldDelegate.reveal != reveal;
  }
}

/// Stops short of the next badge: 500 points are still left.
const double _towardNext = 0.72;

String? _badgeAsset(String id) {
  return switch (id) {
    'silver' => 'assets/rewards/silver_badge.png',
    'gold' => 'assets/rewards/gold_badge.png',
    'platinum' => 'assets/rewards/platinum_badge.png',
    _ => null,
  };
}

const double _row = 76;
const double _rail = 56;
const double _badge = 48;
