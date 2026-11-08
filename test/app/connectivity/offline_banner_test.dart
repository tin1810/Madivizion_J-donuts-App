import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/app/di/injector.dart';
import 'package:madivizion_jdonuts_app/core/network/link_phase.dart';
import 'package:madivizion_jdonuts_app/core/network/link_watch.dart';
import 'package:madivizion_jdonuts_app/main.dart';

import '../../features/auth/memory_auth_repository.dart';

void main() {
  tearDown(() async {
    await injector.reset();
  });

  testWidgets('the offline banner appears when the network cannot be reached', (
    tester,
  ) async {
    final phases = StreamController<LinkPhase>();
    addTearDown(phases.close);
    await configureDependencies(
      authRepository: MemoryAuthRepository(),
      linkWatch: _StreamLink(phases.stream),
    );

    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text("You're offline"), findsNothing);
    phases.add(LinkPhase.offline);
    await tester.pumpAndSettle();

    expect(find.text("You're offline"), findsOneWidget);
  });
}

class _StreamLink extends LinkWatch {
  _StreamLink(this._phases);

  final Stream<LinkPhase> _phases;

  @override
  Stream<LinkPhase> watch() => _phases;
}
