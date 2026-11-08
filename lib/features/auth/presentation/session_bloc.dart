import 'package:bloc/bloc.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/log_out.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/read_session.dart';

sealed class SessionEvent {
  const SessionEvent();
}

/// Reads the saved session when the app launches.
final class SessionStarted extends SessionEvent {
  const SessionStarted();
}

/// Clears the saved session.
final class SessionLoggedOut extends SessionEvent {
  const SessionLoggedOut();
}

sealed class SessionState {
  const SessionState();
}

/// The saved session has not been read yet.
final class SessionUnknown extends SessionState {
  const SessionUnknown();
}

/// [userId] is the phone number stored for this launch.
final class SessionAuthenticated extends SessionState {
  const SessionAuthenticated(this.userId);

  final String userId;

  @override
  bool operator ==(Object other) {
    return other is SessionAuthenticated && other.userId == userId;
  }

  @override
  int get hashCode => userId.hashCode;
}

/// No session is stored.
final class SessionUnauthenticated extends SessionState {
  const SessionUnauthenticated();
}

/// Turns session reads and log out into events the router can follow.
class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc({required ReadSession readSession, required LogOut logOut})
    : _readSession = readSession,
      _logOut = logOut,
      super(const SessionUnknown()) {
    on<SessionStarted>(_onStarted);
    on<SessionLoggedOut>(_onLoggedOut);
  }

  final ReadSession _readSession;
  final LogOut _logOut;

  Future<void> _onStarted(
    SessionStarted event,
    Emitter<SessionState> emit,
  ) async {
    final result = await _readSession();
    switch (result) {
      case Success(value: final userId?):
        emit(SessionAuthenticated(userId));
      case Success():
        emit(const SessionUnauthenticated());
      case Failure(:final failure):
        addError(failure);
        emit(const SessionUnauthenticated());
    }
  }

  Future<void> _onLoggedOut(
    SessionLoggedOut event,
    Emitter<SessionState> emit,
  ) async {
    final result = await _logOut();
    switch (result) {
      case Success():
        emit(const SessionUnauthenticated());
      case Failure(:final failure):
        addError(failure);
    }
  }
}
