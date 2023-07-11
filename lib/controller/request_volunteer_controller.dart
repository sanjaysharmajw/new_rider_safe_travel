
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/controller/permision_controller.dart';
import 'package:http/http.dart' as http;
import '../LoginModule/preferences.dart';
import '../Models/GetVolunteerRequestBody.dart';
import '../Models/StatusUpdateVolunteerModels.dart';
import '../Models/VolunteerData.dart';
import '../Models/VolunteerStatusRequestBody.dart';
import '../Utils/CustomLoader.dart';
import 'header_controller.dart';

class RequestVolunteerController extends GetxController{

  var isLoading = true.obs;
  var getRequestVolunteerData = <VolunteerData>[].obs;
  final headerController = Get.put(HeaderController());
  final locationController = Get.put(PermissionController());

  Future<dynamic> requestVolunteerApi(String status,double lat,double lng) async {
    GetVolunteerRequestBody volunteerRequestBody=GetVolunteerRequestBody(
      userId: Preferences.getId(Preferences.id).toString(),
      status: status.toString(),
      lat: lat.toString(),
      lng: lng.toString(),
    );
    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.getVolunteerRequests),
        headers: headerController.headerToken,
        body: jsonEncode(volunteerRequestBody),
      );
      debugPrint('Volunteer');
      debugPrint(jsonEncode(volunteerRequestBody));
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      // Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        isLoading.value = false;
        CustomLoader.closeLoader();
        GetVolunteerModels model = GetVolunteerModels.fromJson(responseBody);
        getRequestVolunteerData.value = model.data!;
      }
    } on TimeoutException catch (e) {
      isLoading.value = false;
      CustomLoader.showToast(e.message.toString());
    } on SocketException catch (e) {
      isLoading.value = false;
      CustomLoader.showToast(e.message.toString());
    } on Error catch (e) {
      isLoading.value = false;
      CustomLoader.showToast(e.toString());
    } catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.toString());
    }
    return null;
  }


  Future<StatusUpdateVolunteerModels?> volunteerStatusUpdate(VolunteerStatusRequestBody requestBody) async {
    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.updateVolunteerRequest),
        headers: headerController.headerToken,
        body: jsonEncode(requestBody),
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        return StatusUpdateVolunteerModels.fromJson(responseBody);
      }
    }
    on TimeoutException catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.message.toString());
    }  catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.toString());
    }
    return null;
  }

}