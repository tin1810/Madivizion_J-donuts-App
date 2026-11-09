import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:madivizion_jdonuts_app/app/connectivity/bloc_link_read.dart';
import 'package:madivizion_jdonuts_app/app/connectivity/link_bloc.dart';
import 'package:madivizion_jdonuts_app/app/di/app_bloc_observer.dart';
import 'package:madivizion_jdonuts_app/app/router/app_router.dart';
import 'package:madivizion_jdonuts_app/app/router/session_listenable.dart';
import 'package:madivizion_jdonuts_app/core/network/link_phase.dart';
import 'package:madivizion_jdonuts_app/core/network/link_read.dart';
import 'package:madivizion_jdonuts_app/core/network/link_watch.dart';
import 'package:madivizion_jdonuts_app/features/auth/data/app_database.dart';
import 'package:madivizion_jdonuts_app/features/auth/data/database_opener.dart';
import 'package:madivizion_jdonuts_app/features/auth/data/drift_auth_repository.dart';
import 'package:madivizion_jdonuts_app/features/auth/data/secure_session_store.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_repository.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_timing.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/log_out.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/read_session.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/register_account.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/sign_in.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/second_ticker.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/session_bloc.dart';
import 'package:madivizion_jdonuts_app/features/catalog/data/catalog_seeder.dart';
import 'package:madivizion_jdonuts_app/features/catalog/data/disk_image_cache.dart';
import 'package:madivizion_jdonuts_app/features/catalog/data/http_image_fetcher.dart';
import 'package:madivizion_jdonuts_app/features/catalog/data/memory_image_cache.dart';
import 'package:madivizion_jdonuts_app/features/catalog/domain/image_cache.dart';
import 'package:madivizion_jdonuts_app/features/home/data/bundled_catalog_source.dart';
import 'package:madivizion_jdonuts_app/features/home/data/drift_catalog_repository.dart';
import 'package:madivizion_jdonuts_app/features/home/data/memory_catalog_repository.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/catalog_repository.dart';
import 'package:madivizion_jdonuts_app/features/rewards/data/drift_rewards_repository.dart';
import 'package:madivizion_jdonuts_app/features/rewards/data/memory_rewards_repository.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/load_rewards.dart';
import 'package:madivizion_jdonuts_app/features/rewards/domain/rewards_repository.dart';

/// Composition root. Widgets resolve dependencies from here.
final GetIt injector = GetIt.instance;

/// Router created by [configureDependencies].
GoRouter get appRouter => injector<GoRouter>();

/// Registers app-wide services. Tests can pass [authRepository].
Future<void> configureDependencies({
  AuthRepository? authRepository,
  AuthPacing? pacing,
  SecondTicker? ticker,
  LinkWatch? linkWatch,
  CatalogRepository? catalog,
}) async {
  injector.registerLazySingleton<BlocObserver>(AppBlocObserver.new);
  final repository = authRepository ?? await _openAuthRepository();
  _registerAuth(repository, pacing: pacing, ticker: ticker);
  _registerSession();
  _registerLink(linkWatch ?? const FixedLinkWatch(LinkPhase.online));
  _registerCatalog(catalog, production: authRepository == null);
  _registerRewards(production: authRepository == null);
  if (authRepository == null) {
    await _registerProductionImages();
    return;
  }
  _registerImages(
    LoadRemoteImage(
      cache: MemoryImageCache(),
      fetcher: const UnavailableImageFetcher(),
    ),
  );
}

void _registerCatalog(CatalogRepository? catalog, {required bool production}) {
  if (catalog != null) {
    injector.registerSingleton<CatalogRepository>(catalog);
    return;
  }
  if (!production) {
    injector.registerSingleton<CatalogRepository>(MemoryCatalogRepository());
    return;
  }
  injector.registerSingleton<CatalogRepository>(
    DriftCatalogRepository(
      database: injector<AppDatabase>(),
      source: const BundledCatalogSource(),
    ),
  );
}

void _registerRewards({required bool production}) {
  final RewardsRepository repository = production
      ? DriftRewardsRepository(injector<AppDatabase>())
      : MemoryRewardsRepository();
  injector
    ..registerSingleton<RewardsRepository>(repository)
    ..registerSingleton<LoadRewards>(LoadRewards(repository));
}

void _registerLink(LinkWatch watch) {
  final bloc = LinkBloc(watch);
  injector.registerSingleton<LinkBloc>(bloc, dispose: (value) => value.close());
  injector.registerSingleton<LinkRead>(BlocLinkRead(bloc));
  bloc.add(const LinkStarted());
}

void _registerImages(LoadRemoteImage loader) {
  injector.registerSingleton<LoadRemoteImage>(loader);
}

Future<void> _registerProductionImages() async {
  _registerImages(
    LoadRemoteImage(
      cache: await openDiskImageCache(),
      fetcher: const HttpImageFetcher(),
    ),
  );
}

Future<AuthRepository> _openAuthRepository() async {
  final database = await openAppDatabase();
  injector.registerSingleton<AppDatabase>(
    database,
    dispose: (value) => value.close(),
  );
  final raw = await rootBundle.loadString('assets/seed/catalog.json');
  await seedCatalog(database, raw);
  return DriftAuthRepository(
    database: database,
    sessionStore: const SecureSessionStore(FlutterSecureStorage()),
  );
}

void _registerAuth(
  AuthRepository repository, {
  AuthPacing? pacing,
  SecondTicker? ticker,
}) {
  injector
    ..registerSingleton<AuthRepository>(repository)
    ..registerSingleton<AuthPacing>(pacing ?? const AuthPacing())
    ..registerSingleton<SecondTicker>(ticker ?? const SecondTicker())
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
