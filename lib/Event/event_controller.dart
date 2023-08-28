import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:ride_safe_travel/Event/event_models/event_models.dart';
import 'package:ride_safe_travel/Event/event_request/event_request_body.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/utils/CustomLoader.dart';

class EventController extends GetxController{

  var isLoading = true.obs;
  var getEventListData = <EventListData>[].obs;

  @override
  void onInit() {
    super.onInit();
    EventRequestBody requestBody = EventRequestBody(
      userId: Preferences.getId(Preferences.id),
      pageNo: 1,
      limit: 10,
      status: "Active"
    );
    eventListApi(requestBody);
  }

  Future<dynamic> eventListApi(EventRequestBody requestBody) async {
    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.post(
        Uri.parse(ApiUrl.eventList),
        headers: ApiUrl.headerToken,
        body: jsonEncode(requestBody),
      );
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        isLoading.value = false;
        CustomLoader.closeLoader();
        EventModels model = EventModels.fromJson(responseBody);
        getEventListData.value = model.data!;
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