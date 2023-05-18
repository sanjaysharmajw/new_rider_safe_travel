
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/Models/family_list_ride_request.dart';
import 'package:ride_safe_travel/Models/family_member_ride_list_model.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';
import 'package:ride_safe_travel/controller/header_controller.dart';
import 'package:http/http.dart'as http;
import '../LoginModule/Api_Url.dart';

class FamilyRideController extends GetxController{
  final header=Get.put(HeaderController());
  var isLoading = true.obs;
  var getFamilyRideListData = <FamilyData>[].obs;

  Future<dynamic> familyRideListApi(FamilyListRideRequest request) async {
    try {
      //DriverCustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.familymemberRideList),
        headers: header.headerToken,
        body: jsonEncode(request),
      );
      debugPrint('Damily');
      debugPrint(response.body);
      debugPrint( jsonEncode(request));
      debugPrint('Damily');
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        isLoading.value = false;
        //DriverCustomLoader.closeLoader();
        FamilyMemberRideListModel model = FamilyMemberRideListModel.fromJson(responseBody);
        getFamilyRideListData.value = model.data!;
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
     // LoaderUtils.closeLoader();
      LoaderUtils.showToast(e.toString());
    }
    return null;
  }
}