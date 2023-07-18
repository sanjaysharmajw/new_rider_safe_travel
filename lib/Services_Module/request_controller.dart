import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/Utils/toast.dart';

import '../Error.dart';
import 'Service_request_model.dart';

class ServiceRequestController extends GetxController{

  final commentTextField=TextEditingController().obs;
  Future<ServiceRequestModel?> sendRequest(String serviceId, String id, String serviceProviderId,
      double lng, double lat, String comment) async {
    var userId=Preferences.getId(Preferences.id);
    try {
      LoaderUtils.showLoader('Please Wait...');
      final response = await http.post(
          Uri.parse(ApiUrl.sendServiceRequest),
          headers: ApiUrl.headerToken,
          body: jsonEncode({
            "service_id":serviceId,
            "id":id,
            "comment":comment,
            "service_provider_id":serviceProviderId,
            "lng":lng,
            "lat":lat,
            "user_id":userId

          }));
      print(
          "sendServiceRequest"+jsonEncode({
            "service_id":serviceId,
            "id":id,
            "comment":comment,
            "service_provider_id":serviceProviderId,
            "lng":lng,
            "lat":lat,
            "user_id":userId

          })
      );

      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      print("sendrequest"+responseBody.toString());
      if (response.statusCode == 200) {
        print(responseBody);
        LoaderUtils.closeLoader();
        return ServiceRequestModel.fromJson(responseBody);
      }

    } on TimeoutException catch (e) {
      debugPrint(e.message.toString());
      LoaderUtils.closeLoader();
       LoaderUtils.showToast(e.message.toString());
    } on SocketException catch (e) {
      debugPrint(e.message.toString());
      LoaderUtils.closeLoader();
       LoaderUtils.showToast(e.message.toString());
    } on Error catch (e) {
      debugPrint(e.toString());
      LoaderUtils.closeLoader();
       LoaderUtils.showToast(e.toString());
    } catch (e) {
      debugPrint(e.toString());
       LoaderUtils.closeLoader();
       LoaderUtils.showToast(e.toString());
    }
    return null;
  }

}