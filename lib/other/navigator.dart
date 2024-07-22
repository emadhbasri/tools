import 'package:flutter/material.dart';

abstract class Go {
  static void pushAndRemoveSlideAnim(BuildContext context, Widget page,
      {bool full = false, var first, var second}) {
    first ??= const Cubic(0.175, 0.885, 0.32, 1.1);
    second ??= Curves.easeOutCirc;
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
            transitionDuration: const Duration(seconds: 1),
            fullscreenDialog: full,
            pageBuilder: (context, Animation<double> animation,
                Animation<double> secendAnimation) {
              return page;
            },
            transitionsBuilder: (context, Animation<double> animation,
                Animation<double> secendAnimation, Widget widget) {

              return SlideTransition(
                position: Tween(begin: const Offset(1, 0), end: const Offset(0, 0))
                    .animate(CurvedAnimation(
                    curve: first, //Curves.easeOutBack
                    parent: animation,
                    reverseCurve: second)),
                child: widget,
              );
            }),
            (route) => false).catchError((e) => debugPrint('Error 1 $e'));
  }
  static pushAndRemove(BuildContext context, Widget page) {
    FocusScope.of(context).unfocus();
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => page), (route) => false);
  }

  static Future<dynamic> push(BuildContext context, Widget page,
      {bool isModal = false, Duration duration = const Duration(milliseconds: 300)}) async {
    Route route;
    if (isModal) {
      route = PageRouteBuilder(
          transitionDuration: duration, opaque: false, pageBuilder: (BuildContext context, _, __) => page);
    } else {
      route = MaterialPageRoute(builder: (context) => page);
    }
    return await Navigator.push(context, route).catchError((e) =>
    debugPrint('Error push $e'));
  }

  static Future<dynamic> replace(BuildContext context, Widget page,
      {bool isModal = false, Duration duration = const Duration(milliseconds: 300)}) async {
    FocusScope.of(context).unfocus();
    FocusScope.of(context).requestFocus(FocusNode());
    Route route;
    if (isModal) {
      route = PageRouteBuilder(
          barrierColor: Colors.transparent,
          transitionDuration: duration,
          opaque: false,
          pageBuilder: (BuildContext context, _, __) => page);
    } else {
      route = MaterialPageRoute(builder: (context) => page);
    }
    return await Navigator.pushReplacement(context, route).catchError((e) => debugPrint('Error push $e'));
  }

  static void pop(BuildContext context, [dynamic data]) {
    debugPrint('unfocus');
    FocusScope.of(context).unfocus();
    FocusScope.of(context).requestFocus(FocusNode());
    return Navigator.pop(context, data);
  }

  static Future<dynamic> pushSlideBottomAnim(BuildContext context, Widget page,
      {bool full = false, var first, var second}) async {
    debugPrint('unfocus');
    FocusScope.of(context).unfocus();
    FocusScope.of(context).requestFocus(FocusNode());
    first ??= Curves.linear;
    second ??= Curves.linear;
    return await Navigator.push(
        context,
        PageRouteBuilder(
            barrierColor: Colors.black.withOpacity(0.5),
            barrierDismissible: true,
            transitionDuration: const Duration(milliseconds: 300),
            opaque: false,
            pageBuilder: (context, Animation<double> animation, Animation<double> secendAnimation) => page,
            transitionsBuilder:
                (context, Animation<double> animation, Animation<double> secendAnimation, Widget widget) {
              return SlideTransition(
                position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(CurvedAnimation(
                    curve: first, //Curves.easeOutBack
                    parent: animation,
                    reverseCurve: second)),
                child: widget,
              );
            })).catchError((e) => debugPrint('Error 1 $e'));
  }

  static Future<dynamic> replaceSlideBottomAnim(BuildContext context, Widget page,
      {bool full = false, var first, var second}) async {
    debugPrint('unfocus');
    FocusScope.of(context).unfocus();
    FocusScope.of(context).requestFocus(FocusNode());
    first ??= Curves.linear;
    second ??= Curves.linear;
    return await Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            barrierColor: Colors.black.withOpacity(0.5),
            barrierDismissible: true,
            transitionDuration: const Duration(milliseconds: 300),
            fullscreenDialog: full,
            opaque: false,
            pageBuilder: (context, Animation<double> animation, Animation<double> secendAnimation) => page,
            transitionsBuilder:
                (context, Animation<double> animation, Animation<double> secendAnimation, Widget widget) {
              return SlideTransition(
                position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(CurvedAnimation(
                    curve: first, //Curves.easeOutBack
                    parent: animation,
                    reverseCurve: second)),
                child: widget,
              );
            })).catchError((e) => debugPrint('Error 1 $e'));
  }

  static Future<dynamic> pushSlideAnim(BuildContext context, Widget page,
      {bool full = false, var first, var second}) async {
    debugPrint('unfocus');
    FocusScope.of(context).unfocus();
    FocusScope.of(context).requestFocus(FocusNode());
    // first ??= Curves.easeOutBack;
    // second ??= Curves.linear;
    first ??= Curves.linear;
    second ??= Curves.linear;
    return await Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 300),
            fullscreenDialog: full,
            opaque: true, //false
            pageBuilder: (context, Animation<double> animation, Animation<double> secendAnimation) {
              return page;
            },
            transitionsBuilder:
                (context, Animation<double> animation, Animation<double> secendAnimation, Widget widget) {
              return SlideTransition(
                position: Tween(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
                    curve: first, //Curves.easeOutBack
                    parent: animation,
                    reverseCurve: second)),
                child: widget,
              );
            })).catchError((e) => debugPrint('Error 1 $e'));
  }

  static Future<dynamic> replaceSlideAnim(BuildContext context, Widget page,
      {bool full = false, var first, var second}) async {
    debugPrint('unfocus');
    FocusScope.of(context).unfocus();
    FocusScope.of(context).requestFocus(FocusNode());
    first ??= Curves.linear;
    second ??= Curves.linear;
    return await Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 300),
            fullscreenDialog: full,
            opaque: false,
            pageBuilder: (context, Animation<double> animation, Animation<double> secendAnimation) {
              return page;
            },
            transitionsBuilder:
                (context, Animation<double> animation, Animation<double> secendAnimation, Widget widget) {
              return SlideTransition(
                position: Tween(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
                    curve: first, //Curves.easeOutBack
                    parent: animation,
                    reverseCurve: second)),
                child: widget,
              );
            })).catchError((e) => debugPrint('Error 1 $e'));
  }

  static void popUntil(context, String rout) {
    debugPrint('unfocus');
    FocusScope.of(context).unfocus();
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.of(context).popUntil(ModalRoute.withName(rout));
  }

  static void popUntilClass(context, Widget page) {
    debugPrint('unfocus');
    FocusScope.of(context).unfocus();
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => page), (route) => false);
  }
}