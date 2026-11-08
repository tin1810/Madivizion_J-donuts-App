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
    final top = MediaQuery.paddingOf(context).top;
    return DecoratedBox(
      decoration: const BoxDecoration(color: AppColors.headerWash),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.md,
          top + AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.sm,
        ),
        child: profile == null
            ? Text(l10n.homeMemberError, style: _error(context))
            : _Loaded(profile: profile),
      ),
    );
  }

  TextStyle? _error(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: AppColors.error);
  }
}

class _Loaded extends StatelessWidget {
  const _Loaded({required this.profile});

  final MemberProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final next = displayTier(profile.nextTier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: SizedBox.square(
                dimension: 56,
                child: CatalogImage(url: profile.photoUrl),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: _Identity(profile: profile)),
            const SizedBox(width: AppSpacing.sm),
            _Bell(count: profile.notificationCount),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        _Points(label: l10n.homePointsLeft(profile.pointsToNextTier, next)),
      ],
    );
  }
}

class _Identity extends StatelessWidget {
  const _Identity({required this.profile});

  final MemberProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(profile.name, style: _name(context)),
        Text(
          l10n.homeTierMember(displayTier(profile.tier)),
          style: _role(context),
        ),
      ],
    );
  }

  TextStyle? _role(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle? _name(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge?.copyWith(
      fontSize: AppTextSize.subtitle,
      fontWeight: FontWeight.w700,
    );
  }
}

class _Points extends StatelessWidget {
  const _Points({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.pill)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Text(label, style: _style(context)),
      ),
    );
  }

  TextStyle? _style(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600,
    );
  }
}

class _Bell extends StatelessWidget {
  const _Bell({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.badge,
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.pill)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.notifications_none,
              color: AppColors.onPrimary,
              size: 20,
            ),
            const SizedBox(width: AppSpacing.xxs),
            Text('$count', style: _count(context)),
          ],
        ),
      ),
    );
  }

  TextStyle? _count(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.onPrimary,
      fontWeight: FontWeight.w700,
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
