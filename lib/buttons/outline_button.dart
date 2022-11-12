import 'package:flutter/material.dart';

class ToolsButtonOutLine extends StatelessWidget {
  const ToolsButtonOutLine(
      {Key? key,
      required this.child,
      this.onPressed,
      this.onLongPress,
      this.onHover,
      this.backgroundColor,
      this.radius = 7,
      this.shadowColor,
      this.elevation,
      this.side,
      this.textStyle,
      this.padding})
      : super(key: key);
  final ValueChanged<bool>? onHover;
  final Widget child;
  final VoidCallback? onPressed, onLongPress;

  final Color? backgroundColor, shadowColor;
  final double radius;
  final double? elevation;
  final BorderSide? side;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    ButtonStyle style = ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(backgroundColor),
      shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius))),
      elevation: MaterialStatePropertyAll(elevation),
      side: MaterialStatePropertyAll(side),
      textStyle: MaterialStatePropertyAll(textStyle),
      padding: MaterialStatePropertyAll(padding),
      shadowColor: MaterialStatePropertyAll(shadowColor),
    );
    return OutlinedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      style: style,
      child: child,
    );
  }
}
