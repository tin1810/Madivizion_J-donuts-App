import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:madivizion_jdonuts_app/app/di/injector.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/features/catalog/domain/catalog_product.dart';
import 'package:madivizion_jdonuts_app/features/catalog/presentation/catalog_image.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/catalog_repository.dart';
import 'package:madivizion_jdonuts_app/features/product/presentation/product_detail_bloc.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProductDetailBloc(catalog: injector<CatalogRepository>())
            ..add(ProductOpened(id)),
      child: const ProductDetailView(),
    );
  }
}

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      body: SafeArea(
        child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            return switch (state) {
              ProductDetailLoading() => const _Loading(),
              ProductDetailMissing() => const _Missing(),
              ProductDetailReady() => _Ready(state: state),
            };
          },
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }
}

class _Missing extends StatelessWidget {
  const _Missing();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _BackButton(),
        Expanded(
          child: Center(
            child: Text(AppLocalizations.of(context).productMissing),
          ),
        ),
      ],
    );
  }
}

class _Ready extends StatelessWidget {
  const _Ready({required this.state});

  final ProductDetailReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final product = state.product;
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      children: [
        const Row(children: [_BackButton(), Spacer(), _Favorite()]),
        const SizedBox(height: AppSpacing.md),
        _Card(product: product, quantity: state.quantity),
        const SizedBox(height: AppSpacing.xl),
        _Description(text: product.description),
        const SizedBox(height: AppSpacing.xl),
        _AddButton(total: state.totalMmk),
        if (state.added) ...[
          const SizedBox(height: AppSpacing.sm),
          Center(
            child: Text(
              l10n.productAdded,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

const _photoHeight = 280.0;
const _markSize = 28.0;
const _stepSize = 40.0;

class _Card extends StatelessWidget {
  const _Card({required this.product, required this.quantity});

  final CatalogProduct product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: _stepSize / 2),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _sheet(context),
          if (product.isNew)
            const Positioned(
              top: -14,
              right: AppSpacing.lg,
              child: _NewBadge(),
            ),
          Positioned(
            left: 0,
            right: 0,
            bottom: -_stepSize / 2,
            child: Center(child: _Quantity(quantity: quantity)),
          ),
        ],
      ),
    );
  }

  Widget _sheet(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.lg)),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.xxl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name, style: _name(context)),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.productPrice(formatMmkAmount(product.priceMmk)),
              style: _price(context),
            ),
            Text(product.code, style: _code(context)),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: _photoHeight,
              width: double.infinity,
              child: Hero(
                tag: productHeroTag(product.id),
                child: CatalogImage(url: product.imageUrl, fit: BoxFit.contain),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle? _name(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge?.copyWith(
      fontSize: AppTextSize.title,
      fontWeight: FontWeight.w700,
      height: AppTextHeight.tight,
    );
  }

  TextStyle? _price(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary);
  }

  TextStyle? _code(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.textSecondary,
      fontSize: AppTextSize.caption,
    );
  }
}

class _NewBadge extends StatelessWidget {
  const _NewBadge();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.pill)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xxs,
        ),
        child: Text(
          AppLocalizations.of(context).productNew,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.onPrimary,
            fontSize: AppTextSize.caption,
            fontWeight: FontWeight.w700,
            height: AppTextHeight.tight,
          ),
        ),
      ),
    );
  }
}

class _Quantity extends StatelessWidget {
  const _Quantity({required this.quantity});

