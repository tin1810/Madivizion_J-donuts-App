import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';
import 'package:madivizion_jdonuts_app/app/motion/press_scale.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

/// Continue action. A second tap is ignored while [loading] is true.
class ContinueButton extends StatelessWidget {
  const ContinueButton({
    required this.enabled,
    required this.loading,
    required this.onPressed,
    super.key,
  });

  final bool enabled;
  final bool loading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final active = enabled && !loading;
    final button = _Face(loading: loading, enabled: enabled);
    if (!active) {
      return button;
    }
    return PressScale(onPressed: onPressed, child: button);
  }
}

class _Face extends StatelessWidget {
  const _Face({required this.loading, required this.enabled});

  final bool loading;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppMotion.resolve(context, AppMotion.fast),
      curve: AppMotion.enterCurve,
      height: AppSize.buttonHeight,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: enabled ? AppColors.primary : AppColors.primaryDisabled,
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.pill)),
      ),
      child: AnimatedSwitcher(
        duration: AppMotion.resolve(context, AppMotion.fast),
        child: loading ? const _Spinner() : _Label(text: _label(context)),
      ),
    );
  }

  String _label(BuildContext context) {
    return AppLocalizations.of(context).continueAction;
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      key: const ValueKey('continue-label'),
      style: Theme.of(
        context,
      ).textTheme.labelLarge?.copyWith(letterSpacing: AppTextTracking.button),
    );
  }
}

class _Spinner extends StatelessWidget {
  const _Spinner();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
      key: ValueKey('continue-spinner'),
      dimension: AppSpacing.lg,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: AppColors.onPrimary,
      ),
    );
  }
}
