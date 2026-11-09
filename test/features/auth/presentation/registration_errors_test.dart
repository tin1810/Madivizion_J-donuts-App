import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/app/di/injector.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_timing.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/continue_button.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/second_ticker.dart';
import 'package:madivizion_jdonuts_app/main.dart';

import '../memory_auth_repository.dart';

void main() {
  tearDown(() async {
    await injector.reset();
  });

  testWidgets('continue stays disabled until the phone is valid', (
    tester,
  ) async {
    await _pump(tester);

    expect(_continueEnabled(tester), isFalse);
    await tester.tap(find.text('CONTINUE'));
    await tester.pump();
    expect(find.textContaining('Enter your phone'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('phone-field')), '09254135592');
    await tester.pump();

    expect(_continueEnabled(tester), isTrue);
  });

  testWidgets('an invalid phone shows an error and keeps continue disabled', (
    tester,
  ) async {
    await _pump(tester);

    await tester.enterText(find.byKey(const Key('phone-field')), '123');
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pump();

    expect(find.text('Enter a valid Myanmar mobile number.'), findsOneWidget);
    expect(_continueEnabled(tester), isFalse);
  });

  testWidgets(
    'a name with a number shows an error and keeps continue disabled',
    (tester) async {
      await _pump(tester);
      await _openName(tester);

      await tester.enterText(find.byKey(const Key('first-name')), 'Ye1');
      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pump();

      expect(find.text('Use letters and spaces only.'), findsOneWidget);
      expect(_continueEnabled(tester), isFalse);
      expect(find.textContaining('date of birth'), findsNothing);
    },
  );

  testWidgets('31 April shows a calendar error and keeps continue disabled', (
    tester,
  ) async {
    await _pump(tester);
    await _openBirth(tester);

    await tester.tap(find.byKey(const Key('birth-month')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('birth-month-April')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('birth-day')), '31');
    await tester.tap(find.byKey(const Key('birth-year')));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.byKey(const Key('birth-year-1980')),
      400,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.byKey(const Key('birth-year-1980')));
    await tester.pumpAndSettle();
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pump();

    expect(find.text('Enter a real calendar date.'), findsOneWidget);
    expect(_continueEnabled(tester), isFalse);
    expect(find.textContaining("world of J'donuts"), findsNothing);
  });
}

bool _continueEnabled(WidgetTester tester) {
  return tester.widget<ContinueButton>(find.byType(ContinueButton)).enabled;
}

Future<void> _pump(WidgetTester tester) async {
  await configureDependencies(
    authRepository: MemoryAuthRepository(),
    pacing: const AuthPacing(delay: Duration.zero),
    ticker: const _SilentTicker(),
  );
  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();
  await tester.tap(find.text("LET'S GET STARTED"));
  await tester.pumpAndSettle();
}

Future<void> _openName(WidgetTester tester) async {
  await tester.enterText(find.byKey(const Key('phone-field')), '09254135592');
  await tester.pumpAndSettle();
  await tester.tap(find.text('CONTINUE'));
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key('otp-field')), '123456');
  await tester.pumpAndSettle();
}

Future<void> _openBirth(WidgetTester tester) async {
  await _openName(tester);
  await tester.enterText(find.byKey(const Key('first-name')), 'Ye Min');
  await tester.pumpAndSettle();
  await tester.tap(find.text('CONTINUE'));
  await tester.pumpAndSettle();
}

class _SilentTicker extends SecondTicker {
  const _SilentTicker();

  @override
  Stream<int> countdown(int from) => const Stream<int>.empty();
}
