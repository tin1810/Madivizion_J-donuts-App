import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';

/// Text field used by the registration steps, with an animated error line.
class AuthField extends StatefulWidget {
  const AuthField({
    required this.fieldKey,
    required this.controller,
    required this.onChanged,
    this.hint,
    this.prefix,
    this.error,
    this.enabled = true,
    this.keyboardType,
    this.inputFormatters,
    this.onBlur,
    super.key,
  });

  final Key fieldKey;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String? hint;
  final String? prefix;
  final String? error;
  final bool enabled;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onBlur;

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  late final FocusNode _focus;
  var _sawFocus = false;

  @override
  void initState() {
    super.initState();
    _focus = FocusNode()..addListener(_handleFocus);
  }

  @override
  void dispose() {
    _focus
      ..removeListener(_handleFocus)
      ..dispose();
    super.dispose();
  }

  void _handleFocus() {
    if (_focus.hasFocus) {
      _sawFocus = true;
      return;
    }
    if (_sawFocus) {
      widget.onBlur?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          key: widget.fieldKey,
          controller: widget.controller,
          focusNode: _focus,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          onChanged: widget.onChanged,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixText: widget.prefix,
            prefixStyle: Theme.of(context).textTheme.bodyLarge,
            errorText: null,
          ),
        ),
        _ErrorLine(message: widget.error),
      ],
    );
  }
}

class _ErrorLine extends StatelessWidget {
  const _ErrorLine({required this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final text = message;
    return AnimatedSize(
      duration: AppMotion.resolve(context, AppMotion.fast),
      curve: AppMotion.enterCurve,
      alignment: Alignment.topLeft,
      child: text == null
          ? const SizedBox(width: double.infinity)
          : Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xs),
              child: Text(text, style: _style(context)),
            ),
    );
  }

  TextStyle? _style(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.error,
      fontSize: AppTextSize.caption,
    );
  }
}
