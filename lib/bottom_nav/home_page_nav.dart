import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:ride_safe_travel/bottom_nav/profile_nav.dart';
import '../LoginModule/Map/RiderFamilyList.dart';
import '../Models/CheckActiveUserRide.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';

import 'package:ride_safe_travel/bottom_nav/service_request_list.dart';
import '../DriverVehicleList.dart';
import '../Error.dart';
import '../LoginModule/Api_Url.dart';
import '../LoginModule/MainPage.dart';

import '../MyRidesPage.dart';
import '../MyText.dart';
import '../Notification/NotificationScreen.dart';
import '../UserDriverInformation.dart';
import '../UserFamilyList.dart';
import '../Utils/exit_alert_dialog.dart';
import '../Utils/profile_horizontal_view.dart';
import '../Utils/toast.dart';
import '../controller/end_ride_controller.dart';
import '../controller/get_count_notification_controller.dart';
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
  final listController = Get.put(MyRiderController());
  final checkUserController = Get.put(CheckUserController());
  final getCountController = Get.put(GetNotificationController());
  LocationData? locationData;
  late Location location;

  var myRiderCount="";
  var peopleTrackingMe="";
  var trackFamily="";

  String profileName = "";
  String profileMobile = "";
  String profileLastName = "";
  String profileEmailId = "";
  String? riderIdFromStartRider;
  late int countNitification = 0;

  var userId;
  var riderOtp = "";
  void sharePre() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await getLocation();
    await Preferences.setPreferences();
    userId = Preferences.getId(Preferences.id).toString();
    riderOtp = Preferences.getRideOtp();
    setState(() {});
    location = Location();
    locationData = await location.getLocation();
  }

  @override
  void initState() {
    getCount();
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
    setState(() {});
    await Preferences.setPreferences();
    image = Preferences.getProfileImage().toString();
    profileName = Preferences.getFirstName(Preferences.firstname).toString() +
        " " +
        Preferences.getLastName(Preferences.lastname).toString();
    await countNotification();
    profileMobile =
        Preferences.getMobileNumber(Preferences.mobileNumber).toString();
    profileEmailId = Preferences.getEmailId(Preferences.emailId).toString();
    riderIdFromStartRider = Preferences.getNewRiderId().toString();

    //OverlayLoadingProgress.stop();
    print("Profile Details" +
        " " +
        profileMobile +
        " " +
        profileName +
        " " +
        profileEmailId);
  }

  @override
  Widget build(BuildContext context) {
    return GetX<MyRiderController>(
        init: MyRiderController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          margin:
                              const EdgeInsets.only(right: 15, left: 15, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   MyText(
                                      text: 'Nirbhaya Rider',
                                      fontFamily: 'Gilroy',
                                      color: Colors.black,
                                      fontSize: 22),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          Get.to(const NotificationScreen());
                                          String refresh= await Navigator.push(context,
                                              MaterialPageRoute(builder: (context)=>const NotificationScreen()));
                                          if(refresh=='refresh'){
                                            await countNotification();
                                          }
                                        },
                                        child: Center(
                                          child: badges.Badge(
                                            badgeContent:  Text(
                                              countNitification.toString(),
                                              style: const TextStyle(color: CustomColor.black,fontSize: 15, fontFamily: 'Gilroy',),
                                            ),
                                            child: const Icon(Icons.notifications_outlined, size: 40,color: CustomColor.black,),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileNav()));
                                            },
                                          child: CircleAvatar(
                                            backgroundColor: CustomColor.black,
                                            radius: 27,
                                            child: CircleAvatar(
                                              radius: 26,
                                              backgroundColor: Colors.white,
                                              child: AspectRatio(
                                                aspectRatio: 1,
                                                child: ClipOval(
                                                  child: CachedNetworkImage(
                                                      imageUrl: image.toString(),
                                                      width: 30,
                                                      height: 20,
                                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                          CircularProgressIndicator(value: downloadProgress.progress),
                                                      errorWidget: (context, url, error) => Image(image: AssetImage("assets/user_avatar.png"))
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )

                                ],
                              ),
                              const SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.only(right: 5, left: 5),
                                child: ProfileHozontalView(
                                    profileName: profileName,
                                    profileMobile: Preferences.getMobileNumber(
                                            Preferences.mobileNumber)
                                        .toString(),
                                    click: () {
                                      Get.to(const RiderProfileView());
                                    },
                                    imageLink:
                                        Preferences.getProfileImage().toString()),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin:
                              const EdgeInsets.only(left: 20, right: 20, top: 30),
                          child: MyText(
                              text: 'Progress',
                              fontFamily: 'Gilroy',
                              color: Colors.black,
                              fontSize: 16),
                        ),
                        GridView.count(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            crossAxisCount: 2,
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10),
                            mainAxisSpacing: 20,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 20,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to( MyRidesPage(changeAppbar: 'fromClass',));
                                },
                                child:  HomePageItems(
                                  completed: 58,
                                  backgroundColor: Colors.blue,
                                  title: 'My Rides',
                                  subtitle: myRiderCount!.toString(),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(const UserFamilyList());
                                },
                                child:  HomePageItems(
                                  completed: 58,
                                  backgroundColor: Colors.red,
                                  title: 'People Tracking Me',
                                  subtitle: peopleTrackingMe!.toString(),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(const FamilyMemberListScreen(changeUiValue: 'fromClass'));
                                },
                                child:  HomePageItems(
                                  completed: 45,
                                  backgroundColor: Colors.green,
                                  title: 'Track Family & Friends',
                                  subtitle: trackFamily!.toString(),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  OverlayLoadingProgress.start(context);
                                  checkActiveUser();
                                },
                                child: const HomePageItems(
                                  completed: 58,
                                  backgroundColor: Colors.orange,
                                  title: 'Start new ride',
                                  subtitle: '',
                                ),
                              ),
                            ]),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                      child: MyText(
                          text: 'My Active Ride List',
                          fontFamily: 'Gilroy',
                          color: Colors.black,
                          fontSize: 16),
                    ),
                    Container(
                      child: Center(
                        child: controller.isLoading.value
                            ? LoaderUtils.loader():
                             controller.getMyRiderData.isEmpty
                                ? const Center(
                                    child: EmptyScreen(),
                                  )
                                : ListView.builder(
                                    itemCount: controller.getMyRiderData.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return MyRiderItemsList(
                                        myRideList:
                                            controller.getMyRiderData[index],
                                        pressOnView: () {
                                          OverlayLoadingProgress.start(context);
                                          checkActiveUser();
                                        },
                                        pressOnEnd: () {
                                          showExitPopup(context,
                                              "Do you want to stop ride?",
                                              () async {
                                            Navigator.pop(context, true);
                                            checkUser(userId, index);
                                          });
                                        },
                                      );
                                    }),
                      ),
                    ),
                  ],
                ),
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
        print("qrResult" + qrResult.toString());
        result = qrResult ?? 'null string';
        print("ScanQRCode:" + result);
        if (result != "") {
          if (result.length == 24) {
            print("ScanQR:" + result);
            driverVehicleListApi(result);
          } else {
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
    Location location = Location();
    var _permissionGranted = await location.hasPermission();
    _serviceEnabled = await location.serviceEnabled();
    if (_permissionGranted != PermissionStatus.granted || !_serviceEnabled) {
      _permissionGranted = await location.requestPermission();
      _serviceEnabled = await location.requestService();
      ToastMessage.toast("Access Granted");
    }
    setState(() {});
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
      setState(() {});
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
        "status": "Active"
      }),
    );
    print(jsonEncode(<String, String>{
      'driver_id': result.toString(),
      "status": "Active"
    }));

    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];

      if (status == true) {
        OverlayLoadingProgress.stop();
        List<VehicleListData> driverDetails = jsonDecode(response.body)['data']
            .map<VehicleListData>((data) => VehicleListData.fromJson(data))
            .toList();
        print('family: $driverDetails');
        var driverName = driverDetails[0].driverName;
        var driverMob = driverDetails[0].driverMobileNumber.toString();
        var driverLicense =
            driverDetails[0].drivingLicenceNumber.toString() ?? "";
        var vOwnerName = driverDetails[0].ownerName.toString();
        var vRegNumber =
            driverDetails[0].vehicledetails![0].registrationNumber.toString();

        var vPucvalidity =
            driverDetails[0].vehicledetails![0].pucValidity.toString();
        var vFitnessValidity =
            driverDetails[0].vehicledetails![0].fitnessValidity.toString();
        var vInsurance =
            driverDetails[0].vehicledetails![0].insuranceValidity.toString();
        var vModel = driverDetails[0].vehicledetails![0].model.toString();
        var dPhoto = driverDetails[0].driverPhoto.toString();
        var vPhoto = driverDetails[0].ownerPhoto.toString();
        var vehicleIds = driverDetails[0].vehicledetails![0].id.toString();
        var driverIds = driverDetails[0].driverId.toString();
        var rating = driverDetails[0].otherInfo?.rating?.toDouble();
        var comment = driverDetails[0].otherInfo?.totalComments.toString();
        print("Rating.."+rating.toString());

        // print("PUCValidityDate:"+DateFormat('dd-MM-yyyy').format(DateTime.parse(vPucvalidity)) );
        print(response.body);

        Get.to(UserDriverInformation(
            vehicleId: vehicleIds.toString(),
            driverId: driverIds.toString(),
            driverName: driverName.toString(),
            driverMob: driverMob.toString(),
            driverLicense: driverLicense.toString(),
            vOwnerName: vOwnerName.toString(),
            vRegNumber: vRegNumber.toString(),
            vPucvalidity: vPucvalidity.toString(),
            vFitnessValidity: vFitnessValidity.toString(),
            vInsurance:
                vInsurance.toString(),
            vModel: vModel.toString(),
            dPhoto: dPhoto.toString(),
            vPhoto: vPhoto.toString(),
          rating: rating!,
          totalComment: comment.toString(),
        ));
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
    print(
      "USER" +
          jsonEncode(<String, String>{
            'user_id': userId,
          }),
    );

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
      if (socketToken != "") {
        OverlayLoadingProgress.stop();
        List<Data> userCheck = jsonDecode(response.body)['data']
            .map<Data>((data) => Data.fromJson(data))
            .toList();
        print("UserCheck" + userCheck.toString());
        var id = userCheck[0].id.toString();
        Get.to(StartRide(
            riderId: id.toString(),
            dName: userCheck[0].driverName.toString(),
            dMobile: userCheck[0].driverMobileNumber.toString(),
            dPhoto: userCheck[0].driverPhoto.toString(),
            model: userCheck[0].vehicleModel.toString(),
            vOwnerName: userCheck[0].ownerName.toString(),
            vRegNo: userCheck[0].vehicleRegistrationNumber.toString(),
            socketToken: socketToken.toString(),
            driverLicense: userCheck[0].drivingLicenceNumber.toString(),
            otpRide: riderOtp.toString()));
        var ids = userCheck[0].id.toString();
        print('IDssss: $ids');
        print(userCheck[0].driverName.toString());
        print(userCheck[0].driverMobileNumber.toString());
        print(userCheck[0].driverPhoto.toString());
        print(userCheck[0].vehicleModel.toString());
        print(userCheck[0].ownerName.toString());
        print(userCheck[0].vehicleRegistrationNumber.toString());
        print(socketToken.toString());
        setState(() {});
      } else if (socketToken == "") {
        OverlayLoadingProgress.stop();
        print("Print False........");
        _scanQR();
      }
      var userData = jsonDecode(response.body);
      print("userData:" + userData.toString());
      return userData.toString();
    } else {
      throw Exception('Failed to create.');
    }
  }

  Future<http.Response> endRide(
      String riderId, String lat, String lng, int index) async {
    final response = await http.post(
        Uri.parse(
            'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/userRide/endRide'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'ride_id': riderId,
          'end_point': {
            'time': DateTime.now().millisecondsSinceEpoch.toString(),
            'latitude': lat.toString(),
            'longitude': lng.toString(),
            'location': ""
          }
        }));
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      print("$response");
      if (status == true) {
        LoaderUtils.closeLoader();
        ToastMessage.toast(msg);
        Preferences.setRideOtp(''); //MainPage
        listController.getServiceList(userId.toString());

      } else {
        LoaderUtils.closeLoader();
        ToastMessage.toast(msg);
      }
      return response;
    } else {
      throw Exception('Failed');
    }
  }

  void checkUser(String userid, int index) async {
    await checkUserController.checkActiveUser(userid).then((value) async {
      if (value != null) {
        if (value.status == true) {
          String riderId = value.data![0].id.toString();
          await endRide(riderId, locationData!.latitude.toString(),
              locationData!.longitude.toString(), index);
        }
      }
    });
  }
  void getCount()async{
    await getCountController.getCount().then((value) async {
      if (value != null) {
        if (value.status == true) {
          myRiderCount=value.count.totalRides.toString();
          trackFamily=value.count.familymemberrides.toString();
          peopleTrackingMe=value.count.trackingmembers.toString();
          countNitification=value.data.length;
          setState(() {

          });
        }
      }
    });
  }
}
