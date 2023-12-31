import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';

import '../LoginModule/preferences.dart';
import 'RequestedListModel.dart';
import 'Requested_servicelist_model.dart';

class ServiceRequestListController extends GetxController{
  var isLoading = true.obs;
  var requestedList = <requestedListData>[].obs;
 /* @override
  void onInit() {
    getRequestedServicesList(lng, lat)
    super.onInit();
  }*/

  Future<dynamic> getRequestedServicesList(double lng, double lat,) async {
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    var userId = Preferences.getId(Preferences.id);
    print("USERID...."+userId.toString());
    try {
      final response = await http.post(
          Uri.parse(ApiUrl.serviceRequestList),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': loginToken
          },
          body: jsonEncode({
            "user_id":userId,
            "lng":lng,
            "lat":lat

          }));
      print(
          jsonEncode({
            "user_id":userId,
            "lng":lng,
            "lat":lat

          })
      );
      log(response.body);
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);

      if (response.statusCode == 200) {
        isLoading.value = false;
        RequestedListModel model = RequestedListModel.fromJson(responseBody);
        if (model.status == true) {
          requestedList.value = model.data!;
        }
        else {
          requestedList.value = [];
        }

      }

    } on TimeoutException catch (e) {
      isLoading.value = false;
      // CustomLoader.showToast(e.message.toString());
    } on SocketException catch (e) {
      isLoading.value = false;
      // CustomLoader.showToast(e.message.toString());
    } on Error catch (e) {
      isLoading.value = false;
      // CustomLoader.showToast(e.toString());
    } catch (e) {
      // CustomLoader.closeLoader();
      // CustomLoader.showToast(e.toString());
    }
    return null;
  }

}