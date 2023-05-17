import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';

import '../LoginModule/Api_Url.dart';
import '../Models/SessionAttendResponseModel.dart';

class AttendSessionController extends GetxController {

  Future<SessionAttendResponseModel?> attendSession(String userId, String videoId) async {
    try {
      LoaderUtils.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.videoAttend),
        headers: ApiUrl.headerToken, body: jsonEncode(<String, dynamic>{
          "user_id": userId,
          "video_id": videoId,
        }),
      );

      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        LoaderUtils.closeLoader();
        return SessionAttendResponseModel.fromJson(responseBody);
      }
    } on TimeoutException catch (e) {
      LoaderUtils.closeLoader();
      LoaderUtils.showToast(e.message.toString());
    } catch (e) {
      LoaderUtils.closeLoader();
      LoaderUtils.showToast(e.toString());
    }
    return null;
  }

}
