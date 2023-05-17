
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';
import '../LoginModule/preferences.dart';
import '../Models/user_details_models.dart';
import '../Models/user_details_request_body.dart';


class UserDetailsController extends GetxController{

  var isLoading = true.obs;
  var getUserDetailsData = <UserDetailsData>[].obs;




  Future<dynamic> updateProfile() async {
    await Preferences.setPreferences();
    String mobileNo=Preferences.getMobileNumber(Preferences.mobileNumber).toString();
    UserDetailsRequestBody requestBody=UserDetailsRequestBody(
        mobileNumber: mobileNo
    );




    try {
      final response = await http.post(Uri.parse(ApiUrl.userDetails),
        headers: ApiUrl.headerToken,
        body: jsonEncode(requestBody),
      );
      debugPrint('userdetailsListApi');
      debugPrint(jsonEncode(requestBody));
      debugPrint(response.body);

      //var volStatus = Preferences.getVolStatus().toString();
     // debugPrint('volStatus $volStatus');

      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        isLoading.value = false;
        UserDetailsModels model = UserDetailsModels.fromJson(responseBody);
        getUserDetailsData.value = model.data!;
      }
    } on TimeoutException catch (e) {
      isLoading.value = false;
      LoaderUtils.showToast(e.message.toString());
    } on SocketException catch (e) {
      isLoading.value = false;
      LoaderUtils.showToast(e.message.toString());
    } on Error catch (e) {
      isLoading.value = false;
      LoaderUtils.showToast(e.toString());
    } catch (e) {
      LoaderUtils.closeLoader();
      LoaderUtils.showToast(e.toString());
    }
    return null;
  }
}