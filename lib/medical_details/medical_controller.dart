
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:ride_safe_travel/Utils/CustomLoader.dart';

import '../LoginModule/Api_Url.dart';
import 'medical_bottom_models.dart';

class MedicalController extends GetxController{
  var isLoading = true.obs;
  var getMedicalData = <MedicalBottomData>[].obs;

  Future<dynamic> getMedicalBottomList(String medicalType) async {
    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.medicalDropDownList),
        headers: ApiUrl.headerToken,
          body: jsonEncode(<String, String>{"type":medicalType})
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        isLoading.value = false;
        CustomLoader.closeLoader();
        MedicalBottomModels model = MedicalBottomModels.fromJson(responseBody);
        getMedicalData.value = model.data!;
      }
    } on TimeoutException catch (e) {
      isLoading.value = false;
      CustomLoader.showToast(e.message.toString());
    } on SocketException catch (e) {
      isLoading.value = false;
      CustomLoader.showToast(e.message.toString());
    } on Error catch (e) {
      isLoading.value = false;
      CustomLoader.showToast(e.toString());
    } catch (e) {
      //DriverCustomLoader.closeLoader();
      CustomLoader.showToast(e.toString());
    }
    return null;
  }

}