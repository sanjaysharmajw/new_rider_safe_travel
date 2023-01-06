import 'dart:async';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:ride_safe_travel/LoginModule/MainPage.dart';
import 'package:ride_safe_travel/LoginModule/RiderLoginPage.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/Utils/toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //  ScreenUtil.init(context, designSize: const Size(375, 812));
    return GetMaterialApp(
      title: 'Rider Safe Travel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late Location location;
  @override
  void initState() {
    super.initState();
    _initUser();
    startTimer();
  }

  void _initUser() async {
    location = Location();
    //location.enableBackgroundMode(enable: true);
    // location.changeNotificationOptions(
    //     iconName: 'images/rider_launcher.png',
    //     channelName: 'Nirbhaya',
    //     title: 'Nirbhaya app is running');
    location.onLocationChanged.listen((LocationData cLoc) async {
      var lat = cLoc.latitude!;
      var lng = cLoc.longitude!;
    //  ToastMessage.toast(lat.toString());
      //ToastMessage.toast(lng.toString());
      print("lat: $lng, $lat");
    });

  }

  void startTimer() {
    Timer(const Duration(seconds: 2), () {
      checkLoginStatus();
    });
  }

  Future checkLoginStatus() async {
    await Preferences.setPreferences();
    String? userId = Preferences.getId(Preferences.id);
    if (userId == null) {
      Get.to(const RiderLoginPage());
    } else {
      Get.to(const MainPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const <Widget>[
        Positioned.fill(
          child: Image(
            image: AssetImage('assets/splash_image.png'),
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
