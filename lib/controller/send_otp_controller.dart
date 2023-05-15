import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/Models/send_otp_models.dart';
import 'package:ride_safe_travel/controller/header_controller.dart';
import '../Models/otp_verify_models.dart';
import '../Utils/loader.dart';

class SendOtpController extends GetxController{

  final header=Get.put(HeaderController());

  Future<SendOtpModel?> sendOtp(String mobile) async {
    try {
      LoaderUtils.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.sendOtp),
        headers: header.headerToken,
        body: jsonEncode(<String, String>{"mobile_number": mobile}),
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        LoaderUtils.closeLoader();
        return SendOtpModel.fromJson(responseBody);
      }
    }
    on TimeoutException catch (e) {
      LoaderUtils.closeLoader();
      LoaderUtils.showToast(e.message.toString());
    }  catch (e) {
      LoaderUtils.closeLoader();
      LoaderUtils.showToast(e.toString());
    }
    return null;
  }

  Future<VerifyOtpModels?> verifyOtp(String mobile,String otp) async {
    try {
      LoaderUtils.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.verifyOtp),
        headers: header.headerToken, body: jsonEncode(<String, String>{
          "mobile_number": mobile,
          "otp": otp
        }),
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        LoaderUtils.closeLoader();
        return VerifyOtpModels.fromJson(responseBody);
      }
    } on TimeoutException catch (e) {
      LoaderUtils.closeLoader();
      LoaderUtils.showToast(e.message.toString());
    }  catch (e) {
      LoaderUtils.closeLoader();
      LoaderUtils.showToast(e.toString());
    }
    return null;
  }
}