import 'package:flutter/material.dart';
import '../size.dart';
class ToolsButtonNative extends StatelessWidget {
  const ToolsButtonNative(
      {Key? key,
      this.child,
      this.icon,
      this.label,
      this.onPressed,
      this.onLongPress,
      this.onHover,
      this.backgroundColor,
      this.radius = 7,
      this.shadowColor,
      this.elevation,
      this.side,
      this.textStyle,
      this.screenWidth,
      this.screenHeight,
      this.loading = false,
      this.padding})
      : super(key: key);
  final ValueChanged<bool>? onHover;
  final Widget? child;
  final Widget? icon, label;
  final VoidCallback? onPressed, onLongPress;
  final bool loading;
  final Color? backgroundColor, shadowColor;
  final double radius;
  final double? elevation;
  final BorderSide? side;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final double? screenWidth;
  final double? screenHeight;
  @override
  Widget build(BuildContext context) {
    ButtonStyle style = ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(backgroundColor),
      shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius))),
      elevation: MaterialStatePropertyAll(elevation),
      side: MaterialStatePropertyAll(side),
      textStyle: MaterialStatePropertyAll(textStyle),
      padding: MaterialStatePropertyAll(padding??EdgeInsets.symmetric(vertical: h12(screenHeight),horizontal: w8(screenWidth),)),
      shadowColor: MaterialStatePropertyAll(shadowColor),
    );

    if (loading) {
      return ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        onHover: onHover,
        style: style,
        child: SizedBox(
          width: w12(screenWidth),
          height: w12(screenWidth),
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(
              Colors.white,
            ),
          ),
        ),
      );
    }
    if (child != null) {
      return ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        onHover: onHover,
        style: style,
        child: child!,
      );
    } else {
      if (icon != null && label != null) {
        return ElevatedButton.icon(
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHover: onHover,
          icon: icon!,
          label: label!,
          style: style,
        );
      } else {
        return const SizedBox.shrink();
      }
    }
  }
}
