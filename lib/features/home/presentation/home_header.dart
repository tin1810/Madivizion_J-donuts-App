import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/catalog/presentation/catalog_image.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/home_feed.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    required this.member,
    required this.banners,
    this.registeredName,
    super.key,
  });

  final Result<MemberProfile> member;
  final Widget banners;
  final String? registeredName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final profile = switch (member) {
      Success<MemberProfile>(:final value) => value,
      Failure<MemberProfile>() => null,
    };
    final top = MediaQuery.paddingOf(context).top;
    return SizedBox(
      height: top + _profileSpace + 180,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(right: 28, top: top, child: const _HeaderBlob()),
          Positioned(right: 118, top: top + 18, child: const _HeaderStar()),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: top + _profileSpace,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.md,
                top + AppSpacing.sm,
                0,
                AppSpacing.sm,
              ),
              child: profile == null
                  ? Text(l10n.homeMemberError, style: _error(context))
                  : _Loaded(profile: profile, registeredName: registeredName),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: top + 150,
            height: _bannerSpace,
            child: banners,
          ),
        ],
      ),
    );
  }

  TextStyle? _error(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: AppColors.error);
  }
}

const _profileSpace = 168.0;
const _bannerSpace = 220.0;
const _bellIcon = 21.0;
const _badgeSize = 30.0;

class _Loaded extends StatelessWidget {
  const _Loaded({required this.profile, this.registeredName});

  final MemberProfile profile;
  final String? registeredName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final next = displayTier(profile.nextTier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: SizedBox.square(
                dimension: 56,
                child: CatalogImage(url: profile.photoUrl),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _Identity(
                profile: profile,
                name: registeredName ?? profile.name,
              ),
            ),
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
  const _Identity({required this.profile, required this.name});

  final MemberProfile profile;
  final String name;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: _name(context)),
        Text(
          l10n.homeTierMember(displayTier(profile.tier)),
          style: _role(context),
        ),
      ],
    );
  }

  TextStyle? _role(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.textSecondary,
      fontSize: AppTextSize.caption,
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
          vertical: AppSpacing.xs,
        ),
        child: Text(label, style: _style(context)),
      ),
    );
  }

  TextStyle? _style(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.textPrimary,
      fontSize: AppTextSize.caption,
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
      decoration: BoxDecoration(
        color: AppColors.headerBell,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.lg),
          bottomLeft: Radius.circular(AppRadius.lg),
        ),
        border: Border.all(color: AppColors.border, width: 1.0),
      ),
      child: SizedBox(
        height: _badgeSize,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: AppSpacing.md,
                right: AppSpacing.sm,
              ),
              child: Icon(
                CupertinoIcons.bell,
                color: AppColors.onPrimary,
                size: _bellIcon,
              ),
            ),
            _BellCount(count: count),
          ],
        ),
      ),
    );
  }
}

class _BellCount extends StatelessWidget {
  const _BellCount({required this.count});

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
        child: Center(child: Text('$count', style: _count(context))),
      ),
    );
  }

  TextStyle? _count(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.textPrimary,
      fontSize: AppTextSize.label,
      fontWeight: FontWeight.w700,
      height: 1,
    );
  }
}

class _HeaderBlob extends StatelessWidget {
  const _HeaderBlob();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Transform.rotate(
        angle: 0.35,
        child: const DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.headerShape,
            borderRadius: BorderRadius.all(Radius.circular(AppRadius.lg)),
          ),
          child: SizedBox(width: 96, height: 78),
        ),
      ),
    );
  }
}

class _HeaderStar extends StatelessWidget {
  const _HeaderStar();

  @override
  Widget build(BuildContext context) {
    return const IgnorePointer(
      child: Icon(Icons.star_rounded, color: AppColors.headerStar, size: 36),
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
