import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

/// The terms and privacy sentence at the bottom of onboarding.
class OnboardingLegal extends StatelessWidget {
  const OnboardingLegal({
    required this.onTerms,
    required this.onPrivacy,
    super.key,
  });

  final VoidCallback onTerms;
  final VoidCallback onPrivacy;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final body = _body(context);
    return Text.rich(
      TextSpan(
        style: body,
        children: [
          TextSpan(text: l10n.onboardingLegalLead),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: _Link(label: l10n.onboardingTerms, onPressed: onTerms),
          ),
          TextSpan(text: l10n.onboardingLegalJoin),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: _Link(label: l10n.onboardingPrivacy, onPressed: onPrivacy),
          ),
          TextSpan(text: l10n.onboardingLegalEnd),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  TextStyle? _body(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(fontSize: AppTextSize.caption);
  }
}

class _Link extends StatelessWidget {
  const _Link({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(label, style: _style(context)),
    );
  }

  TextStyle? _style(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontSize: AppTextSize.caption,
      color: AppColors.accent,
      fontWeight: FontWeight.w700,
    );
  }
}
