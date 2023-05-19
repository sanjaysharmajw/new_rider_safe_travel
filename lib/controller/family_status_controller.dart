import 'dart:async';
import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart'as http;
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';

import '../Models/MemberBlockDeleteModel.dart';


class FamilyStatusController extends GetxController{



  Future<dynamic> getFamilyStatus(String userId,String memberId, String status) async {
    try {
      print(userId +" "+ memberId +" "+status);
      LoaderUtils.showLoader("Please wait");
      final response = await http.post(Uri.parse(
          "https://l8olgbtnbj.execute-api.ap-south-1.amazonaws.com/dev/api/userRide/deleteblockFamilyMember"),
        headers: ApiUrl.headerToken,
        body: jsonEncode({
          "user_id": userId.toString(),
          "member_id": memberId.toString(),
          "status": status.toString()
        }),
      );
      print(jsonEncode({
        "user_id": userId.toString(),
        "member_id": memberId.toString(),
        "status": status.toString()
      }),);
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        LoaderUtils.closeLoader();
        return MemberBlockDeleteModel.fromJson(responseBody);
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