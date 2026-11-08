import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madivizion_jdonuts_app/app/shell/app_nav_bar.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';

/// Bottom navigation around Home, Reward, and the three placeholders.
class AppShell extends StatelessWidget {
  const AppShell({required this.shell, super.key});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      body: shell,
      bottomNavigationBar: AppNavBar(
        selected: shell.currentIndex,
        onSelected: (index) {
          shell.goBranch(index, initialLocation: index == shell.currentIndex);
        },
      ),
    );
  }
}
