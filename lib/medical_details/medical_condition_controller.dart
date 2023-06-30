import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/medical_details/update_medical_details_model.dart';
import 'package:ride_safe_travel/medical_details/update_medical_request_body.dart';
import '../LoginModule/Api_Url.dart';
import '../utils/CustomLoader.dart';

import 'medical_details_model.dart';

class MedicalConditionController extends GetxController{

  var isLoading = true.obs;
  var getMedicalDetailsData = <MedicalData>[].obs;

  final medicalCondition=TextEditingController().obs;
  final medicalNotes=TextEditingController().obs;
  final allergies=TextEditingController().obs;
  final medication=TextEditingController().obs;
  final organDonor=TextEditingController().obs;
  final weight=TextEditingController().obs;
  final height=TextEditingController().obs;
  final priparyLanguage = TextEditingController().obs;


  @override
  void onInit() {
    super.onInit();
  }

  Future<dynamic> updateMedicalConditions() async {
    UpdateMedicalRequestBody requestBody=UpdateMedicalRequestBody(userId: Preferences.getId(Preferences.id),
    medicalCondition: medicalCondition.value.text,
    medicalNotes: medicalNotes.value.text,
    allergiesAndReactions: allergies.value.text,
    medications: medication.value.text,
    weight: weight.value.text,
    height: height.value.text,
    primaryLanguage: priparyLanguage.value.text);
    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.updateMedicalDetails),
        headers: ApiUrl.headerToken, body: jsonEncode(requestBody),
      );
      debugPrint('updateMedicalDetails');
      debugPrint(jsonEncode(requestBody));
      debugPrint(response.body);
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        return UpdateMedicalDetailsModel.fromJson(responseBody);
      }
    } on TimeoutException catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.message.toString());
    }  catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.toString());
    }
    /*try {
      final response = await http.post(Uri.parse(APIConstant.updateMedicalDetails),
        headers: APIConstant.headerToken,
        body: jsonEncode(requestBody,));
      print(jsonEncode(<String, String>{
      "getMedicalConditions": jsonEncode(requestBody,)
      }),);
      // interceptorResponse(APIConstant.checkActiveRide, jsonEncode(<String, String>{"mobile_number": mobileNumber}));
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      debugPrint(decodedBytes);
      debugPrint('logsssssss');
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        DriverCustomLoader.closeLoader();
        isLoading.value = false;
        MedicalDetailsModel model = MedicalDetailsModel.fromJson(responseBody);
        getMedicalDetailsData.value = model.data!;
      }
    } on TimeoutException catch (e) {
      isLoading.value = false;
      DriverCustomLoader.showToast(e.message.toString());
      DriverCustomLoader.closeLoader();
    } on SocketException catch (e) {
      isLoading.value = false;
      DriverCustomLoader.showToast(e.message.toString());
    } on Error catch (e) {
      isLoading.value = false;
      DriverCustomLoader.closeLoader();
      DriverCustomLoader.showToast(e.toString());
    } catch (e) {
      DriverCustomLoader.closeLoader();
      DriverCustomLoader.showToast(e.toString());
    }*/
    return null;
  }

  Future<dynamic> getMedicalConditions() async {
    try {
      final response = await http.post(Uri.parse(ApiUrl.getMedicalDetails),
        headers: ApiUrl.headerToken,
        body: jsonEncode(<String, String>{"user_id":  Preferences.getId(Preferences.id) }));
      print(jsonEncode(<String, String>{
      "getMedicalConditions": jsonEncode({"user_id":  Preferences.getId(Preferences.id) })
      }),);
      // interceptorResponse(APIConstant.checkActiveRide, jsonEncode(<String, String>{"mobile_number": mobileNumber}));
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      debugPrint(decodedBytes);
      debugPrint('logsssssss');
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        isLoading.value = false;
        MedicalDetailsModel model = MedicalDetailsModel.fromJson(responseBody);
        getMedicalDetailsData.value = model.data!;
      }
    } on TimeoutException catch (e) {
      isLoading.value = false;
      CustomLoader.showToast(e.message.toString());
      CustomLoader.closeLoader();
    } on SocketException catch (e) {
      isLoading.value = false;
      CustomLoader.showToast(e.message.toString());
    } on Error catch (e) {
      isLoading.value = false;
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.toString());
    } catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.toString());
    }
    return null;
  }

}