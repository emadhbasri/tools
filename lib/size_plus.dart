import 'package:flutter/widgets.dart';
import 'package:universal_io/io.dart' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

typedef ResponsiveBuild = Widget Function(
  BuildContext context,
  Orientation orientation,
);

class ToolsSizer extends StatelessWidget {
  const ToolsSizer({Key? key, required this.builder}) : super(key: key);

  final ResponsiveBuild builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        ToolsSize.setScreenSize(constraints: constraints, orientation: orientation);
        return builder(context, orientation);
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

class ToolsSize {
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

    maxH = ToolsSize.boxConstraints.maxHeight / 100;
    maxW = ToolsSize.boxConstraints.maxWidth / 100;

    minH = ToolsSize.boxConstraints.minHeight / 100;
    minW = ToolsSize.boxConstraints.minWidth / 100;

    h = ToolsSize.boxConstraints.maxHeight / 100;
    hh = makeWidth(ToolsSize.boxConstraints.maxHeight) / 100;
    w = makeWidth(ToolsSize.boxConstraints.maxWidth) / 100;

    landscape = orientation == Orientation.landscape;
    portrait = orientation == Orientation.portrait;

    if (constraints.maxWidth <= 500) mobile = true;
    if (constraints.maxWidth > 500 && constraints.maxWidth <= 700) mobileTablet = true;
    if (constraints.maxWidth > 700 && constraints.maxWidth <= 1000) tablet = true;
    if (constraints.maxWidth > 1000 && constraints.maxWidth <= 1200) tabletDesktop = true;
    if (constraints.maxWidth > 1200) desktop = true;

    if (kIsWeb) {
      web = true;
    } else {
      if (Platform.isAndroid) android = true;
      if (Platform.isIOS) ios = true;
      if (Platform.isMacOS) mac = true;
      if (Platform.isWindows) windows = true;
    }
  }
}
