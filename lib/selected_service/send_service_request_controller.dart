

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:ride_safe_travel/Utils/Loader.dart';
import 'package:ride_safe_travel/selected_service/send_service_request_body.dart';
import 'package:ride_safe_travel/selected_service/send_service_request_models.dart';

import '../LoginModule/Api_Url.dart';

class SendServiceRequestController extends GetxController{
  Future<SendServiceRequestModels?> sendServiceRequestApi(SendServiceRequestBody sendServiceRequestBody) async {
    try {
      LoaderUtils.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.sendServiceRequest),
        headers: ApiUrl.headerToken, body: jsonEncode(sendServiceRequestBody),
      );

      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        LoaderUtils.closeLoader();
        return SendServiceRequestModels.fromJson(responseBody);
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