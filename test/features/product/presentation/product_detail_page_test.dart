import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/features/catalog/domain/catalog_product.dart';
import 'package:madivizion_jdonuts_app/features/home/data/memory_catalog_repository.dart';
import 'package:madivizion_jdonuts_app/features/product/presentation/product_detail_bloc.dart';
import 'package:madivizion_jdonuts_app/features/product/presentation/product_detail_page.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

void main() {
  const coconut = CatalogProduct(
    id: 'p_coconut',
    code: 'JD022123',
    name: 'Coconut Donut',
    priceMmk: 3200,
    isNew: true,
    imageUrl: 'assets/catalog/p_coconut.png',
    description: 'Enjoy our scrumptious donuts.',
  );

  testWidgets('the detail screen totals the quantity and confirms the add', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final bloc = ProductDetailBloc(
      catalog: MemoryCatalogRepository(products: const {'p_coconut': coconut}),
    )..add(const ProductOpened('p_coconut'));
    await tester.pumpWidget(_app(bloc));
    await tester.pump();
    await tester.pump();

    expect(find.text('JD022123'), findsOneWidget);
    expect(find.text('Coconut Donut'), findsOneWidget);
    expect(find.text('New'), findsOneWidget);
    expect(find.text('Enjoy our scrumptious donuts.'), findsOneWidget);
    expect(find.textContaining('3,200 MMK'), findsWidgets);
    expect(find.byType(Hero), findsOneWidget);

    await tester.tap(find.byKey(const Key('product-more')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
    expect(find.text('2'), findsOneWidget);
    expect(find.textContaining('6,400 MMK'), findsOneWidget);

    await tester.tap(find.byKey(const Key('product-less')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
    await tester.tap(find.byKey(const Key('product-less')));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byKey(const Key('product-add')));
    await tester.pump();
    expect(find.text('Added to cart'), findsOneWidget);
  });

  testWidgets('a missing product tells the reader', (tester) async {
    final bloc = ProductDetailBloc(catalog: MemoryCatalogRepository())
      ..add(const ProductOpened('missing'));
    await tester.pumpWidget(_app(bloc));
    await tester.pump();
    await tester.pump();

    expect(find.text('This product is not available.'), findsOneWidget);
  });
}

Widget _app(ProductDetailBloc bloc) {
  return MaterialApp(
    theme: AppTheme.light(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: BlocProvider.value(value: bloc, child: const ProductDetailView()),
  );
}
