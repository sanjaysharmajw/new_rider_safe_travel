import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import '../LoginModule/preferences.dart';
import '../SearchServicesModel.dart';

class ServiceListController extends GetxController{
  var isLoading = true.obs;
  var servicesList = <ServiceListData>[].obs;


  Future<dynamic> getServicesList(String serviceId) async {
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    try {
      final response = await http.post(
          Uri.parse("https://i981xwdx4g.execute-api.ap-south-1.amazonaws.com/dev/api/serviceProvider/searchServiceProvider"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': loginToken
          },
          body: jsonEncode({
            "service_id": serviceId,
            "lng": 72.998993,
            "lat":19.077065

          }));
      print(

        'Authorization...'+loginToken
      );
      log(response.body);
      Map<String, dynamic> responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        isLoading.value = false;
        SearchServicesModel model = SearchServicesModel.fromJson(responseBody);
        if (model.status == true) {
          servicesList.value = model.data!;
        }
        else {
          servicesList.value = [];
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