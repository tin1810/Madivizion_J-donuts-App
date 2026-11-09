import 'package:drift/drift.dart';

/// Products shown on Home and opened from `/product/:id`.
class StoredProducts extends Table {
  @override
  String get tableName => 'products';

  TextColumn get id => text()();

  TextColumn get code => text()();

  TextColumn get name => text()();

  IntColumn get priceMmk => integer()();

  BoolColumn get isNew => boolean()();

  IntColumn get discountPercent => integer().nullable()();

  TextColumn get imageUrl => text()();

  TextColumn get description => text()();

  TextColumn get homeSection => text().nullable()();

  IntColumn get sortOrder => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Promo cards in the Home carousel.
class StoredBanners extends Table {
  @override
  String get tableName => 'banners';

  TextColumn get id => text()();

  TextColumn get title => text()();

  TextColumn get badge => text().nullable()();

  TextColumn get imageUrl => text()();

  IntColumn get sortOrder => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// The four nearby shops. Cards are display-only.
class StoredShops extends Table {
  @override
  String get tableName => 'shops';

  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get address => text()();

  TextColumn get phone => text()();

  TextColumn get imageUrl => text()();

  IntColumn get sortOrder => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// The single profile Home and Rewards both read.
class StoredMembers extends Table {
  @override
  String get tableName => 'members';

  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get photoUrl => text()();

  TextColumn get tier => text()();

  TextColumn get nextTier => text()();

  IntColumn get points => integer()();

  IntColumn get pointsToNextTier => integer()();

  IntColumn get notificationCount => integer()();

  IntColumn get rewardsBadgeCount => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Silver, Gold, and Platinum, in ladder order.
class StoredTiers extends Table {
  @override
  String get tableName => 'tiers';

  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get caption => text()();

  IntColumn get sortOrder => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Earn and gift challenges. [artwork] is `donut` or `coffee`.
class StoredChallenges extends Table {
  @override
  String get tableName => 'challenges';

  TextColumn get id => text()();

  TextColumn get title => text()();

  IntColumn get progress => integer()();

  IntColumn get goal => integer()();

  IntColumn get points => integer()();

  TextColumn get artwork => text()();

  TextColumn get tab => text()();

  IntColumn get sortOrder => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
