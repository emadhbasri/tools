import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToolsSwitch<T> extends StatelessWidget {
  const ToolsSwitch({
    Key? key,
    this.textDirection = TextDirection.rtl,
    this.isMaterial = true,
    required this.onChanged,
    required this.value,
    this.materialTapTargetSize,
    this.space = 8,
    this.activeColor = Colors.green,
    this.text,
    this.textStyle,
    this.child,
    this.textDirectionItem = TextDirection.ltr,
    this.activeTrackColor,
    this.thumbColor,
    this.trackColor,
  }) :
        // assert(
        //           (text != null && child == null) || (text == null && child != null)),
        //       assert((text != null && textDirection != null) ||
        //           (child != null && textDirection != null)),
        super(key: key);
  final ValueChanged<bool> onChanged;
  final TextDirection? textDirection;
  final TextDirection textDirectionItem;
  final bool value;
  final Color activeColor;
  final Color? activeTrackColor, thumbColor, trackColor;
  final MaterialTapTargetSize? materialTapTargetSize;
  final String? text;
  final TextStyle? textStyle;
  final Widget? child;
  final double space;
  final bool isMaterial;
  @override
  Widget build(BuildContext context) {
    Widget mySwitch;
    if (isMaterial) {
      mySwitch = Directionality(
        textDirection: textDirectionItem,
        child: SizedBox(
          width: Checkbox.width,
          height: Checkbox.width,
          child: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: activeColor,
            activeTrackColor: activeTrackColor,
            inactiveThumbColor: thumbColor,
            inactiveTrackColor: trackColor,
            materialTapTargetSize: materialTapTargetSize,
          ),
        ),
      );
    } else {
      mySwitch = Directionality(
        textDirection: textDirectionItem,
        child: CupertinoSwitch(
          value: value,
          onChanged: onChanged,
          activeColor: activeColor,
          thumbColor: thumbColor,
          trackColor: trackColor,
        ),
      );
    }

    if (textDirection != null) {
      return ToolsSwitchItem(
        mySwitch: mySwitch,
        space: space,
        textDirection: textDirection!,
        text: text,
        textStyle: textStyle,
        child: child,
      );
    } else {
      return mySwitch;
    }
  }
}

class ToolsSwitchItem extends StatelessWidget {
  const ToolsSwitchItem(
      {super.key,
      required this.mySwitch,
      this.text,
      this.textStyle,
      this.child,
      required this.space,
      required this.textDirection});
  final Widget mySwitch;
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
        if (text != null || child != null)
          if (text != null)
            Text(
              text!,
              textDirection: textDirection,
              style: textStyle,
            )
          else
            child!,
        SizedBox(width: space),
        mySwitch,
      ],
    );
  }
}
