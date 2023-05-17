import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/Models/count_notification_model.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';

import '../Models/VideoListModel.dart';
import '../Utils/CustomLoader.dart';
import '../body_request/video_request_model.dart';
import 'header_controller.dart';




class VideoListController extends GetxController{

  var isLoading = true.obs;
  var getVideoListData = <VideoData>[].obs;
  final headerController = Get.put(HeaderController());

  Future<dynamic> videoListApi(VideoRequest requestBody) async {
    try {
      LoaderUtils.showLoader("Please wait");
      final response = await http.post(
        Uri.parse(ApiUrl.videoList),
        headers: ApiUrl.headerToken,
        body: jsonEncode(<String, dynamic>{
          "type": requestBody.type,
          "user_type": "Driver",

        }),
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        isLoading.value = false;
        CustomLoader.closeLoader();
        VideoListModels model = VideoListModels.fromJson(responseBody);
        getVideoListData.value = model.data!;
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
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.toString());
    }
    return null;
  }


}