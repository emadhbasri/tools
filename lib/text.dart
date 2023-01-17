import 'package:auto_size_text/auto_size_text.dart';
export 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'size.dart';

const String yekan = 'IRANYekanMobileRegular';
const String aviny = 'aviny';

class ToolsText extends StatelessWidget {
  const ToolsText(this.text,
      {Key? key,
      this.textAlign,
      this.maxFontSize,
      this.minFontSize,
      this.maxLines,
      this.overflow = TextOverflow.ellipsis,
      this.presetFontSizes,
      this.textDirection,
      this.style,
      this.group,
      this.stepGranularity = 1,
      this.overflowReplacement})
      :
        // assert(minFontSize != null && overflow != null),
        super(key: key);

  final int? maxLines;
  final TextAlign? textAlign;
  final String text;

  /// how much the font size is decreased each step.
  final double stepGranularity;
  final double? maxFontSize, minFontSize;
  final TextOverflow overflow;
  final List<double>? presetFontSizes;
  final TextDirection? textDirection;
  final TextStyle? style;
  final AutoSizeGroup? group;
  final Widget? overflowReplacement;

  @override
  Widget build(BuildContext context) {
    double minFontSize1 = minFontSize ?? 12;
    double maxFontSize1 = minFontSize ?? double.infinity;
    return AutoSizeText(
      text,
      textAlign: textAlign,
      maxFontSize: maxFontSize1,
      minFontSize: minFontSize1,
      overflow: overflow,
      presetFontSizes: presetFontSizes,
      textDirection: textDirection,
      overflowReplacement: overflowReplacement,
      style: style,
      maxLines: maxLines,
      group: group,
      stepGranularity: stepGranularity,
    );
  }
}

class ToolsRichText extends StatelessWidget {
  const ToolsRichText(this.texts,
      {Key? key,
      this.textAlign,
      this.maxFontSize,
      this.minFontSize,
      this.maxLines,
      this.overflow,
      this.presetFontSizes,
      this.textDirection,
      this.style,
      this.group,
      this.stepGranularity = 1,
      this.overflowReplacement})
      :
        // assert(minFontSize != null && overflow != null),
        super(key: key);

  final int? maxLines;
  final TextAlign? textAlign;

  /// how much the font size is decreased each step.
  final double stepGranularity;
  final double? maxFontSize, minFontSize;
  final TextOverflow? overflow;
  final List<double>? presetFontSizes;
  final List<DataRich> texts;
  final TextDirection? textDirection;
  final TextStyle? style;
  final AutoSizeGroup? group;
  final Widget? overflowReplacement;

  @override
  Widget build(BuildContext context) {
    double minFontSize1 = minFontSize ?? 12;
    double maxFontSize1 = minFontSize ?? double.infinity;
    return AutoSizeText.rich(
      TextSpan(
          children: texts
              .map((e) => TextSpan(text: e.text, style: e.style))
              .toList()),
      textAlign: textAlign,
      maxFontSize: maxFontSize1,
      minFontSize: minFontSize1,
      overflow: overflow,
      presetFontSizes: presetFontSizes,
      textDirection: textDirection,
      overflowReplacement: overflowReplacement,
      style: style,
      maxLines: maxLines,
      group: group,
      stepGranularity: stepGranularity,
    );
  }
}

class DataRich {
  final String text;
  final TextStyle? style;

  const DataRich({required this.text, required this.style});
}

String _priceMake(dynamic price) {
  List<String> tempString = [];
  String priceS = price.toString();
  if (priceS.length <= 3) return priceS;
  while (priceS.length > 3) {
    tempString.add(priceS.substring(priceS.length - 3, priceS.length));
    priceS = priceS.substring(0, priceS.length - 3);
  }
  String out = priceS;

  for (int j = tempString.length - 1; j >= 0; j--) {
    out += ',';
    out += tempString[j];
  }
  return out;
}

String _priceMakeString(dynamic price) {
  String priceS = price.toString();

  int? pi = int.tryParse(priceS);
  if (pi != null) {
    double result;
    if (priceS.length > 6 && priceS.length <= 9) {
      result = pi / 1000000;
      return '${result.toStringAsFixed(1)} میلیون';
    } else if (priceS.length > 9 && priceS.length <= 12) {
      result = pi / 1000000000;
      return '${result.toStringAsFixed(1)} میلیون';
    } else if (priceS.length > 12 && priceS.length <= 15) {
      result = pi / 1000000000000;
      return '${result.toStringAsFixed(1)} میلیون';
    } else {
      return _priceMake(price);
    }
  } else {
    return _priceMake(price);
  }
}

