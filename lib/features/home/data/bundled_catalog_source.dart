import 'package:flutter/services.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/catalog_repository.dart';

/// The JSON shipped with the app. A later remote source can replace it.
class BundledCatalogSource implements CatalogSource {
  const BundledCatalogSource();

  @override
  Future<String> load() {
    return rootBundle.loadString('assets/seed/catalog.json');
  }
}
