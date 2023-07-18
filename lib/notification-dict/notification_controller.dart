import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:http/http.dart'as http;
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';

import '../Error.dart';
import '../LoginModule/Api_Url.dart';
import '../Notification/NotificationModels.dart';
import '../Utils/toast.dart';



class notificationController extends GetxController{
  var getNotificationData = <NotificationData>[].obs;
  var isLoading = true.obs;
  var getToken="".obs;

  @override
  void onInit() {
    super.onInit();
    getNotification();
  }

  Future<dynamic> readNotification(String id) async {
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);

    final response = await http.post(Uri.parse(ApiUrl.readNotification),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': loginToken
        },
        body: json.encode({
          'id': id.toString(),
        }));

    print("userid: $id");

    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      if (status == true) {
        OverlayLoadingProgress.stop();

          await getNotification();

        ToastMessage.toast(msg.toString());
        //Navigator.of(context).pop();
      } else {
        OverlayLoadingProgress.stop();
        ToastMessage.toast(msg.toString());
      }
      return response;
    } else {
      throw Exception('Failed');
    }
  }

  Future<dynamic> getNotification() async {
    String userId = Preferences.getId(Preferences.id).toString();
    try {
      LoaderUtils.showLoader("Please wait");

      final response = await http.post(Uri.parse(ApiUrl.countNotification),
        headers: ApiUrl.headerToken, body: jsonEncode(<String, String>{"user_id": userId}),
      );
      debugPrint('check_response.body');
      debugPrint(response.body);
      debugPrint(jsonEncode(<String, String>{"user_id": userId}));

      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        isLoading.value = false;
        LoaderUtils.closeLoader();
        NotificationModels model = NotificationModels.fromJson(responseBody);
        getNotificationData.value = model.data!;
        //getToken.value = model.token!;
      }
    }  on TimeoutException catch (e) {
      isLoading.value = false;
      LoaderUtils.showToast(e.message.toString());
    } on SocketException catch (e) {
      isLoading.value = false;
      LoaderUtils.showToast(e.message.toString());
    } on Error catch (e) {
      isLoading.value = false;
      LoaderUtils.showToast(e.toString());
    } catch (e) {
      isLoading.value = false;
      LoaderUtils.closeLoader();
      LoaderUtils.showToast(e.toString());
    }
    return null;
  }
}