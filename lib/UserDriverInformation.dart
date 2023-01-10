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
  var date = "";
  Timer? timer;
  var userId;
  late Location location;
  double? lat;
  double? lng;

  var vehicleIds;
  var driverIds;

  @override
  void initState() {
    super.initState();
    locationMethod();
    sharePre();
    OverlayLoadingProgress.start(context);
    driverVehicleListApi(context);
    final now = DateTime.now();
    date = DateFormat('yMd').format(now);
  }

  var qresult;

  Future _scanQR() async {
    try {
      String? qrResult = await MajaScan.startScan(
          title: "QR Code scanner",
          titleColor: Colors.amberAccent[700],
          qRCornerColor: Colors.orange,
          qRScannerColor: Colors.orange);
      setState(() {
        qresult = qrResult ?? 'null string';
        if (qresult != "") {
          Get.to(UserDriverInformation(result: qresult));
        } else {
          Get.to(MainPage());
        }
      });
    } on PlatformException catch (ex) {
      if (ex.code == MajaScan.CameraAccessDenied) {
        setState(() {

          qresult = "Camera permission was denied";

        });
      } else {
        setState(() {
          qresult = "Unknown Error $ex";

        });
      }
    } on FormatException {
      setState(() {
        qresult = "You pressed the back button before scanning anything";

      });
    } catch (ex) {
      setState(() {
        qresult = "Unknown Error $ex";

      });
    }
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
        OverlayLoadingProgress.stop();
        List<Data> driverDetails = jsonDecode(response.body)['data']
            .map<Data>((data) => Data.fromJson(data))
            .toList();
        if(driverDetails.length==0)
          {
            _scanQR();
          }
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

        vehicleIds = driverDetails[0].vehicledetails![0].id.toString();
        driverIds = driverDetails[0].driverId.toString();
        setState(() {});
        // Preferences.setVehicleId(vehicleIds);
        // Preferences.setDriverId(driverIds);
        setState(() {});
      } else if (status == false) {
        OverlayLoadingProgress.stop();
      }
      return DriverVehicleList.fromJson(response.body);
    } else {
      //Get.snackbar(response.body, 'Failed');
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
            press: () {
              Get.to(MainPage());
            },
            pressBtn: () async {
              OverlayLoadingProgress.start(context);
              await userRideAdd(
                  userId, vehicleIds.toString(), driverIds.toString());
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
        Get.to(
            StartRide(
            riderId: rideId.toString(),
            dName: driverName.toString(),
            dMobile: driverMob.toString(),
            dPhoto: dPhoto.toString(),
            model: vModel.toString(),
            vOwnerName: vOwnerName.toString(),
            vRegNo: vRegNumber.toString(),
            socketToken: socketToken)
        );
        OverlayLoadingProgress.stop();
        print("Userinformation" + driverId + vehicleId);
      } else {
        Get.to(FamilyMemberAddScreen(
            driverId: driverId,
            vehicleId: vehicleId,
            riderId: rideId.toString(),
            dName: driverName.toString(),
            dMobile: driverMob.toString(),
            dPhoto: dPhoto.toString(),
            model: vModel.toString(),
            vOwnerName: vOwnerName.toString(),
            vRegNo: vRegNumber.toString(),
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
