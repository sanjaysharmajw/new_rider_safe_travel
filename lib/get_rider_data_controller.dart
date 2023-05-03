import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';

import 'LoginModule/Api_Url.dart';
import 'get_ride_data_models.dart';
import 'get_ride_request_body.dart';

class GetRideDetailsController extends GetxController{

  Future<GetRideDataModels?> getRideDataApi(GetRideRequestBody requestBody) async {
    try {
      LoaderUtils.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.getRideDetails),
        headers: ApiUrl.headerToken, body: jsonEncode(requestBody),
      );
      debugPrint("rideDataDetails");
      debugPrint(jsonEncode(requestBody));
      debugPrint(response.body);
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        LoaderUtils.closeLoader();
        return GetRideDataModels.fromJson(responseBody);
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