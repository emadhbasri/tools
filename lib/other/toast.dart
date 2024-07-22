
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
toast(String str, context,{bool isLong=false}) {
  // if(isdesktop()){
  ToastContext tt =ToastContext();
  tt.init(context);
  Toast.show(str,
    gravity: Toast.bottom,
    duration: isLong?Toast.lengthLong:Toast.lengthShort,
    backgroundColor: Colors.black,
    textStyle:  const TextStyle(color: Colors.white),
    backgroundRadius: 10,);
  // }else{
  //   Fluttertoast.showToast(
  //       msg: str,
  //       toastLength: isLong?Toast.LENGTH_SHORT:Toast.LENGTH_LONG,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: black1,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }
}

// 5022 2919 0005 5631