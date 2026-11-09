import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/app/di/injector.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_timing.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/user_account.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/second_ticker.dart';
import 'package:madivizion_jdonuts_app/main.dart';

import '../memory_auth_repository.dart';

void main() {
  tearDown(() async {
    await injector.reset();
  });

  testWidgets('an unknown number stays on sign in and offers register', (
    tester,
  ) async {
    await _pump(tester);

    await _submitPhone(tester);
    await tester.pumpAndSettle();

    expect(find.text('This number is not registered. '), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
    expect(find.text('Verify your number'), findsNothing);
  });

  testWidgets('a wrong code stays on sign in', (tester) async {
    await _pump(tester, member: _hnin);

    await _submitPhone(tester);
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('otp-field')), '000000');
    await tester.pumpAndSettle();

    expect(find.text('That code is incorrect.'), findsOneWidget);
    expect(find.text('Hnin Ei'), findsNothing);
  });

  testWidgets('the third wrong code locks sign in', (tester) async {
    await _pump(tester, member: _hnin);
    await _submitPhone(tester);
    await tester.pumpAndSettle();

    for (var attempt = 0; attempt < 3; attempt++) {
      await tester.enterText(find.byKey(const Key('otp-field')), '000000');
      await tester.pumpAndSettle();
    }

    expect(
      find.text('Too many attempts. Resend the code to try again.'),
      findsOneWidget,
    );
    expect(
      tester.widget<TextField>(find.byKey(const Key('otp-field'))).enabled,
      isFalse,
    );
    expect(find.text('Hnin Ei'), findsNothing);
  });

  testWidgets('the right code opens home', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await _pump(tester, member: _hnin);

    await _submitPhone(tester);
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('otp-field')), '123456');
    await tester.pumpAndSettle();

    expect(find.text('Hnin Ei'), findsOneWidget);
    expect(find.text('Silver member'), findsOneWidget);
  });
}

final _hnin = UserAccount(
  phoneE164: '+959254135592',
  firstName: 'Hnin',
  lastName: 'Ei',
  birthDate: DateTime(1992, 5, 1),
);

Future<void> _pump(WidgetTester tester, {UserAccount? member}) async {
  final auth = MemoryAuthRepository();
  await configureDependencies(
    authRepository: auth,
    pacing: const AuthPacing(delay: Duration.zero),
    ticker: const _SilentTicker(),
  );
  final account = member;
  if (account != null) {
    auth.store(account);
  }
  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();
  await tester.tap(find.text('Log in'));
  await tester.pumpAndSettle();
}

Future<void> _submitPhone(WidgetTester tester) async {
  await tester.enterText(find.byKey(const Key('phone-field')), '09254135592');
  await tester.pumpAndSettle();
  await tester.tap(find.text('CONTINUE'));
}

class _SilentTicker extends SecondTicker {
  const _SilentTicker();

  @override
  Stream<int> countdown(int from) => const Stream<int>.empty();
}
