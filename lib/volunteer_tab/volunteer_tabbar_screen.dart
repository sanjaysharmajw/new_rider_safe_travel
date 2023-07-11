import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ride_safe_travel/volunteer_tab/volunteer_tabbar_controller.dart';

import '../MyText.dart';
import '../Utils/CustomLoader.dart';
import '../color_constant.dart';
import '../volunteer_screen/volunteer_accept_screen.dart';
import '../volunteer_screen/volunteer_all_screen.dart';
import '../volunteer_screen/volunteer_reject_screen.dart';



class volunteerTabBarScreen extends StatelessWidget {


  volunteerTabBarScreen({super.key});

 /* TabController? _controller;
  int selectedIndex = 0;
  List<String> tabNames = [
    'all',
    'accepted',
    'rejected',
  ];*/

  @override
  Widget build(BuildContext context) {
    final myTabController = Get.put(MyTabBar());
    return SafeArea(
      child: Scaffold(
        backgroundColor: appWhiteColor,
        body: DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: MyText(
                    text: 'Volunteer',
                    fontFamily: 'Gilroy',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: appBlack),
              ),
              Expanded(
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: appLightGrey,
                    centerTitle: true,
                    elevation: 0,
                    toolbarHeight: 48,
                    automaticallyImplyLeading: false,
                    flexibleSpace: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /*-------------- Build Tabs here ------------------*/
                        TabBar(
                            controller: myTabController.tabController,
                            onTap: (index) {

                                //selectedIndex = index;
                                //CustomLoader.message(index.toString());

                            },
                            labelPadding: const EdgeInsets.only(left: 25,right: 25),
                            isScrollable: true,
                            tabs: myTabController.tabNames,
                            indicatorColor: appBlue)
                      ],
                    ),
                  ),
                  /*--------------- Build Tab body here -------------------*/
                  body: TabBarView(
                    controller: myTabController.tabController,
                    children: getTabContents(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  List<Widget> getTabContents() {
    return  [
      VolunteerAllScreen(status: ""),
      VolunteerAcceptScreen(status: "Accept"),
      VolunteerRejectScreen(status: "Reject"),
    ];
  }
}
