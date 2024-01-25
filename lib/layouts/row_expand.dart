import 'package:flutter/material.dart';
import 'package:tools/size_plus.dart';

class ToolsRowExpand extends StatelessWidget {
  ToolsRowExpand({
    super.key,
    required this.children,
    this.space,
    this.spaceFirst,
    this.spaceLast,
    this.flexs = const [],
    this.hasSpace = true,
    this.firstSpace = false,
    this.lastSpace = false,
    this.firstLastSpace = false,
    this.textDirection = TextDirection.ltr,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.end,
    this.verticalDirection = VerticalDirection.down,
  });
  final TextDirection textDirection;
  final List<Widget> children;
  final List<int> flexs;
  double? space, spaceFirst, spaceLast;
  final bool hasSpace, firstSpace, lastSpace, firstLastSpace;

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;
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

      for (int j = 0; j < children.length; j++) {
        var child = children[j];
        int fflex = 1;
        if (flexs.isNotEmpty) {
          fflex = flexs[j];
        }
        if (ToolsSize.maxW <= 700) {
          out.add(child);
        } else {
          out.add(Expanded(flex: fflex, child: child));
        }
        if (child != children.last) {
          if (ToolsSize.maxW <= 700) {
            out.add(SizedBox(height: space));
          } else {
            out.add(SizedBox(width: space));
          }
        }
      }

      if (firstSpace) {
        if (ToolsSize.maxW <= 700) {
          out.add(SizedBox(height: spaceLast ??= h8()));
        } else {
          out.add(SizedBox(width: spaceLast));
        }
      }

      if (ToolsSize.maxW <= 700) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            crossAxisAlignment: crossAxisAlignment,
            verticalDirection: verticalDirection,
            textDirection: TextDirection.rtl,
            children: out,
          ),
        );
      } else {
        return Row(
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          verticalDirection: verticalDirection,
          textDirection: TextDirection.rtl,
          children: out,
        );
      }
    } else {
      if (ToolsSize.maxW <= 700) {
        return Column(
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          verticalDirection: verticalDirection,
          textDirection: TextDirection.rtl,
          children: children,
        );
      } else {
        return Row(
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          verticalDirection: verticalDirection,
          textDirection: TextDirection.rtl,
          children: children,
        );
      }
    }
  }
}

class ToolsRowExpandForce extends StatelessWidget {
  ToolsRowExpandForce({
    super.key,
    required this.children,
    this.space,
    this.spaceFirst,
    this.spaceLast,
    this.flexs = const [],
    this.hasSpace = true,
    this.firstSpace = false,
    this.lastSpace = false,
    this.firstLastSpace = false,
    this.textDirection = TextDirection.ltr,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.verticalDirection = VerticalDirection.down,
  });
  final TextDirection textDirection;
  final List<Widget> children;
  final List<int> flexs;
  double? space, spaceFirst, spaceLast;
  final bool hasSpace, firstSpace, lastSpace, firstLastSpace;

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;
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

      for (int j = 0; j < children.length; j++) {
        var child = children[j];
        int fflex = 1;
        if (flexs.isNotEmpty) {
          fflex = flexs[j];
        }

        out.add(Expanded(flex: fflex, child: child));
        if (child != children.last) {
          out.add(SizedBox(width: space));
        }
      }

      if (lastSpace) {
        out.add(SizedBox(width: spaceLast));
      }

      return Row(
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        verticalDirection: verticalDirection,
        textDirection: TextDirection.rtl,
        children: out,
      );
    } else {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        verticalDirection: verticalDirection,
        textDirection: TextDirection.rtl,
        children: children,
      );
    }
  }
}
