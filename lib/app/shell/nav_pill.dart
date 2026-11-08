part of 'app_nav_bar.dart';

const _shrinkShare = 0.28;

double get _collapsedWidth => AppSpacing.sm * 2 + _iconSize + AppSpacing.sm;

double get _minSlot => _iconSize + AppSpacing.md;

double _lerp(double begin, double end, double t) {
  return begin + (end - begin) * t;
}

class _NavMotion extends StatefulWidget {
  const _NavMotion({
    required this.items,
    required this.selected,
    required this.onSelected,
    required this.widths,
    required this.barWidth,
    required this.style,
  });

  final List<_NavItem> items;
  final int selected;
  final ValueChanged<int> onSelected;
  final List<double> widths;
  final double barWidth;
  final TextStyle style;

  @override
  State<_NavMotion> createState() => _NavMotionState();
}

class _NavMotionState extends State<_NavMotion>
    with SingleTickerProviderStateMixin {
  late final AnimationController _motion;
  late double _originIndex;
  late double _originWidth;
  late int _to;

  @override
  void initState() {
    super.initState();
    _to = widget.selected;
    _originIndex = _to.toDouble();
    _originWidth = widget.widths[_to];
    _motion = AnimationController(
      vsync: this,
      duration: AppMotion.fast,
      value: 1,
    )..addListener(_tick);
  }

  void _tick() => setState(() {});

  @override
  void didUpdateWidget(_NavMotion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected == _to) return;
    final now = _motion.value;
    _originIndex = _index(now);
    _originWidth = _width(now);
    _to = widget.selected;
    _motion.duration = AppMotion.resolve(context, AppMotion.fast);
    _motion.forward(from: 0);
  }

  @override
  void dispose() {
    _motion.removeListener(_tick);
    _motion.dispose();
    super.dispose();
  }

  double _index(double t) {
    final eased = Curves.easeOutCubic.transform(t);
    return _lerp(_originIndex, _to.toDouble(), eased);
  }

  double _width(double t) {
    final room = widget.barWidth - _minSlot * (widget.items.length - 1);
    final target = _fit(widget.widths[_to], room);
    if (t <= _shrinkShare) {
      final u = Curves.easeInCubic.transform(t / _shrinkShare);
      return _fit(_lerp(_originWidth, _collapsedWidth, u), room);
    }
    final u = ((t - _shrinkShare) / (1 - _shrinkShare)).clamp(0.0, 1.0);
    final grown = _lerp(
      _collapsedWidth,
      target,
      Curves.easeOutBack.transform(u),
    );
    return _fit(grown, room);
  }

  double _fit(double value, double room) {
    if (value < _minSlot) return _minSlot;
    if (value > room) return room;
    return value;
  }

  double _weight(int index, double cursor) {
    final distance = (index - cursor).abs();
    if (distance >= 1) return 0;
    return 1 - distance;
  }

  List<double> _slots(double cursor, double pill) {
    final count = widget.items.length;
    final shared = (widget.barWidth - pill) / (count - 1);
    final slots = <double>[];
    var used = 0.0;
    for (var index = 0; index < count - 1; index++) {
      final slot = shared + _weight(index, cursor) * (pill - shared);
      slots.add(slot);
      used += slot;
    }
    slots.add(widget.barWidth - used);
    return slots;
  }

  double _sum(List<double> slots, int start, int end) {
    var total = 0.0;
    for (var index = start; index < end; index++) {
      total += slots[index];
    }
    return total;
  }

  bool _showsLabel(int index, double cursor) {
    final weight = _weight(index, cursor);
    if (weight <= 0) return false;
    final other = index == cursor.floor() ? cursor.ceil() : cursor.floor();
    if (other == index) return true;
    final neighbor = _weight(other, cursor);
    if (weight > neighbor) return true;
    if (weight < neighbor) return false;
    return index == _to;
  }

  @override
  Widget build(BuildContext context) {
    final cursor = _index(_motion.value);
    final slots = _slots(cursor, _width(_motion.value));
    final lower = cursor.floor();
    final upper = cursor.ceil();
    final left = _sum(slots, 0, lower);
    final span = _sum(slots, lower, upper + 1);
    return SizedBox(
      height: _barHeight,
      child: Stack(
        children: [
          Positioned(
            left: left,
            width: span,
            top: (_barHeight - _pillHeight) / 2,
            height: _pillHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.navPink,
                borderRadius: const BorderRadius.all(Radius.circular(AppRadius.pill)),
               border:  Border.all(color: AppColors.border, width: 1)
              ),
            ),
          ),
          Row(
            children: [
              for (var index = 0; index < widget.items.length; index++)
                _NavSlot(
                  item: widget.items[index],
                  width: slots[index],
                  showLabel: _showsLabel(index, cursor),
                  style: widget.style,
                  onTap: () => widget.onSelected(index),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavSlot extends StatelessWidget {
  const _NavSlot({
    required this.item,
    required this.width,
    required this.showLabel,
    required this.style,
    required this.onTap,
  });

  final _NavItem item;
  final double width;
  final bool showLabel;
  final TextStyle style;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final budget = width - AppSpacing.sm * 2 - _iconSize - AppSpacing.xxs;
    final labelFits = showLabel && budget >= AppSpacing.xs;
    return Semantics(
      button: true,
      label: item.label,
      child: GestureDetector(
        key: Key(item.keyName),
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          width: width,
          height: _barHeight,
          child: ClipRect(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _NavIcon(item.icon),
                if (labelFits) ...[
                  const SizedBox(width: AppSpacing.xxs),
                  SizedBox(
                    width: budget,
                    child: Text(
                      item.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: style,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
