import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart'as http;
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';

import 'Models/MemberBlockDeleteModel.dart';


class UserStatusController extends GetxController{



  Future<dynamic> getUserStatus(int indeex, String userId,String memberId, String status) async {
    try {
      LoaderUtils.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.userStatus),
        headers: ApiUrl.headerToken,
        body: jsonEncode({
          "user_id": userId.toString(),
          "member_id": memberId.toString(),
          "status": status.toString()
        }),
      );
      print(jsonEncode({
        "user_id": userId.toString(),
        "member_id": memberId.toString(),
        "status": status.toString()
      }),);
      Map<String, dynamic> responseBody = json.decode(response.body);
      debugPrint("userStatus: "+responseBody.toString());
      if (response.statusCode == 200) {
        LoaderUtils.closeLoader();
        return MemberBlockDeleteModel.fromJson(responseBody);
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