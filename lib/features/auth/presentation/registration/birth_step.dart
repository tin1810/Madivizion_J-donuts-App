import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/birth_date_validator.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/auth_field.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/birth_month_sheet.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/birth_year_sheet.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_bloc.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_copy.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_event.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_state.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

class BirthStep extends StatefulWidget {
  const BirthStep({required this.state, super.key});

  final RegistrationState state;

  @override
  State<BirthStep> createState() => _BirthStepState();
}

class _BirthStepState extends State<BirthStep> {
  late final TextEditingController _month;
  late final TextEditingController _day;
  late final TextEditingController _year;

  @override
  void initState() {
    super.initState();
    _month = TextEditingController(text: widget.state.month);
    _day = TextEditingController(text: widget.state.day);
    _year = TextEditingController(text: widget.state.year);
  }

  @override
  void dispose() {
    _month.dispose();
    _day.dispose();
    _year.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bloc = context.read<RegistrationBloc>();
    final enabled = !widget.state.submitting;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.birthHeadline, style: _title(context)),
        const SizedBox(height: AppSpacing.xl),
        AuthField(
          fieldKey: const Key('birth-month'),
          controller: _month,
          hint: l10n.birthMonthHint,
          enabled: enabled,
          readOnly: true,
          onChanged: (_) {},
          onTap: enabled ? () => _pickMonth(bloc) : null,
        ),
        const SizedBox(height: AppSpacing.md),
        AuthField(
          fieldKey: const Key('birth-day'),
          controller: _day,
          hint: l10n.birthDayHint,
          enabled: enabled,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(BirthRules.dayDigits),
          ],
          onChanged: (value) => bloc.add(BirthDayChanged(value)),
          onBlur: () => bloc.add(const BirthBlurred()),
        ),
        const SizedBox(height: AppSpacing.md),
        AuthField(
          fieldKey: const Key('birth-year'),
          controller: _year,
          hint: l10n.birthYearHint,
          enabled: enabled,
          readOnly: true,
          error: birthMessage(l10n, widget.state),
          onChanged: (_) {},
          onTap: enabled ? () => _pickYear(bloc) : null,
        ),
      ],
    );
  }

  TextStyle? _title(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium;
  }

  Future<void> _pickMonth(RegistrationBloc bloc) async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      builder: (context) => BirthMonthSheet(selected: _month.text),
    );
    if (!mounted) {
      return;
    }
    bloc.add(const BirthBlurred());
    if (picked == null) {
      return;
    }
    _month.text = picked;
    bloc.add(BirthMonthChanged(picked));
  }

  Future<void> _pickYear(RegistrationBloc bloc) async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      builder: (context) => BirthYearSheet(
        selected: _year.text,
        years: birthYears(DateTime.now().year),
      ),
    );
    if (!mounted) {
      return;
    }
    bloc.add(const BirthBlurred());
    if (picked == null) {
      return;
    }
    _year.text = picked;
    bloc.add(BirthYearChanged(picked));
  }
}
