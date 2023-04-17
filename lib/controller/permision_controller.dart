import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';



class PermissionController extends GetxController{

  String? mapStyle;

  @override
  void onInit() {
    super.onInit();
    mapThemeStyle();
  }

  Future permissionLocation() async {
    bool? serviceEnabled;
    Location location =  Location();
    var permissionGranted = await location.hasPermission();
    serviceEnabled = await location.serviceEnabled();
    if (permissionGranted != PermissionStatus.granted || !serviceEnabled) {
      permissionGranted = await location.requestPermission();
      serviceEnabled = await location.requestService();
      LoaderUtils.message("Access Granted");
      //DriverCustomLoader.message("Access Granted");
    }
  }

  Future mapThemeStyle()async{
      rootBundle.loadString('assets/map_style.json').then((string) {
        mapStyle = string;
      });
  }

}