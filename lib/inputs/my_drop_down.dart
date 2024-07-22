import 'package:flutter/material.dart';
import 'package:tools/layouts/container_box.dart';

import '../other/text.dart';
import 'my_input_maker.dart';

// ignore: must_be_immutable
class ToolsDropDown<T> extends StatelessWidget {
  ToolsDropDown({
    Key? key,
    // required this.titles,
    // required this.values,
    this.itemAlignment = Alignment.centerRight,
    this.mainAlignment = AlignmentDirectional.centerStart,
    required this.onChanged,
    this.onChangedNull,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.isDense = false,
    this.isExpanded = false,
    this.hint,
    this.disabledHint,
    this.hintTitle,
    this.underline,
    this.textStyle,
    this.elevation = 8,
    this.itemHeight = 48,
    // required this.value,
    this.icon = const Icon(Icons.arrow_drop_down),
    this.dropdownColor,
    this.borderWidth,
    this.borderColor,
    this.hasDecorBorder = true,
    this.allowNull = false,
    this.padHorizontal = 1,
    required this.data,
  }) : super(key: key);
  final ToolsDataDropDown data;
  // final List<String> titles;
  // final List<T> values;
  final bool hasDecorBorder;
  final AlignmentGeometry itemAlignment, mainAlignment;
  final ValueChanged<T> onChanged;
  final ValueChanged<T?>? onChangedNull;
  final BorderRadius borderRadius;
  final Color? dropdownColor, borderColor;
  final double? borderWidth;
  final bool isExpanded, isDense;
  final Widget icon;
  final Widget? hint, disabledHint;
  final String? hintTitle;
  late Widget? underline;
  final int elevation;
  final double itemHeight;
  final TextStyle? textStyle;
  final bool allowNull;
  final double padHorizontal;
  // final T? value;

  @override
  Widget build(BuildContext context) {
    if (hasDecorBorder) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hintTitle != null)
            Text(
              hintTitle!,
              style: toolstitleStyle(num: 3),
            ),
          ToolsContainerBox(
            padHorizontal: padHorizontal,
            borderWidth: borderWidth ?? 1,
            padVertical: 0,
            borderColor: borderColor ?? Colors.black,
            color: Colors.transparent,
            child: DropdownButton<T>(
              items: [
                if (allowNull)
                  DropdownMenuItem(
                      value: null,
                      alignment: itemAlignment,
                      child: const Text(
                        '',
                        textDirection: TextDirection.rtl,
                      )),
                ...List.generate(
                    data.titles.length,
                    (index) => DropdownMenuItem(
                        value: data.values[index],
                        alignment: itemAlignment,
                        child: Text(
                          data.titles[index],
                          textDirection: TextDirection.rtl,
                        )))
              ],
              onChanged: (T? value) {
                if (allowNull) {
                  onChangedNull!(value);
                } else if (value != null) {
                  onChanged(value);
                }
              },
              alignment: mainAlignment,
              borderRadius: borderRadius,
              isDense: isDense,
              isExpanded: isExpanded,
              dropdownColor: dropdownColor,
              icon: icon,
              hint: hint,
              disabledHint: disabledHint,
              elevation: elevation,
              itemHeight: itemHeight,
              style: textStyle,
              underline: const SizedBox.shrink(),
              value: data.value,

            ),
          ),
        ],
      );
    } else {
      underline ??= Container(
        height: 1.0,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFBDBDBD),
              width: 0.0,
            ),
          ),
        ),
      );
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hintTitle != null)
            Text(
              hintTitle!,
              style: toolstitleStyle(num: 3),
            ),
          DropdownButton<T>(
            items: [
              if (allowNull)
                DropdownMenuItem(
                    value: null,
                    alignment: itemAlignment,
                    child: const Text(
                      '',
                      textDirection: TextDirection.rtl,
                    )),
              ...List.generate(
                  data.titles.length,
                  (index) => DropdownMenuItem(
                      value: data.values[index],
                      alignment: itemAlignment,
                      child: Text(data.titles[index])))
            ],
            onChanged: (T? value) {
              if (allowNull) {
                onChangedNull!(value);
              } else if (value != null) {
                onChanged(value);
              }
            },
            alignment: mainAlignment,
            borderRadius: borderRadius,
            isDense: isDense,
            isExpanded: isExpanded,
            dropdownColor: dropdownColor,
            icon: icon,
            hint: hint,
            disabledHint: disabledHint,
            elevation: elevation,
            itemHeight: itemHeight,
            style: textStyle,
            underline: underline,
            value: data.value,
          ),
        ],
      );
    }
  }
}
