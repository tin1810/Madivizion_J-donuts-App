import 'package:flutter/material.dart';

/// Colours, type, and spacing taken from the J'Donuts screen designs.
abstract final class AppTheme {
  static ThemeData light() {
    final scheme = _colorScheme();
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: _textTheme(scheme),
      appBarTheme: _appBarTheme(scheme),
      filledButtonTheme: _filledButtonTheme(),
      textButtonTheme: _textButtonTheme(scheme),
      inputDecorationTheme: _inputDecorationTheme(),
      progressIndicatorTheme: _progressTheme(),
    );
  }
}

abstract final class AppColors {
  static const Color background = Color(0xFFFFF0F4);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF20D0E8);
  static const Color primaryDisabled = Color(0xFFB6EEF6);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color accent = Color(0xFFF868A0);
  static const Color badge = Color(0xFFF88838);
  static const Color textPrimary = Color(0xFF202020);
  static const Color textSecondary = Color(0xFF7A7378);
  static const Color border = Color(0xFFF0DDE4);
  static const Color error = Color(0xFFE5484D);
  static const Color transparent = Color(0x00000000);
}

abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

abstract final class AppRadius {
  static const double md = 16;
  static const double pill = 28;
}

abstract final class AppSize {
  static const double buttonHeight = 52;
  static const double inputHeight = 56;
  static const double borderWidth = 1;
  static const double focusedBorderWidth = 1.5;
  static const double elevationNone = 0;
}

abstract final class AppTextSize {
  static const double headline = 32;
  static const double title = 28;
  static const double body = 16;
  static const double label = 14;
  static const double button = 15;
}

abstract final class AppTextHeight {
  static const double tight = 1.15;
  static const double body = 1.4;
}

abstract final class AppTextTracking {
  static const double button = 0.4;
}

ColorScheme _colorScheme() {
  return const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    secondary: AppColors.accent,
    onSecondary: AppColors.onPrimary,
    error: AppColors.error,
    onError: AppColors.onPrimary,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    outline: AppColors.border,
    surfaceTint: AppColors.transparent,
  );
}

TextTheme _textTheme(ColorScheme scheme) {
  final base = Typography.material2021().black;
  return base.copyWith(
    headlineMedium: _style(
      base.headlineMedium,
      size: AppTextSize.headline,
      weight: FontWeight.w700,
      height: AppTextHeight.tight,
      color: scheme.onSurface,
    ),
    titleLarge: _style(
      base.titleLarge,
      size: AppTextSize.title,
      weight: FontWeight.w700,
      height: AppTextHeight.tight,
      color: scheme.onSurface,
    ),
    bodyLarge: _style(
      base.bodyLarge,
      size: AppTextSize.body,
      weight: FontWeight.w400,
      height: AppTextHeight.body,
      color: scheme.onSurface,
    ),
    bodyMedium: _style(
      base.bodyMedium,
      size: AppTextSize.label,
      weight: FontWeight.w400,
      height: AppTextHeight.body,
      color: AppColors.textSecondary,
    ),
    labelLarge: _style(
      base.labelLarge,
      size: AppTextSize.button,
      weight: FontWeight.w700,
      height: AppTextHeight.tight,
      color: scheme.onPrimary,
    ),
  );
}

TextStyle? _style(
  TextStyle? base, {
  required double size,
  required FontWeight weight,
  required double height,
  required Color color,
}) {
  return base?.copyWith(
    fontSize: size,
    fontWeight: weight,
    height: height,
    color: color,
  );
}

AppBarTheme _appBarTheme(ColorScheme scheme) {
  return AppBarTheme(
    backgroundColor: AppColors.background,
    foregroundColor: scheme.onSurface,
    elevation: AppSize.elevationNone,
    scrolledUnderElevation: AppSize.elevationNone,
    surfaceTintColor: AppColors.transparent,
  );
}

FilledButtonThemeData _filledButtonTheme() {
  return FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size.fromHeight(AppSize.buttonHeight),
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
      disabledBackgroundColor: AppColors.primaryDisabled,
      disabledForegroundColor: AppColors.onPrimary,
      textStyle: const TextStyle(
        fontSize: AppTextSize.button,
        fontWeight: FontWeight.w700,
        letterSpacing: AppTextTracking.button,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.pill)),
      ),
    ),
  );
}

TextButtonThemeData _textButtonTheme(ColorScheme scheme) {
  return TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: scheme.onSurface,
      textStyle: const TextStyle(
        fontSize: AppTextSize.label,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

InputDecorationTheme _inputDecorationTheme() {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppRadius.md),
    borderSide: const BorderSide(
      color: AppColors.border,
      width: AppSize.borderWidth,
    ),
  );
  return InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface,
    constraints: const BoxConstraints(minHeight: AppSize.inputHeight),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.md,
    ),
    border: border,
    enabledBorder: border,
    focusedBorder: border.copyWith(
      borderSide: const BorderSide(
        color: AppColors.primary,
        width: AppSize.focusedBorderWidth,
      ),
    ),
    errorBorder: border.copyWith(
      borderSide: const BorderSide(
        color: AppColors.error,
        width: AppSize.borderWidth,
      ),
    ),
  );
}

ProgressIndicatorThemeData _progressTheme() {
  return const ProgressIndicatorThemeData(
    color: AppColors.accent,
    linearTrackColor: AppColors.border,
  );
}
