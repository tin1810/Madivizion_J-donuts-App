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
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
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
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

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

  Widget? _prefix(BuildContext context) {
    final text = widget.prefix;
    if (text == null) {
      return null;
    }
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.md),
      child: Text(text, style: _prefixStyle(context)),
    );
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
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          onChanged: widget.onChanged,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            filled: true,
            fillColor: AppColors.surface,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            prefixIcon: _prefix(context),
            prefixIconConstraints: widget.prefix == null
                ? null
                : const BoxConstraints(minWidth: 0, minHeight: 0),
            contentPadding: widget.prefix == null
                ? _fieldPadding
                : _prefixPadding,
            errorText: null,
            suffixIcon: widget.suffixIcon,
          ),
        ),
        _ErrorLine(message: widget.error),
      ],
    );
  }
}

TextStyle? _prefixStyle(BuildContext context) {
  return Theme.of(
    context,
  ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary);
}

const EdgeInsets _fieldPadding = EdgeInsets.symmetric(
  horizontal: AppSpacing.md,
  vertical: AppSpacing.md,
);

const EdgeInsets _prefixPadding = EdgeInsets.fromLTRB(
  0,
  AppSpacing.md,
  AppSpacing.md,
  AppSpacing.md,
);

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
