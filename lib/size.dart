import 'package:flutter/material.dart';
import 'package:tools/size_plus.dart';

export 'size_plus.dart';
// double doubleHeight(double value, [double screenHeight = 0]) {

//   if (screenHeight == 0) screenHeight = value.h;
//   return (screenHeight * value) / 100;
// }

// double doubleWidth(double value, [double screenWidth = 0]) {
//   if (screenWidth == 0) screenWidth = value.width;
//   return (screenWidth * value) / 100;
// }

double h8() => 0.95.maxH;
double h4() => h8() / 2;
double h2() => h4() / 2;
double h12() => 1.45.maxH;
double h16() => 1.9.maxH;
double h20() => h4() * 5;
double h24() => h12() * 2;
double h28() => h24() + h4();
double h32() => h16() * 2;

Widget sh1() => SizedBox(height: h4());
Widget sh2() => SizedBox(height: h8());
Widget sh3() => SizedBox(height: h12());
Widget sh4() => SizedBox(height: h16());
Widget sh5() => SizedBox(height: h20());
Widget sh6() => SizedBox(height: h24());
Widget sh7() => SizedBox(height: h28());
Widget sh8() => SizedBox(height: h32());

double w8() => 2.1.w;
double w4() => w8() / 2;
double w2() => w4() / 2;
double w12() => 3.1.w;
double w16() => 4.1.w;
double w20() => w4() * 5;
double w24() => w12() * 2;
double w28() => w24() + w4();
double w32() => w16() * 2;

Widget sw1() => SizedBox(width: w4());
Widget sw2() => SizedBox(width: w8());
Widget sw3() => SizedBox(width: w12());
Widget sw4() => SizedBox(width: w16());
Widget sw5() => SizedBox(width: w20());
Widget sw6() => SizedBox(width: w24());
Widget sw7() => SizedBox(width: w28());
Widget sw8() => SizedBox(width: w32());

double makeWidth(double width) => width >= 501 ? 500 : width;

Widget sizeh(double h) {
  return SizedBox(height: h);
}

Widget sizew(double w) {
  return SizedBox(width: w);
}


double? sizeText(double? mobile, double? other) =>
    ToolsSize.desktop ? mobile : other;
