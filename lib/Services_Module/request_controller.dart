import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/Utils/toast.dart';

import '../Error.dart';
import 'Service_request_model.dart';

class ServiceRequestController extends GetxController{

  final commentTextField=TextEditingController().obs;
  Future<ServiceRequestModel?> sendRequest(String serviceId, String id, String serviceProviderId,
      double lng, double lat, String userId) async {
    try {
      LoaderUtils.showLoader('Please Wait...');
      final response = await http.post(
          Uri.parse("https://i981xwdx4g.execute-api.ap-south-1.amazonaws.com/dev/api/serviceProvider/sendServiceRequest"),
          headers: ApiUrl.headerToken,
          body: jsonEncode({
            "service_id":serviceId,
            "id":id,
            "comment":commentTextField.value.text,
            "service_provider_id":serviceProviderId,
            "lng":lng,
            "lat":lat,
            "user_id":userId

          }));
      print(
          jsonEncode({
            "service_id":serviceId,
            "id":id,
            "comment":commentTextField.value.text,
            "service_provider_id":serviceProviderId,
            "lng":lng,
            "lat":lat,
            "user_id":userId

          })
      );

      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        LoaderUtils.closeLoader();
        return ServiceRequestModel.fromJson(responseBody);
      }

    } on TimeoutException catch (e) {
      LoaderUtils.closeLoader();
       LoaderUtils.showToast(e.message.toString());
    } on SocketException catch (e) {
      LoaderUtils.closeLoader();
       LoaderUtils.showToast(e.message.toString());
    } on Error catch (e) {
      LoaderUtils.closeLoader();
       LoaderUtils.showToast(e.toString());
    } catch (e) {
       LoaderUtils.closeLoader();
       LoaderUtils.showToast(e.toString());
    }
    return null;
  }

}