import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

/// Year grid shown when the birth year field is tapped.
class BirthYearSheet extends StatelessWidget {
  const BirthYearSheet({
    required this.selected,
    required this.years,
    super.key,
  });

  final String selected;
  final List<int> years;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
              Text(l10n.birthYearHint, style: _title(context)),
              const SizedBox(height: AppSpacing.md),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: AppSpacing.sm,
                crossAxisSpacing: AppSpacing.sm,
                childAspectRatio: 2.2,
                children: [
                  for (final year in years)
                    _YearCell(year: year, selected: '$year' == selected),
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

class _YearCell extends StatelessWidget {
  const _YearCell({required this.year, required this.selected});

  final int year;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final label = '$year';
    return Material(
      color: selected ? AppColors.primary : AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.md)),
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.border,
        ),
      ),
      child: InkWell(
        key: Key('birth-year-$label'),
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
