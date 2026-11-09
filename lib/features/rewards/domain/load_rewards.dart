import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/rewards_board.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/rewards_repository.dart';

/// Loads the shared member, tiers, and challenges from the local store.
class LoadRewards {
  const LoadRewards(this._repository);

  final RewardsRepository _repository;

  Future<Result<RewardsBoard>> call() => _repository.load();
}
