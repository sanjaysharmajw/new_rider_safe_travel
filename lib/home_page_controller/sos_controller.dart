import 'dart:async';
import 'dart:convert';



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';

import '../Error.dart';
import '../LoginModule/Api_Url.dart';
import '../LoginModule/preferences.dart';
import '../Utils/toast.dart';
import '../home_page_models/Sos_controller_model.dart';

class SOSController extends GetxController{


  Future<SosControllerModel?> SOSNotification(String reason, String riderId, String latitude, String longitude) async {
    try {
      LoaderUtils.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.SOS_Push_Notification),
        headers: ApiUrl.headerToken,
          body: json.encode({
            'reason': reason,
            'user_id': Preferences.getId(Preferences.id).toString(),
            'ride_id': riderId,
            "lat": latitude,
            "lng": longitude,
            "timestamp": DateTime.now().millisecondsSinceEpoch
          })
      );
      debugPrint("notifiaction");
      debugPrint(response.body);
      debugPrint("bodyResponse");
      debugPrint(json.encode({
        'reason': reason,
        'user_id': Preferences.getId(Preferences.id).toString(),
        'ride_id': riderId,
        "lat": latitude,
        "lng": longitude,
        "timestamp": DateTime.now().millisecondsSinceEpoch
      }));
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        LoaderUtils.closeLoader();
        return SosControllerModel.fromJson(responseBody);
      }
    }
    on TimeoutException catch (e) {
      LoaderUtils.closeLoader();
      LoaderUtils.showToast(e.message.toString());
    }  catch (e) {
      LoaderUtils.closeLoader();
      LoaderUtils.showToast(e.toString());
    }
    return null;
  }

}