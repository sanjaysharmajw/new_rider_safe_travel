import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';

import '../LoginModule/Api_Url.dart';
import 'co_passanger_models.dart';
import 'list_co_passanager_request_body.dart';

class DriverCoPassController extends GetxController{

  var isLoading = true.obs;
  var getCoPassangerListData = <Copassenger>[].obs;

  Future<dynamic> coPassangerListApi(ListCoPassanagerRequestBody requestBody) async {
    try {
      //DriverCustomLoader.showLoader("Please wait");
      final response = await http.post(
        Uri.parse("https://tzlcfuw04d.execute-api.ap-south-1.amazonaws.com/dev/api/userRide/coPassengerList"),
        headers: ApiUrl.headerToken,
        body: jsonEncode(requestBody),
      );
      debugPrint('co_passanger');
      debugPrint(jsonEncode(requestBody));
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        isLoading.value = false;
        LoaderUtils.closeLoader();
        CoPassangerModels model = CoPassangerModels.fromJson(responseBody);
        getCoPassangerListData.value = model.data![0].copassenger!;
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