import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/rewards_board.dart';

/// Silver, Gold, and Platinum badges, with the captions stored beside each rung.
class TierLadder extends StatelessWidget {
  const TierLadder({required this.tiers, super.key});

  final List<RewardTier> tiers;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _row * tiers.length,
      child: Row(
        children: [
          SizedBox(
            width: _rail,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  painter: _RungLine(count: tiers.length),
                  size: Size(_rail, _row * tiers.length),
                ),
                Column(
                  children: [for (final tier in tiers) _Badge(tier: tier)],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [for (final tier in tiers) _Caption(tier: tier)],
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.tier});

  final RewardTier tier;

  @override
  Widget build(BuildContext context) {
    final asset = _badgeAsset(tier.id);
    return SizedBox(
      height: _row,
      width: _rail,
      child: Center(
        child: asset == null
            ? const SizedBox.square(dimension: _badge)
            : Image.asset(asset, width: _badge, height: _badge),
      ),
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption({required this.tier});

  final RewardTier tier;

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
      color: AppColors.textPrimary,
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
  const _RungLine({required this.count});

  final int count;

  @override
  void paint(Canvas canvas, Size size) {
    if (count < 2) {
      return;
    }
    final row = size.height / count;
    canvas.drawLine(
      Offset(size.width / 2, row / 2),
      Offset(size.width / 2, size.height - row / 2),
      Paint()
        ..color = AppColors.textSecondary
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(_RungLine oldDelegate) => oldDelegate.count != count;
}

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
