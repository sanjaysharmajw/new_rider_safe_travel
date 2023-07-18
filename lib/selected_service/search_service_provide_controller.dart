
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';
import 'package:ride_safe_travel/selected_service/search_service_provider_model.dart';
import 'package:ride_safe_travel/selected_service/search_service_reqest_body.dart';

class SearchServiceProvideController extends GetxController{
  var isLoading = true.obs;
  var getServiceSearchListData = <SearchServiceProviderModelData>[].obs;

  Future<dynamic> serviceSearchListApi(SearchServiceReqestBody request) async {
    try {
      //DriverCustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.searchServiceRequest),
        headers: ApiUrl.headerToken,
        body: jsonEncode(request),
      );
      print("searchServiceProvider: "+jsonEncode(request));

      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        isLoading.value = false;
        LoaderUtils.closeLoader();
        SearchServiceProviderModel model = SearchServiceProviderModel.fromJson(responseBody);
        getServiceSearchListData.value = model.data!;
      }
    } on TimeoutException catch (e) {
      isLoading.value = false;
      LoaderUtils.showToast(e.message.toString());
      debugPrint('log message');
      debugPrint(e.message.toString());
    } on SocketException catch (e) {
      isLoading.value = false;
      LoaderUtils.showToast(e.message.toString());
      debugPrint('log message');
      debugPrint(e.message.toString());
    } on Error catch (e) {
      isLoading.value = false;
      LoaderUtils.showToast(e.toString());
      debugPrint('log message');
      debugPrint(e.toString());
    } catch (e) {
      //DriverCustomLoader.closeLoader();
      LoaderUtils.showToast(e.toString());
      debugPrint('log message');
      debugPrint(e.toString());
    }
    return null;
  }

}