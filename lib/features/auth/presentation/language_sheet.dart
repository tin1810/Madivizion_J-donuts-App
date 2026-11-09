import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/locale/app_locale.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

Future<void> showLanguageSheet(BuildContext context, AppLocale languages) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.canvas,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
    ),
    builder: (context) => _LanguageSheet(languages: languages),
  );
}

class _LanguageSheet extends StatelessWidget {
  const _LanguageSheet({required this.languages});

  final AppLocale languages;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Title(label: l10n.settingsLanguage),
            const SizedBox(height: AppSpacing.md),
            _Option(
              label: l10n.settingsLanguageEnglish,
              selected: !languages.isMyanmar,
              onTap: () => _choose(context, AppLocale.english),
            ),
            _Option(
              label: l10n.settingsLanguageMyanmar,
              selected: languages.isMyanmar,
              onTap: () => _choose(context, AppLocale.myanmar),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _choose(BuildContext context, Locale locale) async {
    await languages.use(locale);
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final row = InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(AppRadius.md)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Expanded(child: Text(label, style: _label(context))),
            _Mark(selected: selected),
          ],
        ),
      ),
    );
    if (!selected) {
      return row;
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.md)),
        border: Border.all(color: AppColors.border),
      ),
      child: row,
    );
  }

  TextStyle? _label(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600);
  }
}

class _Mark extends StatelessWidget {
  const _Mark({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? AppColors.primary : AppColors.ringTrack,
          width: 2,
        ),
      ),
      child: selected
          ? const DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: SizedBox.square(dimension: 10),
            )
          : null,
    );
  }
}
