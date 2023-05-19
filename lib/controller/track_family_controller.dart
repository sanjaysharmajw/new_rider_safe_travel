import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../LoginModule/Api_Url.dart';
import '../LoginModule/Map/FamilyListDataModel.dart';
import '../LoginModule/preferences.dart';
import '../Utils/Loader.dart';
import '../familydatamodel.dart';

class TrackFamilyListController extends GetxController{
  var isLoading = true.obs;
  var getTrackData = <FamilyListDataModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    trackFamilyListApi(Preferences.getId(Preferences.id), Preferences.getMobileNumber(Preferences.mobileNumber));
  }

  Future<dynamic> trackFamilyListApi(String userId, String mobileNumber) async {
    try {
      LoaderUtils.showLoader("Please wait");
      final response = await http.post(Uri.parse(
          'https://l8olgbtnbj.execute-api.ap-south-1.amazonaws.com/dev/api/userRide/familymemberRideList'),
        headers: ApiUrl.headerToken,
        body: jsonEncode(<String, String>{
          'mobile_number': mobileNumber,
          "user_id": userId
        }),
      );
      print( jsonEncode(<String, String>{
        'mobile_number': mobileNumber,
        "user_id": userId
      }),);
      log(response.body);
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        isLoading.value = false;
        LoaderUtils.closeLoader();
        Familydatamodel model = Familydatamodel.fromJson(responseBody);
        getTrackData.value = model.data!;
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