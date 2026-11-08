import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/app/di/injector.dart';
import 'package:madivizion_jdonuts_app/main.dart';

import '../../features/auth/memory_auth_repository.dart';

void main() {
  tearDown(() async {
    await injector.reset();
  });

  testWidgets('the reward tab opens rewards and home stays the member row', (
    tester,
  ) async {
    final auth = MemoryAuthRepository();
    await auth.saveSession('+959254135592');
    await configureDependencies(authRepository: auth);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Hania'), findsOneWidget);

    await tester.tap(find.byKey(const Key('nav-reward')));
    await tester.pumpAndSettle();
    expect(find.text("J' Donuts Rewards"), findsOneWidget);

    await tester.tap(find.byKey(const Key('nav-home')));
    await tester.pumpAndSettle();
    expect(find.text('Hania'), findsOneWidget);

    await tester.tap(find.byKey(const Key('nav-settings')));
    await tester.pumpAndSettle();
    expect(find.text('Log out'), findsOneWidget);
  });
}
