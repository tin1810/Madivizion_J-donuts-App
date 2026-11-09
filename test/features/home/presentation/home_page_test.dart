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
import 'package:madivizion_jdonuts_app/features/catalog/domain/catalog_product.dart';
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
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final bloc = HomeBloc(
      catalog: _FixedCatalog(_feed()),
      link: ScriptLink(LinkPhase.offline),
    );
    bloc.add(const HomeStarted());
    await tester.pumpWidget(_app(bloc));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Hania'), findsOneWidget);
    expect(find.text('Silver member'), findsOneWidget);
    expect(find.text('500 points left to become Gold'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('Mistletoe Romance box'), findsOneWidget);
    expect(find.text('59% off'), findsOneWidget);
    expect(find.text('New shop'), findsOneWidget);
    expect(find.text('Nothing here yet'), findsOneWidget);
    expect(find.text("Couldn't load this section"), findsOneWidget);
    expect(find.text('There are 4 J\'Donut shops'), findsOneWidget);
    expect(find.text('EXPLORE NOW'), findsOneWidget);
    expect(find.text('Order Online'), findsWidgets);

    await tester.drag(find.byType(CustomScrollView), const Offset(0, -700));
    await tester.pump();
    expect(find.text('Hania').hitTestable(), findsNothing);
    expect(find.text('2').hitTestable(), findsOneWidget);
    expect(find.text('Seasonal specials').hitTestable(), findsOneWidget);

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
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(
          body: BannerCarousel(
            interval: Duration(seconds: 2),
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
    final first = tester.getTopLeft(find.byKey(const ValueKey('a'))).dx;

    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(milliseconds: 400));

    expect(
      tester.getTopLeft(find.byKey(const ValueKey('b'))).dx,
      closeTo(first, 1),
    );
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
        badge: 'New shop',
      ),
    ]),
    shops: Success([
      HomeShop(
        id: 'shop_pinlon',
        name: 'Pinlon',
        address: 'North Dagon Township, Yangon',
        phone: '09 880914808',
        imageUrl: 'assets/catalog/shop_storefront.jpg',
      ),
      HomeShop(
        id: 'shop_sanchaung',
        name: 'Sanchaung',
        address: 'Sanchaung Township, Yangon',
        phone: '09260185647',
        imageUrl: 'assets/catalog/shop_storefront.jpg',
      ),
      HomeShop(
        id: 'shop_thanlyin',
        name: 'Thanlyin',
        address: 'Thanlyin, Yangon',
        phone: '09880914782',
        imageUrl: 'assets/catalog/shop_storefront.jpg',
      ),
      HomeShop(
        id: 'shop_hledan',
        name: 'Hledan-2',
        address: 'Corner of Pyay & Hledan Rd, Yangon',
        phone: '09880914809',
        imageUrl: 'assets/catalog/shop_storefront.jpg',
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

  @override
  Future<Result<CatalogProduct>> findProduct(String id) async {
    return const Failure(CacheFailure());
  }
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

  @override
  Future<Result<CatalogProduct>> findProduct(String id) async {
    return const Failure(CacheFailure());
  }
}
