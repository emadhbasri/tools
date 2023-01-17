import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';

enum DeviceType { mobile, mobileTablet, tablet, tabletDesktop, desktop }

///(context, widgets, deviceType, screenWidth, screenHeight, realWidth, realHeight){}
typedef MyResponsiveBuild = Widget Function(
  BuildContext context,
  // Widget? widgets,
  DeviceType deviceType,
  double screenWidth,
  double screenHeight,
  double realWidth,
  double realHeight,
);

///(context, screenWidth, screenHeight, realWidth, realHeight) {}
typedef MyResponsiveBuildSimple = Widget? Function(
  BuildContext context,
  double screenWidth,
  double screenHeight,
  double realWidth,
  double realHeight,
);

late Size screenSize;
// double doubleHeight1(double value, {double height = 0}) {
//   if (height == 0) height = screenSize.height;
//   return (height * value) / 100;
// }

// double doubleWidth1(double value, {double width = 0}) {
//   if (width == 0) width = screenSize.width;
//   return (width * value) / 100;
// }

double doubleHeight(double value, [double screenHeight = 0]) {
  if (screenHeight == 0) screenHeight = screenSize.height;
  return (screenHeight * value) / 100;
}

double doubleWidth(double value, [double screenWidth = 0]) {
  if (screenWidth == 0) screenWidth = screenSize.width;
  return (screenWidth * value) / 100;
}

double h8([double? screenHeight]) => screenHeight != null
    ? doubleHeight(0.95, screenHeight)
    : doubleHeight(0.95, screenSize.height);
double h4([double? screenHeight]) => h8(screenHeight) / 2;
double h2([double? screenHeight]) => h4(screenHeight) / 2;
double h12([double? screenHeight]) => screenHeight != null
    ? doubleHeight(1.45, screenHeight)
    : doubleHeight(1.45, screenSize.height);
double h16([double? screenHeight]) => screenHeight != null
    ? doubleHeight(1.9, screenHeight)
    : doubleHeight(1.9, screenSize.height);
double h20([double? screenHeight]) => h4(screenHeight) * 5;
double h24([double? screenHeight]) => h12(screenHeight) * 2;
double h28([double? screenHeight]) => h24(screenHeight) + h4(screenHeight);
double h32([double? screenHeight]) => h16(screenHeight) * 2;

Widget sh05([double? screenHeight]) => SizedBox(height: h4(screenHeight));
Widget sh1([double? screenHeight]) => SizedBox(height: h8(screenHeight));
Widget sh15([double? screenHeight]) => SizedBox(height: h12(screenHeight));
Widget sh2([double? screenHeight]) => SizedBox(height: h16(screenHeight));
Widget sh25([double? screenHeight]) => SizedBox(height: h20(screenHeight));
Widget sh3([double? screenHeight]) => SizedBox(height: h24(screenHeight));
Widget sh35([double? screenHeight]) => SizedBox(height: h28(screenHeight));
Widget sh4([double? screenHeight]) => SizedBox(height: h32(screenHeight));

double w8([double? screenWidth]) => screenWidth != null
    ? doubleWidth(2.1, screenWidth)
    : doubleWidth(2.1, screenSize.width);
double w4([double? screenWidth]) => w8(screenWidth) / 2;
double w2([double? screenWidth]) => w4(screenWidth) / 2;
double w12([double? screenWidth]) => screenWidth != null
    ? doubleWidth(3.1, screenWidth)
    : doubleWidth(3.1, screenSize.width);
double w16([double? screenWidth]) => screenWidth != null
    ? doubleWidth(4.1, screenWidth)
    : doubleWidth(4.1, screenSize.width);
double w20([double? screenWidth]) => w4(screenWidth) * 5;
double w24([double? screenWidth]) => w12(screenWidth) * 2;
double w28([double? screenWidth]) => w24(screenWidth) + w4(screenWidth);
double w32([double? screenWidth]) => w16(screenWidth) * 2;

