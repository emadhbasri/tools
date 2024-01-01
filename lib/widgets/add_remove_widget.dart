import 'package:flutter/material.dart';
import 'package:tools/size_plus.dart';
import 'package:tools/tools.dart';


class ToolsAddRemoveWidget extends StatefulWidget {
  ToolsAddRemoveWidget({
    Key? key,
    this.addFunc,
    this.removeFunc,
    required this.onChanged,
    this.count = 0,
    this.step = 1,
    this.addIcon = Icons.add,
    this.removeIcon = Icons.remove,
    this.addIconColor,
    this.removeIconColor,
    this.addIconSize = 17,
    this.removeIconSize = 17,
    this.negative = false,
    this.textDirection = TextDirection.rtl,
    this.textStyle = const TextStyle(),
  }) : super(key: key);
  final bool negative;
  final Function? addFunc, removeFunc;
  final ValueChanged<int> onChanged;
  final int count;
  final int step;
  final IconData addIcon, removeIcon;
  Color? addIconColor, removeIconColor;
  final double addIconSize, removeIconSize;
  final TextDirection textDirection;
  final TextStyle textStyle;
  @override
  State<ToolsAddRemoveWidget> createState() => _ToolsAddRemoveWidgetState();
}

class _ToolsAddRemoveWidgetState extends State<ToolsAddRemoveWidget> {
  late int count;
  @override
  void initState() {
    super.initState();
    widget.addIconColor ??= mainColor;
    widget.removeIconColor ??= mainColor;
    count = widget.count;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: widget.textDirection,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            if (widget.addFunc != null) {
              widget.addFunc!();
            } else {
              count += widget.step;
              widget.onChanged(count);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: .5, color: mainColor),
            ),
            child: Icon(
              widget.addIcon,
              color: mainColor,
              size: widget.addIconSize,
            ),
          ),
        ),
        SizedBox(width: 3.w),
        Text(
          count.toString(),
          style: widget.textStyle,
          textDirection: TextDirection.ltr,
        ),
        SizedBox(width: 3.w),
        GestureDetector(
          onTap: () {
            if (widget.removeFunc != null) {
              widget.removeFunc!();
            } else {
              count -= widget.step;
              if (widget.negative) {
                widget.onChanged(count);
              } else {
                if (count < 1) {
                  count = 1;
                  widget.onChanged(count);
                } else {
                  widget.onChanged(count);
                }
              }
            }
          },
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: .5, color: mainColor)
            ),
            child: Icon(
              widget.removeIcon,
              color: widget.removeIconColor,
              size: widget.removeIconSize,
            ),
          ),
        ),
      ],
    );
  }
}
