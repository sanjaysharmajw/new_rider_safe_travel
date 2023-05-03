

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';

import '../LoginModule/preferences.dart';
import 'get_service_ride_details_models.dart';


class GetServiceDetailsController extends GetxController{
  Future<GetServiceRideDetailsModels?> getServiceRideDetails(String serviceId) async {
    try {
      LoaderUtils.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.getServiceDetails),
        headers: ApiUrl.headerToken, body: jsonEncode(<String, String>{
          'service_id': serviceId,
          'user_id': Preferences.getId(Preferences.id).toString()
        }),
      );
      debugPrint(jsonEncode(<String, String>{
        'service_id': serviceId,
        'user_id': Preferences.getId(Preferences.id).toString()
      }));
      debugPrint(response.body);
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        LoaderUtils.closeLoader();
        return GetServiceRideDetailsModels.fromJson(responseBody);
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