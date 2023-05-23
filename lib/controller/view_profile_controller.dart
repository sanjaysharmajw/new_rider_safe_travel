import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';


import '../../Models/user_details_models.dart';
import '../LoginModule/preferences.dart';


import '../RiderUserListData.dart';
import '../riderData.dart';

class ViewProfileController extends GetxController{

  var isLoading = true.obs;
  var getViewProfileData = <RiderDetails>[].obs;

  @override
  void onInit() {
    viewProfileApi(Preferences.getMobileNumber(Preferences.mobileNumber).toString());
    super.onInit();
  }

  Future<dynamic> viewProfileApi(String mobileNumber) async {
    try {
      final response = await http.post(Uri.parse(ApiUrl.userDetails),
        headers: ApiUrl.headerToken,
        body: jsonEncode(<String, String>{
          "mobile_number": Preferences.getMobileNumber(Preferences.mobileNumber).toString(),
          "user_type" : "Rider"
        }),
      );
     // interceptorResponse(APIConstant.checkActiveRide, jsonEncode(<String, String>{"mobile_number": mobileNumber}));
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      debugPrint(decodedBytes);
      debugPrint('logsssssss');
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        LoaderUtils.closeLoader();
        isLoading.value = false;
        RiderUserListData model = RiderUserListData.fromJson(responseBody);
        getViewProfileData.value = model.data!;
      }
    } on TimeoutException catch (e) {
      isLoading.value = false;
      LoaderUtils.showToast(e.message.toString());
      LoaderUtils.closeLoader();
    } on SocketException catch (e) {
      isLoading.value = false;
      LoaderUtils.showToast(e.message.toString());
    } on Error catch (e) {
      isLoading.value = false;
      LoaderUtils.closeLoader();
      LoaderUtils.showToast(e.toString());
    } catch (e) {
      LoaderUtils.closeLoader();
      LoaderUtils.showToast(e.toString());
    }
    return null;
  }

}