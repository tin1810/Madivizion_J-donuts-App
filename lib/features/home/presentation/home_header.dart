import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/catalog/presentation/catalog_image.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/home_feed.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({required this.member, super.key});

  final Result<MemberProfile> member;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final profile = switch (member) {
      Success<MemberProfile>(:final value) => value,
      Failure<MemberProfile>() => null,
    };
    if (profile == null) {
      return Text(l10n.homeMemberError, style: _error(context));
    }
    return Row(
      children: [
        ClipOval(
          child: SizedBox.square(
            dimension: 52,
            child: CatalogImage(url: profile.photoUrl),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: _Identity(profile: profile)),
        _Bell(count: profile.notificationCount),
      ],
    );
  }

  TextStyle? _error(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: AppColors.error);
  }
}

class _Identity extends StatelessWidget {
  const _Identity({required this.profile});

  final MemberProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final next = displayTier(profile.nextTier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(profile.name, style: _name(context)),
        const SizedBox(height: AppSpacing.xxs),
        _TierChip(label: displayTier(profile.tier)),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          l10n.homePointsLeft(profile.pointsToNextTier, next),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  TextStyle? _name(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700);
  }
}

class _TierChip extends StatelessWidget {
  const _TierChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.pill)),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xxs,
        ),
        child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}

class _Bell extends StatelessWidget {
  const _Bell({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Badge(
      isLabelVisible: count > 0,
      label: Text('$count'),
      backgroundColor: AppColors.badge,
      child: const Icon(
        Icons.notifications_outlined,
        color: AppColors.textPrimary,
      ),
    );
  }
}

/// `silver` becomes `Silver` for the chip and the points line.
String displayTier(String tier) {
  if (tier.isEmpty) {
    return tier;
  }
  return '${tier[0].toUpperCase()}${tier.substring(1)}';
}
