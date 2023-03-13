import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'AcceptedServiceList.dart';
import 'LoginModule/custom_color.dart';
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
            title: Text("Service List",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'transport',
                    fontWeight: FontWeight.bold, color: CustomColor.black)),
          ),
          body: Column(
            children: [
              TabBar(
                indicatorColor: CustomColor.yellow,
                  labelColor: CustomColor.yellow, //<-- selected text color
                  unselectedLabelColor: Colors.black,
                  tabs: [
                  Tab(
                  child: Text('Rejected', style: TextStyle(fontSize: 18),),
                  ),
                Tab(
                 child: Text('Accepted', style: TextStyle(fontSize: 18),),
                )
              ]),
              Expanded(
                child: TabBarView(children: [
                  Container(

                      child: RejectedServiceList()
                  ), 
                  Container(
                    child: AcceptedServiceListPage(),
                  )
                ]),
              )
            ],
          ),

        )
    );
  }
}
