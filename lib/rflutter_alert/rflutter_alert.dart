library rflutter_alert;

import 'package:flutter/material.dart';
import 'package:tools/colors.dart';
import 'package:tools/navigator.dart';
import 'package:tools/size.dart';
import 'package:tools/size_plus.dart';
import 'package:tools/text.dart';

import 'rflutter_alert.dart';
export 'src/alert.dart';
export 'src/alert_style.dart';
export 'src/constants.dart';
export 'src/dialog_button.dart';

myAlertDialog(context,
    {AlertType type = AlertType.warning,
    String title = 'هشدار',
    String? content,
    Color yesColor = green,
    Color noColor = pink,
    required String yes,
    required String? no}) async {
  return await Alert(
    context: context,
    type: type,
    title: title,
    desc: content,
    padding: EdgeInsets.symmetric(horizontal: 4.w).copyWith(top: 3.h),
    style: AlertStyle(
        animationType: AnimationType.grow,
        isCloseButton: false,
        overlayColor: Colors.black.withOpacity(0.5)),
    buttons: [
      if (no != null)
        DialogButton(
          onPressed: () => Go.pop(context, false),
          color: noColor,
          child: Text(no,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        ),
      DialogButton(
          onPressed: () {
            Go.pop(context, true);
          },
          color: yesColor,
          child: Text(
            yes,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ))
    ],
  ).show();
}




// Alert(
//                       context: context,
//                       type: AlertType.warning,
//                       title: 'هشدار',
//                       desc: 'آیا می خواهید کاربر را حذف کنید؟',
//                       padding: EdgeInsets.symmetric(horizontal: doubleWidth(4))
//                           .copyWith(top: doubleHeight(3)),
//                       style: AlertStyle(
//                           animationType: AnimationType.grow,
//                           isCloseButton: false,
//                           overlayColor: Colors.black.withOpacity(0.5)),
//                       buttons: [
//                         DialogButton(
//                           onPressed: () {},
//                           color: pink,
//                           child: Text('انصراف', style: toolstitleStyle(color: black1)),
//                         ),
//                         DialogButton(
//                           onPressed: () async {
//                             bool back = await Services.auserdelete(context, phone: item.phone);
//                             if (back) {
//                               toast('کاربر با موفقیت حذف شد', context, isLong: true);
//                               getData(context);
//                             } else {
//                               showError(context);
//                             }
//                           },
//                           color: green,
//                           child: Text('حذف', style: toolstitleStyle(color: black1)),
//                         )
//                       ],
//                     ).show();