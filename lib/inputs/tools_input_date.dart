import 'package:flutter/material.dart';
import 'package:tools/other/colors.dart';
import 'package:tools/other/size_plus.dart';

import '../buttons/outline_button.dart';
import '../other/date.dart';
import '../other/jalali_calendar.dart';
import '../layouts/container_box.dart';
import '../other/text.dart';
import '../other/tools.dart';

class ToolsInputDate extends StatelessWidget {
  ToolsInputDate({
    Key? key,
    this.padding,
    this.hasDecorBorder = true,
    this.backColor,
    this.borderColor,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.text,
    this.textWidget,
    this.iconWidget,
    this.maxYear,
    required this.onChange,
    required this.showText,
  }) : super(key: key);

  final EdgeInsets? padding;

  final Color? backColor;

  final IconData? icon;
  final Color? iconColor, borderColor;
  final double? iconSize;

  final String? text;
  final Widget? textWidget, iconWidget;
  final Widget? showText;
  final void Function(int year, int month, int dya) onChange;
  final bool hasDecorBorder;
  int? maxYear;
  @override
  Widget build(BuildContext context) {
    maxYear ??= Jalali.now().year+3;
    Widget out = InkWell(
        onTap: () {
          DatePicker.showDatePicker(context,
              initialDay: Jalali.now().day,
              initialMonth: Jalali.now().month,
              initialYear: Jalali.now().year,
              maxYear: maxYear!,
              // minYear: Jalali.now().year - ,
              onConfirm: (int? year, int? month, int? day) {
            if (year != null && month != null && day != null) {
              onChange(year, month, day);
            }
          });
        },
        child: Ink(
            color: backColor ?? Colors.transparent,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textDirection: TextDirection.rtl,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (iconWidget != null)
                        iconWidget!
                      else
                        Icon(
                          icon ?? Icons.calendar_month,
                          color: iconColor ?? toolsMainColor,
                          size: iconSize,
                        ),
                      sw2(),
                      if (textWidget != null)
                        textWidget!
                      else
                        Text(
                          text ?? '',
                          style: toolscontentStyle(num: 35),
                        )
                    ],
                  ),
                  if (showText != null)
                    showText!
                  else
                    Text(
                      '0000/00/00',
                      style: toolscontentStyle(num: 35, color: colorGray6),
                    )
                ])));

    if (hasDecorBorder) {
      return Padding(
        padding: padding ?? EdgeInsets.zero,
        child: ToolsContainerBox(
          color: backColor ?? Colors.transparent,
          borderColor: borderColor ?? Colors.black,
          padHorizontal: 1,
          padVertical: 2.3,
          child: out,
        ),
      );
    } else {
      return Padding(
        padding: padding ?? EdgeInsets.zero,
        child: out,
      );
    }
  }
}



class ToolsInputDateSuper extends StatelessWidget {
  const ToolsInputDateSuper({super.key, required this.title,required this.value, required this.onChange});
  final String title;
  final DateTime? value;
  final Function(DateTime) onChange;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            onPressed: () async {
              DateTime? back = await showDatePicker(

                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().add(const Duration(days: -365)),
                  lastDate: DateTime.now().add(const Duration(days: 365)));
              if (back != null) {
                TimeOfDay time = TimeOfDay.now();
                onChange(DateTime(back.year, back.month, back.day, time.hour, time.minute));
              }
            },
            icon: const Icon(
              Icons.edit_calendar_outlined,
              color: black1,
            )),
        ToolsButtonOutLine(
            padding: EdgeInsets.symmetric(
              horizontal: w8(),
              vertical: h20(),
            ),
            onPressed: () {
              DateTime now = DateTime.now();
              onChange(DateTime(now.year, now.month, now.day, 0, 0, 0));
            },
            child: const Text('امروز')),
        sw1(),
        ToolsButtonOutLine(
            padding: EdgeInsets.symmetric(
              horizontal: w8(),
              vertical: h20(),
            ),
            onPressed: () {
              onChange(DateTime.now());
            },
            child: const Text('الان')),
        sw2(),
        Expanded(
          child: ToolsInputDate(
              text: title,
              onChange: (year, month, day) {
                TimeOfDay time = TimeOfDay.now();
                DateTime tempDate = Jalali(year, month, day, time.hour, time.minute).toDateTime();
                onChange(tempDate);
              },
              showText: value != null
                  ? ToolsText(
                      '${toolsMakeDate(isJalali: true, date: value, isWeekDay: true, isWeekDayLeft: false)}'
                      ' ${makeHourMin(value!.hour, value!.minute)}',
                      textDirection: TextDirection.rtl,
                    )
                  : null),
        ),
      ],
    );
  }
}
