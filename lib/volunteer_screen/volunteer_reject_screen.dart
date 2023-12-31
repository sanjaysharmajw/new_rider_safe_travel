

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';


import '../Models/VolunteerStatusRequestBody.dart';
import '../Utils/CustomLoader.dart';
import '../Utils/EmptyScreen.dart';
import '../Utils/exit_dialog.dart';
import '../controller/request_volunteer_controller.dart';
import 'volunteer_request_items.dart';

class VolunteerRejectScreen extends StatefulWidget {
  String? status;
  VolunteerRejectScreen({Key? key,this.status}) : super(key: key);

  @override
  State<VolunteerRejectScreen> createState() => _VolunteerRejectScreenState();
}

class _VolunteerRejectScreenState extends State<VolunteerRejectScreen> {
  final volunteerRequestController=Get.put(RequestVolunteerController());
  LocationData? locationData;
  Location? location;
  @override
  void initState() {
    super.initState();
    api();
  }

  void api()async{
    location=Location();
    locationData=await location!.getLocation();
    volunteerRequestController.getRequestVolunteerData.clear();
    await volunteerRequestController.requestVolunteerApi(widget.status.toString(),locationData!.latitude!,locationData!.longitude!);
    setState(() {});
  }



  void updateVolunteerStatusApi(String id,String status)async{
    VolunteerStatusRequestBody requestBody=VolunteerStatusRequestBody(
        id: id,
        status: status
    );
    await volunteerRequestController.volunteerStatusUpdate(requestBody).then((value){
      if(value!=null){
        if(value.status==true){
          CustomLoader.message(value.message.toString());
          api();
          Get.back();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Obx(() {
              return Center(
                child: volunteerRequestController.isLoading.value
                    ? CustomLoader.loader()
                    : volunteerRequestController.getRequestVolunteerData.isEmpty
                    ? const Center(
                  child: EmptyScreen(),
                )
                    : ListView.builder(
                    itemCount: volunteerRequestController
                        .getRequestVolunteerData.length,
                    itemBuilder: (context, index) {
                      return VolunteerRequestItems(volunteerData: volunteerRequestController.getRequestVolunteerData[index], readyClick: () {
                        confirmationDialog(index,"Accept","Ready to go");
                      }, notReadyClick: () {
                        confirmationDialog(index,"Reject","Not ready to go");
                      },);
                    }),
              );
            }),
          )

        ],
      ),
    )));
  }
  void confirmationDialog(int index, String status,String confirmation){
    exitShowDialog(context, 'Confirmation', 'No', 'Yes', 'Are you sure you want to $confirmation?', () {
      Get.back();
    }, () {     updateVolunteerStatusApi(volunteerRequestController.getRequestVolunteerData[index].id.toString(),status); });
  }
}
