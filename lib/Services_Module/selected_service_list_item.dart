import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/Services_Module/request_controller.dart';
import 'package:ride_safe_travel/custom_button.dart';

import '../SearchServicesModel.dart';
import '../Widgets/add_custom_btn.dart';
import '../color_constant.dart';
import '../new_widgets/my_new_text.dart';

class ShowSelectedServiceItem extends StatelessWidget {

  final ServiceListData serviceListData;
  final VoidCallback voidCallback;
   ShowSelectedServiceItem({Key? key, required this.serviceListData, required this.voidCallback}) : super(key: key);

   final requestController=Get.put(ServiceRequestController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 10,left: 20,right: 20),
      width: double.infinity,
      decoration: BoxDecoration(
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
        border: Border.all(color: appBlue),
        color: appWhiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      padding: const EdgeInsets.only(left: 10, right: 10,bottom: 10,top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              NewMyText(
                  textValue: serviceListData.title==""?"N/A":serviceListData.title.toString(),
                  fontName: 'Gilroy',
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
              NewMyText(
                  textValue: serviceListData.dist.toString()+"km",
                  fontName: 'Gilroy',
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NewMyText(textValue: serviceListData.address.toString(), fontName: 'Gilroy', color: appBlack, fontWeight: FontWeight.w500, fontSize: 16),
              Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Material(
                      color: appLightBlue, // button color
                      child: SizedBox(
                          width: 100,
                          height: 30,
                          child: AddCustomButton(press:(){
                            showDialog(
                                context: context,
                                builder: (BuildContext
                                context) {
                                  return StatefulBuilder(
                                      builder: (BuildContext
                                      context,
                                          StateSetter
                                          setState) {
                                        return AlertDialog(
                                          content:
                                          Container(
                                            height: 150,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .center,
                                              children: [
                                                SizedBox(
                                                  height:
                                                  10,
                                                ),
                                                Container(
                                                  height: 60,
                                                  width: 300,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    border: Border.all(
                                                        color: appBlack),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsets.only(left: 20, top: 2),
                                                    child: TextFormField(
                                                      controller: requestController.commentTextField.value,

                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: 'write_a_Comment'.tr,
                                                      ),
                                                      autovalidateMode: AutovalidateMode
                                                          .onUserInteraction,
                                                      validator: (text) {
                                                        if (text == null || text.isEmpty) {
                                                          return 'Can\'t be empty';
                                                        }
                                                        if (text.length < 4) {
                                                          return 'Too short';
                                                        }
                                                        return null;
                                                      },
                                                      // update the state variable when the text changes
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                    height:
                                                    15),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child:
                                                      ElevatedButton(
                                                        onPressed:
                                                            () {
                                                          voidCallback();
                                                          Navigator.pop(context);
                                                        },
                                                        child:
                                                        Text("send_request".tr),
                                                        style:
                                                        ElevatedButton.styleFrom(primary: appBlue),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width:
                                                        15),
                                                    Expanded(
                                                        child:
                                                        ElevatedButton(
                                                          onPressed:
                                                              () {
                                                            print('no selected');
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Text(
                                                              "cancel".tr,
                                                              style: TextStyle(color: Colors.black)),
                                                          style:
                                                          ElevatedButton.styleFrom(
                                                            primary:
                                                            Colors.white,
                                                          ),
                                                        ))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                });
                          }, buttonText: 'Request')
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),

    /* Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10,top: 10),
                child: Text("Distance :",
                  style: TextStyle(fontFamily: 'Gilroy',fontSize: 15,color: appBlack),),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10,top: 10),
                child: Text(serviceListData.dist!.toStringAsFixed(2),
                  style: TextStyle(fontFamily: 'Gilroy',fontSize: 14,color: appBlack),),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,top: 10),
            child: Text(serviceListData.serviceName.toString(),
              style: TextStyle(fontFamily: 'Gilroy',fontSize: 18,color: appBlack,fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,top: 10),
            child: Text(serviceListData.addressDetails!.label.toString(),
              style: TextStyle(fontFamily: 'Gilroy',fontSize: 14,color: appBlack),),
          ),
          Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 180,top: 5),
                child: Material(
                  color: appLightBlue, // button color
                  child: SizedBox(
                      width: 100,
                      height: 30,
                      child: AddCustomButton(
                          press: (){
                            showDialog(
                                context: context,
                                builder: (BuildContext
                                context) {
                                  return StatefulBuilder(
                                      builder: (BuildContext
                                      context,
                                          StateSetter
                                          setState) {
                                        return AlertDialog(
                                          content:
                                          Container(
                                            height: 150,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .center,
                                              children: [
                                                SizedBox(
                                                  height:
                                                  10,
                                                ),
                                                Container(
                                                  height: 60,
                                                  width: 300,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    border: Border.all(
                                                        color: appBlack),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsets.only(left: 20, top: 2),
                                                    child: TextFormField(
                                                      controller: requestController.commentTextField.value,

                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: 'write_a_Comment'.tr,
                                                      ),
                                                      autovalidateMode: AutovalidateMode
                                                          .onUserInteraction,
                                                      validator: (text) {
                                                        if (text == null || text.isEmpty) {
                                                          return 'Can\'t be empty';
                                                        }
                                                        if (text.length < 4) {
                                                          return 'Too short';
                                                        }
                                                        return null;
                                                      },
                                                      // update the state variable when the text changes
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                    height:
                                                    15),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child:
                                                      ElevatedButton(
                                                        onPressed:
                                                            () {
                                                          voidCallback();
                                                          Navigator.pop(context);
                                                        },
                                                        child:
                                                        Text("send_request".tr),
                                                        style:
                                                        ElevatedButton.styleFrom(primary: appBlue),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width:
                                                        15),
                                                    Expanded(
                                                        child:
                                                        ElevatedButton(
                                                          onPressed:
                                                              () {
                                                            print('no selected');
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Text(
                                                              "cancel".tr,
                                                              style: TextStyle(color: Colors.black)),
                                                          style:
                                                          ElevatedButton.styleFrom(
                                                            primary:
                                                            Colors.white,
                                                          ),
                                                        ))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                });
                      }, buttonText: 'Request')

                  ),
                ),
              ),
            ],
          )

          /*Padding(
            padding: const EdgeInsets.only(top: 10,left: 220),
            child: ElevatedButton(
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext
                      context) {
                        return StatefulBuilder(
                            builder: (BuildContext
                            context,
                                StateSetter
                                setState) {
                              return AlertDialog(
                                content:
                                Container(
                                  height: 150,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .center,
                                    children: [
                                      SizedBox(
                                        height:
                                        10,
                                      ),
                                      Container(
                                        height: 60,
                                        width: 300,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                              color: appBlack),
                                        ),
                                        child: Padding(
                                          padding:
                                          EdgeInsets.only(left: 20, top: 2),
                                          child: TextFormField(
                                            controller: requestController.commentTextField.value,

                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Write a Comment',
                                            ),
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (text) {
                                              if (text == null || text.isEmpty) {
                                                return 'Can\'t be empty';
                                              }
                                              if (text.length < 4) {
                                                return 'Too short';
                                              }
                                              return null;
                                            },
                                            // update the state variable when the text changes
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                          height:
                                          15),
                                      Row(
                                        children: [
                                          Expanded(
                                            child:
                                            ElevatedButton(
                                              onPressed:
                                                  () {
                                                voidCallback();
                                                Navigator.pop(context);
                                              },
                                              child:
                                              Text("Send Request"),
                                              style:
                                              ElevatedButton.styleFrom(primary: appBlue),
                                            ),
                                          ),
                                          SizedBox(
                                              width:
                                              15),
                                          Expanded(
                                              child:
                                              ElevatedButton(
                                                onPressed:
                                                    () {
                                                  print('no selected');
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                    "Cancel",
                                                    style: TextStyle(color: Colors.black)),
                                                style:
                                                ElevatedButton.styleFrom(
                                                  primary:
                                                  Colors.white,
                                                ),
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      });
                  /* showDialog(
                       context: context,
                       builder: (ctx) => AlertDialog(
                         content: Padding(
                           padding: const EdgeInsets.only(left: 15,right: 15),
                           child: SizedBox(
                             child: Container(
                               height: 80,
                               width: 100,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(8),
                                 border: Border.all(
                                     color: appBlack),
                               ),
                               child: Padding(
                                 padding:
                                 EdgeInsets.only(left: 20, top: 2),
                                 child: TextFormField(
                                   controller: requestController.commentTextField.value,

                                   decoration: InputDecoration(
                                     border: InputBorder.none,
                                     hintText: 'Write a Comment',
                                   ),
                                   autovalidateMode: AutovalidateMode
                                       .onUserInteraction,
                                   validator: (text) {
                                     if (text == null || text.isEmpty) {
                                       return 'Can\'t be empty';
                                     }
                                     if (text.length < 4) {
                                       return 'Too short';
                                     }
                                     return null;
                                   },
                                   // update the state variable when the text changes
                                 ),
                               ),
                             ),
                           ),
                         ),
                         actions: [



                              ElevatedButton(
                                  onPressed: () {
                                    voidCallback();
                                    Navigator.pop(context);


                                  },
                                  child: const Text("Send Request",
                                    style: TextStyle(fontFamily: "Gilroy",fontSize: 15),),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    primary: appBlue,
                                  )),
                               ElevatedButton(
                                   onPressed: () {
                                     Navigator.pop(context);
                                   },
                                   child: const Text("Cancel",
                                     style: TextStyle(fontFamily: "Gilroy",fontSize: 15),),
                                   style: ElevatedButton.styleFrom(
                                     foregroundColor: Colors.white,
                                     primary: appBlue,
                                   )),


                         ],
                       ),
                     );*/
                },
                style: ElevatedButton.styleFrom(backgroundColor: appBlue ),
                child: Text("Request",style: TextStyle(fontFamily: "Gilroy",fontSize: 15),)
            ),
          )*/
        ],
      ),*/
    );



  }
}
