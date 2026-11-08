import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';
import 'package:madivizion_jdonuts_app/app/motion/entrance.dart';
import 'package:madivizion_jdonuts_app/app/motion/press_scale.dart';
import 'package:madivizion_jdonuts_app/app/router/app_routes.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/onboarding/donut_cluster.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/onboarding/onboarding_legal.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/onboarding/onboarding_notice.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/onboarding/social_marks.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

/// First screen. Donuts drift in, then the title and actions follow.
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  static const int _staggerSteps = 5;

  late final AnimationController _entrance;
  var _started = false;

  @override
  void initState() {
    super.initState();
    _entrance = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _entrance.duration = AppMotion.resolve(
      context,
      AppMotion.entrance + (AppMotion.stagger * _staggerSteps),
    );
    if (_started) {
      return;
    }
    _started = true;
    _entrance.forward();
  }

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(flex: 5, child: DonutCluster(animation: _entrance)),
          Expanded(flex: 6, child: _OnboardingBody(animation: _entrance)),
        ],
      ),
    );
  }
}

class _OnboardingBody extends StatelessWidget {
  const _OnboardingBody({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Column(
          children: [
            Entrance(
              animation: animation,
              start: 0.38,
              end: 0.7,
              child: Text(
                l10n.onboardingHeadline,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Entrance(
              animation: animation,
              start: 0.48,
              end: 0.78,
              child: _GetStartedButton(
                label: l10n.onboardingGetStarted,
                onPressed: () => context.push(AppRoutes.registerPhone),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Entrance(
              animation: animation,
              start: 0.56,
              end: 0.84,
              child: _AccountLine(
                prompt: l10n.onboardingAccountPrompt,
                action: l10n.onboardingLogIn,
                onLogIn: () => context.push(AppRoutes.signInPhone),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Entrance(
              animation: animation,
              start: 0.64,
              end: 0.9,
              child: SocialSignInRow(
                onGoogle: () => _social(context, l10n.onboardingGoogle),
                onApple: () => _social(context, l10n.onboardingApple),
                onFacebook: () => _social(context, l10n.onboardingFacebook),
              ),
            ),
            const Spacer(),
            Entrance(
              animation: animation,
              start: 0.72,
              end: 1,
              child: OnboardingLegal(
                onTerms: () => _document(context, l10n.onboardingTerms),
                onPrivacy: () => _document(context, l10n.onboardingPrivacy),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }

  void _social(BuildContext context, String provider) {
    final l10n = AppLocalizations.of(context);
    showOnboardingNotice(
      context,
      title: provider,
      message: l10n.onboardingSocialUnavailable(provider),
    );
  }

  void _document(BuildContext context, String title) {
    showOnboardingNotice(
      context,
      title: title,
      message: AppLocalizations.of(context).onboardingDocumentUnavailable,
    );
  }
}

class _GetStartedButton extends StatelessWidget {
  const _GetStartedButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return PressScale(
      onPressed: onPressed,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.pill)),
        ),
        child: SizedBox(
          height: AppSize.buttonHeight,
          width: double.infinity,
          child: Center(child: Text(label, style: _label(context))),
        ),
      ),
    );
  }

  TextStyle? _label(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.labelLarge?.copyWith(letterSpacing: AppTextTracking.button);
  }
}

class _AccountLine extends StatelessWidget {
  const _AccountLine({
    required this.prompt,
    required this.action,
    required this.onLogIn,
  });

  final String prompt;
  final String action;
  final VoidCallback onLogIn;

  @override
  Widget build(BuildContext context) {
    final promptStyle = Theme.of(context).textTheme.bodyMedium;
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(prompt, style: promptStyle),
        GestureDetector(
          onTap: onLogIn,
          child: Text(action, style: _action(promptStyle)),
        ),
      ],
    );
  }

  TextStyle? _action(TextStyle? prompt) {
    return prompt?.copyWith(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
      decorationColor: AppColors.textPrimary,
    );
  }
}
