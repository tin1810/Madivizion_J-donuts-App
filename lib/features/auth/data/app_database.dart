import 'package:drift/drift.dart';
import 'package:madivizion_jdonuts_app/features/catalog/data/catalog_tables.dart';

part 'app_database.g.dart';

/// Local accounts. Schema version 1 created this table.
class StoredUsers extends Table {
  @override
  String get tableName => 'users';

  TextColumn get phoneE164 => text()();

  TextColumn get firstName => text()();

  TextColumn get lastName => text()();

  TextColumn get birthDate => text()();

  @override
  Set<Column> get primaryKey => {phoneE164};
}

@DriftDatabase(
  tables: [
    StoredUsers,
    StoredProducts,
    StoredBanners,
    StoredShops,
    StoredMembers,
    StoredTiers,
    StoredChallenges,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e, {int? schemaVersion}) : _schemaVersion = schemaVersion;

  /// Tests pass `1` to build the pre-catalog file. The app uses version 2.
  final int? _schemaVersion;

  @override
  int get schemaVersion => _schemaVersion ?? 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      if (schemaVersion < 2) {
        await migrator.createTable(storedUsers);
        return;
      }
      await migrator.createAll();
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 2 && to >= 2) {
        await migrator.createTable(storedProducts);
        await migrator.createTable(storedBanners);
        await migrator.createTable(storedShops);
        await migrator.createTable(storedMembers);
        await migrator.createTable(storedTiers);
        await migrator.createTable(storedChallenges);
      }
    },
  );
}
