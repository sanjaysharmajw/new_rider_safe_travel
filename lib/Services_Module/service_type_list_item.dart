import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ride_safe_travel/Services_Module/selected_service_list.dart';

import '../ServiceTypeModel.dart';
import '../color_constant.dart';

class ServiceTypeListItem extends StatelessWidget {

  final ServiceTypeData serviceTypeData;
  const ServiceTypeListItem({Key? key, required this.serviceTypeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder( //<-- SEE HERE
        side: BorderSide(
          color: appBlue,
        ),
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: ListTile(

        minLeadingWidth: 5,
        horizontalTitleGap: 1,
        leading: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Icon(Icons.car_repair_outlined,size: 14,color: appBlack,),
        ),
        title:  Text(serviceTypeData.name.toString(),style: TextStyle(fontFamily: 'Gilroy',fontSize: 14,color: appBlack),),
        trailing: IconButton(onPressed: (){
          Get.to(SelectedServiceLists(serviceId: serviceTypeData.id.toString(),));
        }, icon: Icon(Icons.arrow_forward_ios_sharp,size: 14,color: appBlack,))
      ),
    );

    /* Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
        color: appBlack,
        borderRadius: BorderRadius.circular(15)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.car_repair_outlined,size: 20,color: appWhiteColor,),
        Text(serviceTypeData.name.toString(),style: TextStyle(fontFamily: 'Gilroy',fontSize: 18,color: appWhiteColor),),
        IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_sharp,size: 20,color: appWhiteColor,))
      ],
    )
    );*/


  }
}
