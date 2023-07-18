import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';

import '../FamilyMemberDataModel.dart';
import '../FamilyMemberModel.dart';
import 'LoginModule/Api_Url.dart';
import 'LoginModule/RiderLoginPage.dart';



class FamilyListController extends GetxController{
  var isLoading = true.obs;
  var getFamilyListData = <FamilyMemberDataModel>[].obs;

  Future<dynamic> familyListApi(String userId) async {
    try {
      LoaderUtils.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.myFamilyList),
        headers: ApiUrl.headerToken,
        body: jsonEncode(<String, String>{
          "user_id": userId
        }),
      );
      print( jsonEncode(<String, String>{
        "user_id": userId
      }),);
      log(response.body);

      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        print("responseBody");
        print(responseBody);
        isLoading.value = false;
        LoaderUtils.closeLoader();
        FamilyMemberModel model = FamilyMemberModel.fromJson(responseBody);
        getFamilyListData.value = model.data!;
      }else{
        Get.to(RiderLoginPage());
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