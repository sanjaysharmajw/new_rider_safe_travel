import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:ride_safe_travel/Services_Module/service_type_list_item.dart';
import 'package:ride_safe_travel/Services_Module/serviceType_controller.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';

import '../LoginModule/custom_color.dart';
import '../RejectedServiceList.dart';
import '../bottom_nav/EmptyScreen.dart';
import '../bottom_nav/custom_bottom_navi.dart';
import '../bottom_nav/my_rider_controller.dart';
import '../color_constant.dart';

class ServiceListsScreen extends StatefulWidget {
  const ServiceListsScreen({Key? key}) : super(key: key);

  @override
  State<ServiceListsScreen> createState() => _ServiceListsScreenState();
}

class _ServiceListsScreenState extends State<ServiceListsScreen> {


  @override
  Widget build(BuildContext context) {
    return GetX<ServiceTypeController>(
        init: ServiceTypeController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: appWhiteColor,
              appBar: AppBar(

                backgroundColor:  appBlue,
                elevation: 10,
                title:  Text("service_category".tr,
                    style: TextStyle(color:  appWhiteColor,fontSize: 22, fontFamily: 'Gilroy',)),
                leading: IconButton(
                  color:  appWhiteColor,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomBottomNav() ));
                  },
                  icon: const Icon(Icons.arrow_back_outlined),
                ),
              ),

              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               /* IconButton(onPressed: (){
                  Get.back();
                }, icon: Icon(Icons.arrow_back_outlined)),
                  const SizedBox(height: 20),
                  const Text('Services',style: TextStyle(fontFamily: 'Gilroy', color: appBlack, fontWeight: FontWeight.w100,fontSize: 20),
                  ),*/
                  const SizedBox(height: 60),

                  Expanded(
                    child: controller.isLoading.value
                        ? LoaderUtils.loader()
                        : controller.serviceTypeList.isEmpty
                        ? Center(
                      child: EmptyScreen(text: 'service_type_not_found'.tr,),
                    ) :
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: (3 / 1),
                        shrinkWrap: true,
                        children: List.generate( controller.serviceTypeList.length, (index) {
                          return ServiceTypeListItem(serviceTypeData: controller.serviceTypeList[index],);
                        }),
                      )
                      /*GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10.0,
                              childAspectRatio: 2.5,
                              crossAxisCount: 2),
                          itemCount: controller.serviceTypeList.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return ServiceTypeListItem(serviceTypeData: controller.serviceTypeList[index],);


                          }),*/
                    ),
                    /* GridView.count(
                      crossAxisCount: 2,

                      children: List.generate( controller.serviceTypeList.length, (index) {
                        return ServiceTypeListItem(serviceTypeData: controller.serviceTypeList[index],);
                      }),
                    )*/
                    /*ListView.builder(
                        itemCount: controller.serviceTypeList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ServiceTypeListItem(serviceTypeData: controller.serviceTypeList[index],);
                        }),*/
                  )

                ],
              ),
            ),
          );
        });
  }
}
