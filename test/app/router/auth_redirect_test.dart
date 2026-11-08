import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/app/router/app_router.dart';
import 'package:madivizion_jdonuts_app/app/router/app_routes.dart';

void main() {
  test('signed out user opening home is sent to onboarding', () {
    final location = authRedirect(
      isSignedIn: false,
      location: AppRoutes.home,
    );

    expect(location, AppRoutes.onboarding);
  });

  test('signed out user stays on onboarding', () {
    final location = authRedirect(
      isSignedIn: false,
      location: AppRoutes.onboarding,
    );

    expect(location, isNull);
  });

  test('signed out user cannot open a product', () {
    final location = authRedirect(
      isSignedIn: false,
      location: AppRoutes.productLocation('p_coconut'),
    );

    expect(location, AppRoutes.onboarding);
  });

  test('signed in user leaving onboarding is sent home', () {
    final location = authRedirect(
      isSignedIn: true,
      location: AppRoutes.onboarding,
    );

    expect(location, AppRoutes.home);
  });

  test('signed in user can open a product', () {
    final location = authRedirect(
      isSignedIn: true,
      location: AppRoutes.productLocation('p_coconut'),
    );

    expect(location, isNull);
  });
}
