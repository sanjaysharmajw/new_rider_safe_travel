import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';

import '../Error.dart';
import '../LoginModule/preferences.dart';
import '../Utils/Loader.dart';
import '../Utils/toast.dart';
import '../bottom_nav/my_rider_controller.dart';
import '../controller/check_active_ride_models.dart';
import '../home_page_models/End_ride_model.dart';

class EndRideController extends GetxController{

  final listController = Get.put(MyRiderController());


  Future<EndRideModel?> endRide(String riderId, String lat, String lng) async {
    try {
      //LoaderUtils.showLoader("Please wait");
      final response = await http.post(Uri.parse('https://l8olgbtnbj.execute-api.ap-south-1.amazonaws.com/dev/api/userRide/endRide'),
        headers: ApiUrl.headerToken, body: jsonEncode(json.encode({
          'ride_id': riderId,
          'end_point': {
            'time': DateTime.now().millisecondsSinceEpoch.toString(),
            'latitude': lat.toString(),
            'longitude': lng.toString(),
            'location': ""
          }
        })),
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        LoaderUtils.closeLoader();
        return EndRideModel.fromJson(responseBody);
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

  // Future<http.Response> endRide(
  //     String riderId, String lat, String lng) async {
  //   var userId = Preferences.getId(Preferences.id);
  //
  //   final response = await http.post(
  //       Uri.parse(
  //           'https://l8olgbtnbj.execute-api.ap-south-1.amazonaws.com/dev/api/userRide/endRide'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: json.encode({
  //         'ride_id': riderId,
  //         'end_point': {
  //           'time': DateTime.now().millisecondsSinceEpoch.toString(),
  //           'latitude': lat.toString(),
  //           'longitude': lng.toString(),
  //           'location': ""
  //         }
  //       }));
  //   print("object");
  //   print(json.encode({
  //     'ride_id': riderId,
  //     'end_point': {
  //       'time': DateTime.now().millisecondsSinceEpoch.toString(),
  //       'latitude': lat.toString(),
  //       'longitude': lng.toString(),
  //       'location': ""
  //     }
  //   }));
  //   if (response.statusCode == 200) {
  //     bool status = jsonDecode(response.body)[ErrorMessage.status];
  //     var msg = jsonDecode(response.body)[ErrorMessage.message];
  //     print("response");
  //     print("$response");
  //     if (status == true) {
  //       LoaderUtils.closeLoader();
  //       print("END RIDE....."+msg);
  //       ToastMessage.toast(msg);
  //       floatingVisibility = true;
  //       dataVisibility = false;
  //
  //       Preferences.setRideOtp(''); //MainPage
  //       await listController.getServiceList(userId.toString());
  //
  //     } else {
  //       LoaderUtils.closeLoader();
  //       ToastMessage.toast(msg);
  //     }
  //     return response;
  //   } else {
  //     throw Exception('Failed');
  //   }
  // }


}