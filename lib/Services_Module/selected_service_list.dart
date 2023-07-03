import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:location/location.dart';
import 'package:ride_safe_travel/RejectedServiceList.dart';
import 'package:ride_safe_travel/Services_Module/request_controller.dart';
import 'package:ride_safe_travel/Services_Module/service_requestlist_controller.dart';
import 'package:ride_safe_travel/Services_Module/service_type_list_item.dart';
import 'package:ride_safe_travel/Services_Module/service_types.dart';
import 'package:ride_safe_travel/Services_Module/servicelist_controller.dart';
import 'package:ride_safe_travel/Services_Module/selected_service_list_item.dart';
import 'package:ride_safe_travel/Utils/CustomLoader.dart';
import 'package:ride_safe_travel/controller/location_controller.dart';

import '../Utils/Loader.dart';
import '../bottom_nav/EmptyScreen.dart';
import '../bottom_nav/custom_bottom_navi.dart';
import '../bottom_nav/home_page_nav.dart';
import '../color_constant.dart';

class SelectedServiceLists extends StatefulWidget {
  String serviceId;
  final String backToDashboard;

  SelectedServiceLists({Key? key, required this.serviceId, required this.backToDashboard}) : super(key: key);

  @override
  State<SelectedServiceLists> createState() => _SelectedServiceListsState();
}

class _SelectedServiceListsState extends State<SelectedServiceLists> {
  final servicelist = Get.put(ServiceListController());
  final request = Get.put(ServiceRequestController());
  final requestedservicelist = Get.put(ServiceRequestListController());
  final currentLocation = Get.put(LocationController());
   LocationData? currenctLoaction;
  Location? location;

  void initState(){
    getCurrentLocation();
    super.initState();
  }
  void getCurrentLocation()async{
    location=Location();
    currenctLoaction=await location!.getLocation();
   // CustomLoader.message(currenctLoaction!.latitude.toString());
    print('currenctLoaction!.latitude.toString()');
    print(currenctLoaction!.latitude.toString());
    print(currenctLoaction!.longitude.toString());
    print('object');
    if(currenctLoaction!=null){
      getList();
    }
  }

  void getList()async{
   await servicelist.getServicesList(widget.serviceId,currenctLoaction!.latitude!,currenctLoaction!.longitude!);
   setState(() {});
   debugPrint('widget.serviceId');
   debugPrint(widget.serviceId);
  }

  @override
  Widget build(BuildContext context) {
  return SafeArea(
        child: Scaffold(
          backgroundColor: appWhiteColor,
          appBar: AppBar(
            backgroundColor: appBlue,
            elevation: 10,
            title: Text("services".tr,
                style: TextStyle(
                  color: appWhiteColor, fontSize: 22, fontFamily: 'Gilroy',)),
            leading: IconButton(
              color: appWhiteColor,
              onPressed: () {
                widget.backToDashboard == "DashBoard" ?  Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomBottomNav())) :
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>ServiceListsScreen()));
              },
              icon: const Icon(Icons.arrow_back_outlined),
            ),
          ),

          body: Container(
            child: Obx((){
              return  servicelist.isLoading.value
                      ? LoaderUtils.loader()
                      : servicelist.servicesList.isEmpty
                      ? Center(
                    child: EmptyScreen(text: 'service_list_not_found'.tr,),
                  ) :
                  ListView.builder(
                      itemCount: servicelist.servicesList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                          return  ShowSelectedServiceItem(
                            serviceListData: servicelist.servicesList[index],
                            voidCallback: () async {
                             requestService(servicelist.servicesList[index].serviceId.toString(),
                                  servicelist.servicesList[index].id.toString(),
                                servicelist.servicesList[index].serviceProviderId.toString(),
                               currenctLoaction!.longitude!,
                               currenctLoaction!.latitude!,

                              );
                            },
                          );
                      });
            }),
          )
        ),
      );

  }

  void requestService(String serviceId, String id, String serviceProviderId,
      double lng, double lat)async{
    await request.sendRequest(serviceId, id, serviceProviderId, lng, lat).then((value) async {
      if (value != null) {
        print("Click on request");
        LoaderUtils.closeLoader();
        Get.offAll(const RejectedServiceList());
        print("RequestSend");
        requestedServiceList();
        LoaderUtils.message(value.message.toString());
      }
    });
  }
  void requestedServiceList()async{
    await requestedservicelist.getRequestedServicesList(currentLocation.locationData!.longitude!, currentLocation.locationData!.latitude!);
  }
}
