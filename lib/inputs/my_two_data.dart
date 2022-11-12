import 'package:flutter/material.dart';

import '../size.dart';
import 'my_input.dart';

class ToolsInputTwoData extends StatelessWidget {
  const ToolsInputTwoData(
      {Key? key,
      required this.screenWidth,
      this.onChangedStart,
      this.onChangedEnd,
      this.keyboardTypeStart = TextInputType.number,
      this.keyboardTypeEnd = TextInputType.number,
      this.textDirectionStart = TextDirection.ltr,
      this.textDirectionEnd = TextDirection.ltr,
      this.controllerStart,
      this.controllerEnd,
      required this.title})
      : super(key: key);
  final TextInputType keyboardTypeStart, keyboardTypeEnd;
  final TextDirection textDirectionStart, textDirectionEnd;
  final double screenWidth;
  final ValueChanged<String>? onChangedStart, onChangedEnd;
  final TextEditingController? controllerStart, controllerEnd;
  final Widget title;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      title,
      sw3(screenWidth),
      SizedBox(
        width: doubleWidth(10, screenWidth),
        child: ToolsInput(
          controller: controllerStart,
          onChanged: onChangedStart,
          textDirection: textDirectionStart,
          keyboardType: keyboardTypeStart,
          expands: false,
          isDense: true,
        ),
      ),
      sw2(screenWidth),
      const Center(child: Text('تا')),
      sw2(screenWidth),
      SizedBox(
        width: doubleWidth(10, screenWidth),
        child: ToolsInput(
          controller: controllerEnd,
          onChanged: onChangedEnd,
          expands: false,
          isDense: true,
          keyboardType: keyboardTypeEnd,
          textDirection: textDirectionEnd,
        ),
      ),
    ]);
  }
}