  final int quantity;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProductDetailBloc>();
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.canvas,
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.pill)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _StepButton(
              key: const Key('product-less'),
              icon: Icons.remove,
              enabled: quantity > 1,
              onPressed: () => bloc.add(const QuantityDecreased()),
            ),
            const SizedBox(width: AppSpacing.lg),
            _QuantityLabel(quantity: quantity),
            const SizedBox(width: AppSpacing.lg),
            _StepButton(
              key: const Key('product-more'),
              icon: Icons.add,
              enabled: true,
              onPressed: () => bloc.add(const QuantityIncreased()),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuantityLabel extends StatelessWidget {
  const _QuantityLabel({required this.quantity});

  final int quantity;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: AppMotion.resolve(context, AppMotion.fast),
      switchInCurve: AppMotion.enterCurve,
      transitionBuilder: (child, animation) {
        final slide = Tween<Offset>(
          begin: const Offset(0, 0.4),
          end: Offset.zero,
        ).animate(animation);
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(position: slide, child: child),
        );
      },
      child: Text(
        '$quantity',
        key: ValueKey(quantity),
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.enabled,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final background = enabled ? AppColors.primary : AppColors.primaryDisabled;
    return Material(
      color: background,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: enabled ? onPressed : null,
        customBorder: const CircleBorder(),
        child: SizedBox.square(
          dimension: _stepSize,
          child: Center(
            child: _StepMark(icon: icon, color: AppColors.onPrimary),
          ),
        ),
      ),
    );
  }
}

class _StepMark extends StatelessWidget {
  const _StepMark({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (icon == Icons.remove) {
      return _bar();
    }
    return SizedBox.square(
      dimension: AppSpacing.sm,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _bar(),
          RotatedBox(quarterTurns: 1, child: _bar()),
        ],
      ),
    );
  }

  Widget _bar() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(1)),
      ),
      child: const SizedBox(width: AppSpacing.sm, height: 2),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 72,
          child: Column(
            children: [
              _InfoMark(),
              SizedBox(height: AppSpacing.xxs),
              _WhatsThis(),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        const SizedBox(
          height: 48,
          child: DecoratedBox(
            decoration: BoxDecoration(color: AppColors.border),
            child: SizedBox(width: AppSize.borderWidth),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}

class _WhatsThis extends StatelessWidget {
  const _WhatsThis();

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context).productWhatsThis,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
        fontSize: AppTextSize.caption,
        height: AppTextHeight.tight,
        letterSpacing: 0,
      ),
    );
  }
}

class _InfoMark extends StatelessWidget {
  const _InfoMark();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(color: AppColors.info, shape: BoxShape.circle),
      child: SizedBox.square(
        dimension: _markSize,
        child: Center(
          child: Text(
            '?',
            style: TextStyle(
              color: AppColors.onPrimary,
              fontSize: AppTextSize.caption,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final style = Theme.of(
      context,
    ).textTheme.labelLarge?.copyWith(letterSpacing: AppTextTracking.button);
    return Material(
      color: AppColors.primary,
      borderRadius: const BorderRadius.all(Radius.circular(AppRadius.pill)),
      child: InkWell(
        key: const Key('product-add'),
        onTap: () =>
            context.read<ProductDetailBloc>().add(const AddToCartPressed()),
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.pill)),
        child: SizedBox(
          height: AppSize.buttonHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(l10n.productAdd, style: style),
              const SizedBox(width: AppSpacing.lg),
              Text(l10n.productPrice(formatMmkAmount(total)), style: style),
            ],
          ),
        ),
      ),
    );
  }
}

class _Favorite extends StatefulWidget {
  const _Favorite();

  @override
  State<_Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<_Favorite> {
  var _saved = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const CircleBorder(),
      elevation: 1,
      shadowColor: AppColors.textPrimary.withValues(alpha: 0.08),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => setState(() => _saved = !_saved),
        child: SizedBox.square(
          dimension: 44,
          child: Icon(
            _saved ? Icons.favorite : Icons.favorite_border,
            color: _saved ? AppColors.accent : AppColors.textPrimary,
            size: 22,
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: const Key('product-back'),
      onPressed: () => context.pop(),
      padding: EdgeInsets.zero,
      alignment: Alignment.centerLeft,
      visualDensity: VisualDensity.compact,
      icon: const Icon(
        Icons.arrow_back,
        size: 22,
        color: AppColors.textPrimary,
      ),
    );
  }
}
