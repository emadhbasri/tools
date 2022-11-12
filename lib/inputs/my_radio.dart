import 'package:flutter/material.dart';

class ToolsRadio<T> extends StatelessWidget {
  const ToolsRadio({
    Key? key,
    this.textDirection,
    required this.onChanged,
    required this.value,
    this.materialTapTargetSize,
    this.space = 8,
    this.activeColor = Colors.green,
    this.text,
    this.textStyle,
    this.child,
    required this.groupValue,
  })  : assert(
            (text != null && child == null) || (text == null && child != null)),
        assert((text != null && textDirection != null) ||
            (child != null && textDirection != null)),
        super(key: key);
  final ValueChanged<T?> onChanged;
  final TextDirection? textDirection;
  final T value;
  final T groupValue;
  final Color activeColor;
  final MaterialTapTargetSize? materialTapTargetSize;
  final String? text;
  final TextStyle? textStyle;
  final Widget? child;
  final double space;
  @override
  Widget build(BuildContext context) {
    Widget radio = Radio(
      groupValue: groupValue,
      onChanged: onChanged,
      value: value,
      activeColor: activeColor,
      materialTapTargetSize: materialTapTargetSize,
    );
    if (textDirection != null) {
      return ToolsRadioItem(
        radio: radio,
        space: space,
        textDirection: textDirection!,
        text: text,
        textStyle: textStyle,
        child: child,
      );
    } else {
      return radio;
    }
  }
}

class ToolsRadioItem extends StatelessWidget {
  const ToolsRadioItem(
      {super.key,
      required this.radio,
      this.text,
      this.textStyle,
      this.child,
      required this.space,
      required this.textDirection});
  final Widget radio;
  final String? text;
  final TextStyle? textStyle;
  final Widget? child;
  final double space;
  final TextDirection textDirection;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: textDirection,
      children: [
        radio,
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
  }
}
