import 'package:drift/drift.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/core/result/unit.dart';
import 'package:madivizion_jdonuts_app/features/auth/data/app_database.dart';
import 'package:madivizion_jdonuts_app/features/catalog/data/catalog_seeder.dart';
import 'package:madivizion_jdonuts_app/features/catalog/domain/catalog_product.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/catalog_repository.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/home_feed.dart';

/// Drift is the only source the Home screen paints from.
class DriftCatalogRepository implements CatalogRepository {
  const DriftCatalogRepository({required this.database, required this.source});

  final AppDatabase database;
  final CatalogSource source;

  @override
  Future<HomeFeed> loadHome() async {
    return HomeFeed(
      member: await _member(),
      seasonal: await _products(HomeSections.seasonal),
      popular: await _products(HomeSections.popular),
      orderAgain: await _products(HomeSections.orderAgain),
      banners: await _banners(),
      shops: await _shops(),
    );
  }

  @override
  Future<Result<Unit>> refresh() {
    return Result.capture(() async {
      await replaceCatalog(database, await source.load());
      return Unit.instance;
    });
  }

  @override
  Future<Result<CatalogProduct>> findProduct(String id) {
    return _guard(() async {
      final query = database.select(database.storedProducts)
        ..where((row) => row.id.equals(id));
      final row = await query.getSingleOrNull();
      if (row == null) {
        throw const CacheFailure();
      }
      return CatalogProduct(
        id: row.id,
        code: row.code,
        name: row.name,
        priceMmk: row.priceMmk,
        isNew: row.isNew,
        imageUrl: row.imageUrl,
        description: row.description,
      );
    });
  }

  Future<Result<MemberProfile>> _member() {
    return _guard(() async {
      final row = await database
          .select(database.storedMembers)
          .getSingleOrNull();
      if (row == null) {
        throw const CacheFailure();
      }
      return MemberProfile(
        name: row.name,
        photoUrl: row.photoUrl,
        tier: row.tier,
        nextTier: row.nextTier,
        pointsToNextTier: row.pointsToNextTier,
        notificationCount: row.notificationCount,
      );
    });
  }

  Future<Result<List<HomeProduct>>> _products(String section) {
    return _guard(() async {
      final query = database.select(database.storedProducts)
        ..where((row) => row.homeSection.equals(section))
        ..orderBy([(row) => OrderingTerm.asc(row.sortOrder)]);
      final rows = await query.get();
      return [
        for (final row in rows)
          HomeProduct(
            id: row.id,
            name: row.name,
            imageUrl: row.imageUrl,
            discountPercent: row.discountPercent,
          ),
      ];
    });
  }

  Future<Result<List<HomeBanner>>> _banners() {
    return _guard(() async {
      final query = database.select(database.storedBanners)
        ..orderBy([(row) => OrderingTerm.asc(row.sortOrder)]);
      final rows = await query.get();
      return [
        for (final row in rows)
          HomeBanner(id: row.id, title: row.title, imageUrl: row.imageUrl),
      ];
    });
  }

  Future<Result<List<HomeShop>>> _shops() {
    return _guard(() async {
      final query = database.select(database.storedShops)
        ..orderBy([(row) => OrderingTerm.asc(row.sortOrder)]);
      final rows = await query.get();
      return [
        for (final row in rows)
          HomeShop(id: row.id, name: row.name, imageUrl: row.imageUrl),
      ];
    });
  }
}

Future<Result<T>> _guard<T>(Future<T> Function() read) async {
  try {
    return Success(await read());
  } on AppFailure catch (failure) {
    return Failure(failure);
  } on Object {
    return const Failure(CacheFailure());
  }
}
