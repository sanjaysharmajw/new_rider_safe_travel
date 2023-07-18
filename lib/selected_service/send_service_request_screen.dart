import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';
import 'package:ride_safe_travel/selected_service/search_service_provide_controller.dart';
import 'package:ride_safe_travel/selected_service/search_service_reqest_body.dart';
import 'package:ride_safe_travel/selected_service/send_service_request_body.dart';
import 'package:ride_safe_travel/selected_service/send_service_request_controller.dart';
import 'package:ride_safe_travel/selected_service/send_service_request_list_items.dart';
import '../RejectedServiceList.dart';
import '../Utils/EmptyScreen.dart';
import '../Widgets/add_custom_btn.dart';
import '../color_constant.dart';
import '../controller/location_controller.dart';
import '../controller/permision_controller.dart';
import '../new_widgets/my_new_text.dart';

class SendServiceRequestScreen extends StatefulWidget {
  String serviceId;
  SendServiceRequestScreen({Key? key,required this.serviceId}) : super(key: key);

  @override
  State<SendServiceRequestScreen> createState() => _SendServiceRequestScreenState();
}

class _SendServiceRequestScreenState extends State<SendServiceRequestScreen> {
  final searchController=Get.put(SearchServiceProvideController());
  final sendServiceRequestController=Get.put(SendServiceRequestController());
  final currentLocation = Get.put(LocationController());

  @override
  void initState() {
    print("selectedServiceName: "+widget.serviceId);
    super.initState();
    serviceList();
  }
  void serviceList()async{
    SearchServiceReqestBody requestBody=SearchServiceReqestBody(
      serviceId: widget.serviceId.toString(),
      lng: currentLocation.locationData?.longitude,
      lat: currentLocation.locationData?.latitude
    );
    await searchController.serviceSearchListApi(requestBody);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appWhiteColor,
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell( highlightColor: Colors.black38,onTap: (){
                Get.back();
              },child: Container(
                  width: 30,height: 20,
                  child: Image.asset('new_assets/new_back.png',width: 17,height: 17))),
              const SizedBox(height: 20),
               NewMyText(textValue: 'service_list'.tr, fontName: 'Gilroy',
                  color: appBlack, fontWeight: FontWeight.w700, fontSize: 20),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  return searchController.isLoading.value
                      ? LoaderUtils.loader()
                      : searchController.getServiceSearchListData.isEmpty
                      ? const Center(
                    child: EmptyScreen(),
                  ) : ListView.builder(
                      itemCount: searchController.getServiceSearchListData.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return SendServiceProvideRequestListItems(
                            searchServiceProviderModelData: searchController.getServiceSearchListData[index],
                            requestClick: () async {
                          String? id=searchController.getServiceSearchListData[index].id.toString();
                          String? serviceId=searchController.getServiceSearchListData[index].serviceId.toString();
                          String? serviceProvideId=searchController.getServiceSearchListData[index].serviceProviderId.toString();
                          commentDialogBox(id,serviceId,serviceProvideId);
                        });
                      });
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future commentDialogBox(String id, String serviceId, String serviceProvideId){
    TextStyle textStyle = const TextStyle(color: appBlack,fontFamily: 'Gilroy', height: 1.4, fontSize: 16);
    final commentTextController=TextEditingController();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content:SizedBox(
            height: 280,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       NewMyText(textValue: 'comment'.tr, fontName: 'Gilroy', color: appBlack,
                          fontWeight: FontWeight.w700, fontSize: 18),
                      IconButton(
                        padding: const EdgeInsets.only(left: 30.0),
                          onPressed: (){
                        Get.back();
                      }, icon: const Icon(Icons.close_outlined)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: commentTextController,
                        style: textStyle, cursorColor: appBlack,
                        maxLines: 4, minLines: 4,
                        decoration: InputDecoration(
                          hintText: 'type_your_message'.tr,
                          hintStyle: const TextStyle(color: appBlack),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: appBlack, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: appBlack, width: 1),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      AddCustomButton(press:  (){
                        if(commentTextController.text.toString().isNotEmpty){
                          sendServiceRequestApi(id,serviceId,serviceProvideId,commentTextController);
                        }else{
                          LoaderUtils.showToast('write_something_in_the_comment_box'.tr);
                        }
                      }, buttonText: 'submit'.tr)
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  void sendServiceRequestApi(String id, String serviceId, String serviceProvideId, TextEditingController commentTextController)async{
    SendServiceRequestBody requestBody=SendServiceRequestBody(
      serviceId: serviceId.toString(),
      id: id.toString(),
      comment: commentTextController.text.toString(),
      serviceProviderId: serviceProvideId.toString(),
      lat: currentLocation.locationData?.latitude,
      lng: currentLocation.locationData?.longitude,
      userId: Preferences.getId(Preferences.id),
    );
    await sendServiceRequestController.sendServiceRequestApi(requestBody).then((value){
      if(value!.status==true){
        LoaderUtils.closeLoader();
        LoaderUtils.message(value.message.toString());
        Get.offAll(const RejectedServiceList());
      }else{
        LoaderUtils.closeLoader();
        LoaderUtils.message(value.message.toString());
      }
    });
  }
}
