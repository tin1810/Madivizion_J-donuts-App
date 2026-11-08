import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/phone_validator.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/auth_field.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_bloc.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_copy.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_event.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_state.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

class PhoneStep extends StatefulWidget {
  const PhoneStep({required this.state, super.key});

  final RegistrationState state;

  @override
  State<PhoneStep> createState() => _PhoneStepState();
}

class _PhoneStepState extends State<PhoneStep> {
  late final TextEditingController _phone;

  @override
  void initState() {
    super.initState();
    _phone = TextEditingController(text: widget.state.phoneRaw);
  }

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bloc = context.read<RegistrationBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.phoneHeadline, style: _title(context)),
        const SizedBox(height: AppSpacing.xl),
        AuthField(
          fieldKey: const Key('phone-field'),
          controller: _phone,
          prefix: '${PhoneRules.countryCode}  ',
          keyboardType: TextInputType.phone,
          inputFormatters: const [PhoneDigitFormatter()],
          enabled: !widget.state.submitting,
          error: phoneMessage(l10n, widget.state),
          onChanged: (value) => bloc.add(PhoneChanged(value)),
          onBlur: () => bloc.add(const PhoneBlurred()),
        ),
        _AccountLink(state: widget.state),
      ],
    );
  }

  TextStyle? _title(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium;
  }
}

/// Stops the field at [PhoneRules.maxDigits] digits. Shorter input stays.
class PhoneDigitFormatter extends TextInputFormatter {
  const PhoneDigitFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final limited = limitPhoneDigits(newValue.text);
    if (limited == newValue.text) {
      return newValue;
    }
    return TextEditingValue(
      text: limited,
      selection: TextSelection.collapsed(offset: limited.length),
    );
  }
}

class _AccountLink extends StatelessWidget {
  const _AccountLink({required this.state});

  final RegistrationState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (state.unknownAccount) {
      return _LinkLine(
        lead: l10n.phoneUnknown,
        action: l10n.phoneRegisterLink,
        onTap: () =>
            context.read<RegistrationBloc>().add(const SwitchToRegister()),
      );
    }
    if (state.alreadyRegistered) {
      return _LinkLine(
        lead: l10n.phoneAlready,
        action: l10n.phoneLogInLink,
        onTap: () =>
            context.read<RegistrationBloc>().add(const SwitchToSignIn()),
      );
    }
    return const SizedBox.shrink();
  }
}

class _LinkLine extends StatelessWidget {
  const _LinkLine({
    required this.lead,
    required this.action,
    required this.onTap,
  });

  final String lead;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final body = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.error,
      fontSize: AppTextSize.caption,
    );
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(lead, style: body),
          GestureDetector(
            onTap: onTap,
            child: Text(action, style: _action(body)),
          ),
        ],
      ),
    );
  }

  TextStyle? _action(TextStyle? body) {
    return body?.copyWith(
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
      decorationColor: AppColors.error,
    );
  }
}
