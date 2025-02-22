import 'package:flutter/material.dart';
import 'package:tools/layouts/container_box.dart';
import 'package:tools/other/size_plus.dart';

import '../other/text.dart';
import '../other/tools.dart';
import 'my_input_maker.dart';

class ToolsPopUp<T> extends StatelessWidget {
  const ToolsPopUp({
    Key? key,
    required this.data,
    this.elevation = 8,
    this.position = PopupMenuPosition.over,
    this.backgroundColor,
    this.dividerHeight = 16.0,
    this.menuItemHeight = 48.0,
    this.offset = Offset.zero,
    this.shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
    this.tooltip = 'انتخاب کنید',
    this.onCanceled,
    required this.onSelected,
    this.padding = const EdgeInsets.all(8.0),
    this.menuItemPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.splashRadius,
    this.hasDecorBorder = true,
    this.icon = const Icon(Icons.arrow_drop_down_sharp),
    required this.title,
    this.textDirection = TextDirection.rtl,
    this.decorDirection = TextDirection.rtl,
    this.checkColor = Colors.blue,
    this.borderColor,
    this.iconSize = 20,
    this.hintTitle,
    this.borderWidth,
    this.handleError = true,
  }) : super(key: key);
  // final List<String> titles;
  // final List<T> values;
  // final T? initialValue;
  final ToolsDataPopUp<T> data;
  final String? hintTitle;
  final Widget icon;
  final Color? backgroundColor;
  final Color checkColor;
  final Color? borderColor;
  final double? borderWidth;
  final ShapeBorder shape;
  final String? tooltip;
  final double elevation, dividerHeight, menuItemHeight;
  final PopupMenuPosition position;
  final Offset offset;
  final void Function()? onCanceled;
  final void Function(T) onSelected;
  final double? splashRadius;
  final EdgeInsets padding, menuItemPadding;
  final Widget title;
  final bool hasDecorBorder, handleError;
  final TextDirection textDirection, decorDirection;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    String outHint = '';
    outHint = hintTitle != null ? hintTitle! : '';
    if (doHint == true && hintTitle == null && title is Text) {
      outHint = (title as Text).data ?? '';
    }
    if ((handleError) && (data.enables.isNotEmpty) && (T.toString() == 'String')) {
      debugPrint('bbbb');
      List<String> notHave = [];
      List<String> have = [];

      while (data.enables.isNotEmpty) {
        var x = data.enables.first;
        if (data.values.contains(x)) {
          have.add(x.toString());
        } else {
          notHave.add(x.toString());
        }
        data.enables.remove(x);
      }
      if (notHave.isNotEmpty) outHint += '- ${notHave.join(',')}';
      data.enables = have.toList().cast<T>();
    }

    Widget out = PopupMenuButton<T>(
      initialValue: data.initialValue,
      itemBuilder: (context) => List.generate(data.titles.length, (index) {
        if (data.values[index] == null) {
          return PopupMenuDivider(
            height: dividerHeight,
          );
        } else {
          bool selected = data.enables.contains(data.values[index]);
          return PopupMenuItem<T>(
              height: menuItemHeight,
              value: data.values[index],
              padding: menuItemPadding,
              child: Align(
                alignment: textDirection == TextDirection.rtl
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Row(
                  textDirection: textDirection,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (selected)
                      Icon(
                        Icons.check,
                        color: checkColor,
                        size: iconSize,
                      ),
                    sw1(),
                    Text(
                      data.titles[index],
                      textDirection: textDirection,
                      style: TextStyle(color: selected ? checkColor : null),
                    ),
                  ],
                ),
              ));
        }
      }),
      shape: shape,
      color: backgroundColor,
      tooltip: tooltip,
      elevation: elevation,
      position: PopupMenuPosition.over,
      offset: offset,
      onCanceled: onCanceled,
      onSelected: onSelected,
      splashRadius: splashRadius,
      padding: padding,
      child: data.enables.isNotEmpty
          ? ToolsText(
              data.enables.join('،'),
              textDirection: textDirection,
            )
          : Row(
              textDirection: decorDirection,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [title, icon],
            ),
    );

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
            width: double.maxFinite,
            padHorizontal: 1,
            padVertical: 3,
            borderWidth: borderWidth ?? 1,
            borderColor: borderColor ?? Colors.black,
            child: out,
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hintTitle != null)
            Text(
              hintTitle!,
              style: toolstitleStyle(num: 3),
            ),
          out,
        ],
      );
    }
  }
}
