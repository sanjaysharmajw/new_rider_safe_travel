import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/LoginModule/Map/RiderMap.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/Models/affFamilyMemberNewModel.dart';
import 'package:ride_safe_travel/Utils/RiderButton.dart';
import 'package:ride_safe_travel/start_ride_map.dart';

import 'LoginModule/Error.dart';
import 'LoginModule/preferences.dart';

class FamilyMemberAddScreen extends StatefulWidget {
   FamilyMemberAddScreen({Key? key,required this.driverId,required this.vehicleId,required this.riderId}) : super(key: key);

  @override
  State<FamilyMemberAddScreen> createState() => _FamilyMemberAddScreenState();

  String driverId;
  String vehicleId;
  String riderId;
}

class _FamilyMemberAddScreenState extends State<FamilyMemberAddScreen> {
  var userId='';
  final TextEditingController controllerRelation = TextEditingController();
  final TextEditingController controllerMobile = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.keyboard_backspace_sharp),
        centerTitle: true,
        backgroundColor: CustomColor.yellow,
        title: const Text("Add Family Member",style: TextStyle(fontFamily: 'transport',fontSize: 18)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          const SizedBox(height: 20),
          const Text("User Who can track",style: TextStyle(fontFamily: 'transport',fontSize: 20)),
           Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: controllerRelation,
              style: const TextStyle(fontFamily: 'transport',fontSize: 14),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Relation',
                hintText: 'Enter Your Family Relation',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              controller: controllerMobile,
              style: const TextStyle(fontFamily: 'transport',fontSize: 14),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Mobile',
                hintText: 'Enter Your Mobile Number',
              ),
            ),
          ),
          RiderButton(click: (){
            OverlayLoadingProgress.start(context);
            addFamilyMember(userId,controllerRelation.text.toString(),controllerMobile.text.toString());
          }, textBtn: 'Add')
        ],
      ),
    ));
  }
  Future<AffFamilyMemberNewModel> addFamilyMember(String userId,String relation,String mobile) async {
    final response = await http.post(
      Uri.parse(
          'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/addFamilyMemberNew'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': userId,
        'relation': relation,
        'mobile_number': mobile,
      }),
    );
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      if (status == true) {
        OverlayLoadingProgress.stop(context);
        Get.to(StartRide(riderId: widget.riderId));
        print(msg);
        print(userId + msg);
      } else {
        OverlayLoadingProgress.stop(context);
        print(msg);
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
    userId = Preferences.getId(Preferences.id);

    userId = Preferences.getId(Preferences.id).toString();
    Preferences.setVehicleId(widget.vehicleId);
    Preferences.setDriverId(widget.driverId);

    print(userId);
    setState(() {});
  }
}
