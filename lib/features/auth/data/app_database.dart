import 'package:drift/drift.dart';

part 'app_database.g.dart';

/// Local accounts. Schema version 1 creates this table.
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

@DriftDatabase(tables: [StoredUsers])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
  );
}
