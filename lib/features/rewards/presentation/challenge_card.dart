import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';
import 'package:madivizion_jdonuts_app/app/motion/press_scale.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/rewards_board.dart';
import 'package:madivizion_jdonuts_app/features/rewards/presentation/challenge_art.dart';
import 'package:madivizion_jdonuts_app/features/rewards/presentation/earn_fireworks.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

class ChallengeCard extends StatelessWidget {
  const ChallengeCard({required this.challenge, this.reveal, super.key});

  final RewardChallenge challenge;
  final Animation<double>? reveal;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: DecoratedBox(
        decoration: _card,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              SizedBox.square(
                dimension: 112,
                child: ChallengeArt(challenge: challenge, reveal: reveal),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _Copy(challenge: challenge, points: l10n),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Copy extends StatelessWidget {
  const _Copy({required this.challenge, required this.points});

  final RewardChallenge challenge;
  final AppLocalizations points;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(challenge.title, maxLines: 2, style: _title(context)),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          '${challenge.progress}/${challenge.goal}',
          style: _progress(context),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            _EarnButton(ready: challenge.complete),
            const SizedBox(width: AppSpacing.sm),
            Text(
              points.rewardsPoints(challenge.points),
              style: _progress(context),
            ),
          ],
        ),
      ],
    );
  }

  TextStyle? _title(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.textPrimary,
      fontSize: AppTextSize.body,
      fontWeight: FontWeight.w700,
      height: AppTextHeight.tight,
    );
  }

  TextStyle? _progress(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.textSecondary,
      fontSize: AppTextSize.label,
      fontWeight: FontWeight.w500,
    );
  }
}

/// The finished challenge pops its EARN button once.
class _EarnButton extends StatefulWidget {
  const _EarnButton({required this.ready});

  final bool ready;

  @override
  State<_EarnButton> createState() => _EarnButtonState();
}

class _EarnButtonState extends State<_EarnButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _motion;
  late final CurvedAnimation _curve;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _motion = AnimationController(vsync: this);
    _curve = CurvedAnimation(parent: _motion, curve: AppMotion.badgeCurve);
    _scale = Tween<double>(begin: 0.72, end: 1).animate(_curve);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _motion.duration = AppMotion.resolve(context, AppMotion.fast);
    if (!widget.ready || _motion.value > 0 || _motion.isAnimating) {
      return;
    }
    if (_motion.duration == Duration.zero) {
      _motion.value = 1;
      return;
    }
    _motion.forward();
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
    final face = DecoratedBox(
      key: widget.ready ? const Key('rewards-earn-ready') : null,
      decoration: BoxDecoration(
        color: widget.ready ? AppColors.primary : AppColors.ringTrack,
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.pill)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        child: Text(l10n.rewardsEarn, style: _label(context)),
      ),
    );
    if (!widget.ready) {
      return IgnorePointer(child: face);
    }
    return ScaleTransition(
      scale: _scale,
      child: PressScale(
        onPressed: () => EarnFireworks.show(context),
        child: face,
      ),
    );
  }

  TextStyle? _label(BuildContext context) {
    final color = widget.ready ? AppColors.onPrimary : AppColors.textSecondary;
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: color,
      fontWeight: FontWeight.w700,
      letterSpacing: AppTextTracking.button,
    );
  }
}

final BoxDecoration _card = BoxDecoration(
  color: AppColors.surface,
  borderRadius: const BorderRadius.all(Radius.circular(AppRadius.lg)),
  boxShadow: [
    BoxShadow(
      color: AppColors.textPrimary.withValues(alpha: 0.06),
      blurRadius: 12,
      offset: const Offset(0, 6),
    ),
  ],
);
