import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import 'LoginModule/custom_color.dart';
import 'MyText.dart';
import 'ServicesPage.dart';

class RejectedServiceList extends StatefulWidget {
  const RejectedServiceList({Key? key}) : super(key: key);

  @override
  State<RejectedServiceList> createState() => _RejectedServiceListState();
}

class _RejectedServiceListState extends State<RejectedServiceList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
             Padding(
              padding:  EdgeInsets.only(left: 20,right: 20),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const[
                   MyText(text: 'Road Side Assistance', fontFamily: 'transport', color: Colors.black, fontSize: 22),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Card(
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
                              child:  Text("Rejected"),
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
                      children: const [
                        Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: Text("Car Service",style: TextStyle(fontSize: 17),),
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
                            children: const [
                              Text("Kilometer",style: TextStyle(color: Colors.black54,fontSize: 18),),
                              SizedBox(height: 10,),
                              Text("10 Km",style: TextStyle(color: Colors.black87,fontSize: 16),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: const [
                              Text("Rejected on",style: TextStyle(color: Colors.black54,fontSize: 18),),
                              SizedBox(height: 10,),
                              Text("04 March 2023 05.50 PM",style: TextStyle(color: Colors.black87,fontSize: 16),),
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
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 40),
          child: FloatingActionButton(
            backgroundColor: Colors.yellow,
            onPressed: () {
              Get.to(const ServicesScreenPage());
            },
            child: Icon(Icons.add,color: Colors.black,),
          ),
        ),
      ),
    );
  }
}
