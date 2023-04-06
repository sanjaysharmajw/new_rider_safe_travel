import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:location/location.dart';
import 'package:ride_safe_travel/Services_Module/request_controller.dart';
import 'package:ride_safe_travel/Services_Module/service_type_list_item.dart';
import 'package:ride_safe_travel/Services_Module/service_types.dart';
import 'package:ride_safe_travel/Services_Module/servicelist_controller.dart';
import 'package:ride_safe_travel/Services_Module/selected_service_list_item.dart';

import '../Utils/Loader.dart';
import '../bottom_nav/EmptyScreen.dart';
import '../color_constant.dart';

class SelectedServiceLists extends StatefulWidget {
  String serviceId;

  SelectedServiceLists({Key? key, required this.serviceId}) : super(key: key);

  @override
  State<SelectedServiceLists> createState() => _SelectedServiceListsState();
}

class _SelectedServiceListsState extends State<SelectedServiceLists> {
  final servicelist = Get.put(ServiceListController());
  final request = Get.put(ServiceRequestController());
  LocationData? currenctLoaction;
  Location? location;

  void initState(){
    getCurrentLocation();
    getList();
    super.initState();
  }
  void getCurrentLocation()async{
    location=Location();
    currenctLoaction=await location!.getLocation();

  }

  void getList()async{

   await servicelist.getServicesList(widget.serviceId);
   setState(() {});
   debugPrint('widget.serviceId');
   debugPrint(widget.serviceId);
  }
  @override
  Widget build(BuildContext context) {
  return SafeArea(
        child: Scaffold(
          backgroundColor: appWhiteColor,
          appBar: AppBar(

            backgroundColor: appBlue,
            elevation: 10,
            title: Text("Services",
                style: TextStyle(
                  color: appWhiteColor, fontSize: 22, fontFamily: 'Gilroy',)),
            leading: IconButton(
              color: appWhiteColor,
              onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>ServiceListsScreen()));
              },
              icon: const Icon(Icons.arrow_back_outlined),
            ),
          ),

          body: Obx((){
            return  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                servicelist.isLoading.value
                    ? LoaderUtils.loader()
                    : servicelist.servicesList.isEmpty
                    ? const Center(
                  child: EmptyScreen(),
                ) :
                ListView.builder(
                    itemCount: servicelist.servicesList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {

                        return  ShowSelectedServiceItem(
                          serviceListData: servicelist.servicesList[index],
                          voidCallback: () {
                           requestService(servicelist.servicesList[index].serviceId.toString(),
                                servicelist.servicesList[index].id.toString(),
                              servicelist.servicesList[index].id.toString(),
                             currenctLoaction!.longitude!,
                             currenctLoaction!.latitude!,
                              servicelist.servicesList[index].userId.toString(),
                            );
                          },
                        );


                    })
              ],
            );
          })
        ),
      );

  }

  void requestService(String serviceId, String id, String serviceProviderId,
      double lng, double lat, String userId)async{
    await request.sendRequest(serviceId, id, serviceProviderId, lng, lat, userId).then((value) async {
      if (value != null) {

        LoaderUtils.message(value.message.toString());
      }
    });
  }
}
