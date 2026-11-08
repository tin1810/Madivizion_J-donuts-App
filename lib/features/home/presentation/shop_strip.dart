import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/catalog/presentation/catalog_image.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/home_feed.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

/// The shop count and display-only cards.
class ShopStrip extends StatelessWidget {
  const ShopStrip({required this.shops, super.key});

  final Result<List<HomeShop>> shops;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return switch (shops) {
      Failure<List<HomeShop>>() => _Banner(text: l10n.homeSectionError),
      Success<List<HomeShop>>(value: []) => _Banner(
        text: l10n.homeSectionEmpty,
      ),
      Success<List<HomeShop>>(:final value) => _Loaded(shops: value),
    };
  }
}

class _Loaded extends StatelessWidget {
  const _Loaded({required this.shops});

  final List<HomeShop> shops;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Banner(text: l10n.homeShops(shops.length)),
        const SizedBox(height: AppSpacing.md),
        const _NearYou(),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            itemCount: shops.length,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, index) => _ShopCard(shop: shops[index]),
          ),
        ),
      ],
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Text(text, style: _style(context)),
      ),
    );
  }

  TextStyle? _style(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge?.copyWith(
      color: AppColors.onPrimary,
      fontWeight: FontWeight.w700,
    );
  }
}

class _NearYou extends StatelessWidget {
  const _NearYou();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.homeNearYou, style: _title(context)),
          const SizedBox(height: AppSpacing.xxs),
          Text(l10n.homeExploreNow, style: _action(context)),
        ],
      ),
    );
  }

  TextStyle? _title(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700);
  }

  TextStyle? _action(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.primary,
      fontWeight: FontWeight.w700,
      letterSpacing: AppTextTracking.button,
    );
  }
}

class _ShopCard extends StatelessWidget {
  const _ShopCard({required this.shop});

  final HomeShop shop;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SizedBox(
      width: 220,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.md)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppRadius.md),
              ),
              child: SizedBox(
                height: 112,
                width: double.infinity,
                child: CatalogImage(url: shop.imageUrl),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(shop.name, style: _name(context)),
                  const SizedBox(height: AppSpacing.xs),
                  Text(l10n.homeOrderOnline, style: _action(context)),
                ],
              ),
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

  TextStyle? _action(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.accent,
      fontWeight: FontWeight.w700,
    );
  }
}
