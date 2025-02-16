import 'package:flutter/material.dart';

// import '../other/text.dart';

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
    this.handleError = true,
  }) : super(key: key);
  final ToolsDataDropDown data;
  // final List<String> titles;
  // final List<T> values;
  final bool hasDecorBorder, handleError;
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
    String outHint = '';
    outHint = hintTitle != null ? hintTitle! : '';
    if (hintTitle == null && hint is Text) {
      outHint = (hint as Text).data ?? '';
    }

    if (handleError && (data.value != null && !data.values.contains(data.value))) {
      outHint += '- ${data.value.toString()}';
      data.value=null;
    }

    if (hasDecorBorder) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            outHint,
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
          Text(
            outHint,
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


class ToolsDataDropDown<T> {
  List<String> titles;
  late List<T> values;
  T? value;
  ToolsDataDropDown(this.titles, this.value, {List<T>? values, bool titleValueSame = true}) {
    if (titleValueSame) {
      this.values = titles.cast<T>();
    } else {
      this.values = values!;
    }
  }
  clear(){
    value=null;
  }
}

class ToolsContainerBox extends StatelessWidget {
  const ToolsContainerBox(
      {Key? key,
      this.width,
      this.height,
      this.padHorizontal = 2,
      this.padVertical = .5,
      this.borderWidth = 1,
      this.radius = 10,
      this.borderColor = Colors.black,
      this.color = Colors.white,
      required this.child})
      : super(key: key);
  final double? width,height;
  final double padHorizontal, padVertical, borderWidth, radius;
  final Color borderColor,color;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width:width,
      height:height,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(width: borderWidth, color: borderColor),
        borderRadius: BorderRadius.circular(radius),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 4,
      ),
      child: child,
    );
  }
}


TextStyle toolstitleStyle({
  int num = 4,
  Color? color,
  FontWeight fontWeight = FontWeight.bold,
  double? fontSize,
}) {
  color ??= Colors.black;
  switch (num) {
    case 1:
      fontSize ??= 4;
      break;
    case 15:
      fontSize ??= 4 + 2;
      break;
    case 2:
      fontSize ??= 8;
      break;
    case 25:
      fontSize ??= 8 + 2;
      break;
    case 3:
      fontSize ??= 12;
      break;
    case 35:
      fontSize ??= 12 + 2;
      break;
    case 4:
      fontSize ??= 16;
      break;
    case 45:
      fontSize ??= 16 + 2;
      break;
    case 5:
      fontSize ??= 20;
      break;
    case 55:
      fontSize ??= 20 + 2;
      break;
    case 6:
      fontSize ??= 24;
      break;
    case 65:
      fontSize ??= 24 + 2;
      break;
    case 7:
      fontSize ??= 28;
      break;
    case 75:
      fontSize ??= 28 + 2;
      break;
    case 8:
      fontSize ??= 32;
      break;
    case 85:
      fontSize ??= 32 + 2;
      break;
  }
  fontSize ??= 32;
  return TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize);
}

TextStyle toolscontentStyle({
  int num = 3,
  Color? color,
  FontWeight fontWeight = FontWeight.normal,
  String? fontFamily,
  double? fontSize,
}) {
  color ??= Colors.black;
  switch (num) {
    case 1:
      fontSize ??= 4;
      break;
    case 15:
      fontSize ??= 4 + 2;
      break;
    case 2:
      fontSize ??= 8;
      break;
    case 25:
      fontSize ??= 8 + 2;
      break;
    case 3:
      fontSize ??= 12;
      break;
    case 35:
      fontSize ??= 12 + 2;
      break;
    case 4:
      fontSize ??= 16;
      break;
    case 45:
      fontSize ??= 16 + 2;
      break;
    case 5:
      fontSize ??= 20;
      break;
    case 55:
      fontSize ??= 20 + 2;
      break;
    case 6:
      fontSize ??= 24;
      break;
    case 65:
      fontSize ??= 24 + 2;
      break;
    case 7:
      fontSize ??= 28;
      break;
    case 75:
      fontSize ??= 28 + 2;
      break;
    case 8:
      fontSize ??= 32;
      break;
    case 85:
      fontSize ??= 32 + 2;
      break;
  }
  fontSize ??= 32;
  return TextStyle(
      color: color, fontWeight: fontWeight, fontSize: fontSize, fontFamily: fontFamily);
}
