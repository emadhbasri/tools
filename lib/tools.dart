library tools;

// export 'copy_share.dart';
// export 'data.dart';
// export 'image.dart';
// export 'navigator.dart';
// export 'open_url.dart';
// export 'shared_pref.dart';
// export 'size.dart';
// export 'toast.dart';
// export 'ui.dart';
// export 'colors.dart';
import 'dart:ui';
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

Color mainColor = black1;
// WebBrowserInfo? webBrowserInfo;
toolsMain(kIsWeb, {Color? newmainColor}) async {
  print('toolsMain');
  if (newmainColor != null) mainColor = newmainColor;
  if (kIsWeb) {
    setPathUrlStrategy();
    // webBrowserInfo = await DeviceInfoPlugin().webBrowserInfo;
    // print('webBrowserInfowebBrowserInfo1 ${webBrowserInfo}');
  }
}


// toolsMain(kIsWeb, {Color? newmainColor}) async {
//   print('toolsMain');
//   if (newmainColor != null) mainColor = newmainColor;
//   if (kIsWeb) {
//     setPathUrlStrategy();
//     webBrowserInfo = await DeviceInfoPlugin().webBrowserInfo;
//     // print('webBrowserInfowebBrowserInfo1 ${webBrowserInfo}');
//   }
// }
// toolsMain1(kIsWeb) async {
//   print('toolsMain1');
//   if (kIsWeb) {
//     webBrowserInfo = await DeviceInfoPlugin().webBrowserInfo;
//     print('webBrowserInfowebBrowserInfo1 ${webBrowserInfo}');
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