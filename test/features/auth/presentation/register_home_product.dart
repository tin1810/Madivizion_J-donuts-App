import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/app/di/injector.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_timing.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/second_ticker.dart';
import 'package:madivizion_jdonuts_app/features/catalog/domain/catalog_product.dart';
import 'package:madivizion_jdonuts_app/features/home/data/memory_catalog_repository.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/home_feed.dart';
import 'package:madivizion_jdonuts_app/main.dart';

import '../memory_auth_repository.dart';

/// Register, open Home, then open the product. Widget and device tests share it.
void registerThenOpenProduct() {
  tearDown(() async {
    await injector.reset();
  });

  testWidgets('register opens home and then the product', (tester) async {
    await _wideSurface(tester);
    await configureDependencies(
      authRepository: MemoryAuthRepository(),
      catalog: _catalog(),
      pacing: const AuthPacing(delay: Duration.zero),
      ticker: const _SilentTicker(),
    );
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text("LET'S GET STARTED"));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('phone-field')), '09254135592');
    await tester.pumpAndSettle();
    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('otp-field')), '123456');
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('first-name')), 'Ye Min');
    await tester.enterText(find.byKey(const Key('last-name')), 'Phyo Win');
    await tester.pumpAndSettle();
    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('birth-month')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('birth-month-May')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('birth-day')), '01');
    await tester.tap(find.byKey(const Key('birth-year')));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.byKey(const Key('birth-year-1980')),
      400,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.byKey(const Key('birth-year-1980')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();

    expect(find.textContaining("world of J'donuts"), findsOneWidget);
    await tester.tap(find.text("LET'S EXPLORE"));
    await tester.pumpAndSettle();

    expect(find.text('Ye Min Phyo Win'), findsOneWidget);
    await tester.ensureVisible(find.text('Coconut Cloud'));
    await tester.tap(find.text('Coconut Cloud'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('product-add')), findsOneWidget);
    expect(find.text('3,200 MMK'), findsWidgets);
  });
}

Future<void> _wideSurface(WidgetTester tester) async {
  if (tester.binding is LiveTestWidgetsFlutterBinding) {
    return;
  }
  await tester.binding.setSurfaceSize(const Size(800, 1600));
  addTearDown(() => tester.binding.setSurfaceSize(null));
}

MemoryCatalogRepository _catalog() {
  const product = CatalogProduct(
    id: 'p_coconut',
    code: 'JD022123',
    name: 'Coconut Cloud',
    priceMmk: 3200,
    isNew: true,
    imageUrl: 'assets/catalog/p_coconut.png',
    description: 'A soft coconut donut.',
  );
  return MemoryCatalogRepository(
    feed: HomeFeed(
      member: MemoryCatalogRepository.sample.member,
      seasonal: const Success([
        HomeProduct(
          id: 'p_coconut',
          name: 'Coconut Cloud',
          imageUrl: 'assets/catalog/p_coconut.png',
          discountPercent: null,
        ),
      ]),
      popular: const Success([]),
      orderAgain: const Success([]),
      banners: const Success([]),
      shops: const Success([]),
    ),
    products: const {'p_coconut': product},
  );
}

class _SilentTicker extends SecondTicker {
  const _SilentTicker();

  @override
  Stream<int> countdown(int from) => const Stream<int>.empty();
}
