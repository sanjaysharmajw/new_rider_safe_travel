import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../LoginModule/Map/RiderFamilyList.dart';
import '../MyText.dart';
import '../UserFamilyList.dart';
import '../bottom_nav/custom_bottom_navi.dart';
import '../color_constant.dart';

class TrackingTabPage extends StatefulWidget {
  const TrackingTabPage({super.key});

  @override
  State<TrackingTabPage> createState() => _TrackingTabPageState();
}

class _TrackingTabPageState extends State<TrackingTabPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appWhiteColor,
        appBar: AppBar(
          backgroundColor: appBlue,
          elevation: 0,
          title: Text("Tracking",
              style: TextStyle(
                color: appWhiteColor,
                fontSize: 22,
                fontFamily: 'Gilroy',
              )),
          leading: IconButton(
            color: appWhiteColor,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CustomBottomNav()));
            },
            icon: const Icon(Icons.arrow_back_outlined),
          ),
        ),
        body: DefaultTabController(
          length: 5,
          initialIndex: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 25,),

              Expanded(
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: appWhiteColor,
                    centerTitle: true,
                    elevation: 0,
                    toolbarHeight: 48,
                    automaticallyImplyLeading: false,
                    flexibleSpace: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /*-------------- Build Tabs here ------------------*/
                        TabBar(
                            labelPadding: const EdgeInsets.only(left: 25,right: 25),
                            isScrollable: true,
                            tabs: getTabs(),
                            indicatorColor: appBlue)
                      ],
                    ),
                  ),
                  /*--------------- Build Tab body here -------------------*/
                  body: TabBarView(
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

  List<Tab> getTabs() {
    List<String> tabNames = [
      "People Tracking Me",
      "Other's Live Ride",
    ];

    List<Tab> tabs = [];
    for (String tabName in tabNames) {
      tabs.add(Tab(
          child: MyText(
              text: tabName,
              fontFamily: 'Gilroy',
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: appBlack)));
    }
    return tabs;
  }

  List<Widget> getTabContents() {
    return  [
      FamilyList(),
      FamilyMemberListScreen(changeUiValue: '',),

    ];
  }
}
