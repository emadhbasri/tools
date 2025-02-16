library tools;

import 'dart:ui';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

Color toolsMainColor = black1;
bool doHint=false;
toolsMain(kIsWeb, {Color? newmainColor,bool? doHint1}) async {
  debugPrint('toolsMain');
  if(doHint1!=null) doHint = doHint1;
  if (newmainColor != null) toolsMainColor = newmainColor;
  if (kIsWeb) {
    setPathUrlStrategy();
    // webBrowserInfo = await DeviceInfoPlugin().webBrowserInfo;
    // debugPrint('webBrowserInfowebBrowserInfo1 ${webBrowserInfo}');
  }
}


// toolsMain(kIsWeb, {Color? newmainColor}) async {
//   debugPrint('toolsMain');
//   if (newmainColor != null) mainColor = newmainColor;
//   if (kIsWeb) {
//     setPathUrlStrategy();
//     webBrowserInfo = await DeviceInfoPlugin().webBrowserInfo;
//     // debugPrint('webBrowserInfowebBrowserInfo1 ${webBrowserInfo}');
//   }
// }
// toolsMain1(kIsWeb) async {
//   debugPrint('toolsMain1');
//   if (kIsWeb) {
//     webBrowserInfo = await DeviceInfoPlugin().webBrowserInfo;
//     debugPrint('webBrowserInfowebBrowserInfo1 ${webBrowserInfo}');
//   }
// }

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
