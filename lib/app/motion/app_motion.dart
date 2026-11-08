import 'package:flutter/widgets.dart';

/// Durations and curves for the J'Donuts flow.
///
/// Screens read these constants and pass them through [AppMotion.resolve]
/// so Reduce Motion can skip the animation.
abstract final class AppMotion {
  static const Duration press = Duration(milliseconds: 120);
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration page = Duration(milliseconds: 350);
  static const Duration entrance = Duration(milliseconds: 500);
  static const Duration stagger = Duration(milliseconds: 80);
  static const Duration ring = Duration(milliseconds: 900);
  static const Duration countUp = Duration(milliseconds: 1400);
  static const Duration bannerHold = Duration(milliseconds: 4000);

  static const Curve pressCurve = Curves.easeOutCubic;
  static const Curve enterCurve = Curves.easeOutCubic;
  static const Curve exitCurve = Curves.easeInCubic;
  static const Curve sharedAxisCurve = Curves.easeInOutCubic;
  static const Curve badgeCurve = Curves.easeOutBack;

  static Duration resolve(BuildContext context, Duration duration) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return Duration.zero;
    }
    return duration;
  }
}
