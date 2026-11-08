import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/core/result/unit.dart';
import 'package:madivizion_jdonuts_app/features/catalog/domain/catalog_product.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/catalog_repository.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/home_feed.dart';

/// Catalog used when a test does not open the real database.
class MemoryCatalogRepository implements CatalogRepository {
  MemoryCatalogRepository({HomeFeed? feed, this.products = const {}})
    : feed = feed ?? sample;

  static final HomeFeed sample = HomeFeed(
    member: const Success(
      MemberProfile(
        name: 'Hania',
        photoUrl: 'assets/catalog/member_hania.png',
        tier: 'silver',
        nextTier: 'gold',
        pointsToNextTier: 500,
        notificationCount: 2,
      ),
    ),
    seasonal: const Success([]),
    popular: const Success([]),
    orderAgain: const Success([]),
    banners: const Success([]),
    shops: const Success([]),
  );

  HomeFeed feed;
  final Map<String, CatalogProduct> products;
  var refreshCount = 0;

  @override
  Future<HomeFeed> loadHome() async => feed;

  @override
  Future<Result<Unit>> refresh() async {
    refreshCount += 1;
    return const Success(Unit.instance);
  }

  @override
  Future<Result<CatalogProduct>> findProduct(String id) async {
    final product = products[id];
    if (product == null) {
      return const Failure(CacheFailure());
    }
    return Success(product);
  }
}
