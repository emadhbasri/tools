import 'package:flutter/material.dart';

import '../size.dart';

class ToolsContainerBox extends StatelessWidget {
  const ToolsContainerBox(
      {Key? key,
      this.screenWidth,
      this.width,
      this.height,
      this.screenHeight,
      this.padHorizontal = 2,
      this.padVertical = .5,
      this.borderWidth = 1,
      this.radius = 10,
      this.borderColor = Colors.black,
      this.color = Colors.white,
      required this.child})
      : super(key: key);
  final double? screenWidth, screenHeight,width,height;
  final double padHorizontal, padVertical, borderWidth, radius;
  final Color borderColor,color;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width:width,
      height:height,
      decoration: BoxDecoration(
        color: color,
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
