import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/DriverVehicleList.dart';
import 'package:ride_safe_travel/FamilyMemberAddScreen.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/LoginModule/Map/RiderMap.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/Models/userFamilyListModels.dart';
import 'package:ride_safe_travel/UserVehiclesInfo.dart';
import 'package:ride_safe_travel/start_ride_map.dart';

import 'Error.dart';

class UserDriverInformation extends StatefulWidget {
  String result;

  UserDriverInformation({Key? key, required this.result}) : super(key: key);

  @override
  State<UserDriverInformation> createState() => _UserDriverInformationState();
}

class _UserDriverInformationState extends State<UserDriverInformation> {
  var vehicleId = "";
  var driverId = "";
  var driverName = "";
  var driverMob = "";
  var driverLicense = "";
  var vOwnerName = "";
  var vRegNumber = "";
  var vPucvalidity = "";
  var vFitnessValidity = "";
  var vInsurance = "";
  var vModel = "";
  var dPhoto = "";
  var vPhoto = "";
  Timer? timer;
  var userId;

  @override
  void initState() {
    super.initState();
    sharePre();
    OverlayLoadingProgress.start(context);
    driverVehicleListApi(context);
  }

  void sharePre() async {
    await Preferences.setPreferences();
    userId = Preferences.getId(Preferences.id).toString();
    Get.snackbar("Hit with time", userId);
  }

  Future<DriverVehicleList> driverVehicleListApi(BuildContext context) async {
    final response = await http.post(
      Uri.parse(ApiUrl.driverVehicleList),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'driver_id': widget.result.toString(),
        'status': "Active",
      }),
    );
    print(jsonEncode(<String, String>{
      'driver_id': widget.result.toString(),
      'status': "Active",
    }));

    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      if (status == true) {
        OverlayLoadingProgress.stop(context);
        List<Data> driverDetails = jsonDecode(response.body)['data']
            .map<Data>((data) => Data.fromJson(data))
            .toList();
        driverName = driverDetails[0].driverName.toString();
        driverMob = driverDetails[0].driverMobileNumber.toString();
        driverLicense = driverDetails[0].drivingLicenceNumber.toString();
        vOwnerName = driverDetails[0].ownerName.toString();
        vRegNumber =
            driverDetails[0].vehicledetails![0].registrationNumber.toString();
        vPucvalidity = formatDate(
            driverDetails[0].vehicledetails![0].pucValidity.toString());
        vFitnessValidity = formatDate(
            driverDetails[0].vehicledetails![0].fitnessValidity.toString());
        vInsurance = formatDate(
            driverDetails[0].vehicledetails![0].insuranceValidity.toString());
        vModel = driverDetails[0].vehicledetails![0].model.toString();
        dPhoto = driverDetails[0].driverPhoto.toString();
        vPhoto = driverDetails[0].ownerPhoto.toString();

        var vehicleIds = driverDetails[0].vehicledetails![0].id.toString();
        var driverIds = driverDetails[0].driverId.toString();
        setState(() {});
        Preferences.setVehicleId(vehicleIds);
        Preferences.setDriverId(driverIds);
        setState(() {});
      } else if (status == false) {
        OverlayLoadingProgress.stop(context);
      }
      return DriverVehicleList.fromJson(response.body);
    } else {
      Get.snackbar(response.body, 'Failed');
      throw Exception('Failed to create album.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          UserVehiclesInfo(
            dInfoName: driverName.toString(),
            dInfoMobile: driverMob.toString(),
            dInfoImage: dPhoto.toString(),
            vInfoImage: vPhoto.toString(),
            vInfoModel: vModel.toString(),
            vInfoOwnerName: vOwnerName.toString(),
            vInfoRegNo: vRegNumber.toString(),
            vInfoPuc: vPucvalidity.toString(),
            vInfoFitness: vFitnessValidity.toString(),
            vInfoInsurance: vInsurance.toString(),
            dInfoLicense: driverLicense.toString(),
            press: () {},
            pressBtn: () {
              OverlayLoadingProgress.start(context);
              userFamilyList(userId);
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

  Future<http.Response?> userFamilyList(String userId) async {
    final response = await http.post(
      Uri.parse(
          'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/userFamilyList'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': userId,
      }),
    );
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      //var msg = jsonDecode(response.body)[ErrorMessage.message];
      if (status == true) {
        OverlayLoadingProgress.stop(context);
        Get.snackbar("Message", "Successful",
            snackPosition: SnackPosition.BOTTOM);
        Get.to(StartRide());
        print("Userinformation"+driverId+vehicleId);

        // List<familyListData> familyData = jsonDecode(response.body)['data']
        //     .map<familyListData>((data) => familyListData.fromJson(data))
        //     .toList();
        // var id = familyData[0].id;
        // var userId = familyData[0].userId;
        // var relation = familyData[0].relation;
        // var memberId = familyData[0].memberId;
        // print(id! + userId! + relation! + memberId!);

      } else {
        OverlayLoadingProgress.stop(context);
        Get.snackbar("Message", "wertyuio",
            snackPosition: SnackPosition.BOTTOM);
        Get.to(FamilyMemberAddScreen(driverId: driverId, vehicleId: vehicleId));
      }
      return null;
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
