import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/bottom_nav/profile_nav.dart';
import 'package:ride_safe_travel/color_constant.dart';
import '../LoginModule/Map/RiderFamilyList.dart';
import '../MyRidesPage.dart';
import '../RejectedServiceList.dart';
import '../Utils/exit_alert_dialog.dart';
import '../tracking/tracking_tabs.dart';
import 'home_page_nav.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({super.key});

  @override
  UserDashBoardScreenState createState() => UserDashBoardScreenState();
}

class UserDashBoardScreenState extends State<CustomBottomNav> {
  int currentPage = 0;


  List<Widget> page = [
    const HomePageNav(),
      TrackingTabPage(),
     MyRidesPage(changeAppbar: 'bottomNav',),
     RejectedServiceList(),
     ProfileNav(backbutton: 'bottomNav',),
  ];

  List<BottomNavigationBarItem> icons = [
    BottomNavigationBarItem(icon: Icon(FeatherIcons.home), label: 'home'.tr),
    BottomNavigationBarItem(icon: Icon(Icons.assistant_navigation), label: 'track_family'.tr),
    BottomNavigationBarItem(icon: Icon(Icons.directions_car_outlined), label: 'my_rides'.tr),
    BottomNavigationBarItem(icon: Icon(Icons.car_repair_outlined), label: 'services'.tr),
    BottomNavigationBarItem(icon: Icon(FeatherIcons.user), label: 'profile'.tr)
  ];



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context, "Do you want to exit?", () {
        exit(0);
      }),
      child: Scaffold(
        body: page[currentPage],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: appBlue,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          currentIndex: currentPage,
          type: BottomNavigationBarType.fixed,
          items: icons,
          onTap: (value) {
            currentPage = value;
            setState(() {});
          },
        ),
      ),
    );
  }
}
