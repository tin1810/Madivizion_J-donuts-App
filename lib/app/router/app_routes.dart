/// Paths for the app shell. Session storage replaces [signedInStub].
abstract final class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String settings = '/settings';
  static const String productId = 'id';
  static const String product = '/product/:$productId';

  static String productLocation(String id) => '/product/$id';
}

/// Logged-out until the session is read from secure storage.
const bool signedInStub = false;
