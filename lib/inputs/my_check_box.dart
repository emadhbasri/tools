import 'package:flutter/material.dart';

class ToolsCheckBox extends StatelessWidget {
  const ToolsCheckBox({
    Key? key,
    this.textDirection,
    required this.onChanged,
    required this.value,
    this.materialTapTargetSize,
    this.space = 8,
    this.shape = const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))),
    this.activeColor = Colors.green,
    this.checkColor = Colors.white,
    this.text,
    this.textStyle,
    this.child,
  })  : assert(
            (text != null && child == null) || (text == null && child != null)),
        assert((text != null && textDirection != null) ||
            (child != null && textDirection != null)),
        super(key: key);
  final void Function(bool?) onChanged;
  final TextDirection? textDirection;
  final bool value;
  final OutlinedBorder shape;
  final Color activeColor, checkColor;
  final MaterialTapTargetSize? materialTapTargetSize;
  final String? text;
  final TextStyle? textStyle;
  final Widget? child;
  final double space;
  @override
  Widget build(BuildContext context) {
    Widget checkbox = Checkbox(
      onChanged: onChanged,
      value: value,
      activeColor: activeColor,
      checkColor: checkColor,
      shape: shape,
      materialTapTargetSize: materialTapTargetSize,
    );
    if (textDirection != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        textDirection: textDirection,
        children: [
          checkbox,
          SizedBox(width: space),
          if (text != null)
            Text(
              text!,
              textDirection: textDirection,
              style: textStyle,
            )
          else
            child!
        ],
      );
    } else {
      return checkbox;
    }
  }
}
