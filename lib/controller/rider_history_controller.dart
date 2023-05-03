import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';

import '../LoginModule/preferences.dart';
import '../Models/RideDataModel.dart';
import '../Models/RidesModel.dart';
import '../Models/rider_history_model.dart';

class RiderHistoryListController extends GetxController{

  var isLoading = true.obs;
  var getRiderHistoryData = <RiderHistoryData>[].obs;
  @override
  void onInit() {
    rideFun();
    super.onInit();
  }
  void rideFun()async{
    await Preferences.setPreferences();
    String? userId=Preferences.getId(Preferences.id).toString();
    String? userType=Preferences.getUserType(Preferences.userType).toString();
    getRiderHistoryList(userId,userType);
    print('UserIdd: $userId');
    print('UserType: $userType');
  }

  Future<dynamic> getRiderHistoryList(String userId,String userType) async {
    try {
      //DriverCustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.getMyTripApi),
        headers: ApiUrl.headerToken,
        body: jsonEncode({
          "user_id":userId,
          //"user_type":userType,
        }),
      );
      print( jsonEncode({
        "user_id_ride":userId,
        "user_type":userType,
      }));
      debugPrint("riderHistory");
      debugPrint(response.body);
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        isLoading.value = false;
        //DriverCustomLoader.closeLoader();
        RiderHistoryModel model = RiderHistoryModel.fromJson(responseBody);
        getRiderHistoryData.value = model.data!;
      }
    } on TimeoutException catch (e) {
      isLoading.value = false;
      LoaderUtils
          .showToast(e.message.toString());
    } on SocketException catch (e) {
      isLoading.value = false;
      LoaderUtils.showToast(e.message.toString());
    } on Error catch (e) {
      isLoading.value = false;
      LoaderUtils.showToast(e.toString());
    } catch (e) {
      //DriverCustomLoader.closeLoader();
      LoaderUtils.showToast(e.toString());
    }
    return null;
  }

}