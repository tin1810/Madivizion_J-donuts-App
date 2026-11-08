import 'package:flutter/widgets.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';

/// Scales [child] down while it is pressed, then runs [onPressed].
class PressScale extends StatefulWidget {
  const PressScale({required this.child, required this.onPressed, super.key});

  final Widget child;
  final VoidCallback onPressed;

  @override
  State<PressScale> createState() => _PressScaleState();
}

class _PressScaleState extends State<PressScale>
    with SingleTickerProviderStateMixin {
  late final AnimationController _press;
  late final CurvedAnimation _curve;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _press = AnimationController(vsync: this, duration: AppMotion.press);
    _curve = CurvedAnimation(parent: _press, curve: AppMotion.pressCurve);
    _scale = Tween<double>(begin: 1, end: 0.96).animate(_curve);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _press.duration = AppMotion.resolve(context, AppMotion.press);
  }

  @override
  void dispose() {
    _curve.dispose();
    _press.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _press.forward(),
      onTapCancel: _press.reverse,
      onTapUp: (_) {
        _press.reverse();
        widget.onPressed();
      },
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}
