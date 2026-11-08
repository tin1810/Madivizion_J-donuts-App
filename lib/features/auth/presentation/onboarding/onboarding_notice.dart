import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';

/// Bottom sheet for an onboarding action that has no real integration.
Future<void> showOnboardingNotice(
  BuildContext context, {
  required String title,
  required String message,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.surface,
    showDragHandle: true,
    builder: (context) => _Notice(title: title, message: message),
  );
}

class _Notice extends StatelessWidget {
  const _Notice({required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xs,
        AppSpacing.lg,
        AppSpacing.xl + bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _title(context)),
          const SizedBox(height: AppSpacing.sm),
          Text(message, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  TextStyle? _title(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700);
  }
}
