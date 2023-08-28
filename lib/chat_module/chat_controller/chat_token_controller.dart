import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/chat_module/models/chat_token_model.dart';
import 'package:ride_safe_travel/chat_module/models/get_token_request_body.dart';
import 'package:ride_safe_travel/utils/CustomLoader.dart';

class ChatTokenController extends GetxController{
  Future<ChatTokenModel?> chatTokenApi(GetTokenRequestBody requestBody) async {
    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse('http://65.1.73.254:3700'),  //http://65.1.73.254:3700
        headers: ApiUrl.authHeader, body: jsonEncode(requestBody),
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      debugPrint('chatApiToken');
      debugPrint(responseBody.toString());
      debugPrint(jsonEncode(requestBody));
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        return ChatTokenModel.fromJson(responseBody);
      }
    } on TimeoutException catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.message.toString());
    }  catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.toString());
    }
    return null;
  }
}