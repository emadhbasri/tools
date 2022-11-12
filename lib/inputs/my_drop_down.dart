import 'package:flutter/material.dart';
import 'package:tools/layouts.dart';

import 'my_input_maker.dart';

class ToolsDropDown<T> extends StatelessWidget {
  ToolsDropDown({
    Key? key,
    // required this.titles,
    // required this.values,
    this.itemAlignment = Alignment.centerRight,
    this.mainAlignment = AlignmentDirectional.centerStart,
    required this.onChanged,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.isDense = false,
    this.isExpanded = false,
    this.hint,
    this.disabledHint,
    this.underline,
    this.textStyle,
    this.elevation = 8,
    this.itemHeight = 48,
    // required this.value,
    this.icon = const Icon(Icons.arrow_drop_down),
    this.dropdownColor,
    this.screenWidth,
    this.screenHeight,
    this.hasDecorBorder = true,
    required this.data,
  }) : super(key: key);
  final ToolsDataDropDown data;
  // final List<String> titles;
  // final List<T> values;
  final bool hasDecorBorder;
  final AlignmentGeometry itemAlignment, mainAlignment;
  final ValueChanged<T> onChanged;
  final BorderRadius borderRadius;
  final Color? dropdownColor;
  final bool isExpanded, isDense;
  final Widget icon;
  final Widget? hint, disabledHint;
  late Widget? underline;
  final int elevation;
  final double itemHeight;
  final TextStyle? textStyle;
  final double? screenWidth,screenHeight;
  // final T? value;

  @override
  Widget build(BuildContext context) {
    if (hasDecorBorder) {
      return ToolsContainerBox(
        padHorizontal: 1,
        padVertical: 0,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        child: DropdownButton<T>(
        items: List.generate(
            data.titles.length,
            (index) => DropdownMenuItem(
                value: data.values[index],
                alignment: itemAlignment,
                child: Text(data.titles[index]))),
        onChanged: (T? value) {
          if (value != null) {
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
      return DropdownButton<T>(
      items: List.generate(
          data.titles.length,
          (index) => DropdownMenuItem(
              value: data.values[index],
              alignment: itemAlignment,
              child: Text(data.titles[index]))),
      onChanged: (T? value) {
        if (value != null) {
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
    );
    }

    
  }
}
