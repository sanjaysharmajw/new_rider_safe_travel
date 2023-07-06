

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/Models/multi_marker_models.dart';
import 'package:ride_safe_travel/Models/multi_marker_request.dart';
import 'package:ride_safe_travel/Utils/CustomLoader.dart';
import 'package:http/http.dart'as http;
import 'package:ride_safe_travel/controller/header_controller.dart';
import '../LoginModule/Api_Url.dart';
import '../Utils/Loader.dart';

class MultiMarkerController extends GetxController{
  final headerController = Get.put(HeaderController());
  var getMultipleMarkerData = <MarkerData>[].obs;
  var isLoading = true.obs;
  Future<MultiMarkerModels?> multiMarkerApi(MultiMarkerRequest requestBody) async {
    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.multiMarker),
        headers: headerController.headerToken,
        body: jsonEncode(requestBody),
      );
      debugPrint("requestBody: "+jsonEncode(requestBody));
      debugPrint("multipleMArker");
      debugPrint(response.body);
      debugPrint(jsonEncode(requestBody));
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        isLoading.value = false;
        LoaderUtils.closeLoader();
        MultiMarkerModels model = MultiMarkerModels.fromJson(responseBody);
        getMultipleMarkerData.value = model.data!;
      }
    } on TimeoutException catch (e) {
      isLoading.value = false;
      LoaderUtils.showToast(e.message.toString());
    } on SocketException catch (e) {
      isLoading.value = false;
      LoaderUtils.showToast(e.message.toString());
    } on Error catch (e) {
      isLoading.value = false;
      LoaderUtils.showToast(e.toString());
    } catch (e) {
      LoaderUtils.closeLoader();
      LoaderUtils.showToast(e.toString());
    }
    return null;
  }
}