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
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ride_safe_travel/LoginModule/Map/RiderFamilyList.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/MainPageWidgets/MainPageCard.dart';
import 'package:ride_safe_travel/UserDriverInformation.dart';
import 'package:ride_safe_travel/Utils/exit_alert_dialog.dart';
import 'package:ride_safe_travel/Utils/toast.dart';
import '../DriverVehicleList.dart';
import '../FeedBackPage.dart';
import '../MainPageWidgets/main_page_btn.dart';
import '../Models/CheckActiveUserRide.dart';
import '../MyRidesPage.dart';
import '../Notification/NotificationScreen.dart';
import '../ServiceListPage.dart';
import '../ServicesPage.dart';
import '../UserFamilyList.dart';
import '../Utils/logout_dialog_box.dart';
import '../Widgets/dashboard_profile_widgets.dart';
import '../chat_bot/ChatScreen.dart';
import '../rider_profile_view.dart';
import '../start_ride_map.dart';
import 'Api_Url.dart';
import 'Error.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String result = "";
  String image = "";

  String profileName = "";
  String profileMobile = "";
  String profileLastName = "";
  String profileEmailId = "";
  late int countNitification=0;

  // bool refreshValue=false;
  // void refreshData(){
  //   setState(() {
  //     refreshValue=true;
  //   });
  // }
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
var userId;
  void sharePre() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await getLocation();
    await Preferences.setPreferences();
    userId = Preferences.getId(Preferences.id).toString();
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


    // listen for user to click on notification
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
   // String? instaid=FirebaseInstallations.instance.getId() as String?;
    await Preferences.setPreferences();
    image = Preferences.getProfileImage().toString();
   // profileName = Preferences.getFirstName(Preferences.firstname).toString();
    //profileLastName = Preferences.getLastName(Preferences.lastname).toString();
    profileName = Preferences.getFirstName(Preferences.firstname).toString() + " " + Preferences.getLastName(Preferences.lastname).toString();
   // userId = Preferences.getId(Preferences.id).toString();
    await countNotification();
    profileMobile =
        Preferences.getMobileNumber(Preferences.mobileNumber).toString();
    profileEmailId = Preferences.getEmailId(Preferences.emailId).toString();

    //OverlayLoadingProgress.stop();
    print("Profile Details"+" "+profileMobile+" "+profileName+" "+profileEmailId);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return WillPopScope(
      onWillPop: () => showExitPopup(context, "Do you want to exit?", () {
        exit(0);
      }),
      child: Scaffold(
      //debugShowCheckedModeBanner: false,
      //  home: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
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
                  style: const TextStyle(color: CustomColor.black,fontSize: 15, fontFamily: 'transport',),
                ),
                child: const Icon(Icons.notifications_outlined, size: 30,color: CustomColor.black,),
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
              icon: const Icon(Icons.feedback_outlined),
              color: CustomColor.black,
              onPressed: () {
                Get.to(const FeedBackScreenPage());
              }),


          IconButton(
              icon: const Icon(Icons.chat),
              color: CustomColor.black,
              onPressed: () {
                Get.to(const ChatScreen());
              }),
          IconButton(
              icon: const Icon(Icons.logout),
              color: CustomColor.black,
              onPressed: () {
                logoutPopup(context);
              }),



        ],
        elevation: 15,
        centerTitle: false,
        backgroundColor: CustomColor.yellow,
        title:const Text("Dashboard",
          style: TextStyle(color: CustomColor.black,fontSize: 20, fontFamily: 'transport',),),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          //height: 400,
          child: Column(
            children: [
              DashboardProfileWidgets(
                  image: image,
                  profileName: profileName.toString() == "null" ? " " : profileName.toString(),
                  profileMobile: profileMobile.toString() == "null" ? " " : profileMobile.toString(),
                  emailId: profileEmailId.toString() == "null" ? " " : profileEmailId.toString(),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainPageCard(
                    icons: 'images/my_profile.png',
                    text: 'My Profile',
                    press: () {
                      Get.to(const RiderProfileView());
                    },
                    width: 165.w,
                    height: 165.h,
                    widthImage: 45.w,
                    heightImage: 45.h,
                  ),
                  MainPageCard(
                    icons: 'images/my_rides.png',
                    text: 'My Rides',
                    press: () {
                      Get.to(const MyRidesPage());
                    },
                    width: 165.w,
                    height: 165.h,
                    widthImage: 45.w,
                    heightImage: 45.h,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MainPageCard(
                    icons: 'images/track_me.png',
                    text: 'Track Me',
                    press: (){
                      OverlayLoadingProgress.start(context);
                      checkActiveUser();
                    }, //_scanQR
                    width: 165.w,
                    height: 165.h,
                    widthImage: 45.w,
                    heightImage: 45.h,
                  ),
                  MainPageCard(
                    icons: 'images/track_me.png',
                    text: 'Track Others',
                    press: () {
                     Get.to( FamilyMemberListScreen());
                      //Navigator.push(context, MaterialPageRoute(builder:
                      //(context)=>FamilyMemberListScreen(userId: userId.toString(),)));
                    },
                    width: 165.w,
                    height: 165.h,
                    widthImage: 45.w,
                    heightImage: 45.h,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                child: MainPageBtn(
                    icons: 'images/my_family_icons.png',
                    text: 'My Family List',
                    press: () {
                      Get.to(const UserFamilyList());
                    }),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                child: InkWell(
                  onTap: (){
                    Get.to(const ServicesScreenPage());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(8)),
                        border: Border.all(
                            color: Colors.black38,
                            width: 1.5)),
                    child: Container(
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: CustomColor.lightYellow,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.miscellaneous_services_rounded),
                          SizedBox(width: 10.w),
                          Text("Services",
                              style: const TextStyle(
                                  fontFamily: 'transport', fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                  ),
                )
              ),
              SizedBox(height: 8.h),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                  child: InkWell(
                    onTap: (){
                      Get.to(const ServiceListScreenPage());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(8)),
                          border: Border.all(
                              color: Colors.black38,
                              width: 1.5)),
                      child: Container(
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: CustomColor.lightYellow,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.miscellaneous_services_rounded),
                            SizedBox(width: 10.w),
                            Text("Service List",
                                style: const TextStyle(
                                    fontFamily: 'transport', fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                    ),
                  )
              ),
              SizedBox(height: 25.h),
            ]
        ),
      ),
     )
    )
    );
  }
  Future<String> checkActiveUser() async {
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    print( "USER"+jsonEncode(<String, String>{
      'user_id': userId,
    }),);

    final response = await http.post(
      Uri.parse(ApiUrl.checkActiveUserRide),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': loginToken

      },
      body: jsonEncode(<String, String>{
        'user_id': userId,
      }),
    );
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
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
            socketToken: socketToken.toString(), driverLicense: userCheck[0].drivingLicenceNumber.toString()));
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
  Future<http.Response> countNotification() async {
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    final response = await http.post(Uri.parse(ApiUrl.countNotification),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': loginToken

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

    var loginToken = Preferences.getLoginToken(Preferences.loginToken);

    final response = await http.post(
      Uri.parse(ApiUrl.driverVehicleList),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': loginToken
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
}
