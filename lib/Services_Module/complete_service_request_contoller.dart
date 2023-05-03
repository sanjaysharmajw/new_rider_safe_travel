

import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';

import 'complete_service_request_body.dart';
import 'complete_service_request_model.dart';

class CompleteServiceRequestController extends GetxController{
  Future<CompleteServiceRequestModel?> completeServiceApi(CompleteServiceRequestBody requestBody) async {
    try {
      LoaderUtils.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.completeServiceRequest),
        headers: ApiUrl.headerToken, body: jsonEncode(requestBody),
      );
      debugPrint('feedback');
      debugPrint(jsonEncode(requestBody));
      debugPrint(response.body);
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        LoaderUtils.closeLoader();
        return CompleteServiceRequestModel.fromJson(responseBody);
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