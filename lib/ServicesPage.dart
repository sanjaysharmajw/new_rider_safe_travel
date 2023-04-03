import 'dart:async';
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:location/location.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';

import 'package:http/http.dart' as http;
import 'package:ride_safe_travel/color_constant.dart';
import 'package:ride_safe_travel/service_list_items.dart';

import 'BottomSheet/GeocodeResultModel.dart';
import 'DemoController.dart';
import 'Error.dart';
import 'GroupModel.dart';
import 'LoginModule/Api_Url.dart';
import 'LoginModule/custom_color.dart';
import 'LoginModule/preferences.dart';
import 'SearchServicesModel.dart';
import 'ServiceTypeModel.dart';
import 'Utils/small_submit_button.dart';
import 'Utils/toast.dart';


class ServicesScreenPage extends StatefulWidget {
  const ServicesScreenPage({Key? key}) : super(key: key);

  @override
  State<ServicesScreenPage> createState() => _ServicesScreenPageState();
}

class _ServicesScreenPageState extends State<ServicesScreenPage> {
  var status;
  var service;
  bool? updateList=false;
  late Location current_location;
  LocationData? currentLocation;
  final controllerList=Get.put(DemoController());

  var selectedService = [];
  bool isServiceSelected = false;

  final TextEditingController commentController = TextEditingController();

  double? latitude;
  double? longitude;



  @override
  void initState() {
    current_location =  Location();
    getCurrentLocation();
    servicesList();
    super.initState();
  }
  void getCurrentLocation()async{
    currentLocation = await current_location.getLocation();
  }




  @override
  Widget build(BuildContext context) {
    return GetX<DemoController>(
        init: DemoController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title:
              const Text("Services", style: TextStyle(color: CustomColor.black)),
              leading: IconButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_outlined),
              ),
            ),

            body: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    color: Colors.white,
                    shape: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: CustomColor.yellow)),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: DropdownButton(
                        underline: Container(),
                        // hint: Text("Select State"),
                        icon: Icon(Icons.keyboard_arrow_down),
                        isDense: true,
                        isExpanded: true,
                        hint: Text(
                          "Select Services",
                          style: TextStyle(color: Colors.black26),
                        ),
                        items: selectedService.map((e) {
                          status = e['status'].toString();
                          // longitude = e['lng'].toString();
                          //latitude = e['lat'].toString();
                          //print("SelectedServingiceDetails..."+status+"..."+longitude.toString()+"..."+latitude.toString());
                          //  ToastMessage.toast(e['service_id']);
                          return DropdownMenuItem(
                            value: e['_id'].toString(),
                            child: Text(e['name'].toString()),
                          );
                        }).toList(),
                        value: service,
                        onChanged: (value) async {
                          print(" isServiceSelected: " + value.toString());

                          setState(() async{
                            service = value;
                            isServiceSelected = true;
                            updateList=true;
                            searchServices(service.toString());
                            Timer(const Duration(milliseconds: 500), () {
                              getServiceList(updateList!,value.toString());
                              controller.serviceDatalist.clear();
                            });
                            print(" isServiceSelectedName: " + service.toString());


                          });
                        },
                      ),
                    ),
                  ),
                ),
                RefreshIndicator(
                  onRefresh: () => controller.getDemoData(service.toString()),
                  child: controller.isLoading.value
                      ? Text("Please select Service Type !")
                      : controller.serviceDatalist.isEmpty
                      ? const Center(
                    child: Text('Service details not found !'),
                  ) : ListView.builder(
                      itemCount: controller.serviceDatalist.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ServiceListItems(data: controller.serviceDatalist[index]);
                      }),
                ),
              ],
            ),
          );
        });
  }

  Future<List<ServiceTypeModel>> servicesList() async {
    var userId = Preferences.getId(Preferences.id);
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    final response = await http.post(
      Uri.parse(ApiUrl.getserviceType),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': loginToken
      },
      body: jsonEncode({"status": status}),
    );

    print(
      "ServiceList: " + jsonEncode({"status": status}),
    );

    print(
      <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': loginToken
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body)['data'];
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      if (status == true) {
        setState(() {
          selectedService = jsonResponse;
        });
        print("selectedGroup" + selectedService.toString());


      }
      List<ServiceTypeModel> servicelist = jsonDecode(response.body)['data']
          .map<ServiceTypeModel>((data) => ServiceTypeModel.fromJson(data))
          .toList();
      var serviceStatus = servicelist[0].status.toString();
      print(serviceStatus);

      return servicelist;
    } else {
      print("----------------------------");
      print(response.statusCode);
      print("----------------------------");

      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<SearchServicesModel>> searchServices(String servoce) async {
    var userId = Preferences.getId(Preferences.id);
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    final response = await http.post(
      Uri.parse("https://i981xwdx4g.execute-api.ap-south-1.amazonaws.com/dev/api/serviceProvider/searchServiceProvider"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': loginToken
      },
      body: jsonEncode({
        "service_id": servoce.toString(),
        "lng": 72.998993,
        "lat":19.077065
      }),
    );

    print(
      "SearchService: " + jsonEncode({
        "service_id":servoce.toString(),
        "lng":72.998993,
        "lat":19.077065
      }),
    );

    print(
      <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': loginToken
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body)['data'];
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      var res=response.body;
      print('respnse1:::: $res');
      List<SearchServicesModel> servicelistData = jsonDecode(response.body)['data']
          .map<SearchServicesModel>((data) => SearchServicesModel.fromJson(data)).toList();
      // List<SearchServicesModel> responseBody = json.decode(response.body)['data'] ?? [];
      print('respnse:::: $servicelistData');
      setState(() {

      });
      return servicelistData;
    } else {
      print("----------------------------");
      print(response.statusCode);
      print(response.body);
      print("----------------------------");

      throw Exception('Unexpected error occured!');
    }
  }

  void getServiceList(bool updateList,String serviceId)async{
    setState(() async {
      await controllerList.getDemoData(serviceId);
      ToastMessage.toast('Click');
      ToastMessage.toast(serviceId.toString());
    });
  }


}
