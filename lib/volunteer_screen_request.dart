
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/bottom_nav/profile_nav.dart';
import 'package:ride_safe_travel/volunteer_request_items.dart';

import 'MyText.dart';
import 'bottom_nav/custom_bottom_navi.dart';
import 'color_constant.dart';


class VolunteerRequestList extends StatefulWidget {
  const VolunteerRequestList({Key? key}) : super(key: key);

  @override
  State<VolunteerRequestList> createState() => _VolunteerRequestListState();
}

class _VolunteerRequestListState extends State<VolunteerRequestList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor:  appBlue,
            elevation: 15,
            leading: IconButton(
              color:  appWhiteColor,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileNav(backbutton: '')));
              },
              icon: const Icon(Icons.arrow_back_outlined),
            ),
            title: Text("Volunteer Request",style: TextStyle(fontFamily: 'Gilroy',fontSize: 22,color: Colors.white ),),
          ),
            body: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         /* InkWell( highlightColor: Colors.black38,onTap: (){
            Get.back();
          },child: Image.asset('assets/back_icons.png',width: 17,height: 17)),
          const SizedBox(height: 20),
           MyText(text: 'Volunteer',
              fontSize: 20,  fontFamily: 'Gilroy', color: Colors.black,),*/
          const SizedBox(height: 20),
          const  VolunteerRequestItems(),

        ],
      ),
    )));
  }
}
