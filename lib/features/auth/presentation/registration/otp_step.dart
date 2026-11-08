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
        const SizedBox(height: AppSpacing.xl),
        OtpBoxes(
          code: state.otp,
          shake: state.shake,
          enabled: !state.submitting && !state.otpLocked,
          onChanged: (value) {
            context.read<RegistrationBloc>().add(OtpChanged(value));
          },
        ),
        if (state.submitting) ...[
          const SizedBox(height: AppSpacing.lg),
          const _OtpLoading(),
        ],
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
    final prompt = Text(l10n.otpResendPrompt, style: style);
    if (state.resendRemaining == Duration.zero) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          prompt,
          GestureDetector(
            onTap: state.submitting
                ? null
                : () => context.read<RegistrationBloc>().add(
                    const ResendPressed(),
                  ),
            child: Text(l10n.otpResendAction, style: _link(style)),
          ),
        ],
      );
    }
    final time = formatResend(state.resendRemaining);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        prompt,
        Text.rich(
          TextSpan(
            style: style,
            children: [
              TextSpan(text: '${l10n.otpResendIn} '),
              TextSpan(text: time, style: _link(style)),
              TextSpan(text: ' ${l10n.otpResendMin}'),
            ],
          ),
        ),
      ],
    );
  }

  TextStyle? _link(TextStyle? style) {
    return style?.copyWith(
      color: AppColors.accent,
      fontWeight: FontWeight.w700,
    );
  }
}

class _OtpLoading extends StatelessWidget {
  const _OtpLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox.square(
        key: Key('otp-loading'),
        dimension: AppSpacing.lg,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
