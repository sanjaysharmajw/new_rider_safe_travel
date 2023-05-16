
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/Models/start_ride_details.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';
import 'package:http/http.dart'as http;
import 'package:ride_safe_travel/body_request/start_ride_request.dart';
import 'package:ride_safe_travel/controller/header_controller.dart';
import 'package:ride_safe_travel/controller/location_controller.dart';

class RideStartWithVehicleNoController extends GetxController{


  final header=Get.put(HeaderController());


  Future<StartRideDetails?> startRideWithVehicleId(StartRideRequestForVehicle requestForVehicle) async {
    try {
      LoaderUtils.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.startRideWithVehicle),
        headers: header.headerToken,
        body: jsonEncode(requestForVehicle),
      );
      debugPrint("vehicleNo");
      debugPrint(jsonEncode(requestForVehicle));
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        LoaderUtils.closeLoader();
        return StartRideDetails.fromJson(responseBody);
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