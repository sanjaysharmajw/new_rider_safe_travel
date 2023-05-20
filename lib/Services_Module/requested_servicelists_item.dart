import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ride_safe_travel/Services_Module/service_details_screen.dart';
import 'package:ride_safe_travel/Services_Module/service_requestlist_controller.dart';

import '../LoginModule/custom_color.dart';
import '../LoginModule/preferences.dart';
import '../Utils/Loader.dart';
import '../Widgets/add_custom_btn.dart';
import '../color_constant.dart';
import '../new_widgets/my_new_text.dart';
import '../users_status_controller.dart';
import 'RequestedListModel.dart';
import 'ServiceTrackingMap.dart';
import 'get_servic_detail_controller.dart';

class RequestedServiceListItems extends StatelessWidget {

  final requestedListData requestedList;
  final VoidCallback feedBackClick;
  final VoidCallback deleteUser;

  const RequestedServiceListItems({Key? key, required this.requestedList, required this.feedBackClick, required this.deleteUser}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    DateFormat formatter = DateFormat.yMMMd(); // use any format
    String formatted = formatter.format(DateTime.parse(requestedList.date.toString()));
    print(formatted);
    return Container(

      margin: const EdgeInsets.only(top: 10, bottom: 10,left: 10,right:10),
      width: double.infinity,
      decoration: BoxDecoration(

        border: Border.all(color: appBlue),
        color: appWhiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 15.0, // soften the shadow
            spreadRadius: 2.0, //extend the shadow
            offset: Offset(
              5.0, // Move to right 5  horizontally
              5.0, // Move to bottom 5 Vertically
            ),
          )
        ],
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NewMyText(
                  textValue: formatted.toString(),
                  fontName: 'Gilroy',
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
              NewMyText(
                  textValue: requestedList.serviceStatus.toString(),
                  fontName: 'Gilroy',
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NewMyText(
                        textValue: requestedList.providername == null ? "N/A" : requestedList.providername!,
                        fontName: 'Gilroy',
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NewMyText(
                            textValue:
                            requestedList.providermobilenumber == null ? "N/A" : requestedList.providermobilenumber!,
                            fontName: 'Gilroy',
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                        Row(
                          children: [
                            Visibility(
                              visible: requestedList.serviceStatus=="Pending"?true:false,
                              child: Container(
                                margin: const EdgeInsets.only(left: 10,right: 10),
                                child: ClipOval(
                                  child: Material(
                                    color: lightAppRed, // button color
                                    child: InkWell(
                                      splashColor: appBlue,
                                      highlightColor:
                                      theme.colorScheme.primary.withAlpha(28),
                                      onTap: deleteUser,
                                      child: const SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Icon(
                                            MdiIcons.delete,
                                            color: appRed,
                                            size: 20,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: requestedList.serviceStatus=="Completed"?true:false,
                              child: Container(
                                margin: const EdgeInsets.only(left: 10,right: 10),
                                child: ClipOval(
                                  child: Material(
                                    color: appLightBlue, // button color
                                    child: InkWell(
                                      splashColor: appBlue,
                                      highlightColor:
                                      theme.colorScheme.primary.withAlpha(28),
                                      onTap: feedBackClick,
                                      child: const SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Icon(
                                            MdiIcons.message,
                                            color: appBlue,
                                            size: 20,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: requestedList.serviceStatus=="Accept"?true:false,
                              child: ClipOval(
                                child: Material(
                                  color: appLightBlue, // button color
                                  child: InkWell(
                                    splashColor: appBlue,
                                    highlightColor: theme.colorScheme.error.withAlpha(28),
                                    child: const SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Icon(
                                          MdiIcons.navigation,
                                          color: appBlue,
                                        )),
                                    onTap: () async {
                                      if(requestedList.serviceStatus=="Accept"){
                                        getServiceRideDetailsAPi(requestedList.id.toString());
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ],
      )
      /*
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NewMyText(
                  textValue: requestedList.date.toString(),
                  fontName: 'Gilroy',
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
              NewMyText(
                  textValue: requestedList.serviceStatus.toString(),
                  fontName: 'Gilroy',
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NewMyText(
                        textValue: requestedList.providername == null ? "N/A" : requestedList.providername!,
                        fontName: 'Gilroy',
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                    const SizedBox(height: 5),
                    NewMyText(
                        textValue:
                        requestedList.providermobilenumber == null ? "N/A" : requestedList.providermobilenumber!,
                        fontName: 'Gilroy',
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),*/
    );

    /*Card(
        elevation: 15,
        margin: EdgeInsets.all(20),
        child:  Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Text("Rx Service",style: TextStyle(color: CustomColor.black,fontSize: 20),),
                  ),
                  Padding(
                    padding:  const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {  },
                      child:  Text("Requested"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:  [
                  Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Text(requestedList.servicetype.toString(),style: TextStyle(fontSize: 17),),
                  ),
                ],
              ),
              Divider(thickness: 2,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children:  [
                        Text("Distance",style: TextStyle(color: Colors.black54,fontSize: 18),),
                        SizedBox(height: 10,),
                        Text(requestedList.dist!.toStringAsFixed(2),style: TextStyle(color: Colors.black87,fontSize: 16),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children:  [
                        Text("Requested on",style: TextStyle(color: Colors.black54,fontSize: 18),),
                        SizedBox(height: 10,),
                        Text(requestedList.date.toString(),style: TextStyle(color: Colors.black87,fontSize: 16),),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {  }, child: Text("Location"),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFD3ACAD),
                          side: BorderSide(color: CustomColor.yellow, width: 1),
                        ),

                      ),

                    ],
                  ),
                ],
              ),
            ],
          ),
        )
    );*/
  }

  void getServiceRideDetailsAPi(String serviceId)async{
    final getServiceDetails=Get.put(GetServiceDetailsController());
    await getServiceDetails.getServiceRideDetails(serviceId).then((value){
      if(value!=null){
        if(value.status==true){
          Get.to(ServiceTrackingMap(serviceRideData: value,requestedList:requestedList));

        }
      }
    });
  }


}
