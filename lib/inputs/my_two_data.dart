import 'package:flutter/material.dart';
import 'package:tools/date.dart';
import 'package:tools/size_plus.dart';
import 'package:tools/text.dart';

import 'my_input.dart';
import 'my_input_maker.dart';
import 'tools_input_date.dart';

class ToolsInputTwoData extends StatelessWidget {
  const ToolsInputTwoData(
      {Key? key,
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
  final ValueChanged<String>? onChangedStart, onChangedEnd;
  final TextEditingController? controllerStart, controllerEnd;
  final Widget title;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      title,
      sw3(),
      SizedBox(
        width: 10.w,
        child: ToolsInput(
          controller: controllerStart,
          onChanged: onChangedStart,
          textDirection: textDirectionStart,
          keyboardType: keyboardTypeStart,
          expands: false,
          isDense: true,
        ),
      ),
      sw2(),
      const Center(child: Text('تا')),
      sw2(),
      SizedBox(
        width: 10.w,
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

class ToolsInputTwoData1 extends StatelessWidget {
  const ToolsInputTwoData1(
      {Key? key,
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
  final ValueChanged<String>? onChangedStart, onChangedEnd;
  final TextEditingController? controllerStart, controllerEnd;
  final Widget title;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      title,
      sw3(),
      Expanded(
        child: ToolsInput(
          decorDirection: TextDirection.rtl,
          labelText: 'عدد اول',
          controller: controllerStart,
          onChanged: onChangedStart,
          textDirection: textDirectionStart,
          keyboardType: keyboardTypeStart,
          expands: false,
          isDense: true,
        ),
      ),
      sw2(),
      const Center(child: Text('تا')),
      sw2(),
      Expanded(
        child: ToolsInput(
          decorDirection: TextDirection.rtl,
          labelText: 'عدد دوم',
          controller: controllerEnd,
          onChanged: onChangedEnd,
          expands: false,
          isDense: true,
          keyboardType: keyboardTypeEnd,
          textDirection: textDirectionEnd,
        ),
      )
    ]);
  }
}

class ToolsInputTwoDataDate extends StatelessWidget {
  const ToolsInputTwoDataDate({Key? key,  required this.onChangedStart, required this.onChangedEnd, required this.title, required this.data}) : super(key: key);
  final ValueChanged<DateTime> onChangedStart, onChangedEnd;
  final ToolsDataTwo<DateTime?> data;
  final Widget title;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      title,
      sw3(),
      ToolsInputDate(
          text: '',
          onChange: (year, month, day) {
            DateTime tempDate = DateTime(year, month, day);
            onChangedStart(tempDate);
          },
          showText: data.data1 != null ? ToolsText(toolsMakeDate(isJalali: false, date: data.data1),style: toolscontentStyle(num:3)) : null),
      sw2(),
      const Center(child: Text('تا')),
      sw2(),
      ToolsInputDate(
          text: '',
          onChange: (year, month, day) {
            DateTime tempDate = DateTime(year, month, day);
            onChangedEnd(tempDate);
          },
          showText: data.data2 != null ? ToolsText(toolsMakeDate(isJalali: false, date: data.data2),style: toolscontentStyle(num:3)) : null),
    ]);
  }
}
