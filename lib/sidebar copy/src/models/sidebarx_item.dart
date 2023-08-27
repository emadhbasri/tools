import 'package:flutter/cupertino.dart';

class SidebarXItem {
  const SidebarXItem({
    this.label,
    this.icon,
    this.iconWidget,
    this.onTap,
  }) : assert(
          (icon != null || iconWidget != null) &&
              (icon == null || iconWidget == null),
          'You can create SidebarXItem with IconData? icon or with Widget? iconWidget',
        );

  final String? label;
  final IconData? icon;
  final Widget? iconWidget;
  final Function()? onTap;
}

class SidebarXItemList {
  const SidebarXItemList({
    required this.children,
    this.label,
    this.icon,
    this.onTap,
  });
  final List<SidebarXItem> children;
  final String? label;
  final IconData? icon;
  final Function()? onTap;
}