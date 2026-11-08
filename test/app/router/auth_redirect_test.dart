import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/app/router/app_router.dart';
import 'package:madivizion_jdonuts_app/app/router/app_routes.dart';

void main() {
  test('signed out user opening home is sent to onboarding', () {
    final location = authRedirect(isSignedIn: false, location: AppRoutes.home);

    expect(location, AppRoutes.onboarding);
  });

  test('signed out user stays on the phone step', () {
    final register = authRedirect(
      isSignedIn: false,
      location: AppRoutes.registerPhone,
    );
    final signIn = authRedirect(
      isSignedIn: false,
      location: AppRoutes.signInPhone,
    );

    expect(register, isNull);
    expect(signIn, isNull);
  });

  test('a signed in user can stay on welcome', () {
    final location = authRedirect(
      isSignedIn: true,
      location: AppRoutes.welcome,
    );

    expect(location, isNull);
  });

  test('signed in user leaving the phone step is sent home', () {
    final location = authRedirect(
      isSignedIn: true,
      location: AppRoutes.registerPhone,
    );

    expect(location, AppRoutes.home);
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

  test('an unknown session stays on the startup route', () {
    final location = authRedirect(
      isSignedIn: null,
      location: AppRoutes.startup,
    );

    expect(location, isNull);
  });

  test('an unknown session opening home waits on startup', () {
    final location = authRedirect(isSignedIn: null, location: AppRoutes.home);

    expect(location, AppRoutes.startup);
  });

  test('a signed in user leaving startup is sent home', () {
    final location = authRedirect(
      isSignedIn: true,
      location: AppRoutes.startup,
    );

    expect(location, AppRoutes.home);
  });
}
