import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'LoginModule/preferences.dart';
import 'SearchServicesModel.dart';


class DemoController extends GetxController{
  var isLoading = true.obs;
  var serviceDatalist = <ServiceListData>[].obs;
  @override
  void onInit() {
    getDemoData('');
    super.onInit();
  }

  Future<dynamic> getDemoData(String serviceId) async {
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    try {
      final response = await http.post(
        Uri.parse("https://i981xwdx4g.execute-api.ap-south-1.amazonaws.com/dev/api/serviceProvider/searchServiceProvider"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2Nzg1MjAyNzgsImRhdGEiOnsiX2lkIjoiNjM4NmY4M2JhMmQ4MDA3NGNiY2ZiOTAzIn0sImlhdCI6MTY3ODQzMzg3OH0.FDjIHEWjhmNNbTE4B-ERGQd_xsbrMVjS7ve8eIxuGzM'
          },
        body: jsonEncode({
          "service_id": serviceId,
          "lng": 72.998993,
          "lat":19.077065
        }));
      log(response.body);
      Map<String, dynamic> responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        isLoading.value = false;
        SearchServicesModel model = SearchServicesModel.fromJson(responseBody);
        serviceDatalist.value = model.data!;

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