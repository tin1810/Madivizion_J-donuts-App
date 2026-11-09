import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/rewards_board.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

const _countSize = 30.0;

/// Title and the orange count pill. The pill pops in once.
class RewardsHeading extends StatefulWidget {
  const RewardsHeading({required this.count, super.key});

  final int count;

  @override
  State<RewardsHeading> createState() => _RewardsHeadingState();
}

class _RewardsHeadingState extends State<RewardsHeading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _motion;
  late final CurvedAnimation _curve;

  @override
  void initState() {
    super.initState();
    _motion = AnimationController(vsync: this);
    _curve = CurvedAnimation(parent: _motion, curve: AppMotion.badgeCurve);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _motion.duration = AppMotion.resolve(context, AppMotion.fast);
    if (_motion.duration == Duration.zero) {
      _motion.value = 1;
      return;
    }
    if (!_motion.isAnimating && _motion.value == 0) {
      _motion.forward();
    }
  }

  @override
  void dispose() {
    _curve.dispose();
    _motion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: FittedBox(
            alignment: Alignment.centerLeft,
            fit: BoxFit.scaleDown,
            child: Text(l10n.rewardsTitle, maxLines: 1, style: _title(context)),
          ),
        ),
        ScaleTransition(
          scale: _curve,
          child: _Badge(count: widget.count),
        ),
      ],
    );
  }

  TextStyle? _title(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge?.copyWith(
      fontSize: AppTextSize.title,
      fontWeight: FontWeight.w700,
      height: AppTextHeight.tight,
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.headerBell,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.pill),
          bottomLeft: Radius.circular(AppRadius.pill),
        ),
        // borderRadius: BorderRadius.all(Radius.circular(AppRadius.pill)),
      ),
      child: SizedBox(
        height: _countSize,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: AppSpacing.md,
                right: AppSpacing.xs,
              ),
              child: Text(
                AppLocalizations.of(context).rewardsBadge,
                style: _label(context),
              ),
            ),
            _Count(count: count),
          ],
        ),
      ),
    );
  }

  TextStyle? _label(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.onPrimary,
      fontWeight: FontWeight.w700,
      height: 1,
    );
  }
}

class _Count extends StatelessWidget {
  const _Count({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
      ),
      child: SizedBox.square(
        dimension: 17,
        child: Center(child: Text('$count', style: _style(context))),
      ),
    );
  }

  TextStyle? _style(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.textPrimary,
      fontSize: AppTextSize.caption,
      fontWeight: FontWeight.w700,
      height: 1,
    );
  }
}

/// Earn and Gift. The selected pill slides its color.
class RewardsTabs extends StatelessWidget {
  const RewardsTabs({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _Tab(
          label: l10n.rewardsEarnTab,
          selected: selected == RewardTabs.earn,
          onTap: () => onSelected(RewardTabs.earn),
          tabKey: const Key('rewards-earn-tab'),
        ),
        const SizedBox(width: AppSpacing.sm),
        _Tab(
          label: l10n.rewardsGiftTab,
          selected: selected == RewardTabs.gift,
          onTap: () => onSelected(RewardTabs.gift),
          tabKey: const Key('rewards-gift-tab'),
        ),
      ],
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.tabKey,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Key tabKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: tabKey,
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppMotion.resolve(context, AppMotion.fast),
        curve: AppMotion.enterCurve,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.grey.shade300,
          borderRadius: const BorderRadius.all(Radius.circular(AppRadius.pill)),
          border: Border.all(color: Colors.white, width: AppSize.borderWidth),
          // border: selected
          //     ? Bor
          //     :
        ),
        child: Text(label, style: _style(context)),
      ),
    );
  }

  TextStyle? _style(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: selected ? AppColors.onPrimary : AppColors.textSecondary,
      fontWeight: FontWeight.w600,
    );
  }
}
