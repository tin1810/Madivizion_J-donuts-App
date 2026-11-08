import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/session_bloc.dart';

/// Tells go_router to redirect when [SessionBloc] emits a new state.
class SessionListenable extends ChangeNotifier {
  SessionListenable(this._bloc) {
    _subscription = _bloc.stream.listen((_) => notifyListeners());
  }

  final SessionBloc _bloc;
  late final StreamSubscription<SessionState> _subscription;

  /// Null while the session is still being read.
  bool? get isSignedIn {
    return switch (_bloc.state) {
      SessionUnknown() => null,
      SessionAuthenticated() => true,
      SessionUnauthenticated() => false,
    };
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
