import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/motion/press_scale.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

/// Google, Apple, and Facebook actions. Each opens a placeholder sheet.
class SocialSignInRow extends StatelessWidget {
  const SocialSignInRow({
    required this.onGoogle,
    required this.onApple,
    required this.onFacebook,
    super.key,
  });

  final VoidCallback onGoogle;
  final VoidCallback onApple;
  final VoidCallback onFacebook;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialButton(
          label: l10n.onboardingGoogle,
          onPressed: onGoogle,
          child: const GoogleMark(),
        ),
        const SizedBox(width: AppSpacing.lg),
        _SocialButton(
          label: l10n.onboardingApple,
          onPressed: onApple,
          child: const AppleMark(),
        ),
        const SizedBox(width: AppSpacing.lg),
        _SocialButton(
          label: l10n.onboardingFacebook,
          onPressed: onFacebook,
          child: const FacebookMark(),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.onPressed,
    required this.child,
  });

  final String label;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: PressScale(
        onPressed: onPressed,
        child: SizedBox.square(
          dimension: AppSize.buttonHeight,
          child: Center(child: child),
        ),
      ),
    );
  }
}

abstract final class _MarkSize {
  static const double diameter = 28;
  static const double glyph = 18;
}

class GoogleMark extends StatelessWidget {
  const GoogleMark({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
      dimension: _MarkSize.diameter,
      child: CustomPaint(painter: _GooglePainter()),
    );
  }
}

class AppleMark extends StatelessWidget {
  const AppleMark({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExcludeSemantics(
      child: Icon(
        Icons.apple,
        size: _MarkSize.diameter,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class FacebookMark extends StatelessWidget {
  const FacebookMark({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExcludeSemantics(
      child: SizedBox.square(
        dimension: _MarkSize.diameter,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: _FacebookBlue.color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              'f',
              style: TextStyle(
                color: AppColors.onPrimary,
                fontSize: _MarkSize.glyph,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

abstract final class _FacebookBlue {
  static const Color color = Color(0xFF1877F2);
}

abstract final class _GooglePalette {
  static const Color blue = Color(0xFF4285F4);
  static const Color green = Color(0xFF34A853);
  static const Color yellow = Color(0xFFFBBC05);
  static const Color red = Color(0xFFEA4335);
}

class _GooglePainter extends CustomPainter {
  const _GooglePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;
    _arc(canvas, center, radius, -0.5, 1.35, _GooglePalette.blue);
    _arc(canvas, center, radius, 0.85, 1.15, _GooglePalette.green);
    _arc(canvas, center, radius, 2.0, 1.15, _GooglePalette.yellow);
    _arc(canvas, center, radius, 3.15, 1.5, _GooglePalette.red);
    _bar(canvas, size);
  }

  void _arc(
    Canvas canvas,
    Offset center,
    double radius,
    double start,
    double sweep,
    Color color,
  ) {
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius * 0.72),
      start,
      sweep,
      false,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = radius * 0.38
        ..strokeCap = StrokeCap.butt,
    );
  }

  void _bar(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.48,
        size.height * 0.4,
        size.width * 0.48,
        size.height * 0.18,
      ),
      Paint()..color = _GooglePalette.blue,
    );
  }

  @override
  bool shouldRepaint(_GooglePainter oldDelegate) => false;
}
