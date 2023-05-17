import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import 'package:ride_safe_travel/Utils/Loader.dart';
import 'package:ride_safe_travel/controller/volunteer_request.dart';

import '../LoginModule/Api_Url.dart';
import '../LoginModule/preferences.dart';
import '../Models/volunteer_models.dart';


class VolunteerController extends GetxController{

  Future<VolunteerModels?> volunteerApi(VolunteerRequest request) async {
    try {
      LoaderUtils.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.selectVolunteer),
        headers: ApiUrl.headerToken,
        body: jsonEncode(request),);
      print("VolenteerController"+request.toString());
      print( jsonEncode(request));
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {

        LoaderUtils.closeLoader();
        return VolunteerModels.fromJson(responseBody);
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

