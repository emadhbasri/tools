import 'package:flutter/material.dart';

import '../size.dart';

class ToolsContainerBox extends StatelessWidget {
  const ToolsContainerBox(
      {Key? key,
      this.screenWidth,
      this.screenHeight,
      this.padHorizontal = 2,
      this.padVertical = .5,
      this.borderWidth = 1,
      this.radius = 10,
      this.borderColor = Colors.black,
      required this.child})
      : super(key: key);
  final double? screenWidth, screenHeight;
  final double padHorizontal, padVertical, borderWidth, radius;
  final Color borderColor;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: borderWidth, color: borderColor),
        borderRadius: BorderRadius.circular(radius),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth != null
            ? doubleWidth(padHorizontal, screenWidth!)
            : doubleWidth(padHorizontal),
        vertical: screenWidth != null
            ? doubleHeight(padVertical, screenWidth!)
            : doubleHeight(padVertical),
      ),
      child: child,
    );
  }
}
