import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/auth/data/app_database.dart';
import 'package:madivizion_jdonuts_app/features/catalog/data/catalog_seeder.dart';
import 'package:madivizion_jdonuts_app/features/rewards/data/drift_rewards_repository.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/rewards_board.dart';

void main() {
  test(
    'rewards reads the member, ladder, and challenges seeded for home',
    () async {
      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      final raw = File('assets/seed/catalog.json').readAsStringSync();
      await seedCatalog(database, raw);

      final result = await DriftRewardsRepository(database).load();

      expect(result, isA<Success<RewardsBoard>>());
      final board = (result as Success<RewardsBoard>).value;
      expect(board.points, 680000);
      expect(board.badgeCount, 3);
      expect(board.currentTierId, 'silver');
      expect(board.tiers.map((tier) => tier.name), [
        'Silver',
        'Gold',
        'Platinum',
      ]);
      expect(board.tiers[1].caption, '500 pts Remaining to become Gold');
      final coffee = board.challenges.singleWhere(
        (item) => item.artwork == 'coffee',
      );
      expect(coffee.progress, 9);
      expect(coffee.goal, 12);
      expect(board.challengesFor(RewardTabs.gift), isEmpty);
    },
  );
}
