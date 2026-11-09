import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';

CustomTransitionPage<void> popupPage({
  required LocalKey pageKey,
  required Widget child,
  required Duration duration,
}) {
  return CustomTransitionPage<void>(
    key: pageKey,
    opaque: false,
    barrierDismissible: true,
    barrierColor: AppColors.textPrimary.withValues(alpha: 0.4),
    fullscreenDialog: true,
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    transitionsBuilder: (context, animation, _, sheet) {
      return SlideTransition(position: _rise(animation), child: sheet);
    },
    child: _PopupSheet(child: child),
  );
}

Animation<Offset> _rise(Animation<double> animation) {
  return animation.drive(
    Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).chain(CurveTween(curve: AppMotion.enterCurve)),
  );
}

class _PopupSheet extends StatelessWidget {
  const _PopupSheet({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top + AppSpacing.lg;
    return Padding(
      padding: EdgeInsets.only(top: top),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.lg),
        ),
        child: child,
      ),
    );
  }
}
