import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/log_out.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/read_session.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/session_bloc.dart';

import '../memory_auth_repository.dart';

void main() {
  test('launch with no saved session is unauthenticated', () async {
    final repository = MemoryAuthRepository();
    final bloc = SessionBloc(
      readSession: ReadSession(repository),
      logOut: LogOut(repository),
    );

    final expectation = expectLater(
      bloc.stream,
      emits(const SessionUnauthenticated()),
    );
    bloc.add(const SessionStarted());
    await expectation;
    await bloc.close();
  });

  test('launch with a saved session opens as authenticated', () async {
    final repository = MemoryAuthRepository();
    await repository.saveSession('+959254135592');
    final bloc = SessionBloc(
      readSession: ReadSession(repository),
      logOut: LogOut(repository),
    );

    final expectation = expectLater(
      bloc.stream,
      emits(const SessionAuthenticated('+959254135592')),
    );
    bloc.add(const SessionStarted());
    await expectation;
    await bloc.close();
  });

  test('log out clears the saved session', () async {
    final repository = MemoryAuthRepository();
    await repository.saveSession('+959254135592');
    final bloc = SessionBloc(
      readSession: ReadSession(repository),
      logOut: LogOut(repository),
    );
    bloc.add(const SessionStarted());
    await bloc.stream.first;

    bloc.add(const SessionLoggedOut());
    await expectLater(
      bloc.stream,
      emits(const SessionUnauthenticated()),
    );
    await bloc.close();
  });
}
