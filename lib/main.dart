import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/LoginModule/MainPage.dart';
import 'package:ride_safe_travel/LoginModule/RiderLoginPage.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer(const Duration(seconds: 2), () {
      checkLoginStatus();
    });
  }
  Future checkLoginStatus() async {
    await Preferences.setPreferences();
    String? userId = Preferences.getId(Preferences.id);
    if (userId==null) {
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
