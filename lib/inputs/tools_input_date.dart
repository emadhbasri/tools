import 'package:flutter/material.dart';
import 'package:tools/colors.dart';
import 'package:tools/size.dart';

import '../date.dart';
import '../jalali_calendar.dart';
import '../layouts/container_box.dart';
import '../text.dart';
import '../tools.dart';

class ToolsInputDate extends StatelessWidget {
  ToolsInputDate(
      {Key? key,
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
      })
      : super(key: key);

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
    maxYear ??= Jalali.now().year;
    Widget out = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textDirection: TextDirection.rtl,
        children: [
          InkWell(
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (iconWidget != null)
                    iconWidget!
                  else
                    Icon(
                      icon ?? Icons.calendar_month,
                      color: iconColor ?? mainColor,
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
            ),
          ),
          if (showText != null)
            showText!
          else
            Text(
              '0000/00/00',
              style: toolscontentStyle(num: 35, color: colorGray6),
            )
        ]);

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
