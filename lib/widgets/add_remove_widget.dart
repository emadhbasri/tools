import 'package:flutter/material.dart';
import 'package:tools/size.dart';
import 'package:tools/text.dart';

import '../colors.dart';

class ToolsAddRemoveWidget extends StatefulWidget {
  const ToolsAddRemoveWidget({
    Key? key,
    this.addFunc,
    this.removeFunc,
    required this.onChanged,
    this.count = 0,
    this.step = 1,
    this.addIcon = Icons.add,
    this.removeIcon = Icons.remove,
    this.addIconColor = black,
    this.removeIconColor = black,
    this.addIconSize = 17,
    this.removeIconSize = 17,
    this.textDirection = TextDirection.rtl,
    this.textStyle = const TextStyle(),
  }) : super(key: key);
  final Function? addFunc, removeFunc;
  final ValueChanged<int> onChanged;
  final int count;
  final int step;
  final IconData addIcon, removeIcon;
  final Color addIconColor, removeIconColor;
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
              border: Border.all(width: .5, color: Colors.black),
            ),
            child: Icon(
              widget.addIcon,
              color: black,
              size: widget.addIconSize,
            ),
          ),
        ),
        SizedBox(width: doubleWidth(3)),
        Text(count.toString().toPrice, style: widget.textStyle),
        SizedBox(width: doubleWidth(3)),
        GestureDetector(
          onTap: () {
            if (widget.removeFunc != null) {
              widget.removeFunc!();
            } else {
              count -= widget.step;
              widget.onChanged(count);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: .5, color: Colors.black),
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
