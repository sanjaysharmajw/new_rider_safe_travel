import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../LoginModule/custom_color.dart';
import '../Widgets/add_custom_btn.dart';
import '../color_constant.dart';
import '../new_widgets/my_new_text.dart';
import 'RequestedListModel.dart';

class RequestedServiceListItems extends StatelessWidget {

  final RequestedList requestedList;

  const RequestedServiceListItems({Key? key, required this.requestedList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NewMyText(
                  textValue: requestedList.dist!.toStringAsFixed(2),
                  fontName: 'Gilroy',
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            NewMyText(
                textValue: requestedList.date.toString(),
                fontName: 'Gilroy',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ],),
          SizedBox(height: 5,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              NewMyText(
                  textValue: requestedList.servicetype.toString(),
                  fontName: 'Gilroy',
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
              NewMyText(
                  textValue: requestedList.customerStatus.toString(),
                  fontName: 'Gilroy',
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 5),
                    NewMyText(
                        textValue:
                        requestedList.username.toString(),
                        fontName: 'Gilroy',
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                    const SizedBox(height: 5),
                    NewMyText(
                        textValue:
                        requestedList.usermobilenumber.toString(),
                        fontName: 'Gilroy',
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ],
                ),
              ),
              Material(
                elevation: 10,
                color: appLightBlue, // button color
                child: SizedBox(
                    width: 80,
                    height: 30,
                    child: AddCustomButton(
                        press: (){

                        }, buttonText: 'Location')

                ),
              ),
            ],
          ),
        ],
      ),
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
}
