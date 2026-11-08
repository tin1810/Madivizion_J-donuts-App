import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:madivizion_jdonuts_app/app/router/app_routes.dart';
import 'package:madivizion_jdonuts_app/app/router/route_placeholder.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

/// Sends signed-out users to onboarding and signed-in users away from it.
String? authRedirect({
  required bool isSignedIn,
  required String location,
}) {
  final atOnboarding = location == AppRoutes.onboarding;
  if (!isSignedIn) {
    return atOnboarding ? null : AppRoutes.onboarding;
  }
  if (atOnboarding) {
    return AppRoutes.home;
  }
  return null;
}

/// App routes. [isSignedIn] is the session stub until secure storage exists.
GoRouter createRouter({required bool isSignedIn}) {
  return GoRouter(
    initialLocation: isSignedIn ? AppRoutes.home : AppRoutes.onboarding,
    redirect: (context, state) {
      return authRedirect(
        isSignedIn: isSignedIn,
        location: state.matchedLocation,
      );
    },
    routes: [
      _titledRoute(
        path: AppRoutes.onboarding,
        title: (context) => AppLocalizations.of(context).onboardingTitle,
      ),
      _titledRoute(
        path: AppRoutes.home,
        title: (context) => AppLocalizations.of(context).homeTitle,
      ),
      _titledRoute(
        path: AppRoutes.settings,
        title: (context) => AppLocalizations.of(context).settingsTitle,
      ),
      _productRoute(),
    ],
  );
}

GoRoute _titledRoute({
  required String path,
  required String Function(BuildContext context) title,
}) {
  return GoRoute(
    path: path,
    builder: (context, state) {
      return RoutePlaceholder(title: title(context));
    },
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
