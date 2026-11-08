import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:madivizion_jdonuts_app/app/di/app_bloc_observer.dart';
import 'package:madivizion_jdonuts_app/app/router/app_router.dart';
import 'package:madivizion_jdonuts_app/app/router/app_routes.dart';

/// Composition root. Widgets resolve dependencies from here.
final GetIt injector = GetIt.instance;

/// Router created by [configureDependencies].
GoRouter get appRouter => injector<GoRouter>();

/// Registers app-wide services. Feature repositories are added with the
/// feature that owns them.
Future<void> configureDependencies() async {
  injector
    ..registerLazySingleton<BlocObserver>(AppBlocObserver.new)
    ..registerLazySingleton<GoRouter>(
      () => createRouter(isSignedIn: signedInStub),
      dispose: (router) => router.dispose(),
    );
}
