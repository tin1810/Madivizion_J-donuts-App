import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/auth/data/app_database.dart';
import 'package:madivizion_jdonuts_app/features/catalog/data/catalog_seeder.dart';
import 'package:madivizion_jdonuts_app/features/catalog/domain/catalog_product.dart';
import 'package:madivizion_jdonuts_app/features/home/data/drift_catalog_repository.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/catalog_repository.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/home_feed.dart';

void main() {
  test('home reads the shared member, rows, and shops from Drift', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final raw = File('assets/seed/catalog.json').readAsStringSync();
    await seedCatalog(database, raw);
    final repository = DriftCatalogRepository(
      database: database,
      source: _Source(raw),
    );

    final feed = await repository.loadHome();

    final member = (feed.member as Success<MemberProfile>).value;
    expect(member.name, 'Hania');
    expect(member.tier, 'silver');
    expect(member.pointsToNextTier, 500);
    expect(member.notificationCount, 2);
    final seasonal = (feed.seasonal as Success<List<HomeProduct>>).value;
    expect(seasonal.map((item) => item.name), [
      'Mistletoe Romance box',
      'Christmas MI Family box',
    ]);
    expect(seasonal.map((item) => item.id), isNot(contains('p_coconut')));
    expect((feed.shops as Success<List<HomeShop>>).value, hasLength(4));
    final banners = (feed.banners as Success<List<HomeBanner>>).value;
    expect(banners, hasLength(4));
    expect(banners.first.title, 'We are now at Central Boulevard');
    expect(banners.first.badge, 'New shop');
    final coconut = await repository.findProduct('p_coconut');
    final product = (coconut as Success<CatalogProduct>).value;
    expect(product.code, 'JD022123');
    expect(product.priceMmk, 3200);
    expect(product.isNew, isTrue);
    expect(
      await repository.findProduct('missing'),
      isA<Failure<CatalogProduct>>(),
    );
  });

  test('refresh replaces catalog rows and keeps accounts', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final raw = File('assets/seed/catalog.json').readAsStringSync();
    await seedCatalog(database, raw);
    await database
        .into(database.storedUsers)
        .insert(
          StoredUsersCompanion.insert(
            phoneE164: '+959254135592',
            firstName: 'Ye Min',
            lastName: 'Phyo Win',
            birthDate: '1980-05-01',
          ),
        );
    final updated = raw.replaceFirst('Hania', 'Updated');
    final repository = DriftCatalogRepository(
      database: database,
      source: _Source(updated),
    );

    await repository.refresh();
    final feed = await repository.loadHome();

    expect((feed.member as Success<MemberProfile>).value.name, 'Updated');
    final users = await database.select(database.storedUsers).get();
    expect(users.single.phoneE164, '+959254135592');
  });
}

class _Source implements CatalogSource {
  const _Source(this.raw);

  final String raw;

  @override
  Future<String> load() async => raw;
}
