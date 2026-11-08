import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

/// The twelve months, in calendar order, using the same English names
/// the birth-date parser already accepts.
List<String> birthMonthNames(AppLocalizations l10n) {
  return [
    l10n.monthJanuary,
    l10n.monthFebruary,
    l10n.monthMarch,
    l10n.monthApril,
    l10n.monthMay,
    l10n.monthJune,
    l10n.monthJuly,
    l10n.monthAugust,
    l10n.monthSeptember,
    l10n.monthOctober,
    l10n.monthNovember,
    l10n.monthDecember,
  ];
}

/// Month grid shown when the birth month field is tapped.
class BirthMonthSheet extends StatelessWidget {
  const BirthMonthSheet({required this.selected, super.key});

  final String selected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final months = birthMonthNames(l10n);
    final maxHeight = MediaQuery.sizeOf(context).height * 0.75;
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.birthMonthHint, style: _title(context)),
              const SizedBox(height: AppSpacing.md),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: AppSpacing.sm,
                crossAxisSpacing: AppSpacing.sm,
                childAspectRatio: 2.2,
                children: [
                  for (final month in months)
                    _MonthCell(label: month, selected: month == selected),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle? _title(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700);
  }
}

class _MonthCell extends StatelessWidget {
  const _MonthCell({required this.label, required this.selected});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.primary : AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.md)),
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.border,
        ),
      ),
      child: InkWell(
        key: Key('birth-month-$label'),
        onTap: () => Navigator.of(context).pop(label),
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.md)),
        child: Center(child: Text(label, style: _label(context))),
      ),
    );
  }

  TextStyle? _label(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: selected ? AppColors.onPrimary : AppColors.textPrimary,
      fontWeight: FontWeight.w700,
    );
  }
}
