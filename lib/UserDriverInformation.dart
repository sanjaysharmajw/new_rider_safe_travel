import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:majascan/majascan.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/DriverVehicleList.dart';
import 'package:ride_safe_travel/FamilyMemberAddScreen.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/start_ride_map.dart';

import 'Error.dart';
import 'LoginModule/MainPage.dart';
import 'LoginModule/Map/RideFamilyListModel.dart';
import 'LoginModule/preferences.dart';
import 'UserVehiclesInfo.dart';

class UserDriverInformation extends StatefulWidget {
  String vehicleId = "";
  String driverId = "";
  String driverName = "";
  String driverMob = "";
  String driverLicense = "";
  String vOwnerName = "";
  String vRegNumber = "";
  String vPucvalidity = "";
  String vFitnessValidity = "";
  String vInsurance = "";
  String vModel = "";
  String dPhoto = "";
  String vPhoto = "";

  UserDriverInformation({Key? key,
    required this.vehicleId,required this.driverId,
    required this.driverName,required this.driverMob,
    required this.driverLicense,required this.vOwnerName,
    required this.vRegNumber,required this.vPucvalidity,
    required this.vFitnessValidity,required this.vInsurance,
    required this.vModel,required this.dPhoto,
    required this.vPhoto,
  }) : super(key: key);

  @override
  State<UserDriverInformation> createState() => _UserDriverInformationState();
}

class _UserDriverInformationState extends State<UserDriverInformation> {

  var date = "";
  Timer? timer;
  var userId;
  late Location location;
  double? lat;
  double? lng;


  @override
  void initState() {
    super.initState();
    locationMethod();
    sharePre();
    final now = DateTime.now();
    date = DateFormat('yMd').format(now);
  }


  void locationMethod() async {
    location = Location();
    location.onLocationChanged.listen((LocationData cLoc) async {
      lat = cLoc.latitude!;
      lng = cLoc.longitude!;
    });
  }

  void sharePre() async {
    await Preferences.setPreferences();
    userId = Preferences.getId(Preferences.id).toString();
    // Get.snackbar("Hit with time", userId);
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          UserVehiclesInfo(
            dInfoName: widget.driverName.toString(),
            dInfoMobile: widget.driverMob.toString(),
            dInfoImage: widget.dPhoto.toString(),
            vInfoImage: widget.vPhoto.toString(),
            vInfoModel: widget.vModel.toString(),
            vInfoOwnerName: widget.vOwnerName.toString(),
            vInfoRegNo: widget.vRegNumber.toString(),
            vInfoPuc: formatDate(widget.vPucvalidity.toString()),
            vInfoFitness: formatDate(widget.vFitnessValidity.toString()),
            vInfoInsurance: formatDate(widget.vInsurance.toString()),
            dInfoLicense: widget.driverLicense.toString(),
            press: () {
              Get.to(MainPage());
            },
            pressBtn: () async {
              OverlayLoadingProgress.start(context);
              await userRideAdd(userId, widget.vehicleId.toString(), widget.driverId.toString());
              setState(() {});
            },
            pressBtnText: 'Start Ride',
          ),
        ],
      ),
    ));
  }

  String formatDate(String date) {
    final DateTime now = DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);
    return formatted;
  }

  Future<http.Response?> userFamilyList(
      String userId, rideId, socketToken) async {
    final response = await http.post(
      Uri.parse('https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/userFamilyList'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
      body: jsonEncode(<String, String>{
        'user_id': userId,
      }),
    );
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      //var msg = jsonDecode(response.body)[ErrorMessage.message];

      if (status == true) {
        // Get.to(
        //     StartRide(
        //     riderId: rideId.toString(),
        //     dName: widget.driverName.toString(),
        //     dMobile: widget.driverMob.toString(),
        //     dPhoto: widget.dPhoto.toString(),
        //     model: widget.vModel.toString(),
        //     vOwnerName: widget.vOwnerName.toString(),
        //     vRegNo: widget.vRegNumber.toString(),
        //     socketToken: socketToken)
        // );
        OverlayLoadingProgress.stop();
        print("Userinformation" + widget.driverId + widget.vehicleId);
      } else {
        Get.to(FamilyMemberAddScreen(
            driverId: widget.driverId,
            vehicleId: widget.vehicleId,
            riderId: rideId.toString(),
            dName: widget.driverName.toString(),
            dMobile: widget.driverMob.toString(),
            dPhoto: widget.dPhoto.toString(),
            model: widget.vModel.toString(),
            vOwnerName: widget.vOwnerName.toString(),
            vRegNo: widget.vRegNumber.toString(),
            socketToken: socketToken));
        OverlayLoadingProgress.stop();
      }
      return null;
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<http.Response> userRideAdd(
      String userId, String vehicleId, String driverId) async {
    final response = await http.post(Uri.parse(ApiUrl.userRideAdd),
        body: json.encode({
          'user_id': userId,
          'vehicle_id': vehicleId,
          'driver_id': driverId,
          'date': date.toString(),
          'start_point': {
            'time': DateTime.now().millisecondsSinceEpoch.toString(),
            'latitude': lat,
            'longitude': lng,
            'location': ""
          }
        }));
    print(json.encode({
      'user_id': userId,
      'vehicle_id': vehicleId,
      'driver_id': driverId,
      'date': date,
      'start_point': {
        'time': DateTime.now().millisecondsSinceEpoch.toString(),
        'latitude': lat,
        'longitude': lng,
        'location': ""
      }
    }));

    print(response.body);
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      print("start Ride:" + response.body);
      if (status == true) {
        if (jsonDecode(response.body)['data'] != null) {
          var rideId = jsonDecode(response.body)['data'];
          var socketToken = jsonDecode(response.body)['sockettoken'];
          await userFamilyList(userId, rideId, socketToken);
        }
      } else if (status == false) {
        // Get.snackbar(response.body, 'Failed');
      }
      return response;
    } else {
      print(response.body);
      throw Exception('Failed to create album.');
    }
  }
}
