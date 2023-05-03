import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';


class LocationController extends GetxController{

  String? mapStyle;
  LocationData? locationData;
  Location? location;

  @override
  void onInit() {
    super.onInit();
    mapThemeStyle();
    getLocation();
  }

  Future permissionLocation() async {
    bool? serviceEnabled;
    Location location =  Location();
    var permissionGranted = await location.hasPermission();
    serviceEnabled = await location.serviceEnabled();
    if (permissionGranted != PermissionStatus.granted || !serviceEnabled) {
      permissionGranted = await location.requestPermission();
      serviceEnabled = await location.requestService();
    }
  }

  Future mapThemeStyle()async{
    rootBundle.loadString('assets/map_style.json').then((string) {
      mapStyle = string;
    });
  }

  Future<LocationData?> getLocation()async{
    location=Location();
    locationData=await location!.getLocation();
    return locationData;
  }

}