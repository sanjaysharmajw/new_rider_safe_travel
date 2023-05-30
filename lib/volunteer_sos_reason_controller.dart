
import 'dart:convert';

import 'package:get/get.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/Models/sosReasonModel.dart';
import 'package:http/http.dart'as http;
import '../Error.dart';
import '../LoginModule/preferences.dart';

class GetSosReasonController extends GetxController{
  var isLoading = true.obs;
  var getSosReasonData = <ReasonMasterData>[].obs;


  @override
  void onInit() {
    super.onInit();

    getSosReason();
  }

  Future<dynamic> getSosReason() async {
    final response = await http.post(
        Uri.parse(
            ApiUrl.sosReason),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': Preferences.getLoginToken(Preferences.loginToken)
        },

        body: jsonEncode({

          "type":"volunteer"

        })
    );
    Map<String, dynamic> responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      isLoading.value = false;
      SosReasonModel model = SosReasonModel.fromJson(responseBody);
      getSosReasonData.value = model.data!;
      return SosReasonModel.fromJson(jsonDecode(response.body));
    } else {
      print("----------------------------");
      print(response.statusCode);
      print("----------------------------");

      throw Exception('Unexpected error occured!');
    }
  }




}