import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import '../LoginModule/Api_Url.dart';
import '../LoginModule/preferences.dart';
import '../Models/count_notification_model.dart';
import '../Utils/Loader.dart';

class GetNotificationController extends GetxController{
  var isLoading = true.obs;
 // var getNotificationData = <Count>[].obs;

  var myRiderCount="wait...".obs;
  var trackFamily="wait...".obs;
  var peopleTrackingMe="wait...".obs;
  var countNotification="wait...".obs;

  @override
  void onInit() {
    super.onInit();
    getCount();
  }

  Future<dynamic> getCount() async {
    try {
      LoaderUtils.showLoader("Please Wait...");
      final response = await http.post(Uri.parse(ApiUrl.countNotification),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "mobile_number": Preferences.getMobileNumber(Preferences.mobileNumber),
          "count":false,
          "unread":false,
          "user_id":Preferences.getId(Preferences.id),
        }),
      );
      debugPrint("notification");
      debugPrint(jsonEncode(<String, dynamic>{
        "mobile_number": Preferences.getMobileNumber(Preferences.mobileNumber),
        "count":false,
        "unread":false,
        "user_id":Preferences.getId(Preferences.id),
      }));
      debugPrint(response.body);
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        LoaderUtils.closeLoader();
        CountNotificationModel model = CountNotificationModel.fromJson(responseBody);
        myRiderCount.value=model.count.totalRides.toString();
        trackFamily.value=model.count.familymemberrides.toString();
        peopleTrackingMe.value=model.count.trackingmembers.toString();
        countNotification.value=model.data.length.toString();
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