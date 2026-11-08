import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

/// Reward tab. The points ring and challenges arrive in a later step.
class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).rewardsTitle)),
      body: const SizedBox.shrink(),
    );
  }
}
