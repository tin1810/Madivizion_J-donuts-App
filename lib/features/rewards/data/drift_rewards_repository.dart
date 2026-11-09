import 'package:drift/drift.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/auth/data/app_database.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/rewards_board.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/rewards_repository.dart';

/// Rewards paints only what Drift already stored for Home.
class DriftRewardsRepository implements RewardsRepository {
  const DriftRewardsRepository(this.database);

  final AppDatabase database;

  @override
  Future<Result<RewardsBoard>> load() {
    return Result.capture(_read);
  }

  Future<RewardsBoard> _read() async {
    final member = await database
        .select(database.storedMembers)
        .getSingleOrNull();
    if (member == null) {
      throw const CacheFailure();
    }
    return RewardsBoard(
      points: member.points,
      badgeCount: member.rewardsBadgeCount,
      currentTierId: member.tier,
      tiers: await _tiers(),
      challenges: await _challenges(),
    );
  }

  Future<List<RewardTier>> _tiers() async {
    final query = database.select(database.storedTiers)
      ..orderBy([(row) => OrderingTerm.asc(row.sortOrder)]);
    final rows = await query.get();
    return [
      for (final row in rows)
        RewardTier(id: row.id, name: row.name, caption: row.caption),
    ];
  }

  Future<List<RewardChallenge>> _challenges() async {
    final query = database.select(database.storedChallenges)
      ..orderBy([(row) => OrderingTerm.asc(row.sortOrder)]);
    final rows = await query.get();
    return [
      for (final row in rows)
        RewardChallenge(
          id: row.id,
          title: row.title,
          progress: row.progress,
          goal: row.goal,
          points: row.points,
          artwork: row.artwork,
          tab: row.tab,
        ),
    ];
  }
}
