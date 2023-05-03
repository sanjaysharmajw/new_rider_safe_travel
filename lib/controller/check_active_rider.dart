import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:http/http.dart'as http;
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';

import '../LoginModule/Api_Url.dart';
import 'checkActiveRideRequest.dart';
import 'check_active_ride_models.dart';

class CheckActiveRideController extends GetxController{

  Future<CheckActiveRideModels?> checkActiveRideApi(CheckActiveRideRequest checkActiveRideRequest) async {
    try {
      //LoaderUtils.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.checkActiveUserRide),
          headers: ApiUrl.headerToken, body: jsonEncode(checkActiveRideRequest),
      );
      debugPrint('response.body');
      debugPrint(response.body);
      debugPrint(jsonEncode(checkActiveRideRequest));
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        LoaderUtils.closeLoader();
        return CheckActiveRideModels.fromJson(responseBody);
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