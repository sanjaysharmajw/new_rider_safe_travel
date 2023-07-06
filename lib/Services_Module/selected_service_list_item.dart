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
      margin: const EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
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
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: NewMyText(
                      textValue: serviceListData.title==""?"":serviceListData.title.toString(),
                      fontName: 'Gilroy',
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
              ),
              NewMyText(
                  textValue: serviceListData.dist.toString(),
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
              Flexible(
                  child: NewMyText(textValue: serviceListData.address.toString(),textMaxLine: 2,
                      fontName: 'Gilroy', color: appBlack, fontWeight: FontWeight.w500, fontSize: 16)),
              Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Material(
                      color: appLightBlue, // button color
                      child: SizedBox(
                          width: 100,
                          height: 30,
                          child: AddCustomButton(press:  voidCallback, buttonText: 'request'.tr)
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),


    );



  }
}
