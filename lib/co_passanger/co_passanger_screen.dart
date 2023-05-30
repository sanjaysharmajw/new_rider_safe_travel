import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';

import '../LoginModule/custom_color.dart';
import '../Widgets/add_custom_btn.dart';
import '../bottom_nav/EmptyScreen.dart';
import '../color_constant.dart';
import '../new_widgets/my_new_text.dart';
import 'add_co_passanger_screen.dart';
import 'driver_co_passanger_controller.dart';
import 'driver_co_passanger_items.dart';
import 'list_co_passanager_request_body.dart';

class DriverCoPassScreen extends StatefulWidget {
  String rideId;
  DriverCoPassScreen({Key? key,required this.rideId}) : super(key: key);

  @override
  State<DriverCoPassScreen> createState() => _DriverCoPassScreenState();
}

class _DriverCoPassScreenState extends State<DriverCoPassScreen> {
  final driverCoPassController=Get.put(DriverCoPassController());

  @override
  void initState() {
    super.initState();
    coPassanger();
  }
  void coPassanger()async{
    ListCoPassanagerRequestBody requestBody=ListCoPassanagerRequestBody(rideId: widget.rideId.toString());
    await driverCoPassController.coPassangerListApi(requestBody);
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      backgroundColor: appWhiteColor,
      appBar: AppBar(
        backgroundColor: appBlue,
        elevation: 10,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: IconButton(
              onPressed: () {
                Get.back(canPop: true);
              },
              icon: const Icon(
                Icons.arrow_back_sharp,
                color: CustomColor.white,
                size: 25,
              )),
        ),
        title: Text("co_passanger_list".tr,style: TextStyle(fontFamily: "Gilroy",fontSize: 22,color: Colors.white),),

      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: appBlue,
          onPressed: (){
            Get.to(AddCoPassangerScreen(rideId: widget.rideId.toString()))!.then((value){
              if(value==true){
                coPassanger();
              }
            });
          },
          label: Text("add_co_passanger".tr)),

      body: Padding(
        padding: const EdgeInsets.only(right: 25,left: 25,top: 25),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              const SizedBox(height: 20),
              Obx(() {
                return driverCoPassController.isLoading.value
                    ? LoaderUtils.loader()
                    : driverCoPassController.getCoPassangerListData.isEmpty
                    ?  Center(
                  child: EmptyScreen(text: 'co_passanger_list_not_found'.tr,),
                ) : ListView.builder(
                    itemCount: driverCoPassController.getCoPassangerListData.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CoPassangerItems(passangerListData: driverCoPassController.getCoPassangerListData[index]);
                    });
              }),
            ],
          ),
        ),
      ),
    ));
  }
}

