import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:badges/badges.dart' as badges;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:majascan/majascan.dart';
import 'package:location/location.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';
import '../LoginModule/Map/RiderFamilyList.dart';
import '../Models/CheckActiveUserRide.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';

import 'package:ride_safe_travel/bottom_nav/service_request_list.dart';import '../DriverVehicleList.dart';
import '../Error.dart';
import '../LoginModule/Api_Url.dart';
import '../LoginModule/MainPage.dart';

import '../MyRidesPage.dart';
import '../MyText.dart';
import '../UserDriverInformation.dart';
import '../UserFamilyList.dart';
import '../Utils/profile_horizontal_view.dart';
import '../Utils/toast.dart';
import '../rider_profile_view.dart';
import '../start_ride_map.dart';
import 'EmptyScreen.dart';
import 'home_page_items.dart';
import 'my_ride_item_list.dart';
import 'my_rider_controller.dart';


class HomePageNav extends StatefulWidget {
  const HomePageNav({Key? key}) : super(key: key);

  @override
  State<HomePageNav> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageNav> {
  String result = "";
  String image = "";
  final listController=Get.put(MyRiderController());

  String profileName = "";
  String profileMobile = "";
  String profileLastName = "";
  String profileEmailId = "";
  late int countNitification=0;

  var userId;
  var riderOtp="";
  void sharePre() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await getLocation();
    await Preferences.setPreferences();
    userId = Preferences.getId(Preferences.id).toString();
    riderOtp = Preferences.getRideOtp();
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    init();
    sharePre();
    setState(() {
      sharePreferences();
    });
  }