Widget sw1([double? screenWidth]) => SizedBox(width: w4(screenWidth));
Widget sw2([double? screenWidth]) => SizedBox(width: w8(screenWidth));
Widget sw3([double? screenWidth]) => SizedBox(width: w12(screenWidth));
Widget sw4([double? screenWidth]) => SizedBox(width: w16(screenWidth));
Widget sw5([double? screenWidth]) => SizedBox(width: w20(screenWidth));
Widget sw6([double? screenWidth]) => SizedBox(width: w24(screenWidth));
Widget sw7([double? screenWidth]) => SizedBox(width: w28(screenWidth));
Widget sw8([double? screenWidth]) => SizedBox(width: w32(screenWidth));

double makeWidth(double width) => width >= 501 ? 500 : width;

class MySizer extends StatefulWidget {
  const MySizer(
      {Key? key,
      required this.builder,
      // this.mobile,
      // this.tablet,
      // this.desktop,
      this.makeItMobile = false,
      this.backColor})
      : super(key: key);

  ///(context, screenWidth, screenHeight, realWidth, realHeight) {}
  // final MyResponsiveBuildSimple? mobile, tablet, desktop;

  ///(context, widgets, deviceType, screenWidth, screenHeight, realWidth, realHeight){}
  final MyResponsiveBuild builder;
  final bool makeItMobile;
  final Color? backColor;

  @override
  State<MySizer> createState() => _MySizerState();
}

class _MySizerState extends State<MySizer> {
  late Color backColor;
  @override
  void initState() {
    super.initState();
    backColor = widget.backColor ?? Colors.grey[700]!;
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (BuildContext context, Screen screen) {
        return const SizedBox();
      },
      layoutDelegate: _getAllPlatformsDelegate(),
    );
  }

  AdaptiveLayoutDelegate? _getAllPlatformsDelegate() {
    return AdaptiveLayoutDelegateWithScreenSize(
      xSmall: (BuildContext context, Screen screen) {
        double width = screen.mediaQueryData.size.width;
        double height = screen.mediaQueryData.size.height;

        return widget.builder(
            context,
            // widget.mobile == null
            //     ? null
            //     : widget.mobile!(context, width, height, width, height),
            DeviceType.mobile,
            width,
            height,
            width,
            height);
      },
      small: (BuildContext context, Screen screen) {
        print('small');
        double width = screen.mediaQueryData.size.width;
        double height = screen.mediaQueryData.size.height;
        double screenHeight = height;
        double screenWidth = makeWidth(width);

        if (width > 500) {
          if (widget.makeItMobile) {
            return Material(
              color:
                  widget.backColor ?? Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: screenWidth),
                  child: widget.builder(
                      context,
                      // widget.mobile == null
                      //     ? null
                      //     : widget.mobile!(
                      //         context, width, height, width, height),
                      DeviceType.tablet,
                      screenWidth,
                      screenHeight,
                      width,
                      height),
                ),
              ),
            );
          }
        }
        if (width > 500 && width <= 800) {
          return widget.builder(
              context,
              // widget.tablet == null
              //     ? null
              //     : widget.tablet!(context, width, height, width, height),
              DeviceType.mobileTablet,
              screenWidth,
              screenHeight,
              width,
              height);
        } else {
          return widget.builder(
              context,
              // widget.tablet == null
              //     ? null
              //     : widget.tablet!(context, width, height, width, height),
              DeviceType.tablet,
              screenWidth,
              screenHeight,
              width,
              height);
        }
      },
      defaultBuilder: (BuildContext context, Screen screen) {
        print('default');
        double width = screen.mediaQueryData.size.width;
        double height = screen.mediaQueryData.size.height;
        double screenHeight = height;
        double screenWidth = makeWidth(width);

        if (width > 500) {
          if (widget.makeItMobile) {
            return Material(
              color:
                  widget.backColor ?? Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: screenWidth),
                  child: widget.builder(
                      context,
                      // widget.mobile == null
                      //     ? null
                      //     : widget.mobile!(
                      //         context, width, height, width, height),
                      DeviceType.desktop,
                      screenWidth,
                      screenHeight,
                      width,
                      height),
                ),
              ),
            );
          }
        }

        if (width >= 1000 && width <= 1200) {
          return widget.builder(
            context,
            // widget.desktop == null
            //     ? null
            //     : widget.desktop!(context, width, height, width, height),
            DeviceType.tabletDesktop,
            screenWidth,
            screenHeight,
            width,
            height);
        } else {
          return widget.builder(
            context,
            // widget.desktop == null
            //     ? null
            //     : widget.desktop!(context, width, height, width, height),
            DeviceType.desktop,
            screenWidth,
            screenHeight,
            width,
            height);
        }


      },
    );
  }
}

