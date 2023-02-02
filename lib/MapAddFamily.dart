import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/LoginModule/Map/RiderFamilyList.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/Models/affFamilyMemberNewModel.dart';
import 'package:ride_safe_travel/Utils/RiderButton.dart';
import 'LoginModule/Error.dart';
import 'LoginModule/preferences.dart';
import 'Utils/Validators.dart';
import 'Utils/toast.dart';

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
        leading:  IconButton(icon: Icon(Icons.keyboard_backspace_sharp), onPressed: () {
          Get.back();
        },),
        centerTitle: true,
        backgroundColor: CustomColor.yellow,
        title: const Text("Add Family Member",
            style: TextStyle(fontFamily: 'transport', fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const SizedBox(height: 20),
              const Text("User Who can track",
                  style: TextStyle(fontFamily: 'transport', fontSize: 20)),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp("[a-zA-Z\]")),
                    FilteringTextInputFormatter.deny('  ')
                  ],
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.length < 2) {
                      return 'Please enter name!';
                    }
                    return null;
                  },
                  controller: controllerName,
                  style: const TextStyle(fontFamily: 'transport', fontSize: 14),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Name',
                    hintText: 'Enter Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp("[a-zA-Z\]")),
                    FilteringTextInputFormatter.deny('  ')
                  ],
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.length < 2) {
                      return 'Please enter valid relation!';
                    }
                    return null;
                  },
                  controller: controllerRelation,
                  style: const TextStyle(fontFamily: 'transport', fontSize: 14),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Relation',
                    hintText: 'Enter Your Family Relation',
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
                  style: const TextStyle(fontFamily: 'transport', fontSize: 14),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Mobile',
                    hintText: 'Enter Your Mobile Number',
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.length != 10) {
                      return 'Please enter valid mobile number!';
                    }
                    return null;
                  },
                ),
              ),
              RiderButton(
                  click: () {
                    if (_formKey.currentState!.validate()) {
                      OverlayLoadingProgress.start(context);
                      addFamilyMember(
                          controllerName.text.toString(),
                          userId,
                          controllerRelation.text.toString(),
                          controllerMobile.text.toString());

                    }

                  },
                  textBtn: 'Add')
            ],
          ),
        ),
      ),
    );
  }

  Future<AffFamilyMemberNewModel> addFamilyMember(
      String name, String userId, String relation, String mobile) async {
    final response = await http.post(
      Uri.parse(
          'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/addFamilyMemberNew'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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
        Get.back();
        Navigator.pop(context);
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
