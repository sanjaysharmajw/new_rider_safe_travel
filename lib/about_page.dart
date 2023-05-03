import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'color_constant.dart';

class AboutScreenPage extends StatefulWidget {
  const AboutScreenPage({Key? key}) : super(key: key);

  @override
  State<AboutScreenPage> createState() => _AboutScreenPageState();
}

class _AboutScreenPageState extends State<AboutScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        backgroundColor: appBlue,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined, color: Colors.white,size: 25,),
            onPressed: () {
              Navigator.of(context).pop('refresh');
            }),
        title:  Text('about'.tr,
          style: TextStyle(fontFamily: "Gilroy",fontSize: 22,color: Colors.white),),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
              child: Text("   Just like a kite that keeps a watchful eye on her nest,"
                  " our app KITE allows parents to monitor their child's whereabouts even when they're away"
                  " from home. Just as a kite maintains a protective presence over her eggs or chicks, "
                  "KITE provides parents with peace of mind by giving them a bird's-eye view of their"
                  " child's location and activities.",
              style: TextStyle(fontSize: 16,fontFamily: 'Gilroy',fontWeight: FontWeight.normal),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
              child: Text("   With KITE, parents can rest easy knowing that their child is safe and secure, "
                  "even when they're not physically together. Like a kite's keen sense of sight, KITE's features "
                  "enable parents to keep an eye on their child's location and receive real-time updates on their movements,"
                  " so they can react quickly in case of an emergency.",
                style: TextStyle(fontSize: 16,fontFamily: 'Gilroy',fontWeight: FontWeight.normal),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
              child: Text("   And just as a kite adjusts her position in response to changing weather and other "
                  "conditions, KITE allows parents to customize their monitoring preferences and adjust their settings"
                  " as needed. With KITE, parents can rest assured that they have a reliable and trustworthy tool to "
                  "keep watch over their child, no matter where their journey takes them.",
                style: TextStyle(fontSize: 16,fontFamily: 'Gilroy',fontWeight: FontWeight.normal),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
              child: Text("   So let KITE be your watchful companion on your child's journey, "
                  "providing you with the reassurance and security you need to take flight with confidence.",
                style: TextStyle(fontSize: 16,fontFamily: 'Gilroy',fontWeight: FontWeight.normal),),
            )
          ],
        ),
      ),
    );
  }
}
