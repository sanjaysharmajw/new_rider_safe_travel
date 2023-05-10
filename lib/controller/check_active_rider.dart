import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:http/http.dart'as http;
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';

import '../LoginModule/Api_Url.dart';
import 'checkActiveRideRequest.dart';
import 'check_active_ride_models.dart';

class CheckActiveRideController extends GetxController{
  var getCheckRideData = <CheckData>[].obs;
  var isLoading = true.obs;
  var getToken="".obs;

  @override
  void onInit() {
    super.onInit();
    checkActiveRideApi();
  }

  Future<dynamic> checkActiveRideApi() async {
    try {
      LoaderUtils.showLoader("Please wait");
      CheckActiveRideRequest checkActiveRideRequest = CheckActiveRideRequest(userId: Preferences.getId(Preferences.id).toString());
      final response = await http.post(Uri.parse(ApiUrl.checkActiveUserRide),
          headers: ApiUrl.headerToken, body: jsonEncode(checkActiveRideRequest),
      );
      debugPrint('check_response.body');
      debugPrint(response.body);
      debugPrint(jsonEncode(checkActiveRideRequest));

      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        isLoading.value = false;
        LoaderUtils.closeLoader();
        CheckActiveRideModels model = CheckActiveRideModels.fromJson(responseBody);
        getCheckRideData.value = model.data!;
        getToken.value = model.token!;
      }
    }  on TimeoutException catch (e) {
      isLoading.value = false;
      LoaderUtils.showToast(e.message.toString());
    } on SocketException catch (e) {
      isLoading.value = false;
      LoaderUtils.showToast(e.message.toString());
    } on Error catch (e) {
      isLoading.value = false;
      LoaderUtils.showToast(e.toString());
    } catch (e) {
      isLoading.value = false;
      LoaderUtils.closeLoader();
      LoaderUtils.showToast(e.toString());
    }
    return null;
  }
}