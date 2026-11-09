import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madivizion_jdonuts_app/app/connectivity/link_bloc.dart';
import 'package:madivizion_jdonuts_app/app/connectivity/offline_banner.dart';
import 'package:madivizion_jdonuts_app/app/di/injector.dart';
import 'package:madivizion_jdonuts_app/app/locale/app_locale.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/core/network/dns_reachability.dart';
import 'package:madivizion_jdonuts_app/core/network/plugin_link_watch.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/session_bloc.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

const _localeKey = 'app_locale';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const storage = FlutterSecureStorage();
  final saved = await _savedLocale(storage);
  await configureDependencies(
    linkWatch: PluginLinkWatch(
      connectivity: Connectivity(),
      reachability: const DnsReachability(),
    ),
    initialLocale: saved,
    saveLocale: (code) => storage.write(key: _localeKey, value: code),
  );
  Bloc.observer = injector<BlocObserver>();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languages = injector<AppLocale>();
    return ListenableBuilder(
      listenable: languages,
      builder: (context, _) {
        return BlocProvider<SessionBloc>.value(
          value: injector<SessionBloc>(),
          child: BlocProvider<LinkBloc>.value(
            value: injector<LinkBloc>(),
            child: MaterialApp.router(
              locale: languages.locale,
              routerConfig: appRouter,
              builder: (context, child) {
                return OfflineBannerHost(
                  child: child ?? const SizedBox.shrink(),
                );
              },
              debugShowCheckedModeBanner: false,
              onGenerateTitle: (context) =>
                  AppLocalizations.of(context).appTitle,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: AppTheme.light(),
            ),
          ),
        );
      },
    );
  }
}

Future<Locale> _savedLocale(FlutterSecureStorage storage) async {
  try {
    final code = await storage.read(key: _localeKey);
    return AppLocale.known(Locale(code ?? 'en'));
  } on Exception {
    return AppLocale.english;
  }
}
