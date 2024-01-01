import 'package:flutter/material.dart';
import 'package:tools/size_plus.dart';


class ToolsContainerBox extends StatelessWidget {
  const ToolsContainerBox(
      {Key? key,
      this.width,
      this.height,
      this.padHorizontal = 2,
      this.padVertical = .5,
      this.borderWidth = 1,
      this.radius = 10,
      this.borderColor = Colors.black,
      this.color = Colors.white,
      required this.child})
      : super(key: key);
  final double? width,height;
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
        horizontal: padHorizontal.w,
        vertical: padVertical.w,
      ),
      child: child,
    );
  }
}
