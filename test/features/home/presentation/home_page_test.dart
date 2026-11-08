import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:madivizion_jdonuts_app/app/router/app_routes.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/core/network/link_phase.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/core/result/unit.dart';
import 'package:madivizion_jdonuts_app/features/home/data/memory_catalog_repository.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/catalog_repository.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/home_feed.dart';
import 'package:madivizion_jdonuts_app/features/home/presentation/banner_carousel.dart';
import 'package:madivizion_jdonuts_app/features/home/presentation/home_bloc.dart';
import 'package:madivizion_jdonuts_app/features/home/presentation/home_page.dart';
import 'package:madivizion_jdonuts_app/features/home/presentation/home_skeleton.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

import '../data/script_link.dart';

void main() {
  testWidgets('home shows the shared member, sections, and a product route', (
    tester,
  ) async {
    final bloc = HomeBloc(
      catalog: _FixedCatalog(_feed()),
      link: ScriptLink(LinkPhase.offline),
    );
    bloc.add(const HomeStarted());
    await tester.pumpWidget(_app(bloc));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Hania'), findsOneWidget);
    expect(find.text('Silver'), findsOneWidget);
    expect(find.text('500 points left to become Gold'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('Mistletoe Romance box'), findsOneWidget);
    expect(find.text('59% off'), findsOneWidget);
    expect(find.text('Nothing here yet'), findsOneWidget);
    expect(find.text("Couldn't load this section"), findsOneWidget);
    expect(find.text('There are 4 J\'Donut shops near you'), findsOneWidget);
    expect(find.text('Explore now'), findsWidgets);
    expect(find.text('Order online'), findsWidgets);

    await tester.tap(find.text('Mistletoe Romance box'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('product-p_mistletoe'), findsOneWidget);
  });

  testWidgets('home shows skeletons while the local read is still running', (
    tester,
  ) async {
    final gate = Completer<void>();
    final bloc = HomeBloc(
      catalog: _GatedCatalog(gate),
      link: ScriptLink(LinkPhase.offline),
    );
    bloc.add(const HomeStarted());
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: BlocProvider.value(value: bloc, child: const HomeView()),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(HomeSkeleton), findsOneWidget);
    gate.complete();
    await tester.pump();
  });

  testWidgets('the banner carousel advances on its own', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: BannerCarousel(
            interval: Duration(milliseconds: 500),
            banners: [
              HomeBanner(
                id: 'a',
                title: 'First banner',
                imageUrl: 'assets/catalog/banner_central.png',
              ),
              HomeBanner(
                id: 'b',
                title: 'Second banner',
                imageUrl: 'assets/catalog/banner_hot.png',
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('First banner'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 350));

    expect(tester.getTopLeft(find.text('Second banner')).dx, lessThan(80));
  });
}

HomeFeed _feed() {
  return const HomeFeed(
    member: Success(
      MemberProfile(
        name: 'Hania',
        photoUrl: 'assets/catalog/member_hania.png',
        tier: 'silver',
        nextTier: 'gold',
        pointsToNextTier: 500,
        notificationCount: 2,
      ),
    ),
    seasonal: Success([
      HomeProduct(
        id: 'p_mistletoe',
        name: 'Mistletoe Romance box',
        imageUrl: 'assets/catalog/p_mistletoe.png',
        discountPercent: 59,
      ),
    ]),
    popular: Success([]),
    orderAgain: Failure(CacheFailure()),
    banners: Success([
      HomeBanner(
        id: 'banner_central',
        title: 'We are now at Central Boulevard',
        imageUrl: 'assets/catalog/banner_central.png',
      ),
    ]),
    shops: Success([
      HomeShop(
        id: 'shop_central',
        name: 'Central Boulevard',
        imageUrl: 'assets/catalog/shop_central.png',
      ),
      HomeShop(
        id: 'shop_junction',
        name: 'Junction City',
        imageUrl: 'assets/catalog/shop_junction.png',
      ),
      HomeShop(
        id: 'shop_plaza',
        name: 'Myanmar Plaza',
        imageUrl: 'assets/catalog/shop_plaza.png',
      ),
      HomeShop(
        id: 'shop_time',
        name: 'Time City',
        imageUrl: 'assets/catalog/shop_time.png',
      ),
    ]),
  );
}

Widget _app(HomeBloc bloc) {
  final router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) {
          return Scaffold(
            body: BlocProvider.value(value: bloc, child: const HomeView()),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.product,
        builder: (context, state) {
          final id = state.pathParameters[AppRoutes.productId];
          return Text('product-$id');
        },
      ),
    ],
  );
  return MaterialApp.router(
    theme: AppTheme.light(),
    routerConfig: router,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );
}

class _FixedCatalog implements CatalogRepository {
  _FixedCatalog(this.feed);

  final HomeFeed feed;

  @override
  Future<HomeFeed> loadHome() async => feed;

  @override
  Future<Result<Unit>> refresh() async => const Success(Unit.instance);
}

class _GatedCatalog implements CatalogRepository {
  _GatedCatalog(this.gate);

  final Completer<void> gate;

  @override
  Future<HomeFeed> loadHome() async {
    await gate.future;
    return MemoryCatalogRepository.sample;
  }

  @override
  Future<Result<Unit>> refresh() async => const Success(Unit.instance);
}
