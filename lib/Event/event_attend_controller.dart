
import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:ride_safe_travel/Event/event_models/event_attend_models.dart';
import 'package:ride_safe_travel/Event/event_request/event_attend_req.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/Utils/CustomLoader.dart';

class EventAttendController extends GetxController{

  Future<EventAttendModels?> eventAttendApi(EventAttendReq eventAttendReq) async {
    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.eventAttend),
          headers: ApiUrl.headerToken, body: jsonEncode(eventAttendReq));
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        return EventAttendModels.fromJson(responseBody);
      }
    } on TimeoutException catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.message.toString());
    }  catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.toString());
    }
    return null;
  }

}