String engNumToPer(String data) {
  switch (data) {
    case '0':
      return '۰';
    case '1':
      return '۱';
    case '2':
      return '۲';
    case '3':
      return '۳';
    case '4':
      return '۴';
    case '5':
      return '۵';
    case '6':
      return '۶';
    case '7':
      return '۷';
    case '8':
      return '۸';
    case '9':
      return '۹';
    default:
      return data;
  }
}

String perNumToEng(String data) {
  switch (data) {
    case '۰':
      return '0';
    case '۱':
      return '1';
    case '۲':
      return '2';
    case '۳':
      return '3';
    case '۴':
      return '4';
    case '۵':
      return '5';
    case '۶':
      return '6';
    case '۷':
      return '7';
    case '۸':
      return '8';
    case '۹':
      return '9';
    default:
      return data;
  }
}

String _toPersian1(String data) {
  String out = '';
  for (int j = 0; j < data.length; j++) {
    out += engNumToPer(data[j]);
  }
  return out;
}

String _toEnglish1(String data) {
  String out = '';
  for (int j = 0; j < data.length; j++) {
    out += perNumToEng(data[j]);
  }

  return out;
}

extension Persian on String {
  String get toEng => _toEnglish1(this);
  String get toPersian => _toPersian1(this);
  String get toPrice => _priceMake(this);
  String get toPriceString => _priceMakeString(this);
}

TextStyle toolstitleStyle(
    {int num = 4,
    Color color = black1,
    FontWeight fontWeight = FontWeight.bold,
    double? fontSize,
    double? screenWidth}) {
  switch (num) {
    case 1:
      fontSize ??= w4(screenWidth);
      break;
    case 15:
      fontSize ??= w4(screenWidth) + w2(screenWidth);
      break;
    case 2:
      fontSize ??= w8(screenWidth);
      break;
    case 25:
      fontSize ??= w8(screenWidth) + w2(screenWidth);
      break;
    case 3:
      fontSize ??= w12(screenWidth);
      break;
    case 35:
      fontSize ??= w12(screenWidth) + w2(screenWidth);
      break;
    case 4:
      fontSize ??= w16(screenWidth);
      break;
    case 45:
      fontSize ??= w16(screenWidth) + w2(screenWidth);
      break;
    case 5:
      fontSize ??= w20(screenWidth);
      break;
    case 55:
      fontSize ??= w20(screenWidth) + w2(screenWidth);
      break;
    case 6:
      fontSize ??= w24(screenWidth);
      break;
    case 65:
      fontSize ??= w24(screenWidth) + w2(screenWidth);
      break;
    case 7:
      fontSize ??= w28(screenWidth);
      break;
    case 75:
      fontSize ??= w28(screenWidth) + w2(screenWidth);
      break;
    case 8:
      fontSize ??= w32(screenWidth);
      break;
    case 85:
      fontSize ??= w32(screenWidth) + w2(screenWidth);
      break;
  }
  fontSize ??= w32(screenWidth);
  return TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize);
}

TextStyle toolscontentStyle(
    {int num = 3,
    Color color = black1,
    FontWeight fontWeight = FontWeight.normal,
    double? fontSize,
    double? screenWidth}) {
  switch (num) {
    case 1:
      fontSize ??= w4(screenWidth);
      break;
    case 15:
      fontSize ??= w4(screenWidth) + w2(screenWidth);
      break;
    case 2:
      fontSize ??= w8(screenWidth);
      break;
    case 25:
      fontSize ??= w8(screenWidth) + w2(screenWidth);
      break;
    case 3:
      fontSize ??= w12(screenWidth);
      break;
    case 35:
      fontSize ??= w12(screenWidth) + w2(screenWidth);
      break;
    case 4:
      fontSize ??= w16(screenWidth);
      break;
    case 45:
      fontSize ??= w16(screenWidth) + w2(screenWidth);
      break;
    case 5:
      fontSize ??= w20(screenWidth);
      break;
    case 55:
      fontSize ??= w20(screenWidth) + w2(screenWidth);
      break;
    case 6:
      fontSize ??= w24(screenWidth);
      break;
    case 65:
      fontSize ??= w24(screenWidth) + w2(screenWidth);
      break;
    case 7:
      fontSize ??= w28(screenWidth);
      break;
    case 75:
      fontSize ??= w28(screenWidth) + w2(screenWidth);
      break;
    case 8:
      fontSize ??= w32(screenWidth);
      break;
    case 85:
      fontSize ??= w32(screenWidth) + w2(screenWidth);
      break;
  }
  fontSize ??= w32(screenWidth);
  return TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize);
}
