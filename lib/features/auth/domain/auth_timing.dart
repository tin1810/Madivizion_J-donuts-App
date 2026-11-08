/// How long the fake account API waits before it returns.
abstract final class AuthTiming {
  static const Duration fakeDelay = Duration(seconds: 1);
}

/// Delay injected into the registration flow. Tests can pass [Duration.zero].
class AuthPacing {
  const AuthPacing({this.delay = AuthTiming.fakeDelay});

  final Duration delay;
}
