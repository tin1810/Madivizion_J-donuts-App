import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/session_bloc.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

/// Settings row used to clear the saved session.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListTile(
        title: Text(l10n.logOut),
        onTap: () => context.read<SessionBloc>().add(const SessionLoggedOut()),
      ),
    );
  }
}
