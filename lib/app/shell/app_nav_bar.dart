import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/motion/app_motion.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

part 'nav_pill.dart';

/// Five destinations. The icons stay in one row while the pink pill moves.
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
    final pink = MediaQuery.paddingOf(context).bottom + AppSpacing.xl;
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: pink,
          child: const ColoredBox(color: AppColors.navPink),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.nav,
              border: const Border(
                top: BorderSide(color: AppColors.border, width: 1),
                right: BorderSide(color: AppColors.border, width: 1),
                left: BorderSide(color: AppColors.border, width: 1),
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                height: _barHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  child: _NavStack(
                    items: items,
                    selected: selected,
                    onSelected: onSelected,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<_NavItem> _items(AppLocalizations l10n) {
    return [
      _NavItem(l10n.navHome, 'nav-home', asset: 'assets/nav/home.png'),
      _NavItem(l10n.navReward, 'nav-reward', asset: 'assets/nav/reward.png'),
      _NavItem(l10n.navNearby, 'nav-nearby', icon: Icons.adjust),
      _NavItem(l10n.navWallet, 'nav-wallet', asset: 'assets/nav/wallet.png'),
      _NavItem(
        l10n.settingsTitle,
        'nav-settings',
        asset: 'assets/nav/settings.png',
      ),
    ];
  }
}

const _barHeight = 64.0;
const _iconSize = 22.0;
const _pillHeight = 44.0;

class _NavItem {
  const _NavItem(this.label, this.keyName, {this.icon, this.asset});

  final IconData? icon;
  final String? asset;
  final String label;
  final String keyName;
}

class _NavStack extends StatelessWidget {
  const _NavStack({
    required this.items,
    required this.selected,
    required this.onSelected,
  });

  final List<_NavItem> items;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final style = _labelStyle(context);
    final scaler = MediaQuery.textScalerOf(context);
    final widths = [
      for (final item in items) _pillWidth(item.label, style, scaler),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        return _NavMotion(
          items: items,
          selected: selected,
          onSelected: onSelected,
          widths: widths,
          barWidth: constraints.maxWidth,
          style: style,
        );
      },
    );
  }
}

TextStyle _labelStyle(BuildContext context) {
  final theme = Theme.of(context).textTheme.bodyMedium;
  return (theme ?? const TextStyle()).copyWith(
    color: AppColors.onPrimary,
    fontWeight: FontWeight.w700,
  );
}

double _pillWidth(String label, TextStyle style, TextScaler scaler) {
  final painter = TextPainter(
    text: TextSpan(text: label, style: style),
    textDirection: TextDirection.ltr,
    textScaler: scaler,
    maxLines: 1,
  )..layout();
  return AppSpacing.sm * 2 + _iconSize + AppSpacing.xxs + painter.width;
}

Widget _assetIcon(String asset) {
  return ColorFiltered(
    colorFilter: const ColorFilter.mode(AppColors.onPrimary, BlendMode.srcIn),
    child: Image.asset(
      asset,
      width: _iconSize,
      height: _iconSize,
      fit: BoxFit.contain,
    ),
  );
}

class _NavIcon extends StatelessWidget {
  const _NavIcon(this.item);

  final _NavItem item;

  @override
  Widget build(BuildContext context) {
    final asset = item.asset;
    final icon = item.icon;
    if (asset != null) return _assetIcon(asset);
    if (icon == null) return const SizedBox.square(dimension: _iconSize);
    return Icon(icon, color: AppColors.onPrimary, size: _iconSize);
  }
}
