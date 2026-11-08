import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/core/result/unit.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/home_feed.dart';

/// Home reads this. Refresh writes into the local database.
abstract class CatalogRepository {
  Future<HomeFeed> loadHome();

  Future<Result<Unit>> refresh();
}

/// Where a refresh reads the catalog document from.
abstract class CatalogSource {
  Future<String> load();
}
