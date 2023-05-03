
import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import '../Error.dart';
import '../LoginModule/Api_Url.dart';
import '../LoginModule/preferences.dart';
import '../LoginModule/riderNewRegisterLoginModel.dart';
import '../Models/count_notification_model.dart';
import '../Utils/Loader.dart';

class GetNotificationController extends GetxController{



  Future<CountNotificationModel?> getCount() async {
    String mobileNumber = Preferences.getMobileNumber(Preferences.mobileNumber);
    String  userId = Preferences.getId(Preferences.id);
    try{
      final response = await http.post(
        Uri.parse(ApiUrl.countNotification),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',

        },
        body: jsonEncode(<String, dynamic>{
          "mobile_number": mobileNumber,
          "count":false,
          "unread":false,
          "user_id":userId
        }),
      );
      print(jsonEncode(<String, dynamic>{
        "mobile_number": mobileNumber,
        "count":false,
        "unread":false,
        "user_id":userId
      }),);
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        //LoaderUtils.closeLoader();
        return CountNotificationModel.fromJson(responseBody);
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