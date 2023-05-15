

import 'dart:io';

import 'package:get/get.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';


class HeaderController extends GetxController{
  String? loginToken;
  Map<String, String>? headerToken;

  @override
  void onInit() {
    sharePreferences();
    super.onInit();
    headerToken = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      'Authorization': loginToken.toString()
    };
  }
  void sharePreferences()async{
    Preferences.setPreferences();
    loginToken=Preferences.getLoginToken(Preferences.loginToken).toString();
  }
}