import 'package:flutter/material.dart';
import 'package:tools/size_plus.dart';

class ToolsButtonText extends StatelessWidget {
  const ToolsButtonText(
      {Key? key,
      required this.child,
      required this.onTap,
      this.onDoubleTap,
      this.onLongPress,
      this.borderRadius,
      this.splashColor, this.backgroundColor})
      : super(key: key);
  final Widget child;
  final GestureTapCallback onTap;
  final GestureTapCallback? onDoubleTap;
  final GestureLongPressCallback? onLongPress;
  final BorderRadius? borderRadius;
  final Color? splashColor,backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: splashColor,
      borderRadius: borderRadius,
      onLongPress: onLongPress,
      onDoubleTap: onDoubleTap,
      onTap: (){},
      child: Ink(
        width: 10.w,
        height: 10.h,
        // padding: EdgeInsets.symmetric(
        //   horizontal: 10,
        //   vertical: 10
        // ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        child: child,
      ),
    );
  }
}
