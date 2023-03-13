import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'AcceptedServiceList.dart';
import 'LoginModule/custom_color.dart';
import 'MyText.dart';
import 'RejectedServiceList.dart';

class ServiceListScreenPage extends StatefulWidget {
  const ServiceListScreenPage({Key? key}) : super(key: key);

  @override
  State<ServiceListScreenPage> createState() => _ServiceListScreenPageState();
}

class _ServiceListScreenPageState extends State<ServiceListScreenPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: CustomColor.yellow,
            elevation: 15,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: IconButton(
                  onPressed: () {
                    // Get.back();
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_sharp,
                    color: CustomColor.black,
                    size: 30,
                  )),
            ),
            title: const Text("Service List",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'transport',
                    fontWeight: FontWeight.bold, color: CustomColor.black)),
          ),
          body: Column(
            children: const[
               Padding(
                padding:  EdgeInsets.only(left: 10,right: 10),
                child:  MyText(text: 'Profile', fontFamily: 'transport', color: Colors.black, fontSize: 22),
              ),
               SizedBox(height: 30),
              RejectedServiceList(),
            ],
          ),

        )
    );
  }
}
