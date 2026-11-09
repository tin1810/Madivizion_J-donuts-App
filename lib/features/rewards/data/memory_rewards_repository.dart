import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/rewards_board.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/rewards_repository.dart';

/// The seeded rewards board, used when a test does not open Drift.
class MemoryRewardsRepository implements RewardsRepository {
  MemoryRewardsRepository({this.board = sample, this.failure});

  static const RewardsBoard sample = RewardsBoard(
    points: 680000,
    badgeCount: 3,
    currentTierId: 'silver',
    tiers: [
      RewardTier(id: 'silver', name: 'Silver', caption: "You're here now"),
      RewardTier(
        id: 'gold',
        name: 'Gold',
        caption: '500 pts Remaining to become Gold',
      ),
      RewardTier(
        id: 'platinum',
        name: 'Platinum',
        caption: "You'll be here soon",
      ),
    ],
    challenges: [
      RewardChallenge(
        id: 'ch_coco_done',
        title: 'Eat 4 Coco donuts',
        progress: 4,
        goal: 4,
        points: 100,
        artwork: RewardArtwork.donut,
        tab: RewardTabs.earn,
      ),
      RewardChallenge(
        id: 'ch_coco_start',
        title: 'Eat 4 Coco donuts',
        progress: 1,
        goal: 4,
        points: 100,
        artwork: RewardArtwork.donut,
        tab: RewardTabs.earn,
      ),
      RewardChallenge(
        id: 'ch_coffee',
        title: 'Drink 12 cups americano',
        progress: 9,
        goal: 12,
        points: 100,
        artwork: RewardArtwork.coffee,
        tab: RewardTabs.earn,
      ),
    ],
  );

  final RewardsBoard board;
  final AppFailure? failure;

  @override
  Future<Result<RewardsBoard>> load() async {
    final error = failure;
    if (error != null) {
      return Failure(error);
    }
    return Success(board);
  }
}
