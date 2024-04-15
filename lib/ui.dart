import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tools/colors.dart';
import 'package:tools/size.dart';
import 'package:tools/text.dart';

class DividerName extends StatelessWidget {
  const DividerName(
      {Key? key,
      this.textDirection = TextDirection.rtl,
      required this.text,
      this.size = 2,
      this.color = colorGray156})
      : super(key: key);
  final TextDirection textDirection;
  final Widget text;
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: textDirection,
      children: [
        text,
        sw2(),
        Expanded(
          child: Container(
            width: double.maxFinite,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: color,
            ),
          ),
        )
      ],
    );
  }
}

MaterialStateProperty<T> toolsmakeStyle<T>(value) => MaterialStateProperty.all<T>(value);

Widget toolscircleLoader([Color? color]) =>
    Scaffold(body: Center(child: CircularProgressIndicator(color: color)));

Widget toolsprogressSimple({Color? color, double? size, bool justProgress = false}) {
  if (size != null) {
    if (justProgress) {
      return SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: color,
        ),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: Center(
          child: CircularProgressIndicator(
        color: color,
      )),
    );
  } else {
    if (justProgress) {
      return CircularProgressIndicator(
        color: color,
      );
    }
    return Center(
        child: CircularProgressIndicator(
      color: color,
    ));
  }
}

toolscircleSmall(Color color, {double size = 15}) => Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Color(0x3f000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
        color: color,
      ),
    );

toolsstatusSet({
  Color? statusBar,
  Color? navigationBar,
  bool? statusBarIconIsWhite,
  bool? navigationBarLineIsWhite,
}) async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: true,
      systemNavigationBarContrastEnforced: true,
      statusBarColor: statusBar,
      statusBarBrightness: (statusBarIconIsWhite != null)
          ? (statusBarIconIsWhite ? Brightness.light : Brightness.dark)
          : null,
      statusBarIconBrightness: (statusBarIconIsWhite != null)
          ? (statusBarIconIsWhite ? Brightness.light : Brightness.dark)
          : null,
      systemNavigationBarColor: navigationBar,
      systemNavigationBarIconBrightness: (navigationBarLineIsWhite != null)
          ? (navigationBarLineIsWhite ? Brightness.light : Brightness.dark)
          : null,
    ));
  } on PlatformException catch (e) {
    debugPrint(e.toString());
  }
}

Widget toolsphoneText(String data,
    {TextDirection textDirection = TextDirection.ltr,
    TextAlign? textAlign,
    TextStyle? style,
    Color differetColor = Colors.pink,
    bool hasSpace = true}) {
  style ??= const TextStyle();
  if (data.length < 11) return Text(data);
  return ToolsRichText(
    textAlign: textAlign,
    [
      DataRich(
        text: data.substring(0, 4),
        style: style,
      ),
      if (hasSpace) DataRich(text: ' ', style: style),
      DataRich(text: data.substring(4, 7), style: style.copyWith(color: differetColor)),
      if (hasSpace) DataRich(text: ' ', style: style),
      DataRich(text: data.substring(7, 11), style: style),
    ],
    style: style,
    textDirection: textDirection,
  );
}

String toolsmakePhoneStar(String phoneNumber) {
  String pre = phoneNumber.substring(0, 4);
  String suff = phoneNumber.substring(7, 11);
  return '$pre***$suff';
}

// class asds extends StatefulWidget {
//   const asds({Key? key}) : super(key: key);

//   @override
//   State<asds> createState() => _asdsState();
// }

// class _asdsState extends State<asds> {
//   @override
//   Widget build(BuildContext context) {
//     return MySizer(
//       builder: (context, deviceType, screenWidth, screenHeight, realWidth, realHeight) {
//         return Scaffold(
//           body: Padding(
//             padding: EdgeInsets.symmetric(vertical: h8(screenHeight), horizontal: w8(screenWidth)),
//             child: Column(
//               children: [
//                 Text('asd'),
//                 sh8(screenHeight),
//                 Text('asd'),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
