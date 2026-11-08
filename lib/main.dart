import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madivizion_jdonuts_app/app/di/injector.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/session_bloc.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  Bloc.observer = injector<BlocObserver>();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SessionBloc>.value(
      value: injector<SessionBloc>(),
      child: MaterialApp.router(
        routerConfig: appRouter,
        onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: AppTheme.light(),
      ),
    );
  }
}
