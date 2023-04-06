import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/Services_Module/request_controller.dart';
import 'package:ride_safe_travel/custom_button.dart';

import '../SearchServicesModel.dart';
import '../color_constant.dart';

class ShowSelectedServiceItem extends StatelessWidget {

  final ServiceListData serviceListData;
  final VoidCallback voidCallback;
   ShowSelectedServiceItem({Key? key, required this.serviceListData, required this.voidCallback}) : super(key: key);

   final requestController=Get.put(ServiceRequestController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15,bottom: 8,top: 8),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: appLightBlue),
          borderRadius: BorderRadius.circular(10),
          //more than 50% of width makes circle
        ),
        child: Card(
          elevation: 20,
          child: Column(
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
             Padding(
               padding: const EdgeInsets.only(top: 10,left: 220),
               child: ElevatedButton(
                   onPressed: (){
                     showDialog(
                       context: context,
                       builder: (ctx) => AlertDialog(
                         content: Padding(
                           padding: const EdgeInsets.only(left: 15,right: 15),
                           child: SizedBox(
                             child: Container(
                               height: 80,
                               width: 150,
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
                         actions: <Widget>[
                           Padding(
                             padding: const EdgeInsets.only(left: 10,right: 10 ),
                             child: ElevatedButton(
                                 onPressed: () {
                                  voidCallback();
                                  Navigator.pop(context);


                                 },
                                 child: const Text("Send Request",
                                   style: TextStyle(fontFamily: "Gilroy",fontSize: 15),),
                                 style: ElevatedButton.styleFrom(
                                   foregroundColor: Colors.white,
                                   primary: Colors.blue,
                                 )),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(right: 15,left: 10),
                             child: ElevatedButton(
                                 onPressed: () {
                                   Navigator.pop(context);
                                 },
                                 child: const Text("Cancel",
                                   style: TextStyle(fontFamily: "Gilroy",fontSize: 15),),
                                 style: ElevatedButton.styleFrom(
                                   foregroundColor: Colors.white,
                                   primary: Colors.blue,
                                 )),
                           ),
                         ],
                       ),
                     );
                   },
                   style: ElevatedButton.styleFrom(backgroundColor: appBlue ),
                   child: Text("Request",style: TextStyle(fontFamily: "Gilroy",fontSize: 15),)
               ),
             )
            ],
          ),
        )


      ),
    );


  }
}
