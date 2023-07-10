import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';
import 'package:ride_safe_travel/Utils/toast.dart';
import 'package:ride_safe_travel/Utils/view_image.dart';
import 'package:ride_safe_travel/body_request/get_ride_live_request.dart';
import 'package:ride_safe_travel/bottom_nav/EmptyScreen.dart';
import 'package:ride_safe_travel/color_constant.dart';
import 'package:ride_safe_travel/controller/get_ride_live_data_controller.dart';
import 'Error.dart';
import 'LoginModule/Api_Url.dart';
import 'LoginModule/custom_color.dart';
import 'LoginModule/preferences.dart';
import 'Models/RideDataModel.dart';
import 'bottom_nav/custom_bottom_navi.dart';
import 'controller/rider_history_controller.dart';
import 'get_ride_request_body.dart';
import 'get_rider_data_controller.dart';
import 'history_map.dart';
import 'my_rides_history_items.dart';

class MyRidesPage extends StatefulWidget {
  String changeAppbar;
  MyRidesPage({Key? key, required this.changeAppbar}) : super(key: key);

  @override
  State<MyRidesPage> createState() => _MyRidesPageState();
}

class _MyRidesPageState extends State<MyRidesPage> {
  final ridehistoryController = Get.put(RiderHistoryListController());
  var image;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return SafeArea(child:
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: appBlue,
          elevation: 0,
          title: Text('my_rides'.tr,
              style: TextStyle(
                color: appWhiteColor,
                fontSize: 22,
                fontFamily: 'Gilroy',
              )),
          leading: IconButton(
            color: appWhiteColor,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CustomBottomNav()));
            },
            icon: const Icon(Icons.arrow_back_outlined),
          ),
        ),
        body: Obx(() {
          return ridehistoryController.isLoading.value
              ? LoaderUtils.loader()
              : ridehistoryController.getRiderHistoryData.isEmpty
                  ? Center(
                      child: EmptyScreen(
                        text: 'ride_history_not_found'.tr,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          ridehistoryController.getRiderHistoryData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MyRidesHistoryItems(
                          vehicleReg: ridehistoryController
                                      .getRiderHistoryData[index]
                                      .vehicleRegistrationNumber
                                      .toString() ==
                                  "null"
                              ? " "
                              : ridehistoryController
                                  .getRiderHistoryData[index]
                                  .vehicleRegistrationNumber
                                  .toString(),
                          driverName: ridehistoryController
                                      .getRiderHistoryData[index].driverName
                                      .toString() ==
                                  "null"
                              ? " "
                              : ridehistoryController
                                  .getRiderHistoryData[index].driverName
                                  .toString(),
                          fromdestination: ridehistoryController
                                      .getRiderHistoryData[index]
                                      .fromDestination
                                      .toString() ==
                                  "null"
                              ? ""
                              : ridehistoryController
                                  .getRiderHistoryData[index]
                                  .fromDestination
                                  .toString(),
                          todestination: ridehistoryController
                                      .getRiderHistoryData[index]
                                      .toDestination
                                      .toString() ==
                                  "null"
                              ? " "
                              : ridehistoryController
                                  .getRiderHistoryData[index].toDestination
                                  .toString(),
                          clickList: () {
                            getRideDetailsApi(ridehistoryController.getRiderHistoryData[index].id.toString(), index);
                          },
                        );
                      });
        })));

  }

  void getRideDetailsApi(String id,int index)async{
    final getRideDataLiveController=Get.put(GetRideDataLiveController());
    GetRideLiveRequest request=GetRideLiveRequest(rideId: id.toString(),type: 1);
    await getRideDataLiveController.getRideLiveData(request).then((value){
      if(value!=null){
        if(value.status==true){
          Get.to(HistoryMap(riderHistoryData: value,riderData: ridehistoryController.getRiderHistoryData[index]));
        }
      }
    });
  }


}
