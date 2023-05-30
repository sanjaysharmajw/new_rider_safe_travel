import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/Models/affFamilyMemberNewModel.dart';
import 'package:ride_safe_travel/Utils/RiderButton.dart';
import 'package:ride_safe_travel/color_constant.dart';
import 'package:ride_safe_travel/custom_button.dart';
import 'package:ride_safe_travel/start_ride_map.dart';

import 'LoginModule/Error.dart';
import 'LoginModule/preferences.dart';
import 'Utils/Validators.dart';
import 'Utils/toast.dart';

class FamilyMemberAddScreen extends StatefulWidget {
  FamilyMemberAddScreen(
      {Key? key,
      required this.socketToken,
      required this.driverId,
      required this.vehicleId,
      required this.riderId,
      required this.dName,
      required this.dMobile,
      required this.dPhoto,
      required this.model,
      required this.vOwnerName,
      required this.vRegNo,
        required this.driverLicense,
        required this.otpRide})
      : super(key: key);

  @override
  State<FamilyMemberAddScreen> createState() => _FamilyMemberAddScreenState();

  String socketToken;
  String driverId;
  String vehicleId;
  String riderId;

  final String dName;
  final String dMobile;
  final String dPhoto;
  final String model;
  final String vOwnerName;
  final String vRegNo;
  final String driverLicense;
  final String otpRide;
}

class _FamilyMemberAddScreenState extends State<FamilyMemberAddScreen> {
  var userId = '';
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerRelation = TextEditingController();
  final TextEditingController controllerMobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading:  IconButton( onPressed: () {
          Get.back();
        }, icon: Icon(Icons.keyboard_backspace_sharp,)),


        backgroundColor: appBlue,
        title: const Text("Add Family Member",
            style: TextStyle(fontFamily: 'Gilroy', fontSize: 18,color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const SizedBox(height: 20),
            const Text("User Who can track",
                style: TextStyle(fontFamily: 'Gilroy', fontSize: 20)),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp("[a-zA-Z\ ]")),
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
                style: const TextStyle(fontFamily: 'Gilroy', fontSize: 14),
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
                  FilteringTextInputFormatter.deny(' ')
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
                style: const TextStyle(fontFamily: 'Gilroy', fontSize: 14),
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
                  LengthLimitingTextInputFormatter(10),
                ],
                controller: controllerMobile,
                style: const TextStyle(fontFamily: 'Gilroy', fontSize: 14),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Mobile',
                  hintText: 'Enter Your Mobile Number',
                ),
                // validator: Validator.validatePhoneNumber(controllerMobile.text.toString()),

                validator: (value) {
                  Validator.validatePhoneNumber(controllerMobile.text.toString());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomButton(press: (){
                OverlayLoadingProgress.start(context);
                addFamilyMember(
                    controllerName.text.toString(),
                    userId,
                    controllerRelation.text.toString(),
                    controllerMobile.text.toString());
              }, buttonText: "Add Family Member"),
            ),

          ],
        ),
      ),
    ));
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
        OverlayLoadingProgress;
        Get.to(StartRide(
            riderId: widget.riderId.toString(),
            dName: widget.dName.toString(),
            dMobile: widget.dMobile.toString(),
            dPhoto: widget.dPhoto.toString(),
            model: widget.model.toString(),
            vOwnerName: widget.vOwnerName.toString(),
            vRegNo: widget.vRegNo.toString(),
            socketToken: widget.socketToken, driverLicense: widget.driverLicense.toString(), otpRide: widget.otpRide.toString()));
        ToastMessage.toast(msg);
      } else {
        OverlayLoadingProgress;
        ToastMessage.toast(msg);
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
    userId = Preferences.getId(Preferences.id);

    userId = Preferences.getId(Preferences.id).toString();
    Preferences.setVehicleId(widget.vehicleId);
    Preferences.setDriverId(widget.driverId);

    print(userId);
    setState(() {});
  }
}
