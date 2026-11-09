import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:madivizion_jdonuts_app/app/di/injector.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';
import 'package:madivizion_jdonuts_app/app/motion/entrance.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/load_rewards.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/rewards_board.dart';
import 'package:madivizion_jdonuts_app/features/rewards/presentation/challenge_card.dart';
import 'package:madivizion_jdonuts_app/features/rewards/presentation/points_ring.dart';
import 'package:madivizion_jdonuts_app/features/rewards/presentation/rewards_bloc.dart';
import 'package:madivizion_jdonuts_app/features/rewards/presentation/rewards_chrome.dart';
import 'package:madivizion_jdonuts_app/features/rewards/presentation/tier_ladder.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          RewardsBloc(loadRewards: injector<LoadRewards>())
            ..add(const RewardsStarted()),
      child: const RewardsView(),
    );
  }
}

class RewardsView extends StatelessWidget {
  const RewardsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RewardsBloc, RewardsState>(
      builder: (context, state) {
        return switch (state) {
          RewardsLoading() => const _Waiting(),
          RewardsFailure() => const _Failure(),
          RewardsReady(:final board) => _Board(board: board),
        };
      },
    );
  }
}

class _Waiting extends StatelessWidget {
  const _Waiting();

  @override
  Widget build(BuildContext context) {
    return const Center(child: SizedBox.square(dimension: 28));
  }
}

class _Failure extends StatelessWidget {
  const _Failure();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.homeSectionError),
          TextButton(
            onPressed: () {
              context.read<RewardsBloc>().add(const RewardsStarted());
            },
            child: Text(l10n.homeTryAgain),
          ),
        ],
      ),
    );
  }
}

class _Board extends StatefulWidget {
  const _Board({required this.board});

  final RewardsBoard board;

  @override
  State<_Board> createState() => _BoardState();
}

class _BoardState extends State<_Board> with SingleTickerProviderStateMixin {
  late final AnimationController _motion;
  late final CurvedAnimation _reveal;
  String _tab = RewardTabs.earn;

  @override
  void initState() {
    super.initState();
    _motion = AnimationController(vsync: this);
    _reveal = CurvedAnimation(parent: _motion, curve: AppMotion.enterCurve);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _motion.duration = AppMotion.resolve(context, AppMotion.countUp);
    if (_motion.duration == Duration.zero) {
      _motion.value = 1;
      return;
    }
    if (!_motion.isAnimating && _motion.value == 0) {
      _motion.forward();
    }
  }

  @override
  void dispose() {
    _reveal.dispose();
    _motion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cards = widget.board.challengesFor(_tab);
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.lg),
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: _tabHang),
                child: ColoredBox(
                  color: AppColors.surface,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      AppSpacing.md,
                      0,
                      _tabHang + AppSpacing.sm,
                    ),
                    child: Column(
                      children: [
                        RewardsHeading(count: widget.board.badgeCount),
                        const SizedBox(height: AppSpacing.lg),
                        Padding(
                          padding: const EdgeInsets.only(right: AppSpacing.md),
                          child: _Summary(board: widget.board, reveal: _reveal),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: RewardsTabs(
                  selected: _tab,
                  onSelected: (tab) => setState(() => _tab = tab),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: AnimatedSwitcher(
              duration: AppMotion.resolve(context, AppMotion.fast),
              switchInCurve: AppMotion.enterCurve,
              switchOutCurve: AppMotion.exitCurve,
              transitionBuilder: _slide,
              child: KeyedSubtree(
                key: ValueKey(_tab),
                child: _cards(context, cards),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cards(BuildContext context, List<RewardChallenge> cards) {
    if (cards.isEmpty) {
      return const _GiftEmpty();
    }
    return Column(
      children: [
        for (var index = 0; index < cards.length; index++)
          Entrance(
            animation: _motion,
            start: 0.12 + index * 0.08,
            end: 0.42 + index * 0.08,
            child: ChallengeCard(challenge: cards[index], reveal: _motion),
          ),
      ],
    );
  }
}

Widget _slide(Widget child, Animation<double> animation) {
  final offset = Tween<Offset>(
    begin: const Offset(0.06, 0),
    end: Offset.zero,
  ).animate(animation);
  return FadeTransition(
    opacity: animation,
    child: SlideTransition(position: offset, child: child),
  );
}

const double _tabHang = 22;

class _GiftEmpty extends StatelessWidget {
  const _GiftEmpty();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final still = MediaQuery.disableAnimationsOf(context);
    return Column(
      children: [
        Lottie.asset(
          'assets/rewards/no_history.lottie',
          width: 220,
          height: 220,
          animate: !still,
          repeat: !still,
        ),
        Text(l10n.rewardsGiftEmpty, style: _caption(context)),
      ],
    );
  }

  TextStyle? _caption(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.textSecondary,
      fontWeight: FontWeight.w600,
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.board, required this.reveal});

  final RewardsBoard board;
  final Animation<double> reveal;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TierLadder(
            tiers: board.tiers,
            currentTierId: board.currentTierId,
            reveal: reveal,
          ),
        ),
        Transform.translate(
          offset: const Offset(AppSpacing.xl + 8, 0),
          child: PointsRing(points: board.points, reveal: reveal),
        ),
      ],
    );
  }
}
