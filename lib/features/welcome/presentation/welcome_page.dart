import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';
import 'package:madivizion_jdonuts_app/app/motion/entrance.dart';
import 'package:madivizion_jdonuts_app/app/motion/press_scale.dart';
import 'package:madivizion_jdonuts_app/app/router/app_routes.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/features/welcome/presentation/welcome_tiles.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

/// Donut tiles slide in, then the title fades up. Let's explore opens Home.
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  static const int _staggerSteps = 4;

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
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: Column(
            children: [
              Expanded(child: WelcomeTiles(animation: _entrance)),
              const SizedBox(height: AppSpacing.lg),
              Entrance(
                animation: _entrance,
                start: 0.62,
                end: 0.88,
                child: Text(
                  l10n.welcomeHeadline,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Entrance(
                animation: _entrance,
                start: 0.78,
                end: 1,
                child: _ExploreButton(
                  label: l10n.welcomeExplore,
                  onPressed: () => context.go(AppRoutes.home),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExploreButton extends StatelessWidget {
  const _ExploreButton({required this.label, required this.onPressed});

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
