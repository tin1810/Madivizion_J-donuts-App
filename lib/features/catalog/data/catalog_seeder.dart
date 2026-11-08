import 'package:drift/drift.dart';
import 'package:madivizion_jdonuts_app/features/auth/data/app_database.dart';
import 'package:madivizion_jdonuts_app/features/catalog/data/catalog_seed.dart';

/// Copies the bundled catalog into Drift once. Later launches keep the rows.
Future<void> seedCatalog(AppDatabase database, String raw) async {
  final existing = await database.select(database.storedMembers).get();
  if (existing.isNotEmpty) {
    return;
  }
  final seed = CatalogSeed.parse(raw);
  await database.transaction(() => _write(database, seed));
}

/// Replaces catalog rows from a refresh. Accounts in the users table stay.
Future<void> replaceCatalog(AppDatabase database, String raw) async {
  final seed = CatalogSeed.parse(raw);
  await database.transaction(() async {
    await database.delete(database.storedProducts).go();
    await database.delete(database.storedBanners).go();
    await database.delete(database.storedShops).go();
    await database.delete(database.storedMembers).go();
    await database.delete(database.storedTiers).go();
    await database.delete(database.storedChallenges).go();
    await _write(database, seed);
  });
}

Future<void> _write(AppDatabase database, CatalogSeed seed) async {
  await database.into(database.storedMembers).insert(_member(seed.member));
  await database.batch((batch) {
    batch
      ..insertAll(database.storedTiers, seed.tiers.map(_tier))
      ..insertAll(database.storedBanners, seed.banners.map(_banner))
      ..insertAll(database.storedProducts, seed.products.map(_product))
      ..insertAll(database.storedShops, seed.shops.map(_shop))
      ..insertAll(database.storedChallenges, seed.challenges.map(_challenge));
  });
}

StoredMembersCompanion _member(SeedMember member) {
  return StoredMembersCompanion.insert(
    id: member.id,
    name: member.name,
    photoUrl: member.photoUrl,
    tier: member.tier,
    nextTier: member.nextTier,
    points: member.points,
    pointsToNextTier: member.pointsToNextTier,
    notificationCount: member.notificationCount,
    rewardsBadgeCount: member.rewardsBadgeCount,
  );
}

StoredTiersCompanion _tier(SeedTier tier) {
  return StoredTiersCompanion.insert(
    id: tier.id,
    name: tier.name,
    caption: tier.caption,
    sortOrder: tier.sortOrder,
  );
}

StoredBannersCompanion _banner(SeedBanner banner) {
  return StoredBannersCompanion.insert(
    id: banner.id,
    title: banner.title,
    imageUrl: banner.imageUrl,
    sortOrder: banner.sortOrder,
  );
}

StoredProductsCompanion _product(SeedProduct product) {
  return StoredProductsCompanion.insert(
    id: product.id,
    code: product.code,
    name: product.name,
    priceMmk: product.priceMmk,
    isNew: product.isNew,
    imageUrl: product.imageUrl,
    description: product.description,
    sortOrder: product.sortOrder,
    discountPercent: Value(product.discountPercent),
    homeSection: Value(product.homeSection),
  );
}

StoredShopsCompanion _shop(SeedShop shop) {
  return StoredShopsCompanion.insert(
    id: shop.id,
    name: shop.name,
    imageUrl: shop.imageUrl,
    sortOrder: shop.sortOrder,
  );
}

StoredChallengesCompanion _challenge(SeedChallenge challenge) {
  return StoredChallengesCompanion.insert(
    id: challenge.id,
    title: challenge.title,
    progress: challenge.progress,
    goal: challenge.goal,
    points: challenge.points,
    artwork: challenge.artwork,
    tab: challenge.tab,
    sortOrder: challenge.sortOrder,
  );
}
