import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

/// Five destinations. The pink pill slides to the selected one.
class AppNavBar extends StatelessWidget {
  const AppNavBar({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = _items(l10n);
    return ColoredBox(
      color: AppColors.accent,
      child: SafeArea(
        top: false,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xs,
            vertical: AppSpacing.xs,
          ),
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppRadius.pill),
            ),
          ),
          child: SizedBox(
            height: 56,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  children: [
                    for (final item in items)
                      Expanded(
                        child: Icon(
                          item.icon,
                          color: AppColors.onPrimary,
                          size: 22,
                        ),
                      ),
                  ],
                ),
                AnimatedAlign(
                  duration: AppMotion.resolve(context, AppMotion.page),
                  curve: AppMotion.sharedAxisCurve,
                  alignment: Alignment(_align(selected), 0),
                  child: _Pill(item: items[selected]),
                ),
                Row(
                  children: [
                    for (var index = 0; index < items.length; index++)
                      Expanded(
                        child: _Hit(
                          index: index,
                          item: items[index],
                          onSelected: onSelected,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<_NavItem> _items(AppLocalizations l10n) {
    return [
      _NavItem(Icons.home_rounded, l10n.navHome, 'nav-home'),
      _NavItem(Icons.workspace_premium_rounded, l10n.navReward, 'nav-reward'),
      _NavItem(Icons.adjust, null, 'nav-nearby'),
      _NavItem(Icons.account_balance_wallet_outlined, null, 'nav-wallet'),
      _NavItem(Icons.settings_outlined, null, 'nav-settings'),
    ];
  }

  double _align(int index) {
    return (index / 4) * 2 - 1;
  }
}

class _NavItem {
  const _NavItem(this.icon, this.label, this.keyName);

  final IconData icon;
  final String? label;
  final String keyName;
}

class _Hit extends StatelessWidget {
  const _Hit({
    required this.index,
    required this.item,
    required this.onSelected,
  });

  final int index;
  final _NavItem item;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: item.label,
      child: GestureDetector(
        key: Key(item.keyName),
        behavior: HitTestBehavior.opaque,
        onTap: () => onSelected(index),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.item});

  final _NavItem item;

  @override
  Widget build(BuildContext context) {
    final label = item.label;
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.pill)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item.icon, color: AppColors.onPrimary, size: 22),
            if (label != null) ...[
              const SizedBox(width: AppSpacing.xxs),
              Text(label, style: _label(context)),
            ],
          ],
        ),
      ),
    );
  }

  TextStyle? _label(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.onPrimary,
      fontWeight: FontWeight.w700,
    );
  }
}
