import 'package:bloc/bloc.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/catalog/domain/catalog_product.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/catalog_repository.dart';

sealed class ProductDetailEvent {
  const ProductDetailEvent();
}

/// Loads the product for `/product/:id` from Drift.
final class ProductOpened extends ProductDetailEvent {
  const ProductOpened(this.id);

  final String id;
}

/// Raises the quantity. The total on Add to cart follows it.
final class QuantityIncreased extends ProductDetailEvent {
  const QuantityIncreased();
}

/// Lowers the quantity. It never goes below 1.
final class QuantityDecreased extends ProductDetailEvent {
  const QuantityDecreased();
}

/// Visual confirmation only. Nothing is stored.
final class AddToCartPressed extends ProductDetailEvent {
  const AddToCartPressed();
}

sealed class ProductDetailState {
  const ProductDetailState();
}

final class ProductDetailLoading extends ProductDetailState {
  const ProductDetailLoading();
}

final class ProductDetailMissing extends ProductDetailState {
  const ProductDetailMissing();
}

final class ProductDetailReady extends ProductDetailState {
  const ProductDetailReady({
    required this.product,
    this.quantity = 1,
    this.added = false,
  });

  final CatalogProduct product;
  final int quantity;
  final bool added;

  int get totalMmk => product.priceMmk * quantity;

  ProductDetailReady copyWith({int? quantity, bool? added}) {
    return ProductDetailReady(
      product: product,
      quantity: quantity ?? this.quantity,
      added: added ?? this.added,
    );
  }
}

/// Reads one product from Drift and keeps the quantity on screen.
class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc({required CatalogRepository catalog})
    : _catalog = catalog,
      super(const ProductDetailLoading()) {
    on<ProductOpened>(_onOpened);
    on<QuantityIncreased>(_onIncreased);
    on<QuantityDecreased>(_onDecreased);
    on<AddToCartPressed>(_onAdded);
  }

  final CatalogRepository _catalog;

  Future<void> _onOpened(
    ProductOpened event,
    Emitter<ProductDetailState> emit,
  ) async {
    final result = await _catalog.findProduct(event.id);
    if (isClosed) {
      return;
    }
    switch (result) {
      case Success(:final value):
        emit(ProductDetailReady(product: value));
      case Failure():
        emit(const ProductDetailMissing());
    }
  }

  void _onIncreased(QuantityIncreased event, Emitter<ProductDetailState> emit) {
    final current = state;
    if (current is! ProductDetailReady) {
      return;
    }
    emit(current.copyWith(quantity: current.quantity + 1, added: false));
  }

  void _onDecreased(QuantityDecreased event, Emitter<ProductDetailState> emit) {
    final current = state;
    if (current is! ProductDetailReady || current.quantity == 1) {
      return;
    }
    emit(current.copyWith(quantity: current.quantity - 1, added: false));
  }

  void _onAdded(AddToCartPressed event, Emitter<ProductDetailState> emit) {
    final current = state;
    if (current is! ProductDetailReady) {
      return;
    }
    emit(current.copyWith(added: true));
  }
}
