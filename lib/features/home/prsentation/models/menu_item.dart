import 'package:flutter/material.dart';

class MenuItem {
  final IconData icon;
  final String label;
  final Future<Object?> onTap;
  final Color? iconColor;

  MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
  });
}
