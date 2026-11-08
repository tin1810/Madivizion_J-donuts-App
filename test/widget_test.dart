import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/app/di/injector.dart';
import 'package:madivizion_jdonuts_app/main.dart';

void main() {
  setUp(() async {
    await injector.reset();
    await configureDependencies();
  });

  tearDown(() async {
    await injector.reset();
  });

  testWidgets('logged out launch opens onboarding', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Onboarding'), findsWidgets);
  });
}
