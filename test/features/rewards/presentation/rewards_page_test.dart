import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/rewards/data/memory_rewards_repository.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/load_rewards.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/rewards_board.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/rewards_repository.dart';
import 'package:madivizion_jdonuts_app/features/rewards/presentation/rewards_bloc.dart';
import 'package:madivizion_jdonuts_app/features/rewards/presentation/rewards_page.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

void main() {
  testWidgets(
    'the points count up and the finished challenge highlights earn',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(_app(MemoryRewardsRepository()));
      await tester.pump();

      expect(find.text('680,000'), findsNothing);
      expect(find.text("You're here now"), findsOneWidget);
      expect(find.text('500 pts Remaining to become Gold'), findsOneWidget);
      expect(find.text("You'll be here soon"), findsOneWidget);
      expect(find.text('4/4'), findsOneWidget);
      expect(find.text('1/4'), findsOneWidget);
      expect(find.text('9/12'), findsOneWidget);
      expect(find.byKey(const Key('rewards-earn-ready')), findsOneWidget);

      await tester.pump(AppMotion.countUp);
      await tester.pump(const Duration(milliseconds: 50));
      expect(find.text('680,000'), findsOneWidget);
    },
  );

  testWidgets('reduce motion shows the full points immediately', (
    tester,
  ) async {
    await tester.pumpWidget(_app(MemoryRewardsRepository(), still: true));
    await tester.pump();

    expect(find.text('680,000'), findsOneWidget);
  });

  testWidgets('the gift tab is empty until a gift challenge is stored', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(_app(MemoryRewardsRepository()));
    await tester.pump();
    expect(find.text('9/12'), findsOneWidget);
    await tester.tap(find.byKey(const Key('rewards-gift-tab')));
    await tester.pump();
    await tester.pump(AppMotion.fast + const Duration(milliseconds: 50));

    expect(find.text('Nothing here yet'), findsOneWidget);
    expect(find.text('9/12'), findsNothing);
  });

  testWidgets('tapping earn bursts fireworks and stays on the board', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(_app(MemoryRewardsRepository()));
    await tester.pump();
    await tester.pump(AppMotion.countUp);
    await tester.pump(const Duration(milliseconds: 50));
    expect(find.text('680,000'), findsOneWidget);

    await tester.tap(find.byKey(const Key('rewards-earn-ready')));
    await tester.pump();
    expect(find.text('Congratulations!'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1700));

    expect(find.text('Congratulations!'), findsNothing);
    expect(find.text('680,000'), findsOneWidget);
    expect(find.byKey(const Key('rewards-earn-ready')), findsOneWidget);
  });

  testWidgets('a grey earn button does not celebrate', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(_app(MemoryRewardsRepository()));
    await tester.pump();

    await tester.tap(find.text('EARN').at(1), warnIfMissed: false);
    await tester.pump();

    expect(find.text('Congratulations!'), findsNothing);
    expect(find.byKey(const Key('rewards-earn-ready')), findsOneWidget);
  });

  testWidgets('a failed read can be tried again', (tester) async {
    final repository = _ThenSucceeds();
    await tester.pumpWidget(_app(repository));
    await tester.pump();

    expect(find.text("Couldn't load this section"), findsOneWidget);
    await tester.tap(find.text('Try again'));
    await tester.pump();
    await tester.pump();

    expect(find.text('Silver'), findsOneWidget);
  });
}

class _ThenSucceeds implements RewardsRepository {
  var _failed = false;

  @override
  Future<Result<RewardsBoard>> load() async {
    if (!_failed) {
      _failed = true;
      return const Failure(CacheFailure());
    }
    return const Success(MemoryRewardsRepository.sample);
  }
}

Widget _app(RewardsRepository repository, {bool still = false}) {
  return MaterialApp(
    builder: (context, child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(disableAnimations: still),
        child: child ?? const SizedBox.shrink(),
      );
    },
    theme: AppTheme.light(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: BlocProvider(
      create: (_) =>
          RewardsBloc(loadRewards: LoadRewards(repository))
            ..add(const RewardsStarted()),
      child: const RewardsView(),
    ),
  );
}
