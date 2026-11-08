import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/features/auth/data/app_database.dart';
import 'package:madivizion_jdonuts_app/features/catalog/data/catalog_seeder.dart';

void main() {
  test('upgrades a version 1 file and keeps the account', () async {
    final file = File(
      '${Directory.systemTemp.path}/jdonuts-v1-${DateTime.now().microsecondsSinceEpoch}.sqlite',
    );
    final v1 = AppDatabase(NativeDatabase(file), schemaVersion: 1);
    await v1
        .into(v1.storedUsers)
        .insert(
          StoredUsersCompanion.insert(
            phoneE164: '+959254135592',
            firstName: 'Ye Min',
            lastName: 'Phyo Win',
            birthDate: '1980-05-01',
          ),
        );
    await v1.close();

    final v2 = AppDatabase(NativeDatabase(file));
    final users = await v2.select(v2.storedUsers).get();
    final products = await v2.select(v2.storedProducts).get();

    expect(users.single.phoneE164, '+959254135592');
    expect(products, isEmpty);
    await v2.close();
    file.deleteSync();
  });

  test('copies the shared member once, including the coconut donut', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final raw = File('assets/seed/catalog.json').readAsStringSync();

    await seedCatalog(database, raw);
    await seedCatalog(database, raw);

    final members = await database.select(database.storedMembers).get();
    expect(members, hasLength(1));
    expect(members.single.name, 'Hania');
    expect(members.single.tier, 'silver');
    expect(members.single.nextTier, 'gold');
    expect(members.single.points, 680000);
    expect(members.single.pointsToNextTier, 500);
    expect(members.single.notificationCount, 2);
    expect(members.single.rewardsBadgeCount, 3);

    final coconut = await (database.select(
      database.storedProducts,
    )..where((row) => row.id.equals('p_coconut'))).getSingle();
    expect(coconut.code, 'JD022123');
    expect(coconut.priceMmk, 3200);
    expect(coconut.isNew, isTrue);

    final shops = await database.select(database.storedShops).get();
    expect(shops, hasLength(4));
    final gold = await (database.select(
      database.storedTiers,
    )..where((row) => row.id.equals('gold'))).getSingle();
    expect(gold.caption, '500 pts Remaining to become Gold');
  });
}
