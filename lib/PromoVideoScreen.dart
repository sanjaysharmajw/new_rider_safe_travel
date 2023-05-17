import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:ride_safe_travel/TabScreens/ListVIdeoScreen.dart';
import 'package:ride_safe_travel/TabScreens/LiveVideoScreen.dart';

import 'package:ride_safe_travel/color_constant.dart';

import 'Widgets/my_text.dart';


class PromoVideoScreen extends StatefulWidget {
  const PromoVideoScreen({super.key});

  @override
  PromoVideoScreenState createState() => PromoVideoScreenState();
}

class PromoVideoScreenState extends State<PromoVideoScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appWhiteColor,
        body: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: MyText(
                    text: 'Video'.tr,
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
      'Live',
      'Library',
    ];

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
           LiveVideoScreen(status: "Live"),
           ListVideScreen(status: "Library"),
    ];
  }
}



