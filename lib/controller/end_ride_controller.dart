
import 'dart:async';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';

import '../Error.dart';
import '../LoginModule/Api_Url.dart';
import '../LoginModule/preferences.dart';
import '../LoginModule/riderNewRegisterLoginModel.dart';
import '../Utils/toast.dart';
import '../bottom_nav/custom_bottom_navi.dart';

class CheckUserController extends GetxController{

  Future<RiderNewRegisterLoginModel?> checkActiveUser(String? userId) async {
    LoaderUtils.showLoader('Please wait...');

    try{
      final response = await http.post(
        Uri.parse(ApiUrl.checkActiveUserRide),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': userId!.toString(),
        }),
      );
      if (response.statusCode == 200) {
        bool status = jsonDecode(response.body)[ErrorMessage.status];
        String socketToken = jsonDecode(response.body)['token'];
        Map<String, dynamic> responseBody = json.decode(response.body);
        if (socketToken !="") {
          return RiderNewRegisterLoginModel.fromJson(responseBody);
        }
      }
    }
    on TimeoutException catch (e) {
      LoaderUtils.showToast(e.message.toString());
    }  catch (e) {
      LoaderUtils.showToast(e.toString());
    }
    return null;
  }



}