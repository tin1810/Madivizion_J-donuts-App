import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/app/di/injector.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_timing.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/second_ticker.dart';
import 'package:madivizion_jdonuts_app/main.dart';

import '../memory_auth_repository.dart';

void main() {
  tearDown(() async {
    await injector.reset();
  });

  testWidgets('the phone page shows +95 before typing', (tester) async {
    await _pump(tester);

    final prefix = find.textContaining('+95');
    expect(prefix, findsOneWidget);
    expect(_isShown(tester, prefix), isTrue);
  });

  testWidgets('the phone field keeps eleven digits and drops the rest', (
    tester,
  ) async {
    await _pump(tester);

    await tester.enterText(
      find.byKey(const Key('phone-field')),
      '092541355921',
    );
    await tester.pump();

    final field = tester.widget<TextField>(
      find.byKey(const Key('phone-field')),
    );
    expect(field.controller?.text, '09254135592');
  });

  testWidgets('an invalid phone shows an error after blur', (tester) async {
    await _pump(tester);

    await tester.enterText(find.byKey(const Key('phone-field')), '123');
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pump();

    expect(find.text('Enter a valid Myanmar mobile number.'), findsOneWidget);
  });

  testWidgets('a wrong code shakes clear and an accepted code opens name', (
    tester,
  ) async {
    await _pump(tester);
    await _continuePhone(tester);

    await tester.enterText(find.byKey(const Key('otp-field')), '000000');
    await tester.pumpAndSettle();
    expect(find.text('That code is incorrect.'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('otp-field')), '123456');
    await tester.pumpAndSettle();
    expect(find.textContaining("What's your"), findsOneWidget);
  });

  testWidgets('registration reaches welcome and keeps the phone on back', (
    tester,
  ) async {
    await _pump(tester);
    await tester.enterText(find.byKey(const Key('phone-field')), '09254135592');
    await tester.pumpAndSettle();
    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(
      tester
          .widget<EditableText>(find.byType(EditableText).first)
          .controller
          .text,
      '09254135592',
    );

    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('otp-field')), '123456');
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('first-name')), 'Ye Min');
    await tester.enterText(find.byKey(const Key('last-name')), 'Phyo Win');
    await tester.pumpAndSettle();
    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('birth-month')), 'May');
    await tester.enterText(find.byKey(const Key('birth-day')), '1');
    await tester.enterText(find.byKey(const Key('birth-year')), '1980');
    await tester.pumpAndSettle();
    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome'), findsWidgets);
  });

  testWidgets('an unknown number offers register', (tester) async {
    await _pump(tester, fromLogIn: true);
    await _continuePhone(tester);

    expect(find.text('Register'), findsOneWidget);
    expect(find.textContaining('Verify your number'), findsNothing);
  });
}

bool _isShown(WidgetTester tester, Finder finder) {
  var shown = true;
  tester.element(finder).visitAncestorElements((ancestor) {
    final widget = ancestor.widget;
    shown =
        shown &&
        switch (widget) {
          AnimatedOpacity(:final opacity) => opacity > 0,
          Opacity(:final opacity) => opacity > 0,
          FadeTransition(:final opacity) => opacity.value > 0,
          _ => true,
        };
    return shown;
  });
  return shown;
}

Future<void> _pump(WidgetTester tester, {bool fromLogIn = false}) async {
  await configureDependencies(
    authRepository: MemoryAuthRepository(),
    pacing: const AuthPacing(delay: Duration.zero),
    ticker: const _SilentTicker(),
  );
  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();
  await tester.tap(find.text(fromLogIn ? 'Log in' : "LET'S GET STARTED"));
  await tester.pumpAndSettle();
}

Future<void> _continuePhone(WidgetTester tester) async {
  await tester.enterText(find.byKey(const Key('phone-field')), '09254135592');
  await tester.pumpAndSettle();
  await tester.tap(find.text('CONTINUE'));
  await tester.pumpAndSettle();
}

class _SilentTicker extends SecondTicker {
  const _SilentTicker();

  @override
  Stream<int> countdown(int from) => const Stream<int>.empty();
}
