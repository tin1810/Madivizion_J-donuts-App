import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madivizion_jdonuts_app/app/connectivity/link_bloc.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/core/network/link_phase.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

/// Shows a slim bar while [LinkBloc] is offline and hides it otherwise.
class OfflineBannerHost extends StatelessWidget {
  const OfflineBannerHost({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LinkBloc, LinkPhase>(
      builder: (context, phase) {
        final offline = phase == LinkPhase.offline;
        return Column(
          children: [
            _BarSlot(offline: offline),
            Expanded(child: _body(context, offline)),
          ],
        );
      },
    );
  }

  Widget _body(BuildContext context, bool offline) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: offline,
      child: child,
    );
  }
}

class _BarSlot extends StatelessWidget {
  const _BarSlot({required this.offline});

  final bool offline;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: AppMotion.resolve(context, AppMotion.fast),
      curve: AppMotion.enterCurve,
      alignment: Alignment.topCenter,
      child: offline
          ? const _OfflineBanner()
          : const SizedBox(width: double.infinity),
    );
  }
}

class _OfflineBanner extends StatelessWidget {
  const _OfflineBanner();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.textPrimary,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
          child: Text(
            AppLocalizations.of(context).offlineBanner,
            textAlign: TextAlign.center,
            style: _style(context),
          ),
        ),
      ),
    );
  }

  TextStyle? _style(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.onPrimary,
      fontSize: AppTextSize.caption,
    );
  }
}
