import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/app/di/injector.dart';
import 'package:madivizion_jdonuts_app/app/router/app_routes.dart';
import 'package:madivizion_jdonuts_app/main.dart';

import '../../auth/memory_auth_repository.dart';

void main() {
  tearDown(() async {
    await injector.reset();
  });

  testWidgets('lets explore opens home', (tester) async {
    final auth = MemoryAuthRepository();
    await auth.saveSession('+959254135592');
    await configureDependencies(authRepository: auth);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    appRouter.go(AppRoutes.welcome);
    await tester.pumpAndSettle();

    expect(find.textContaining("world of J'donuts"), findsOneWidget);
    expect(find.byType(Image), findsWidgets);
    await tester.tap(find.text("LET'S EXPLORE"));
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsWidgets);
  });
}
