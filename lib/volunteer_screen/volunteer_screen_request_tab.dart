import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:ride_safe_travel/Utils/CustomLoader.dart';

import 'package:ride_safe_travel/volunteer_screen/volunteer_accept_screen.dart';
import 'package:ride_safe_travel/volunteer_screen/volunteer_all_screen.dart';
import 'package:ride_safe_travel/volunteer_screen/volunteer_reject_screen.dart';


import '../Widgets/my_text.dart';
import '../color_constant.dart';

class VolunteerRequestListTabScreen extends StatefulWidget {
  const VolunteerRequestListTabScreen({super.key});

  @override
  VolunteerRequestListTabScreenState createState() => VolunteerRequestListTabScreenState();
}

class VolunteerRequestListTabScreenState extends State<VolunteerRequestListTabScreen>  with SingleTickerProviderStateMixin {

 // int? selected_index;
  TabController? _controller;
  int selectedIndex = 0;
  List<String> tabNames = [
    'all'.tr,
    'accepted'.tr,
    'rejected'.tr,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: tabNames.length, vsync: this);

    _controller?.addListener(() {
      setState(() {
        selectedIndex = _controller!.index;

      });
      print("Selected Index: " + selectedIndex.toString());
    });


  }



  @override
  Widget build(BuildContext context) {
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
                    text: 'Volunteer'.tr,
                    fontName: 'Gilroy',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    textColor: appBlack),
              ),
              Expanded(
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: appWhiteColor,
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
                          controller: _controller,
                            onTap: (index) {
                              setState(() {
                                selectedIndex = index;
                                CustomLoader.message(index.toString());
                              });
                            },
                            labelPadding: const EdgeInsets.only(left: 25,right: 25),
                            isScrollable: true,
                            tabs: getTabs(),
                            indicatorColor: appBlue)
                      ],
                    ),
                  ),
                  /*--------------- Build Tab body here -------------------*/
                  body: TabBarView(
                    controller: _controller,
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


    List<Tab> tabs = [];
    for (String tabName in tabNames) {
      tabs.add(Tab(
          child: MyText(
              text: tabName,
              fontName: 'Gilroy',
              fontSize: 15,
              fontWeight: FontWeight.w500,
              textColor: appBlack)));
    }
    return tabs;
  }

  List<Widget> getTabContents() {
    return  [
      VolunteerAllScreen(status: ""),
      VolunteerAcceptScreen(status: "Accept"),
      VolunteerRejectScreen(status: "Reject"),
    ];
  }

}
