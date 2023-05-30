import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/LoginModule/Map/RiderMap.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/Models/Familymodel.dart';
import 'package:ride_safe_travel/main.dart';

import '../../Error.dart';
import '../../FamilyMemberAddOtherTrack.dart';
import '../../FamilyMemberAddScreen.dart';
import '../../Models/MemberBlockDeleteModel.dart';
import '../../ToggleSwitch.dart';
import '../../Utils/Loader.dart';
import '../../bottom_nav/EmptyScreen.dart';
import '../../bottom_nav/custom_bottom_navi.dart';
import '../../color_constant.dart';
import '../../controller/family_ride_controller.dart';
import '../../controller/family_status_controller.dart';
import '../../controller/track_family_controller.dart';
import '../../familydatamodel.dart';
import '../../new_items/track_family_item.dart';
import '../../switchbutton.dart';
import '../../users_status_controller.dart';
import 'FamilyListDataModel.dart';

class FamilyMemberListScreen extends StatefulWidget {
  final String changeUiValue;
  const FamilyMemberListScreen({Key? key, required this.changeUiValue})
      : super(key: key);

  @override
  State<FamilyMemberListScreen> createState() => _FamilyMemberListScreenState();
}

class _FamilyMemberListScreenState extends State<FamilyMemberListScreen> {
  var _future;
  var status;
  //var userId;

  final trackFamilyController = Get.put(TrackFamilyListController());
  final familystatusController = Get.put(UserStatusController());
  final familyRideDataController = Get.put(FamilyRideController());

  @override
  void initState() {
    super.initState();
    callFamilyList();
  }

  void callFamilyList() async {
   await trackFamilyController.trackFamilyListApi();

  }



  var image;

  String? statusType;
  bool isblocked = false;
  bool unblockbuttonVisibility = false;
  var memberStatus;
  var driverName;
  var memberName;

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: appBlue,
          elevation: 5,
          title: Text("other's_live_rides".tr,
              style: TextStyle(
                color: CustomColor.white,
                fontSize: 20,
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
          return familyRideDataController.isLoading.value
              ? LoaderUtils.loader()
              : familyRideDataController.getFamilyRideListData.isEmpty
                  ? Center(
                      child: EmptyScreen(
                        text: 'family_list_not_found'.tr,
                      ),
                    )
                  : ListView.builder(
                      itemCount: familyRideDataController.getFamilyRideListData.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return TrackFamilyItem(
                          familyListDataModel:
                          familyRideDataController.getFamilyRideListData[index],
                          deleteClick: () {
                            familyStatusApi(index, Preferences.getId(Preferences.id),
                                familyRideDataController.getFamilyRideListData[index].memberId.toString(), 'Deleted');
                          },
                        );
                      });
        }));

  }

  void familyStatusApi(
      int index, String userId, String memberId, String status) async {
    await familystatusController
        .getUserStatus(userId, memberId, status)
        .then((value) async {
      if (value != null) {
        if (value.status == true) {

            trackFamilyController.getTrackData.removeAt(index);

          callFamilyList();
          Navigator.push(context, MaterialPageRoute(builder: (context) => CustomBottomNav()));
            //Get.back();
            // Get.to(CustomBottomNav());


        } else {
          LoaderUtils.showToast(value.message.toString());
        }
      }
    });
  }

}
