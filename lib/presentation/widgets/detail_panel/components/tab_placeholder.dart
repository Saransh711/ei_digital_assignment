import 'package:flutter/material.dart';

/// Placeholder widget for tabs that are not yet implemented
class TabPlaceholder extends StatelessWidget {
  final String title;

  const TabPlaceholder({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("$title Content"));
  }
}

