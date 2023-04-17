import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/bottom_nav/profile_nav.dart';
import 'package:ride_safe_travel/color_constant.dart';

import '../LoginModule/Map/RiderFamilyList.dart';
import '../MyRidesPage.dart';
import '../RejectedServiceList.dart';
import '../ServiceListPage.dart';
import '../Utils/exit_alert_dialog.dart';
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
    const FamilyMemberListScreen(changeUiValue: 'bottomNav'),
     MyRidesPage(changeAppbar: 'bottomNav',),
     RejectedServiceList(changeColor: 'bottomNav',),
     ProfileNav(backbutton: 'bottomNav',),
  ];

  List<BottomNavigationBarItem> icons =const [
    BottomNavigationBarItem(icon: Icon(FeatherIcons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.assistant_navigation), label: "Track Family "),
    BottomNavigationBarItem(icon: Icon(Icons.directions_car_outlined), label: 'My Rides'),
    BottomNavigationBarItem(icon: Icon(Icons.car_repair_outlined), label: 'Services'),
    BottomNavigationBarItem(icon: Icon(FeatherIcons.user), label: 'Profile')
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
