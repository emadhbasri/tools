import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



MaterialStateProperty<T> toolsmakeStyle<T>(value) =>
    MaterialStateProperty.all<T>(value);

Widget toolscircleLoader()=>Scaffold(body: Center(child: CircularProgressIndicator()));

Widget toolsprogressSimple({Color? color, double? size,bool justProgress=false}) {
  
  if (size != null) {
    if(justProgress)return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
            color: color,
          ),
    );
    
    return SizedBox(
      width: size,
      height: size,
      child: Center(
          child: CircularProgressIndicator(
            color: color,
          )),
    );
  } else {
    if(justProgress)return CircularProgressIndicator(
          color: color,
        );
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

Widget toolsphoneText(String data, {TextStyle? style, differetColor = Colors.pink}) {
  if (data.length < 11) return Text(data);
  return RichText(
    textDirection: TextDirection.ltr,
    text: TextSpan(style: style, children: [
      TextSpan(text: data.substring(0, 4)),
      const TextSpan(text: ' '),
      TextSpan(
          text: data.substring(4, 7), style: TextStyle(color: differetColor)),
      const TextSpan(text: ' '),
      TextSpan(text: data.substring(7, 11)),
    ]),
  );
}

String toolsmakePhoneStar(String phoneNumber) {
  String pre = phoneNumber.substring(0, 4);
  String suff = phoneNumber.substring(7, 11);
  return '$pre***$suff';
}





