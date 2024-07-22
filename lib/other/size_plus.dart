import 'package:flutter/widgets.dart';
import 'package:universal_platform/universal_platform.dart' show UniversalPlatform;
import 'package:flutter/foundation.dart' show kIsWeb;

typedef ResponsiveBuild = Widget Function(
    BuildContext context, Orientation orientation, BoxConstraints constraints);

class ToolsSizerPlus extends StatelessWidget {
  const ToolsSizerPlus({Key? key, required this.builder}) : super(key: key);

  final ResponsiveBuild builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        ToolsSize.setScreenSize(constraints: constraints, orientation: orientation);
        return builder(context, orientation, constraints);
      });
    });
  }
}

double percentMake(data1, data2) {
  return (data1 * data2) / 100;
}

extension ToolsSizerExt on num {
  double get maxH => this * ToolsSize.boxConstraints.maxHeight / 100;
  double get maxW => this * ToolsSize.boxConstraints.maxWidth / 100;

  double get minH => this * ToolsSize.boxConstraints.minHeight / 100;
  double get minW => this * ToolsSize.boxConstraints.minWidth / 100;

  double get h => this * ToolsSize.boxConstraints.maxHeight / 100;
  double get hh => this * makeWidth(ToolsSize.boxConstraints.maxHeight) / 100;
  double get w => this * makeWidth(ToolsSize.boxConstraints.maxWidth) / 100;
}

double makeWidth(double data) => data >= 501 ? 500 : data;

class ToolsSize extends ChangeNotifier {
  static bool web = false;
  static bool android = false;
  static bool ios = false;
  static bool mac = false;
  static bool windows = false;

  static bool mobile = false;
  static bool mobileTablet = false;
  static bool tablet = false;
  static bool tabletDesktop = false;
  static bool desktop = false;

  static bool portrait = false;
  static bool landscape = false;

  static double maxH = 0;
  static double maxW = 0;

  static double minH = 0;
  static double minW = 0;

  static double h = 0;
  static double hh = 0;
  static double w = 0;

  static late BoxConstraints boxConstraints;

  static void setScreenSize(
      {required BoxConstraints constraints, required Orientation orientation}) {
    // Sets boxconstraints and orientation
    boxConstraints = constraints;

    maxH = constraints.maxHeight;
    maxW = constraints.maxWidth;

    minH = constraints.minHeight;
    minW = constraints.minWidth;

    h = constraints.maxHeight;
    hh = makeWidth(constraints.maxHeight);
    w = makeWidth(constraints.maxWidth);

    landscape = orientation == Orientation.landscape;
    portrait = orientation == Orientation.portrait;

    if (constraints.maxWidth <= 500) {
      mobile = true;
      mobileTablet = false;
      tablet = false;
      tabletDesktop = false;
      desktop = false;
    } else if (constraints.maxWidth > 500 && constraints.maxWidth <= 700) {
      mobile = false;
      mobileTablet = true;
      tablet = false;
      tabletDesktop = false;
      desktop = false;
    } else if (constraints.maxWidth > 700 && constraints.maxWidth <= 1000) {
      mobile = false;
      mobileTablet = false;
      tablet = true;
      tabletDesktop = false;
      desktop = false;
    } else if (constraints.maxWidth > 1000 && constraints.maxWidth <= 1200) {
      mobile = false;
      mobileTablet = false;
      tablet = false;
      tabletDesktop = true;
      desktop = false;
    } else if (constraints.maxWidth > 1200) {
      mobile = false;
      mobileTablet = false;
      tablet = false;
      tabletDesktop = false;
      desktop = true;
    }

    if (kIsWeb) {
      web = true;
    } else {
      if (UniversalPlatform.isAndroid) android = true;
      if (UniversalPlatform.isIOS) ios = true;
      if (UniversalPlatform.isMacOS) mac = true;
      if (UniversalPlatform.isWindows) windows = true;
    }
  }
}

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

Widget sizeh(double h) {
  return SizedBox(height: h);
}

Widget sizew(double w) {
  return SizedBox(width: w);
}

double? sizeText(double? mobile, double? other) => ToolsSize.desktop ? mobile : other;
