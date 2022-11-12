import 'package:flutter/material.dart';

import '../input.dart';

class ToolsInput extends StatelessWidget {
  const ToolsInput({
    Key? key,
    this.readOnly = false,
    this.isDense = false,
    this.contentPadding,
    this.borderSide = const BorderSide(),
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
    this.inputBorder = ToolsInputBorder.outline,
    this.labelText,
    this.gapPadding = 4.0,
    this.keyboardType = TextInputType.text,
    this.controller,

    required this.textDirection,
    this.decorDirection,
    this.expands = false,
    this.obscureText = false,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.minLines,
    this.maxLines,
    this.suffixText,
    this.prefixText,
    this.hintText,
    this.prefixIcon,
    this.prefix,
    this.suffixIcon,
    this.suffix,
    this.hintStyle,
    this.textStyle,
    this.labelStyle,
    this.prefixStyle,
    this.suffixStyle,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
  }) : super(key: key);
  final String? labelText, hintText, prefixText, suffixText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final TextDirection textDirection;
  final TextDirection? decorDirection;
  final int? minLines, maxLines;
  final ToolsInputBorder inputBorder;
  final BorderRadius borderRadius;
  final BorderSide borderSide;
  final double gapPadding;
  final EdgeInsets? contentPadding;
  final bool readOnly, expands, obscureText, isDense;
  final FocusNode? focusNode;
  final TextStyle? textStyle, hintStyle, labelStyle, prefixStyle, suffixStyle;
  final TextAlign textAlign;
  final Widget? prefixIcon, prefix, suffixIcon, suffix;

  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onChanged, onSubmitted;
  @override
  Widget build(BuildContext context) {
    InputBorder inputBorder1;
    if (inputBorder == ToolsInputBorder.outline) {
      inputBorder1 = OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: borderSide,
          gapPadding: gapPadding);
    } else if (inputBorder == ToolsInputBorder.outline) {
      inputBorder1 = UnderlineInputBorder(
          borderRadius: borderRadius, borderSide: borderSide);
    } else {
      inputBorder1 = InputBorder.none;
    }

    return Directionality(
      textDirection: decorDirection??textDirection,
      child: TextField(
        expands: expands,
        focusNode: focusNode,
        obscureText: obscureText,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmitted,
        style: textStyle,
        textAlign: textAlign,
        onTap: onTap,
        textDirection: textDirection,
        minLines: minLines,
        maxLines: maxLines,
        keyboardType: keyboardType,
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
            floatingLabelStyle: labelStyle,
            hintText: hintText,
            hintStyle: hintStyle,
            prefixIcon: prefixIcon,
            prefix: prefix,
            prefixText: prefixText,
            prefixStyle: prefixStyle,
            suffixIcon: suffixIcon,
            suffix: suffix,
            suffixText: suffixText,
            suffixStyle: suffixStyle,
            isDense: isDense,
            border: inputBorder1,
            contentPadding: contentPadding,
            labelText: labelText),
      ),
    );
  }
}
