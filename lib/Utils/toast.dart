import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
class ToastMessage{
  static toast(String msg)  {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: CustomColor.yellow,
        textColor: Colors.black,
        fontSize: 16.0
    );
  }
}
