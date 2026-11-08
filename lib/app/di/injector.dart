import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:madivizion_jdonuts_app/app/di/app_bloc_observer.dart';
import 'package:madivizion_jdonuts_app/app/router/app_router.dart';
import 'package:madivizion_jdonuts_app/app/router/session_listenable.dart';
import 'package:madivizion_jdonuts_app/features/auth/data/database_opener.dart';
import 'package:madivizion_jdonuts_app/features/auth/data/drift_auth_repository.dart';
import 'package:madivizion_jdonuts_app/features/auth/data/secure_session_store.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_repository.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/log_out.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/read_session.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/register_account.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/sign_in.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/session_bloc.dart';

/// Composition root. Widgets resolve dependencies from here.
final GetIt injector = GetIt.instance;

/// Router created by [configureDependencies].
GoRouter get appRouter => injector<GoRouter>();

/// Registers app-wide services. Tests can pass [authRepository].
Future<void> configureDependencies({AuthRepository? authRepository}) async {
  injector.registerLazySingleton<BlocObserver>(AppBlocObserver.new);
  final repository = authRepository ?? await _openAuthRepository();
  _registerAuth(repository);
  _registerSession();
}

Future<AuthRepository> _openAuthRepository() async {
  final database = await openAppDatabase();
  return DriftAuthRepository(
    database: database,
    sessionStore: const SecureSessionStore(FlutterSecureStorage()),
  );
}

void _registerAuth(AuthRepository repository) {
  injector
    ..registerSingleton<AuthRepository>(repository)
    ..registerSingleton<RegisterAccount>(RegisterAccount(repository))
    ..registerSingleton<SignIn>(SignIn(repository))
    ..registerSingleton<ReadSession>(ReadSession(repository))
    ..registerSingleton<LogOut>(LogOut(repository));
}

void _registerSession() {
  final bloc = SessionBloc(
    readSession: injector<ReadSession>(),
    logOut: injector<LogOut>(),
  );
  injector.registerSingleton<SessionBloc>(
    bloc,
    dispose: (value) => value.close(),
  );
  final session = SessionListenable(bloc);
  injector.registerSingleton<SessionListenable>(
    session,
    dispose: (value) => value.dispose(),
  );
  injector.registerSingleton<GoRouter>(
    createRouter(session: session),
    dispose: (router) => router.dispose(),
  );
  bloc.add(const SessionStarted());
}
