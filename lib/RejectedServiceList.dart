import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/color_constant.dart';

import 'LoginModule/custom_color.dart';
import 'MyText.dart';
import 'ServicesPage.dart';
import 'Services_Module/requested_servicelists_item.dart';
import 'Services_Module/service_requestlist_controller.dart';
import 'Services_Module/service_types.dart';
import 'Utils/Loader.dart';
import 'bottom_nav/EmptyScreen.dart';
import 'bottom_nav/custom_bottom_navi.dart';

class RejectedServiceList extends StatefulWidget {
  String changeColor;
  RejectedServiceList({Key? key, required this.changeColor}) : super(key: key);

  @override
  State<RejectedServiceList> createState() => _RejectedServiceListState();
}

class _RejectedServiceListState extends State<RejectedServiceList> {
  final requestedservicelist = Get.put(ServiceRequestListController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBlue,
          elevation: 0,
          title: Text("Road Side Assistance",
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
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return requestedservicelist.isLoading.value
                      ? LoaderUtils.loader()
                      : requestedservicelist.requestedList.isEmpty
                          ? const Center(
                              child: EmptyScreen(),
                            )
                          : ListView.builder(
                              itemCount:
                                  requestedservicelist.requestedList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                print(
                                  requestedservicelist.requestedList.length,
                                );

                                return RequestedServiceListItems(
                                  requestedList:
                                      requestedservicelist.requestedList[index],
                                );
                              });
                }),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: FloatingActionButton(
            backgroundColor: appBlue,
            onPressed: () {
              // Get.to(const ServicesScreenPage());
              Get.to(const ServiceListsScreen());
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
