import 'dart:io';
import 'package:badges/badges.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:majascan/majascan.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/LoginModule/Map/RiderFamilyList.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/MainPageWidgets/MainPageCard.dart';
import 'package:ride_safe_travel/UserDriverInformation.dart';
import 'package:ride_safe_travel/Utils/exit_alert_dialog.dart';
import 'package:ride_safe_travel/Utils/toast.dart';
import '../MainPageWidgets/main_page_btn.dart';
import '../Models/CheckActiveUserRide.dart';
import '../MyRidesPage.dart';
import '../Notification/NotificationScreen.dart';
import '../UserFamilyList.dart';
import '../Utils/logout_dialog_box.dart';
import '../Widgets/dashboard_profile_widgets.dart';
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
  String userId = "";
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
    try {
      String? qrResult = await MajaScan.startScan(
          title: "QR Code scanner",
          titleColor: Colors.amberAccent[700],
          qRCornerColor: Colors.orange,
          qRScannerColor: Colors.orange);
      setState(() {
        result = qrResult ?? 'null string';
        if (result != "") {
          Get.to(UserDriverInformation(result: result));
        } else {
          Get.to(MainPage());
        }
      });
    } on PlatformException catch (ex) {
      if (ex.code == MajaScan.CameraAccessDenied) {
        setState(() {
          Get.to(MainPage());
          //result = "Camera permission was denied";
        });
      } else {
        setState(() {
          // result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        // result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        //result = "Unknown Error $ex";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    sharePreferences();
    print(image);
  }

  void sharePreferences() async {
    await Preferences.setPreferences();
    image = Preferences.getProfileImage().toString();
    profileName = Preferences.getFirstName(Preferences.firstname).toString();
    profileLastName = Preferences.getLastName(Preferences.lastname).toString();
    userId = Preferences.getId(Preferences.id).toString();
    await countNotification();
    profileMobile =
        Preferences.getMobileNumber(Preferences.mobileNumber).toString();
    profileEmailId = Preferences.getEmailId(Preferences.emailId).toString();
    setState(() {});
    //OverlayLoadingProgress.stop();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return WillPopScope(
      onWillPop: () => showExitPopup(context, "Do you want to exit?", () {
        exit(0);
      }),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            InkWell(
              onTap: () async {
                Get.to(NotificationScreen());
                String refresh= await Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>const NotificationScreen()));
                if(refresh=='refresh'){
                  await countNotification();
                }
              },
              child: Badge(
                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 8),
                badgeContent:  Text(
                  countNitification.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                badgeColor: Colors.green,
                child: const Icon(Icons.notifications, size: 30),
              ),
            ),
            SizedBox(width: 10),
            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  logoutPopup(context);
                }),
          ],
          elevation: 0,
          centerTitle: true,
          backgroundColor: CustomColor.yellow,
          title: Text("Dashboard",
              style: TextStyle(fontSize: 16.sp, fontFamily: 'transport')),
        ),
        body: Column(
          children: [
            DashboardProfileWidgets(
                image: image,
                profileName: profileName + " " + profileLastName,
                profileMobile: profileMobile,
                emailId: profileEmailId),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
                    Get.to(const FamilyMemberListScreen());
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
          ],
        ),
      )),
    );
  }
  Future<Data> checkActiveUser() async {
    final response = await http.post(
      Uri.parse(ApiUrl.checkActiveUserRide),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': userId,
      }),
    );
    print("Resonse Main"+jsonEncode(<String, String>{
      'user_id': userId,
    }));
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      String socketToken = jsonDecode(response.body)['token'];
      if (socketToken !="") {
        OverlayLoadingProgress.stop();
        List<Data> userCheck = jsonDecode(response.body)['data'].map<Data>((data) => Data.fromJson(data)).toList();
        Get.to(StartRide(
            riderId: userCheck[0].id.toString(),
            dName: userCheck[0].driverName.toString(),
            dMobile: userCheck[0].driverMobileNumber.toString(),
            dPhoto: userCheck[0].driverPhoto.toString(),
            model: userCheck[0].vehicleModel.toString(),
            vOwnerName: userCheck[0].ownerName.toString(),
            vRegNo: userCheck[0].vehicleRegistrationNumber.toString(),
            socketToken: socketToken.toString())
        );
        print(userCheck[0].id.toString());
        print(userCheck[0].driverName.toString());
        print(userCheck[0].driverMobileNumber.toString());
        print(userCheck[0].driverPhoto.toString());
        print(userCheck[0].vehicleModel.toString());
        print(userCheck[0].ownerName.toString());
        print(userCheck[0].vehicleRegistrationNumber.toString());
        print(socketToken.toString());
        setState(() {});
      } else if (socketToken =="") {
        _scanQR();
        OverlayLoadingProgress.stop();
        print("Print False........");
      }
      return Data.fromJson(response.body);
    } else {
      //Get.snackbar(response.body, 'Failed');
      throw Exception('Failed to create album.');
    }
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
      print("respins noti $countNitification");
      //ToastMessage.toast(status.toString());
      setState(() {
      });
      return response;
    } else {
      throw Exception('Failed');
    }
  }
}
