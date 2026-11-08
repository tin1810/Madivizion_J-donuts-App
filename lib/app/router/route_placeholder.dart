import 'package:flutter/material.dart';

/// Temporary screen for a route whose real UI is not built yet.
class RoutePlaceholder extends StatelessWidget {
  const RoutePlaceholder({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title)),
    );
  }
}
