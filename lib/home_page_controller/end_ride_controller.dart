import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';

import '../Error.dart';
import '../LoginModule/preferences.dart';
import '../Utils/Loader.dart';
import '../Utils/toast.dart';
import '../bottom_nav/my_rider_controller.dart';
import '../controller/check_active_ride_models.dart';
import '../home_page_models/End_ride_model.dart';

class EndRideController extends GetxController{

  Future<EndRideModel?> endRide(String riderId, String lat, String lng) async {
    try {
      LoaderUtils.showLoader("Please wait");
      final response = await http.post(Uri.parse(
          ApiUrl.endRide),
        headers: ApiUrl.headerToken, body: jsonEncode(
            {
          'ride_id': riderId,
          'end_point': {
            'time': DateTime.now().millisecondsSinceEpoch.toString(),
            'latitude': lat.toString(),
            'longitude': lng.toString(),
            'location': ""
          }
        }

        ),
      );
      debugPrint("endRide");
      debugPrint(response.body);
      debugPrint("bodyResponse");
      debugPrint(
          json.encode({
        'ride_id': riderId,
        'end_point': {
          'time': DateTime.now().millisecondsSinceEpoch.toString(),
          'latitude': lat.toString(),
          'longitude': lng.toString(),
          'location': ""
        }
      })
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        LoaderUtils.closeLoader();
        return EndRideModel.fromJson(responseBody);
      }
    } on TimeoutException catch (e) {
      LoaderUtils.closeLoader();
      LoaderUtils.showToast(e.message.toString());
    }  catch (e) {
      LoaderUtils.closeLoader();
      LoaderUtils.showToast(e.toString());
    }
    return null;
  }




}