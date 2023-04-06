import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:http/http.dart' as http;
import '../LoginModule/preferences.dart';
import '../SearchServicesModel.dart';
import '../ServiceTypeModel.dart';

class ServiceTypeController extends GetxController{
  var isLoading = true.obs;
  var serviceTypeList = <ServiceTypeData>[].obs;
  @override
  void onInit() {
    getServiceType();
    super.onInit();
  }

  Future<dynamic> getServiceType() async {
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    try {
      final response = await http.post(
          Uri.parse(ApiUrl.getserviceType),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': loginToken
          },
          body: jsonEncode({
            "status": "Active"

          }));
      log(response.body);
      Map<String, dynamic> responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        isLoading.value = false;
        ServiceTypeModel model = ServiceTypeModel.fromJson(responseBody);
        serviceTypeList.value = model.data!;

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