  init() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      String? title = remoteMessage.notification!.title;
      String? description = remoteMessage.notification!.body;
      print(remoteMessage.toString());
      //im gonna have an alertdialog when clicking from push notification
      Alert(
        context: context,
        type: AlertType.error,
        title: title, // title from push notification data
        desc: description, // description from push notifcation data
        buttons: [
          DialogButton(
            child: Text(
              "COOL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    });
  }

  void sharePreferences() async {
    setState(() {

    });
    await Preferences.setPreferences();
    image = Preferences.getProfileImage().toString();
    profileName = Preferences.getFirstName(Preferences.firstname).toString() + " " + Preferences.getLastName(Preferences.lastname).toString();
    await countNotification();
    profileMobile =
        Preferences.getMobileNumber(Preferences.mobileNumber).toString();
    profileEmailId = Preferences.getEmailId(Preferences.emailId).toString();

    //OverlayLoadingProgress.stop();
    print("Profile Details"+" "+profileMobile+" "+profileName+" "+profileEmailId);
  }

  @override
  Widget build(BuildContext context) {

    return GetX<MyRiderController>(
        init: MyRiderController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment:  CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment:  CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(right: 15,left: 15,top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            const MyText(text: 'Nirbhaya Rider', fontFamily: 'transport', color: Colors.black, fontSize: 22),
                            const SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.only(right: 5,left: 5),
                              child: ProfileHozontalView(profileName: profileName,
                                  profileMobile: Preferences.getMobileNumber(Preferences.mobileNumber).toString(), click: () {
                                Get.to(const RiderProfileView());
                              }, imageLink: Preferences.getProfileImage().toString()),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20,right: 20,top: 30),
                        child:
                        const MyText(text: 'Progress', fontFamily: 'transport', color: Colors.black, fontSize: 14),
                      ),
                      GridView.count(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          crossAxisCount: 2,
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                          mainAxisSpacing: 20,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 20,
                          children:   [
                            InkWell(
                              onTap: (){
                                Get.to(const MyRidesPage());
                              },
                              child: const HomePageItems(
                                completed: 58,
                                backgroundColor: Colors.blue, title: 'My Rides', subtitle: '10',
                              ),
                            ),

                            InkWell(
                              onTap: (){
                                Get.to(const UserFamilyList());
                              },
                              child: const HomePageItems(
                                completed: 58,
                                backgroundColor: Colors.red, title: 'People Tracking Me', subtitle: '10',
                              ),
                            ),

                            InkWell(
                              onTap: (){
                                Get.to( const FamilyMemberListScreen());
                              },
                              child: const HomePageItems(
                                completed: 45,
                                backgroundColor: Colors.green, title: 'Track Family & Friends', subtitle: '05',
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                OverlayLoadingProgress.start(context);
                                checkActiveUser();
                              },
                              child: const HomePageItems(
                                completed: 58,
                                backgroundColor: Colors.orange, title: 'Start new ride', subtitle: '',
                              ),
                            ),

                          ]),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20,right: 20,top: 30),
                    child: const MyText(text: 'My Active Ride List', fontFamily: 'transport', color: Colors.black, fontSize: 14),
                  ),
                  Container(
                    child: Center(
                      child: controller.isLoading.value
                          ? LoaderUtils.loader()
                          : controller.getMyRiderData.isEmpty
                          ? const Center(
                        child: EmptyScreen(),
                      ) : ListView.builder(
                          itemCount: controller.getMyRiderData.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return MyRiderItemsList(myRideList: controller.getMyRiderData[index]);
                          }),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future _scanQR() async {
    print("_scanQR");
    try {
      String? qrResult = await MajaScan.startScan(
          barColor: CustomColor.yellow,
          title: "QR Code scanner",
          titleColor: CustomColor.black,
          qRCornerColor: Colors.orange,
          qRScannerColor: Colors.orange);
      setState(() async {
        print("qrResult"+qrResult.toString());
        result = qrResult ?? 'null string';
        print("ScanQRCode:"+result);
        if (result != "") {

          if(result.length==24){
            print("ScanQR:"+result);
            driverVehicleListApi(result);
          }else{
            print("Invalid QR Code");
          }
        }
      });
    } on PlatformException catch (ex) {
      if (ex.code == MajaScan.CameraAccessDenied) {
        setState(() {
          print("Something went wrong");
          Get.to(MainPage());
          //result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
          print(result);
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";

        print(result);
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error$ex ";
        print(result);
      });
    }
  }

  Future getLocation() async {
    bool? _serviceEnabled;
    Location location =  Location();
    var _permissionGranted = await location.hasPermission();
    _serviceEnabled = await location.serviceEnabled();
    if (_permissionGranted != PermissionStatus.granted || !_serviceEnabled) {
      _permissionGranted = await location.requestPermission();
      _serviceEnabled = await location.requestService();
      ToastMessage.toast("Access Granted");
    }
    setState(() {

    });
  }
  Future<http.Response> countNotification() async {
    final response = await http.post(Uri.parse(ApiUrl.countNotification),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'user_id': userId.toString(),
          'count': true,
          'unread': true,
        }));
    print(json.encode({
      'user_id': userId.toString(),
      'count': true,
      'unread': true,
    }));
    if (response.statusCode == 200) {
      //bool status = jsonDecode(response.body)[ErrorMessage.status];
      countNitification = jsonDecode(response.body)['data'];
      //ToastMessage.toast(status.toString());
      setState(() {
      });
      return response;
    } else {
      throw Exception('Failed');
    }
  }
  Future<DriverVehicleList> driverVehicleListApi(String result) async {
    final response = await http.post(
      Uri.parse(ApiUrl.driverVehicleList),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'driver_id': result.toString(),

      }),
    );
    print(jsonEncode(<String, String>{
      'driver_id': result.toString(),

    }));

    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      if (status == true) {
        OverlayLoadingProgress.stop();
        List<VehicleListData> driverDetails = jsonDecode(response.body)['data']
            .map<VehicleListData>((data) => VehicleListData.fromJson(data))
            .toList();
        print('family: $driverDetails');
        var driverName = driverDetails[0].driverName.toString();
        var driverMob = driverDetails[0].driverMobileNumber.toString();
        var driverLicense = driverDetails[0].drivingLicenceNumber.toString()??"";
        var vOwnerName = driverDetails[0].ownerName.toString();
        var vRegNumber = driverDetails[0].vehicledetails![0].registrationNumber.toString();


        var vPucvalidity = driverDetails[0].vehicledetails![0].pucValidity.toString();
        var  vFitnessValidity = driverDetails[0].vehicledetails![0].fitnessValidity.toString();
        var vInsurance = driverDetails[0].vehicledetails![0].insuranceValidity.toString();
        var vModel = driverDetails[0].vehicledetails![0].model.toString();
        var dPhoto = driverDetails[0].driverPhoto.toString();
        var vPhoto = driverDetails[0].ownerPhoto.toString();
        var vehicleIds = driverDetails[0].vehicledetails![0].id.toString();
        var driverIds = driverDetails[0].driverId.toString();
        // print("PUCValidityDate:"+DateFormat('dd-MM-yyyy').format(DateTime.parse(vPucvalidity)) );
        print(response.body);


        Get.to(UserDriverInformation(
            vehicleId: vehicleIds.toString(), driverId: driverIds.toString(), driverName: driverName.toString(),
            driverMob: driverMob.toString(),
            driverLicense: driverLicense.toString(), vOwnerName: vOwnerName.toString(), vRegNumber: vRegNumber.toString(),
            vPucvalidity:DateFormat('dd-MM-yyyy').format(DateTime.parse(vPucvalidity)), vFitnessValidity: DateFormat('dd-MM-yyyy').format(DateTime.parse(vFitnessValidity )),
            vInsurance: DateFormat('dd-MM-yyyy').format(DateTime.parse(vInsurance)), vModel: vModel.toString(), dPhoto: dPhoto.toString(), vPhoto: vPhoto.toString()));
        setState(() {});
      } else if (status == false) {
        OverlayLoadingProgress.stop();
      }
      return DriverVehicleList.fromJson(response.body);
    } else {
      throw Exception('Failed to create.');
    }
  }
  Future<String> checkActiveUser() async {
    print( "USER"+jsonEncode(<String, String>{
      'user_id': userId,
    }),);

    final response = await http.post(
      Uri.parse(ApiUrl.checkActiveUserRide),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': userId,
      }),
    );
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      // var otpRide=jsonDecode(response.body)['data'][0]['ride_start_otp'];

      String socketToken = jsonDecode(response.body)['token'];
      if (socketToken !="") {
        OverlayLoadingProgress.stop();
        List<Data> userCheck = jsonDecode(response.body)['data'].map<Data>((data) => Data.fromJson(data)).toList();
        print("UserCheck"+userCheck.toString());
        var id=userCheck[0].id.toString();
        Get.to(StartRide(
            riderId: id.toString(),
            dName: userCheck[0].driverName.toString(),
            dMobile: userCheck[0].driverMobileNumber.toString(),
            dPhoto: userCheck[0].driverPhoto.toString(),
            model: userCheck[0].vehicleModel.toString(),
            vOwnerName: userCheck[0].ownerName.toString(),
            vRegNo: userCheck[0].vehicleRegistrationNumber.toString(),
            socketToken: socketToken.toString(), driverLicense: userCheck[0].drivingLicenceNumber.toString(), otpRide: riderOtp.toString()));
        var ids=userCheck[0].id.toString();
        print('IDssss: $ids');
        print(userCheck[0].driverName.toString());
        print(userCheck[0].driverMobileNumber.toString());
        print(userCheck[0].driverPhoto.toString());
        print(userCheck[0].vehicleModel.toString());
        print(userCheck[0].ownerName.toString());
        print(userCheck[0].vehicleRegistrationNumber.toString());
        print(socketToken.toString());
        setState(() {});
      } else if (socketToken =="") {

        OverlayLoadingProgress.stop();
        print("Print False........");
        _scanQR();
      }
      var userData = jsonDecode(response.body);
      print("userData:"+userData.toString());
      return userData.toString();
    } else {
      throw Exception('Failed to create.');
    }
  }
}

