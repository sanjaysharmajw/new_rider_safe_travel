

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';

import '../Models/RideDataModel.dart';
import 'new_my_rider_model.dart';


class MyRiderController extends GetxController{
  var isLoading = true.obs;
  var getMyRiderData = <DataMyRider>[].obs;
  @override
  // void onInit() {
  //   getServiceList(Preferences.getId(Preferences.id).toString());
  //   super.onInit();
  // }

  Future<dynamic> getServiceList(String userId) async {
    try {
      final response = await http.post(Uri.parse(ApiUrl.getMyTripApi),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "user_id":userId,
          "status":'Active'
        }),
      );
      log('ndkdkmdk');
      log(response.body);
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        isLoading.value = false;
        NewMyRiderModel model = NewMyRiderModel.fromJson(responseBody);
        getMyRiderData.value = model.data!;
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