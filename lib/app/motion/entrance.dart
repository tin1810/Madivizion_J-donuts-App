import 'package:flutter/widgets.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';

/// Fades and slides [child] in across one slice of [animation].
class Entrance extends StatefulWidget {
  const Entrance({
    required this.animation,
    required this.start,
    required this.end,
    required this.child,
    this.begin = const Offset(0, 0.12),
    super.key,
  });

  final Animation<double> animation;
  final double start;
  final double end;
  final Offset begin;
  final Widget child;

  @override
  State<Entrance> createState() => _EntranceState();
}

class _EntranceState extends State<Entrance> {
  late CurvedAnimation _curve;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  void didUpdateWidget(Entrance oldWidget) {
    super.didUpdateWidget(oldWidget);
    final changed =
        oldWidget.animation != widget.animation ||
        oldWidget.start != widget.start ||
        oldWidget.end != widget.end ||
        oldWidget.begin != widget.begin;
    if (changed) {
      _release();
      _bind();
    }
  }

  @override
  void dispose() {
    _release();
    super.dispose();
  }

  void _bind() {
    _curve = CurvedAnimation(
      parent: widget.animation,
      curve: Interval(widget.start, widget.end, curve: AppMotion.enterCurve),
    );
    _slide = Tween<Offset>(
      begin: widget.begin,
      end: Offset.zero,
    ).animate(_curve);
  }

  void _release() {
    _curve.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _curve,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}
