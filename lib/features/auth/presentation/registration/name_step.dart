import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/auth_field.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_bloc.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_copy.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_event.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_state.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

class NameStep extends StatefulWidget {
  const NameStep({required this.state, super.key});

  final RegistrationState state;

  @override
  State<NameStep> createState() => _NameStepState();
}

class _NameStepState extends State<NameStep> {
  late final TextEditingController _first;
  late final TextEditingController _last;

  @override
  void initState() {
    super.initState();
    _first = TextEditingController(text: widget.state.firstName);
    _last = TextEditingController(text: widget.state.lastName);
  }

  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
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
        Text(l10n.nameHeadline, style: _title(context)),
        const SizedBox(height: AppSpacing.lg),
        AuthField(
          fieldKey: const Key('first-name'),
          controller: _first,
          hint: l10n.nameFirstHint,
          enabled: enabled,
          error: nameMessage(l10n, widget.state.firstNameError),
          onChanged: (value) => bloc.add(FirstNameChanged(value)),
          onBlur: () => bloc.add(const FirstNameBlurred()),
        ),
        const SizedBox(height: AppSpacing.md),
        AuthField(
          fieldKey: const Key('last-name'),
          controller: _last,
          hint: l10n.nameLastHint,
          enabled: enabled,
          error: nameMessage(l10n, widget.state.lastNameError),
          onChanged: (value) => bloc.add(LastNameChanged(value)),
          onBlur: () => bloc.add(const LastNameBlurred()),
        ),
      ],
    );
  }

  TextStyle? _title(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium;
  }
}
