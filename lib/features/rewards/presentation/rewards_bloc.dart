import 'package:bloc/bloc.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/load_rewards.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/rewards_board.dart';

sealed class RewardsEvent {
  const RewardsEvent();
}

/// Reads the local member, tiers, and challenges.
final class RewardsStarted extends RewardsEvent {
  const RewardsStarted();
}

sealed class RewardsState {
  const RewardsState();
}

final class RewardsLoading extends RewardsState {
  const RewardsLoading();
}

final class RewardsReady extends RewardsState {
  const RewardsReady(this.board);

  final RewardsBoard board;
}

final class RewardsFailure extends RewardsState {
  const RewardsFailure();
}

/// Paints rewards from the same local rows Home already stored.
class RewardsBloc extends Bloc<RewardsEvent, RewardsState> {
  RewardsBloc({required LoadRewards loadRewards})
    : _loadRewards = loadRewards,
      super(const RewardsLoading()) {
    on<RewardsStarted>(_onStarted);
  }

  final LoadRewards _loadRewards;

  Future<void> _onStarted(
    RewardsStarted event,
    Emitter<RewardsState> emit,
  ) async {
    emit(const RewardsLoading());
    final result = await _loadRewards();
    if (isClosed) {
      return;
    }
    emit(switch (result) {
      Success<RewardsBoard>(:final value) => RewardsReady(value),
      Failure<RewardsBoard>() => const RewardsFailure(),
    });
  }
}
