import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/app/di/injector.dart';
import 'package:madivizion_jdonuts_app/main.dart';

import '../memory_auth_repository.dart';

void main() {
  tearDown(() async {
    await injector.reset();
  });

  testWidgets('lets get started opens the phone step', (tester) async {
    await configureDependencies(authRepository: MemoryAuthRepository());
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text("LET'S GET STARTED"));
    await tester.pumpAndSettle();

    expect(find.text('Phone number'), findsWidgets);
  });

  testWidgets('log in opens the phone step', (tester) async {
    await configureDependencies(authRepository: MemoryAuthRepository());
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();

    expect(find.text('Phone number'), findsWidgets);
  });

  testWidgets('google and terms open placeholder sheets', (tester) async {
    await configureDependencies(authRepository: MemoryAuthRepository());
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.bySemanticsLabel('Google'));
    await tester.pumpAndSettle();
    expect(
      find.text('Google sign-in is not connected in this test.'),
      findsOneWidget,
    );

    await tester.tapAt(const Offset(20, 20));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Terms of Use'));
    await tester.pumpAndSettle();
    expect(
      find.text('This document is not included in the test build.'),
      findsOneWidget,
    );
  });

  testWidgets('reduce motion still shows the headline', (tester) async {
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
    await configureDependencies(authRepository: MemoryAuthRepository());

    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.textContaining('Round food for'), findsOneWidget);
  });
}
