// import 'package:flutter/material.dart';


// enum Data3 {on,off,normal}
// enum ToolsInputBorder { outline, underline, none }

// class ToolsInput extends StatelessWidget {
//   const ToolsInput(
//       {Key? key,
//       this.readOnly = false,
//       this.isDense = false,
//       this.contentPadding,
//       this.borderSide = const BorderSide(),
//       this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
//       this.inputBorder = ToolsInputBorder.outline,
//       this.labelText,
//       this.gapPadding = 4.0,
//       this.keyboardType = TextInputType.text,
//       this.controller,
//       required this.textDirection,
//       this.decorDirection,
//       this.expands = false,
//       this.obscureText = false,
//       this.focusNode,
//       this.textAlign = TextAlign.start,
//       this.minLines,
//       this.maxLines,
//       this.maxLength,
//       this.suffixText,
//       this.prefixText,
//       this.hintText,
//       this.prefixIcon,
//       this.prefix,
//       this.suffixIcon,
//       this.suffix,
//       this.hintStyle,
//       this.textStyle,
//       this.labelStyle,
//       this.prefixStyle,
//       this.suffixStyle,
//       this.onTap,
//       this.onChanged,
//       this.onEditingComplete,
//       this.onSubmitted,
//       this.errorText,
//       // this.buildCounter,
//       this.clearSuffix = false})
//       : super(key: key);
//   final String? labelText, hintText, prefixText, suffixText, errorText;
//   final TextInputType keyboardType;
//   final TextEditingController? controller;
//   final TextDirection textDirection;
//   final TextDirection? decorDirection;
//   final int? minLines, maxLines,maxLength;
//   final ToolsInputBorder inputBorder;
//   final BorderRadius borderRadius;
//   final BorderSide borderSide;
//   final double gapPadding;
//   final EdgeInsets? contentPadding;
//   final bool readOnly, expands, obscureText, isDense;
//   final FocusNode? focusNode;
//   final TextStyle? textStyle, hintStyle, labelStyle, prefixStyle, suffixStyle;
//   final TextAlign textAlign;
//   final Widget? prefixIcon, prefix, suffixIcon, suffix;

//   final GestureTapCallback? onTap;
//   final VoidCallback? onEditingComplete;
//   final ValueChanged<String>? onChanged, onSubmitted;
// // final InputCounterWidgetBuilder? buildCounter;
//   final bool clearSuffix;
//   @override
//   Widget build(BuildContext context) {
//     InputBorder inputBorder1;
//     if (inputBorder == ToolsInputBorder.outline) {
//       inputBorder1 = OutlineInputBorder(
//           borderRadius: borderRadius, borderSide: borderSide, gapPadding: gapPadding);
//     } else if (inputBorder == ToolsInputBorder.outline) {
//       inputBorder1 = UnderlineInputBorder(borderRadius: borderRadius, borderSide: borderSide);
//     } else {
//       inputBorder1 = InputBorder.none;
//     }

//     return Directionality(
//       textDirection: decorDirection ?? textDirection,
//       child: TextField(
//         maxLength: maxLength,
//         // buildCounter: buildCounter,
//         expands: expands,
//         focusNode: focusNode,
//         obscureText: obscureText,
//         onChanged: (e) {
//           int? isInt = int.tryParse(e.toEng);
//           if (isInt != null) {
//             e = e.toEng;
//             if (controller != null) {
//               controller!.text = e;
//             }
//           }
//           if (onChanged != null) {
//             onChanged!(e);
//           }
//         },
//         onEditingComplete: onEditingComplete,
//         onSubmitted: onSubmitted,
//         style: textStyle,
//         textAlign: textAlign,
//         onTap: () {
//           // if (controller != null) {
//           //   if (controller!.selection ==
//           //       TextSelection.fromPosition(TextPosition(offset: controller!.text.length - 1))) {
//           //     controller!.selection =
//           //         TextSelection.fromPosition(TextPosition(offset: controller!.text.length));
//           //   }
//           // }
//           if (onTap != null) {
//             onTap!();
//           }
//         },
//         textDirection: textDirection,
//         minLines: minLines,
//         maxLines: maxLines,
//         keyboardType: keyboardType,
//         controller: controller,
//         readOnly: readOnly,
//         decoration: InputDecoration(
//             floatingLabelStyle: labelStyle,
//             hintText: hintText,
//             hintStyle: hintStyle,
//             prefixIcon: prefixIcon,
//             prefix: prefix,
//             prefixText: prefixText,
//             prefixStyle: prefixStyle,
//             suffixIcon: suffixIcon ??
//                 (clearSuffix
//                     ? IconButton(
//                         onPressed: () {
//                           controller?.clear();
//                         },
//                         icon: const Icon(
//                           Icons.delete_forever,
//                           color: Colors.pink,
//                         ),
//                       )
//                     : null),
//             suffix: suffix,
//             suffixText: suffixText,
//             suffixStyle: suffixStyle,
//             isDense: isDense,
//             border: inputBorder1,
//             focusedBorder: inputBorder1,
//             enabledBorder: inputBorder1,
//             disabledBorder: inputBorder1,
//             errorBorder: inputBorder1,
//             focusedErrorBorder: inputBorder1,
//             contentPadding: contentPadding,
//             errorText: errorText,
//             labelText: labelText,
//             labelStyle: const TextStyle(color: Colors.black)),
//       ),
//     );
//   }
// }


// String perNumToEng(String data) {
//   switch (data) {
//     case '۰':
//       return '0';
//     case '۱':
//       return '1';
//     case '۲':
//       return '2';
//     case '۳':
//       return '3';
//     case '۴':
//       return '4';
//     case '۵':
//       return '5';
//     case '۶':
//       return '6';
//     case '۷':
//       return '7';
//     case '۸':
//       return '8';
//     case '۹':
//       return '9';
//     default:
//       return data;
//   }
// }
// String _toEnglish1(String data) {
//   String out = '';
//   for (int j = 0; j < data.length; j++) {
//     out += perNumToEng(data[j]);
//   }

//   return out;
// }
// extension Persian on String {
//   String get toEng => _toEnglish1(this);

// }