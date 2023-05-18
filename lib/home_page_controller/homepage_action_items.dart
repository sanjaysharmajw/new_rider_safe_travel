

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/Services_Module/selected_service_list.dart';
import 'package:ride_safe_travel/Services_Module/service_types.dart';
import 'package:ride_safe_travel/Widgets/circle_icon_widget.dart';
import 'package:ride_safe_travel/color_constant.dart';

class HomePageAction extends StatelessWidget {
  final VoidCallback sosClick;
  final VoidCallback rideClick;
  final bool startRideVisibility;
  const HomePageAction({Key? key, required this.sosClick, required this.rideClick, required this.startRideVisibility}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 25,right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white60,
                border: Border.all(color: appBlue),
                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
            height: MediaQuery.of(context).size.height * 0.10,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 3, right: 15),
                  child: Text(
                    "road_side_assistance_near_by_you".tr,
                    style: const TextStyle(fontFamily: 'Gilroy', fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          CircleIcon(
                              click: () {
                                Get.to(SelectedServiceLists(
                                  serviceId: "63fc74202e0ec5faaf772783",
                                  backToDashboard: 'DashBoard',
                                ));
                              },
                              imageAssets: 'new_assets/crane-truck.png',
                              allPadding: 7),
                          Text(
                            "towing".tr,
                            style:const TextStyle(
                              fontFamily: 'Gilroy',
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Column(
                        children: [
                          CircleIcon(
                              click: () {
                                Get.to(SelectedServiceLists(
                                  serviceId: "63fc74d82e0ec5faaf772787",
                                  backToDashboard: 'DashBoard',
                                ));
                              },
                              imageAssets: 'new_assets/gas-pump-alt.png',
                              allPadding: 10),
                          Text(
                            "fuel".tr,
                            style:const   TextStyle(
                              fontFamily: 'Gilroy',
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Column(
                        children: [
                          CircleIcon(
                              click: () {
                                Get.to(SelectedServiceLists(
                                  serviceId: "63fc74c62e0ec5faaf772786",
                                  backToDashboard: 'DashBoard',
                                ));
                                ;
                              },
                              imageAssets: 'new_assets/wrench.png',
                              allPadding: 10),
                          Text(
                            "mech.".tr,
                            style: const TextStyle(
                              fontFamily: 'Gilroy',
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Column(
                        children: [
                          CircleIcon(
                              click: () {
                                Get.to(SelectedServiceLists(
                                  serviceId: "63fc74b12e0ec5faaf772785",
                                  backToDashboard: 'DashBoard',
                                ));
                              },
                              imageAssets: 'new_assets/wheels.png',
                              allPadding: 7),
                          Text(
                            "tyre".tr,
                            style:const TextStyle(
                              fontFamily: 'Gilroy',
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Column(
                        children: [
                          CircleIcon(
                              click: () {
                                Get.to(SelectedServiceLists(
                                  serviceId: "63fc74e72e0ec5faaf772788",
                                  backToDashboard: 'DashBoard',
                                ));
                              },
                              imageAssets: 'new_assets/ambulance.png',
                              allPadding: 10),
                          Text(
                            "ambu.".tr,
                            style:const TextStyle(
                              fontFamily: 'Gilroy',
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Column(
                        children: [
                          CircleIcon(
                              click: () {
                                Get.to(const ServiceListsScreen());
                              },
                              imageAssets: 'new_assets/search.png',
                              allPadding: 10),
                          Text(
                            "more".tr,
                            style: const TextStyle(
                              fontFamily: 'Gilroy',
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              InkWell(
                  onTap: sosClick,
                  child: Image.asset(
                    "new_assets/sos_icons.png",
                    height: 55,
                    width: 55,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
