import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madivizion_jdonuts_app/app/di/injector.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';
import 'package:madivizion_jdonuts_app/app/motion/entrance.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/core/network/link_read.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/catalog_repository.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/home_feed.dart';
import 'package:madivizion_jdonuts_app/features/home/presentation/banner_carousel.dart';
import 'package:madivizion_jdonuts_app/features/home/presentation/home_bloc.dart';
import 'package:madivizion_jdonuts_app/features/home/presentation/home_header.dart';
import 'package:madivizion_jdonuts_app/features/home/presentation/home_sections.dart';
import 'package:madivizion_jdonuts_app/features/home/presentation/home_skeleton.dart';
import 'package:madivizion_jdonuts_app/features/home/presentation/shop_strip.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        catalog: injector<CatalogRepository>(),
        link: injector<LinkRead>(),
      )..add(const HomeStarted()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return switch (state) {
          HomeLoading() => const HomeSkeleton(),
          HomeFailure() => const _Failure(),
          HomeReady(:final feed) => _Ready(feed: feed),
        };
      },
    );
  }
}

class _Failure extends StatelessWidget {
  const _Failure();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.homeSectionError),
          TextButton(
            onPressed: () => context.read<HomeBloc>().add(const HomeStarted()),
            child: Text(l10n.homeTryAgain),
          ),
        ],
      ),
    );
  }
}

class _Ready extends StatelessWidget {
  const _Ready({required this.feed});

  final HomeFeed feed;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => _refresh(context),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [SliverToBoxAdapter(child: _Body(feed: feed))],
      ),
    );
  }

  Future<void> _refresh(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    final done = bloc.stream.first;
    bloc.add(const HomeRefreshed());
    return done;
  }
}

class _Body extends StatefulWidget {
  const _Body({required this.feed});

  final HomeFeed feed;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with SingleTickerProviderStateMixin {
  static const int _steps = 5;

  late final AnimationController _entrance;
  var _started = false;

  @override
  void initState() {
    super.initState();
    _entrance = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _entrance.duration = AppMotion.resolve(
      context,
      AppMotion.entrance + (AppMotion.stagger * _steps),
    );
    if (_started) {
      return;
    }
    _started = true;
    _entrance.forward();
  }

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final hold = AppMotion.resolve(context, AppMotion.bannerHold);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.md,
            AppSpacing.md,
            AppSpacing.sm,
          ),
          child: HomeHeader(member: widget.feed.member),
        ),
        _block(0, _banners(hold)),
        _block(
          1,
          HomeProductSection(
            title: l10n.homeSeasonal,
            products: widget.feed.seasonal,
          ),
        ),
        _block(
          2,
          HomeProductSection(
            title: l10n.homePopular,
            products: widget.feed.popular,
          ),
        ),
        _block(
          3,
          HomeProductSection(
            title: l10n.homeOrderAgain,
            products: widget.feed.orderAgain,
          ),
        ),
        _block(4, ShopStrip(shops: widget.feed.shops)),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }

  Widget _banners(Duration hold) {
    return switch (widget.feed.banners) {
      Failure<List<HomeBanner>>() => _SectionNote(
        text: AppLocalizations.of(context).homeSectionError,
      ),
      Success<List<HomeBanner>>(value: []) => _SectionNote(
        text: AppLocalizations.of(context).homeSectionEmpty,
      ),
      Success<List<HomeBanner>>(:final value) => BannerCarousel(
        banners: value,
        interval: hold == Duration.zero ? null : hold,
      ),
    };
  }

  Widget _block(int index, Widget child) {
    final start = 0.08 + (index * 0.1);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Entrance(
        animation: _entrance,
        start: start.clamp(0, 0.8),
        end: (start + 0.35).clamp(0.2, 1),
        child: child,
      ),
    );
  }
}

class _SectionNote extends StatelessWidget {
  const _SectionNote({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
