
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';
import 'package:http/http.dart'as http;

import 'add_co_passanger/add_co_passanger_models.dart';
import 'add_co_passanger/add_co_passanger_request.dart';

class AddCoPassangerController extends GetxController{

  Future<AddCoPassangerModels?> addCoPassangerApi(AddCoPassangerRequest request) async {
    try {
      LoaderUtils.showLoader("Please wait");
      final response = await http.post(Uri.parse(
          "https://tzlcfuw04d.execute-api.ap-south-1.amazonaws.com/dev/api/userRide/coPassengerAdd"),
        headers: ApiUrl.headerToken, body: jsonEncode(request),
      );
      debugPrint('Add Passanger');
      debugPrint(jsonEncode(request));
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        LoaderUtils.closeLoader();
        return AddCoPassangerModels.fromJson(responseBody);
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