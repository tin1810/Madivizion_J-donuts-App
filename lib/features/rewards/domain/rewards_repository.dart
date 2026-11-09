import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/rewards_board.dart';

/// Reads the rewards rows already stored for Home.
abstract class RewardsRepository {
  Future<Result<RewardsBoard>> load();
}
