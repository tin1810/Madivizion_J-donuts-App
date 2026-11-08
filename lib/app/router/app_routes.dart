/// Paths for the app shell.
abstract final class AppRoutes {
  static const String startup = '/';
  static const String onboarding = '/onboarding';
  static const String registerPhone = '/register/phone';
  static const String signInPhone = '/sign-in/phone';
  static const String welcome = '/welcome';
  static const String home = '/home';
  static const String rewards = '/rewards';
  static const String nearby = '/nearby';
  static const String wallet = '/wallet';
  static const String settings = '/settings';
  static const String productId = 'id';
  static const String product = '/product/:$productId';

  static String productLocation(String id) => '/product/$id';
}
