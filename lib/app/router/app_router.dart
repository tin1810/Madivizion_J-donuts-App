import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madivizion_jdonuts_app/app/router/app_routes.dart';
import 'package:madivizion_jdonuts_app/app/router/route_placeholder.dart';
import 'package:madivizion_jdonuts_app/app/router/session_listenable.dart';
import 'package:madivizion_jdonuts_app/app/shell/app_shell.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/onboarding/onboarding_page.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_flow.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_state.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/settings_page.dart';
import 'package:madivizion_jdonuts_app/features/home/presentation/home_page.dart';
import 'package:madivizion_jdonuts_app/features/rewards/presentation/rewards_page.dart';
import 'package:madivizion_jdonuts_app/features/welcome/presentation/welcome_page.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

/// Sends signed-out users to onboarding and signed-in users away from it.
///
/// [isSignedIn] is null while the saved session is still being read.
String? authRedirect({required bool? isSignedIn, required String location}) {
  if (isSignedIn == null) {
    return location == AppRoutes.startup ? null : AppRoutes.startup;
  }
  if (!isSignedIn) {
    return _isAuthStart(location) ? null : AppRoutes.onboarding;
  }
  final leavingAuth = _isAuthStart(location) || location == AppRoutes.startup;
  if (leavingAuth) {
    return AppRoutes.home;
  }
  return null;
}

bool _isAuthStart(String location) {
  return location == AppRoutes.onboarding ||
      location == AppRoutes.registerPhone ||
      location == AppRoutes.signInPhone;
}

/// App routes. [session] refreshes redirects after login and log out.
GoRouter createRouter({required SessionListenable session}) {
  return GoRouter(
    initialLocation: AppRoutes.startup,
    refreshListenable: session,
    redirect: (context, state) {
      return authRedirect(
        isSignedIn: session.isSignedIn,
        location: state.matchedLocation,
      );
    },
    routes: [
      GoRoute(
        path: AppRoutes.startup,
        builder: (context, state) => const Scaffold(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.registerPhone,
        builder: (context, state) {
          return const RegistrationFlow(purpose: RegistrationPurpose.register);
        },
      ),
      GoRoute(
        path: AppRoutes.signInPhone,
        builder: (context, state) {
          return const RegistrationFlow(purpose: RegistrationPurpose.signIn);
        },
      ),
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomePage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.rewards,
                builder: (context, state) => const RewardsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.nearby,
                builder: (context, state) {
                  return RoutePlaceholder(
                    title: AppLocalizations.of(context).navNearby,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.wallet,
                builder: (context, state) {
                  return RoutePlaceholder(
                    title: AppLocalizations.of(context).navWallet,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
      _productRoute(),
    ],
  );
}

GoRoute _productRoute() {
  return GoRoute(
    path: AppRoutes.product,
    builder: (context, state) {
      final id = state.pathParameters[AppRoutes.productId] ?? '';
      return RoutePlaceholder(
        title: AppLocalizations.of(context).productTitle(id),
      );
    },
  );
}
