import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';
import 'package:ride_safe_travel/color_constant.dart';
import 'package:ride_safe_travel/switchbutton.dart';
import 'package:ride_safe_travel/users_status_controller.dart';

import 'DriverVehicleList.dart';
import 'Error.dart';
import 'FamilyMemberAddOtherTrack.dart';
import 'FamilyMemberDataModel.dart';

import 'LoginModule/custom_color.dart';
import 'LoginModule/preferences.dart';
import 'Models/MemberBlockDeleteModel.dart';
import 'UserFamilyListData.dart';
import 'Utils/circular_image_widgets.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../MapAddFamily.dart';
import 'Widgets/add_custom_btn.dart';
import 'bottom_nav/EmptyScreen.dart';
import 'family_list_item.dart';
import 'familylist_controller.dart';
import 'new_widgets/my_new_text.dart';

class FamilyList extends StatefulWidget {
  const FamilyList({Key? key}) : super(key: key);

  @override
  State<FamilyList> createState() => _FamilyListState();
}

class _FamilyListState extends State<FamilyList> {

  final familyListController=Get.put(FamilyListController());
  final userstatusController = Get.put(UserStatusController());

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      backgroundColor: appWhiteColor,

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: appBlue,
          onPressed: (){
            Get.to(const MapFamilyAdd())?.then((value) async {
              if(value==true){
                await familyListController.familyListApi(Preferences.getId(Preferences.id));
                LoaderUtils.message(value);
              }
            });
          },
          label: Text("add_family".tr,style: TextStyle(fontFamily: 'Gilroy',fontSize: 15),),

      ),
      body: Obx(() {
        return familyListController.isLoading.value
            ? LoaderUtils.loader()
            : familyListController.getFamilyListData.isEmpty
            ? Center(
          child: EmptyScreen(text: 'family_list_not_found'.tr,),
        ) : ListView.builder(
            itemCount: familyListController.getFamilyListData.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return FamilyListItems(memberDataModel: familyListController.getFamilyListData[index], deleteClick: () {
                userStatusApi(index,familyListController.getFamilyListData[index].userId.toString(), familyListController.getFamilyListData[index].memberId.toString(), 'Deleted');
              }, blockClick: () {
                userStatusApi(index,familyListController.getFamilyListData[index].userId.toString(),
                    familyListController.getFamilyListData[index].memberId.toString(), 'Blocked');
              },);
            });
      }),

    ));
  }
  void userStatusApi(int index,String userId, String memberId, String status) async {
    await userstatusController.getUserStatus(userId, memberId, status)
        .then((value) async {
      if (value != null) {
        if (value.status == true) {
          familyListController.getFamilyListData.removeAt(index);
          familyListController.familyListApi(Preferences.getId(Preferences.id));
          Get.back();
        } else {
          LoaderUtils.showToast(value.message.toString());
        }
      }
    });
  }
}



