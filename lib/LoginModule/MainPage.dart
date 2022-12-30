import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:majascan/majascan.dart';
import 'package:ride_safe_travel/LoginModule/Map/RiderFamilyList.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/MainPageWidgets/MainPageCard.dart';
import 'package:ride_safe_travel/UserDriverInformation.dart';

import '../MainPageWidgets/main_page_btn.dart';
import '../MyRidesPage.dart';
import '../UserFamilyList.dart';
import '../rider_profile_view.dart';


/*class SizeConfig {
  static MediaQueryData? _mediaQueryData;
   static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData?.size.width;
    screenHeight = _mediaQueryData?.size.height;
    blockSizeHorizontal = 100 / screenWidth!;
    blockSizeVertical = 100 / screenHeight!;

    _safeAreaHorizontal = _mediaQueryData!.padding.left +
        _mediaQueryData?.padding.right;
    _safeAreaVertical = _mediaQueryData?.padding.top +
        _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth -
        _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight -
        _safeAreaVertical) / 100;
  }
}  */

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {



  String result = "";
 // String image="";

  Future _scanQR() async {
    try {
      String? qrResult = await MajaScan.startScan(
          title: "QR Code scanner",
          titleColor: Colors.amberAccent[700],
          qRCornerColor: Colors.orange,
          qRScannerColor: Colors.orange);
      setState(() {
        result = qrResult ?? 'null string';
        if (result != null) {
          Get.to(UserDriverInformation(result: result));
        }
      });
    } on PlatformException catch (ex) {
      if (ex.code == MajaScan.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  @override
  void initState() {
   // Preferences.setImage(Preferences.image, image);

    super.initState();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: CustomColor.yellow,
        title: const Text("Dashboard",
            style: TextStyle(fontSize: 18, fontFamily: 'transport')),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),

            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainPageCard(
                  icons: 'images/my_profile.png',
                  text: 'My Profile',
                  press: (){
                    Get.to(RiderProfileView());

                  },
                  width: 170,
                  height: 170,
                  widthImage: 50, heightImage: 50,
                ),
                MainPageCard(
                  icons: 'images/my_rides.png',
                  text: 'My Rides',
                  press: () {
                    Get.to(const MyRidesPage());
                  },
                  width: 170,
                  height: 170,widthImage: 50, heightImage: 50,
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
                  press:  _scanQR,
                  width: 170,
                  height: 170,widthImage: 50, heightImage: 50,
                ),
                MainPageCard(
                  icons: 'images/track_me.png',
                  text: 'Track Others',
                  press: () {
                    Get.to(const FamilyMemberListScreen());
                  },
                  width: 170,
                  height: 170, widthImage: 50, heightImage: 50,
                ),
              ],
            ),
            const SizedBox(height: 10),
            MainPageBtn(
                icons: 'images/my_family_icons.png',
                text: 'My Family List',
                press: () {
                  Get.to(const UserFamilyList());
                }),
          ],
        ),
      ),
    ));
  }


}

