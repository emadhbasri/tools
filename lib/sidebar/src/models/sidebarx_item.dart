import 'package:flutter/cupertino.dart';

class SidebarXItem {
  const SidebarXItem({
    this.divider,
    this.label,
    this.icon,
    this.iconWidget,
    this.onTap,
  });

  final String? label;
  final IconData? icon;
  final Widget? iconWidget;
  final Widget? divider;
  final Function()? onTap;
}
