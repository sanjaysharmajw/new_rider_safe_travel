import 'dart:async';
import 'dart:convert';



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_loading_progress/overlay_loading_progress.dart';

import '../Error.dart';
import '../LoginModule/Api_Url.dart';
import '../LoginModule/preferences.dart';
import '../Utils/toast.dart';
import '../home_page_models/Sos_controller_model.dart';

class SOSController extends GetxController{


  Future<SosControllerModel?> SOSNotification(String reason, String riderId, String latitude, String longitude) async {
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    var userId = Preferences.getId(Preferences.id);
    final response = await http.post(Uri.parse(ApiUrl.SOS_Push_Notification),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': loginToken
        },
        body: json.encode({
          'reason': reason,
          'user_id': userId,
          'ride_id': riderId,
          "lat": latitude,
          "lng": longitude,
          "timestamp": DateTime.now().millisecondsSinceEpoch
        }));
    print(json.encode({
      'reason': reason,
      'user_id': userId,
      'ride_id': riderId,
      "lat": latitude,
      "lng": longitude,
      "timestamp": DateTime.now().millisecondsSinceEpoch
    }));
    Map<String, dynamic> responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      if (status == true) {
        OverlayLoadingProgress.stop();
        ToastMessage.toast(msg.toString());
        Get.back();
        return SosControllerModel.fromJson(responseBody);
        //stopAlertValue="Yes";
      } else {
        OverlayLoadingProgress.stop();
        ToastMessage.toast(msg.toString());
      }
      return null;
    } else {
      throw Exception('Failed');
    }
  }



  Future<void> sosHelpAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Text('do_you_received_help?'.tr),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:  Text('no'.tr),
              onPressed: () {
                Navigator.pop(context, true);
                //Sos_status="No";
              },
            ),
            TextButton(
              child:  Text('yes'.tr),
              onPressed: () {
                Navigator.pop(context, true);
                //Sos_status="Yes";

                  //timers?.cancel();

              },
            ),
          ],
        );
      },
    );
  }

}