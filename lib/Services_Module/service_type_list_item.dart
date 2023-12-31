import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ride_safe_travel/Services_Module/selected_service_list.dart';

import '../ServiceTypeModel.dart';
import '../color_constant.dart';
import '../new_widgets/my_new_text.dart';
import '../new_widgets/new_my_image.dart';
import '../selected_service/send_service_request_screen.dart';

class ServiceTypeListItem extends StatelessWidget {

  final ServiceTypeData serviceTypeData;
  const ServiceTypeListItem({Key? key, required this.serviceTypeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(SendServiceRequestScreen(serviceId: serviceTypeData.id.toString(),));
       // Get.to(SelectedServiceLists(serviceId: serviceTypeData.id.toString(), backToDashboard: '', ));
      },
      child: Container(

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
        padding: const EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NewMyText(
                textValue: serviceTypeData.name.toString(),
                fontName: 'Gilroy',
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 12),
            const NewMyImage(image: 'new_assets/forword_arrow.png', width: 15, height: 15, fit: BoxFit.contain, color: appBlack)
          ],
        ),
      ),
    );






  }
}
