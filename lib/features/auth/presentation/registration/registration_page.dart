import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/onboarding/onboarding_legal.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/onboarding/onboarding_notice.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/birth_step.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/continue_button.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/name_step.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/otp_step.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/phone_step.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/progress_ring.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_bloc.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_event.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_state.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/session_bloc.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listenWhen: (previous, next) => next.destination != previous.destination,
      listener: _openDestination,
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                children: [
                  _Header(state: state),
                  const SizedBox(height: AppSpacing.md),
                  Expanded(child: _StepBody(state: state)),
                  if (state.step != RegistrationStep.otp)
                    ContinueButton(
                      enabled: _canContinue(state),
                      loading: state.submitting,
                      onPressed: () => _submit(context, state),
                    ),
                  const SizedBox(height: AppSpacing.md),
                  OnboardingLegal(
                    onTerms: () => _notice(context, terms: true),
                    onPrivacy: () => _notice(context, terms: false),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _openDestination(
    BuildContext context,
    RegistrationState state,
  ) async {
    final destination = state.destination;
    final userId = state.userId;
    if (destination == null || userId == null) {
      return;
    }
    final session = context.read<SessionBloc>();
    session.add(SessionEstablished(userId));
    await session.stream.firstWhere((next) => next is SessionAuthenticated);
    if (context.mounted) {
      context.go(destination);
    }
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.state});

  final RegistrationState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => _back(context),
          icon: const Icon(Icons.arrow_back),
        ),
        const Spacer(),
        ProgressRing(progress: state.ringProgress, checked: state.ringChecked),
      ],
    );
  }

  void _back(BuildContext context) {
    if (state.step == RegistrationStep.phone) {
      context.pop();
      return;
    }
    context.read<RegistrationBloc>().add(const RegistrationBackPressed());
  }
}

class _StepBody extends StatelessWidget {
  const _StepBody({required this.state});

  final RegistrationState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AnimatedSwitcher(
        duration: AppMotion.resolve(context, AppMotion.page),
        switchInCurve: AppMotion.sharedAxisCurve,
        switchOutCurve: AppMotion.sharedAxisCurve,
        transitionBuilder: _slide,
        child: _step(state),
      ),
    );
  }

  Widget _step(RegistrationState state) {
    return switch (state.step) {
      RegistrationStep.phone => PhoneStep(
        key: const ValueKey(RegistrationStep.phone),
        state: state,
      ),
      RegistrationStep.otp => OtpStep(
        key: const ValueKey(RegistrationStep.otp),
        state: state,
      ),
      RegistrationStep.name => NameStep(
        key: const ValueKey(RegistrationStep.name),
        state: state,
      ),
      RegistrationStep.birth => BirthStep(
        key: const ValueKey(RegistrationStep.birth),
        state: state,
      ),
    };
  }

  Widget _slide(Widget child, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        final dx = (1 - animation.value) * AppSpacing.xl;
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(offset: Offset(dx, 0), child: child),
        );
      },
    );
  }
}

bool _canContinue(RegistrationState state) {
  return switch (state.step) {
    RegistrationStep.phone => state.phoneReady,
    RegistrationStep.otp => false,
    RegistrationStep.name => state.nameReady,
    RegistrationStep.birth => state.birthReady(DateTime.now()),
  };
}

void _submit(BuildContext context, RegistrationState state) {
  final bloc = context.read<RegistrationBloc>();
  final event = switch (state.step) {
    RegistrationStep.phone => const PhoneSubmitted(),
    RegistrationStep.otp => const OtpSubmitted(),
    RegistrationStep.name => const NameSubmitted(),
    RegistrationStep.birth => const BirthSubmitted(),
  };
  bloc.add(event);
}

void _notice(BuildContext context, {required bool terms}) {
  final l10n = AppLocalizations.of(context);
  showOnboardingNotice(
    context,
    title: terms ? l10n.onboardingTerms : l10n.onboardingPrivacy,
    message: l10n.onboardingDocumentUnavailable,
  );
}
