import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'color_constant.dart';

class SpinkitUtils{
   showToast(String? message, {EasyLoadingToastPosition position = EasyLoadingToastPosition.center}) {
    EasyLoading.showToast(message!, toastPosition: position);
  }

   showLoader(String message) {
    EasyLoading.show(status: message);
  }

  closeLoader() {
    EasyLoading.dismiss();
  }
   message(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
   Widget loader() {
    return Center(
        child: SpinKitThreeBounce(color: appBlue, size: 15,)
      // CircularProgressIndicator(color: Colors.yellow),
    );
  }

}