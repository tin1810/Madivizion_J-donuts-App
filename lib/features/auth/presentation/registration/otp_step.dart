import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/otp_boxes.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_bloc.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_copy.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_event.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_state.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

class OtpStep extends StatelessWidget {
  const OtpStep({required this.state, super.key});

  final RegistrationState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final message = otpMessage(l10n, state);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.otpHeadline, style: _title(context)),
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.otpSent(state.displayPhone),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.lg),
        OtpBoxes(
          code: state.otp,
          shake: state.shake,
          enabled: !state.submitting && !state.otpLocked,
          onChanged: (value) {
            context.read<RegistrationBloc>().add(OtpChanged(value));
          },
        ),
        if (message != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(message, style: _error(context)),
        ],
        const SizedBox(height: AppSpacing.md),
        _ResendLine(state: state),
      ],
    );
  }

  TextStyle? _title(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium;
  }

  TextStyle? _error(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.error,
      fontSize: AppTextSize.caption,
    );
  }
}

class _ResendLine extends StatelessWidget {
  const _ResendLine({required this.state});

  final RegistrationState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final style = Theme.of(context).textTheme.bodyMedium;
    if (state.resendRemaining == Duration.zero) {
      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(l10n.otpResendReady, style: style),
          GestureDetector(
            onTap: () =>
                context.read<RegistrationBloc>().add(const ResendPressed()),
            child: Text(l10n.otpResendAction, style: _link(style)),
          ),
        ],
      );
    }
    return Text(
      l10n.otpResendWaiting(formatResend(state.resendRemaining)),
      style: style,
    );
  }

  TextStyle? _link(TextStyle? style) {
    return style?.copyWith(
      color: AppColors.accent,
      fontWeight: FontWeight.w700,
    );
  }
}
