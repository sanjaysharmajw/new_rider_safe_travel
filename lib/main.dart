import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ride_safe_travel/LoginModule/MainPage.dart';
import 'package:ride_safe_travel/LoginModule/RiderLoginPage.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/bottom_nav/custom_bottom_navi.dart';
import 'package:ride_safe_travel/start_ride_map.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';



import 'LoginModule/Map/RiderMap.dart';
import 'Utils/demod.dart';
import 'Utils/toast.dart';
import 'Widgets/otp_dialog.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();



  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //  ScreenUtil.init(context, designSize: const Size(375, 812));
    return GetMaterialApp(
      builder: EasyLoading.init(),
      title: 'Rider Safe Travel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
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




  void _instanceId() async {
    await Firebase.initializeApp();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.instance.sendMessage();
    var token = await FirebaseMessaging.instance.getToken();
    print("Print Instance Token ID: " + token!);
  }



  @override
  void initState() {
    super.initState();
    _instanceId();
    getLocation();
    //FCM Push Notification
    FirebaseInAppMessaging.instance.triggerEvent("");
    FirebaseMessaging.instance.getInitialMessage();


    // Crashlytics
    FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            )
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
    startTimer();
  }

  Future getLocation() async {
    bool? _serviceEnabled;
    Location location =  Location();
    var _permissionGranted = await location.hasPermission();
    _serviceEnabled = await location.serviceEnabled();
    if (_permissionGranted != PermissionStatus.granted || !_serviceEnabled) {
      _permissionGranted = await location.requestPermission();
      _serviceEnabled = await location.requestService();
      ToastMessage.toast("Access Granted");
    }
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
      Get.to( RiderLoginPage());
    } else {
      Get.to(const CustomBottomNav());  //MainPage //CustomBottomNav

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

