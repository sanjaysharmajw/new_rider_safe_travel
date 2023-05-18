
import 'dart:convert';

import 'package:get/get.dart';
import 'package:ride_safe_travel/Models/sosReasonModel.dart';
import 'package:http/http.dart'as http;
import '../Error.dart';
import '../LoginModule/preferences.dart';

class GetSosMasterController extends GetxController{
  var isLoading = true.obs;
  var getSosReasonMasterData = <ReasonMasterData>[].obs;


  @override
  void onInit() {
    super.onInit();
    getSopsReason();
  }

  Future<dynamic> getSopsReason() async {
    final response = await http.post(
      Uri.parse(
          "https://l8olgbtnbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/sosReasonMaster"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': Preferences.getLoginToken(Preferences.loginToken)
      },

        body: jsonEncode({

          "type":""

        })
    );
    Map<String, dynamic> responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
        isLoading.value = false;
        SosReasonModel model = SosReasonModel.fromJson(responseBody);
        getSosReasonMasterData.value = model.data!;
      return SosReasonModel.fromJson(jsonDecode(response.body));
    } else {
      print("----------------------------");
      print(response.statusCode);
      print("----------------------------");

      throw Exception('Unexpected error occured!');
    }
  }




}