import 'package:flutter/material.dart';
import 'package:tools/other/size.dart';

class ToolsColumnExpand extends StatelessWidget {
  ToolsColumnExpand({
    super.key,
    required this.children,
    this.space,
    this.spaceFirst,
    this.spaceLast,
    this.hasSpace = true,
    this.firstSpace = true,
    this.lastSpace = true,
    this.firstLastSpace = true,
  });
  final List<Widget> children;
  double? space, spaceFirst, spaceLast;
  final bool hasSpace, firstSpace, lastSpace, firstLastSpace;
  @override
  Widget build(BuildContext context) {
    if (hasSpace) {
      space ??= h8();
      spaceFirst ??= h8();
      spaceLast ??= h8();
      List<Widget> out = [];
      if (firstSpace) {
        out.add(SizedBox(height: spaceFirst));
      }

      for (var child in children) {
        out.add(Expanded(child: child));
        if (child != children.last) {
          out.add(SizedBox(height: space));
        }
      }
      if (firstSpace) {
        out.add(SizedBox(height: spaceLast));
      }
      return Column(
        children: out,
      );
    } else {
      return Column(
        children: children,
      );
    }
  }
}
