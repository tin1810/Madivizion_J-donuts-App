import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/features/catalog/domain/catalog_product.dart';
import 'package:madivizion_jdonuts_app/features/home/data/memory_catalog_repository.dart';
import 'package:madivizion_jdonuts_app/features/product/presentation/product_detail_bloc.dart';

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

  ProductDetailBloc open(String id) {
    final bloc = ProductDetailBloc(
      catalog: MemoryCatalogRepository(products: const {'p_coconut': coconut}),
    );
    bloc.add(ProductOpened(id));
    return bloc;
  }

  test('an unknown product is missing', () async {
    final bloc = open('missing');
    await expectLater(bloc.stream, emits(isA<ProductDetailMissing>()));
  });

  test('quantity stays at least 1 and the total follows it', () async {
    final bloc = open('p_coconut');
    await bloc.stream.firstWhere((state) => state is ProductDetailReady);

    bloc.add(const QuantityDecreased());
    bloc.add(const QuantityIncreased());
    bloc.add(const QuantityIncreased());
    await expectLater(
      bloc.stream,
      emitsThrough(
        isA<ProductDetailReady>()
            .having((state) => state.quantity, 'quantity', 3)
            .having((state) => state.totalMmk, 'total', 9600),
      ),
    );
  });

  test('add to cart only marks the screen', () async {
    final bloc = open('p_coconut');
    final ready = await bloc.stream.firstWhere(
      (state) => state is ProductDetailReady,
    );
    bloc.add(const AddToCartPressed());
    await expectLater(
      bloc.stream,
      emits(
        isA<ProductDetailReady>()
            .having((state) => state.added, 'added', isTrue)
            .having((state) => state.quantity, 'quantity', 1),
      ),
    );
    expect((ready as ProductDetailReady).product, coconut);
  });
}
