import 'dart:convert';

import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/Models/sosReasonModel.dart';
import 'package:http/http.dart' as http;
import '../Error.dart';
import '../LoginModule/preferences.dart';
import 'Utils/CustomLoader.dart';

class GetSosReasonController extends GetxController {
  var isLoading = true.obs;
  var getSosReasonData = <ReasonMasterData>[].obs;

  @override
  void onInit() {
    super.onInit();

    //getSosReason();
  }

  Future<dynamic> getSosReason() async {
    try {
      final response = await http.post(Uri.parse(ApiUrl.sosReason),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': Preferences.getLoginToken(Preferences.loginToken)
          },
          body: jsonEncode({"type": "volunteer"}));
      Map<String, dynamic> responseBody = json.decode(response.body);
      debugPrint('master');
      debugPrint(response.body);
      if (response.statusCode == 200) {
        isLoading.value = false;
        CustomLoader.closeLoader();
        SosReasonModel model = SosReasonModel.fromJson(responseBody);
        getSosReasonData.value = model.data!;
        debugPrint("first reason is ${model.data![0].name}");
        debugPrint(response.body);
      }
    } on TimeoutException catch (e) {
      isLoading.value = false;
      CustomLoader.showToast(e.message.toString());
      CustomLoader.closeLoader();
      debugPrint('log message');
      debugPrint(e.message.toString());
    } on SocketException catch (e) {
      isLoading.value = false;
      CustomLoader.showToast(e.message.toString());
      CustomLoader.closeLoader();
      debugPrint('log message');
      debugPrint(e.message.toString());
    } on Error catch (e) {
      isLoading.value = false;
      CustomLoader.showToast(e.toString());
      CustomLoader.closeLoader();
      debugPrint('log message');
      debugPrint(e.toString());
    } catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.toString());
      debugPrint('log message');
      debugPrint(e.toString());
    }
    return null;
  }
}
