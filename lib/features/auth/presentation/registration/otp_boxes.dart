import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/otp_validator.dart';

/// Six OTP cells. One field handles paste, backspace, and SMS autofill.
class OtpBoxes extends StatefulWidget {
  const OtpBoxes({
    required this.code,
    required this.shake,
    required this.enabled,
    required this.onChanged,
    super.key,
  });

  final String code;
  final int shake;
  final bool enabled;
  final ValueChanged<String> onChanged;

  @override
  State<OtpBoxes> createState() => _OtpBoxesState();
}

class _OtpBoxesState extends State<OtpBoxes> {
  late final TextEditingController _controller;
  var _syncing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.code);
  }

  @override
  void didUpdateWidget(OtpBoxes oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.code == _controller.text) {
      return;
    }
    _syncing = true;
    _controller.value = TextEditingValue(
      text: widget.code,
      selection: TextSelection.collapsed(offset: widget.code.length),
    );
    _syncing = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _Shake(
      count: widget.shake,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var index = 0; index < OtpRules.length; index++)
                _Cell(
                  digit: _digit(index),
                  focused: widget.enabled && index == widget.code.length,
                ),
            ],
          ),
          TextField(
            key: const Key('otp-field'),
            controller: _controller,
            enabled: widget.enabled,
            keyboardType: TextInputType.number,
            autofillHints: const [AutofillHints.oneTimeCode],
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(OtpRules.length),
            ],
            showCursor: false,
            enableSuggestions: false,
            autocorrect: false,
            style: const TextStyle(color: AppColors.transparent),
            decoration: const InputDecoration(
              filled: true,
              fillColor: AppColors.transparent,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              counterText: '',
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: _changed,
          ),
        ],
      ),
    );
  }

  void _changed(String value) {
    if (_syncing) {
      return;
    }
    widget.onChanged(value);
  }

  String _digit(int index) {
    if (index >= widget.code.length) {
      return '';
    }
    return widget.code[index];
  }
}

class _Cell extends StatelessWidget {
  const _Cell({required this.digit, required this.focused});

  final String digit;
  final bool focused;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppMotion.resolve(context, AppMotion.fast),
      width: 48,
      height: AppSize.inputHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.md)),
        border: Border.all(
          color: focused ? AppColors.primary : AppColors.border,
          width: focused ? AppSize.focusedBorderWidth : AppSize.borderWidth,
        ),
      ),
      child: Text(digit, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}

class _Shake extends StatefulWidget {
  const _Shake({required this.count, required this.child});

  final int count;
  final Widget child;

  @override
  State<_Shake> createState() => _ShakeState();
}

class _ShakeState extends State<_Shake> with SingleTickerProviderStateMixin {
  late final AnimationController _motion;
  late final CurvedAnimation _curve;
  late final Animation<double> _offset;

  @override
  void initState() {
    super.initState();
    _motion = AnimationController(vsync: this, duration: AppMotion.fast);
    _curve = CurvedAnimation(parent: _motion, curve: AppMotion.pressCurve);
    _offset = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -8), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8, end: 8), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8, end: -6), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -6, end: 0), weight: 1),
    ]).animate(_curve);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _motion.duration = AppMotion.resolve(context, AppMotion.fast);
  }

  @override
  void didUpdateWidget(_Shake oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.count != oldWidget.count && widget.count > 0) {
      _motion.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _curve.dispose();
    _motion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _offset,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_offset.value, 0),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
