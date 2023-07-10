import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/Models/get_ride_data_live.dart';
import 'package:http/http.dart'as http;
import 'package:ride_safe_travel/body_request/get_ride_live_request.dart';
import 'package:ride_safe_travel/controller/header_controller.dart';
import '../Utils/loader.dart';

class GetRideDataLiveController extends GetxController{

  HeaderController header=Get.find();
  Future<GetRideDataLive?> getRideLiveData(GetRideLiveRequest request) async {
    try {
      LoaderUtils.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.rideDataLive),
        body: jsonEncode(request),
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      debugPrint('responseBody.toString()');
      debugPrint(responseBody.toString());
      if (response.statusCode == 200) {
        LoaderUtils.closeLoader();
        return GetRideDataLive.fromJson(responseBody);
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