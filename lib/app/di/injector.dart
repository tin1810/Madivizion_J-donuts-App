import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:madivizion_jdonuts_app/app/di/app_bloc_observer.dart';

/// Composition root. Widgets resolve dependencies from here.
final GetIt injector = GetIt.instance;

/// Registers app-wide services. Feature repositories are added with the
/// feature that owns them.
Future<void> configureDependencies() async {
  injector.registerLazySingleton<BlocObserver>(AppBlocObserver.new);
}
