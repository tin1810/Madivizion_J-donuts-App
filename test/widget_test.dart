import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/app/di/injector.dart';
import 'package:madivizion_jdonuts_app/app/router/app_routes.dart';
import 'package:madivizion_jdonuts_app/main.dart';

import 'features/auth/memory_auth_repository.dart';

void main() {
  tearDown(() async {
    await injector.reset();
  });

  testWidgets('logged out launch opens onboarding', (tester) async {
    await configureDependencies(authRepository: MemoryAuthRepository());

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('Round food for'), findsOneWidget);
  });

  testWidgets('a saved session opens home and log out returns to onboarding', (
    tester,
  ) async {
    final auth = MemoryAuthRepository();
    await auth.saveSession('+959254135592');
    await configureDependencies(authRepository: auth);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsWidgets);

    appRouter.go(AppRoutes.settings);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Log out'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Round food for'), findsOneWidget);
  });
}
