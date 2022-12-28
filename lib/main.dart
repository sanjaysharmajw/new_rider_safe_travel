import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ride_safe_travel/FamilyMemberAddScreen.dart';
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
      home: const RiderLoginPage(),
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
  String id = '';

  @override
  void initState() {
    super.initState();
    preferences();
    setState(() {});
      Timer(
          const Duration(seconds: 3),
              () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const RiderLoginPage()),
          )
      );
  }

  void preferences() async {
    await Preferences.setPreferences();
    id = Preferences.getId(Preferences.id);
    print(id);
    setState(() {});

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
