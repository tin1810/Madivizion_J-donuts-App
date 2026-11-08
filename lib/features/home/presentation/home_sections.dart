import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madivizion_jdonuts_app/app/router/app_routes.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/catalog/domain/catalog_product.dart';
import 'package:madivizion_jdonuts_app/features/catalog/presentation/catalog_image.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/home_feed.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

class HomeProductSection extends StatelessWidget {
  const HomeProductSection({
    required this.title,
    required this.products,
    super.key,
  });

  final String title;
  final Result<List<HomeProduct>> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Heading(title: title),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(height: 232, child: _body(context)),
      ],
    );
  }

  Widget _body(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return switch (products) {
      Failure<List<HomeProduct>>() => _Note(text: l10n.homeSectionError),
      Success<List<HomeProduct>>(value: []) => _Note(
        text: l10n.homeSectionEmpty,
      ),
      Success<List<HomeProduct>>(:final value) => _Cards(products: value),
    };
  }
}

class _Heading extends StatelessWidget {
  const _Heading({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: [
          Expanded(child: Text(title, style: _style(context))),
          const _Chevron(),
        ],
      ),
    );
  }

  TextStyle? _style(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge?.copyWith(
      fontSize: AppTextSize.subtitle,
      fontWeight: FontWeight.w700,
      height: AppTextHeight.tight,
    );
  }
}

class _Chevron extends StatelessWidget {
  const _Chevron();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
      ),
      child: SizedBox.square(
        dimension: 28,
        child: Icon(
          Icons.chevron_right,
          color: AppColors.textSecondary,
          size: 18,
        ),
      ),
    );
  }
}

class _Note extends StatelessWidget {
  const _Note({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}

class _Cards extends StatelessWidget {
  const _Cards({required this.products});

  final List<HomeProduct> products;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      itemCount: products.length,
      separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
      itemBuilder: (context, index) => _ProductCard(product: products[index]),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final HomeProduct product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: InkWell(
        onTap: () => context.push(AppRoutes.productLocation(product.id)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Art(product: product),
            const SizedBox(height: AppSpacing.xs),
            Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Art extends StatelessWidget {
  const _Art({required this.product});

  final HomeProduct product;

  @override
  Widget build(BuildContext context) {
    final discount = product.discountPercent;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.lg)),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.lg)),
        child: SizedBox(
          height: 180,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              const ColoredBox(color: AppColors.surface),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Hero(
                  tag: productHeroTag(product.id),
                  child: CatalogImage(
                    url: product.imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              if (discount != null)
                Align(
                  alignment: Alignment.bottomLeft,
                  child: _Discount(percent: discount),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Discount extends StatelessWidget {
  const _Discount({required this.percent});

  final int percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.xs),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xxs,
      ),
      decoration: const BoxDecoration(
        color: AppColors.badge,
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.pill)),
      ),
      child: Text(
        AppLocalizations.of(context).homeDiscount(percent),
        style: _style(context),
      ),
    );
  }

  TextStyle? _style(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.onPrimary,
      fontSize: AppTextSize.caption,
      fontWeight: FontWeight.w700,
    );
  }
}
