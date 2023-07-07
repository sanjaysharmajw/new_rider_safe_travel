import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/LoginModule/Map/RiderFamilyList.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/Models/affFamilyMemberNewModel.dart';
import 'package:ride_safe_travel/Utils/RiderButton.dart';
import 'package:ride_safe_travel/color_constant.dart';
import 'package:ride_safe_travel/custom_button.dart';
import 'package:ride_safe_travel/tracking/tracking_tabs.dart';
import 'Language/custom_text_input_formatter.dart';
import 'LoginModule/Error.dart';
import 'LoginModule/preferences.dart';
import 'UserFamilyList.dart';
import 'Utils/Validators.dart';
import 'Utils/toast.dart';
import 'color_constant.dart';
import 'color_constant.dart';
import 'color_constant.dart';

class MapFamilyAdd extends StatefulWidget {
  const MapFamilyAdd({Key? key}) : super(key: key);

  @override
  State<MapFamilyAdd> createState() =>
      _MapFamilyAdd();
}

class _MapFamilyAdd extends State<MapFamilyAdd> {
  var userId = '';
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerRelation = TextEditingController();
  final TextEditingController controllerMobile = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(icon: Icon(Icons.keyboard_backspace_sharp, color:  appWhiteColor,), onPressed: () {
          Get.back();
        },),
        centerTitle: false,
        backgroundColor: appBlue,
        title:  Text("add_family_member".tr,
            style: TextStyle(color:  appWhiteColor,fontSize: 22, fontFamily: 'Gilroy',)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const SizedBox(height: 20),
              Text("user_who_can_track".tr,
                  style: TextStyle(fontFamily: 'Gilroy', fontSize: 20,fontWeight: FontWeight.w600)),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  inputFormatters: [
                    engHindFormatter,
                    //FilteringTextInputFormatter.allow(
                       // RegExp("[a-zA-Z\]")),
                    FilteringTextInputFormatter.deny('  ')
                  ],
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.length < 2) {
                      return 'please_enter_name!'.tr;
                    }
                    return null;
                  },
                  controller: controllerName,
                  style: const TextStyle(fontFamily: 'Gilroy', fontSize: 14),
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'enter_name'.tr,
                    hintText: 'enter_name'.tr,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  inputFormatters: [
                    engHindFormatter,
                    //FilteringTextInputFormatter.allow(
                      //  RegExp("[a-zA-Z\]")),
                    FilteringTextInputFormatter.deny('  ')
                  ],
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.length < 2) {
                      return 'please_enter_valid_relation!'.tr;
                    }
                    return null;
                  },
                  controller: controllerRelation,
                  style: const TextStyle(fontFamily: 'Gilroy', fontSize: 14),
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'enter_relation'.tr,
                    hintText: 'enter_your_family_relation'.tr,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp("[0-9]")),
                    FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  controller: controllerMobile,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontFamily: 'Gilroy', fontSize: 14),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'enter_mobile_number'.tr,
                    hintText: 'enter_your_mobile_number'.tr,
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.length != 10) {
                      return 'please_enter_valid_mobile_number!'.tr;
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,),
                child: CustomButton(press: (){
                  if (_formKey.currentState!.validate()) {
                    OverlayLoadingProgress.start(context);
                    addFamilyMember(
                        controllerName.text.toString(),
                        userId,
                        controllerRelation.text.toString(),
                        controllerMobile.text.toString());

                  }
                }, buttonText: "add_member".tr),
              )

            ],
          ),
        ),
      ),
    );
  }

  Future<AffFamilyMemberNewModel> addFamilyMember(
      String name, String userId, String relation, String mobile) async {
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);

    final response = await http.post(
      Uri.parse(
          ApiUrl.addFamilyMemberNew),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': loginToken
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'user_id': userId,
        'relation': relation,
        'mobile_number': mobile,
      }),
    );

    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      if (status == true) {
        OverlayLoadingProgress.stop();
        ToastMessage.toast(msg);
        //Get.back();
        Get.offAll(TrackingTabPage());
       // Get.offAll(const FamilyList());
        print(userId + msg);
      } else {
        OverlayLoadingProgress.stop();
        ToastMessage.toast(msg);
        print(userId + msg);
      }
      return AffFamilyMemberNewModel.fromJson(response.body);
    } else {
      throw Exception('Failed Add Family Member');
    }
  }

  @override
  void initState() {
    super.initState();
    preferences();
  }

  void preferences() async {
    await Preferences.setPreferences();
    userId = Preferences.getId(Preferences.id).toString();
    print(userId);
    setState(() {});
  }
}