double sizeText3(double screenWidth1, DeviceType deviceType,
    {bool forceDo = false}) {
  if (forceDo) return doubleWidth(3, screenWidth1);
  double screenWidth = makeWidth(screenWidth1);
  if (deviceType == DeviceType.desktop) {
    return doubleWidth(3, screenWidth1);
  } else {
    return doubleWidth(3, screenWidth);
  }
}

double sizeText35(double screenWidth1, DeviceType deviceType,
    {bool forceDo = false}) {
  if (forceDo) return doubleWidth(3.5, screenWidth1);
  double screenWidth = makeWidth(screenWidth1);
  if (deviceType == DeviceType.desktop) {
    return doubleWidth(3.5, screenWidth1);
  } else {
    return doubleWidth(3.5, screenWidth);
  }
}

double sizeText37(double screenWidth1, DeviceType deviceType,
    {bool forceDo = false}) {
  if (forceDo) return doubleWidth(3.75, screenWidth1);
  double screenWidth = makeWidth(screenWidth1);
  if (deviceType == DeviceType.desktop) {
    return doubleWidth(3.75, screenWidth1);
  } else {
    return doubleWidth(3.75, screenWidth);
  }
}

double sizeText4(double screenWidth1, DeviceType deviceType,
    {bool forceDo = false}) {
  if (forceDo) return doubleWidth(4, screenWidth1);
  double screenWidth = makeWidth(screenWidth1);
  if (deviceType == DeviceType.desktop) {
    return doubleWidth(4, screenWidth1);
  } else {
    return doubleWidth(4, screenWidth);
  }
}

double sizeText45(double screenWidth1, DeviceType deviceType,
    {bool forceDo = false}) {
  if (forceDo) return doubleWidth(4.5, screenWidth1);
  double screenWidth = makeWidth(screenWidth1);
  if (deviceType == DeviceType.desktop) {
    return doubleWidth(4.5, screenWidth1);
  } else {
    return doubleWidth(4.5, screenWidth);
  }
}

double sizeText5(double screenWidth1, DeviceType deviceType,
    {bool forceDo = false}) {
  if (forceDo) return doubleWidth(5, screenWidth1);
  double screenWidth = makeWidth(screenWidth1);
  if (deviceType == DeviceType.desktop) {
    return doubleWidth(5, screenWidth1);
  } else {
    return doubleWidth(5, screenWidth);
  }
}

double sizeText6(double screenWidth1, DeviceType deviceType,
    {bool forceDo = false}) {
  if (forceDo) return doubleWidth(6, screenWidth1);
  double screenWidth = makeWidth(screenWidth1);
  if (deviceType == DeviceType.desktop) {
    return doubleWidth(6, screenWidth1);
  } else {
    return doubleWidth(6, screenWidth);
  }
}

double? sizeText(DeviceType deviceType, double? mobile, double? other) =>
    deviceType == DeviceType.desktop ? mobile : other;

Widget sizeh(double h) {
  return SizedBox(height: h);
}

Widget sizew(double w) {
  return SizedBox(width: w);
}
