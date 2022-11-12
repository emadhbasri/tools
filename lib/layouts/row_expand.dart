import 'package:flutter/material.dart';

import '../size.dart';

class ToolsRowExpand extends StatelessWidget {
  ToolsRowExpand({
    super.key,
    required this.children,
    this.space,
    this.spaceFirst,
    this.spaceLast,
    this.hasSpace = true,
    this.firstSpace = false,
    this.lastSpace = false,
    this.firstLastSpace = false,
    this.textDirection=TextDirection.ltr,
  });
  final TextDirection textDirection;
  final List<Widget> children;
  double? space, spaceFirst, spaceLast;
  final bool hasSpace, firstSpace, lastSpace, firstLastSpace;
  @override
  Widget build(BuildContext context) {
    if (hasSpace) {
      space ??= w8();
      spaceFirst ??= w8();
      spaceLast ??= w8();
      List<Widget> out = [];
      if (firstSpace) {
        out.add(SizedBox(width: spaceFirst));
      }

      for (var child in children) {
        out.add(Expanded(child: child));
        if (child != children.last) {
          out.add(SizedBox(width: space));
        }
      }
      if (firstSpace) {
        out.add(SizedBox(width: spaceLast));
      }
      return Row(
        textDirection: TextDirection.rtl,
        children: out,
      );
    } else {
      return Row(
        textDirection: TextDirection.rtl,
        children: children,
      );
    }
  }
}
