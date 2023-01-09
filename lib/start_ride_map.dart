import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/LoginModule/MainPage.dart';
import 'package:ride_safe_travel/LoginModule/Map/Drawer.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/MapAddFamily.dart';
import 'package:ride_safe_travel/Utils/make_a_call.dart';
import 'package:ride_safe_travel/Utils/toast.dart';
import 'package:share_plus/share_plus.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'LoginModule/Error.dart';
import 'Utils/MapMyIndiaKeys.dart';
import 'Utils/back_button_popup.dart';
import 'Utils/exit_alert_dialog.dart';

class StartRide extends StatefulWidget {
  const StartRide(
      {Key? key,
      required this.riderId,
      required this.socketToken,
      required this.dName,
      required this.dMobile,
      required this.dPhoto,
      required this.model,
      required this.vOwnerName,
      required this.vRegNo})
      : super(key: key);

  @override
  State<StartRide> createState() => _SignUpState();
  final String riderId;
  final String socketToken;
  final String dName;
  final String dMobile;
  final String dPhoto;
  final String model;
  final String vOwnerName;
  final String vRegNo;
}

class _SignUpState extends State<StartRide> {
  Timer? timer;
  late IO.Socket socket;
  late Location location;
  late LocationData currentLocation;
  late double lat;
  late double lng;
  String id = '';
  var userId = '';
  String socketToken = '';
  bool visibility = false;
  late MapmyIndiaMapController mapController;
  late Symbol symbol;
  late Line line;
  late List<LatLng> polyline_latlng;


  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(19.0654285394954, 73.00269069070602),
    zoom: 14,
  );

  @override
  void initState() {
    super.initState();
    setState(() {
      MapmyIndiaAccountManager.setMapSDKKey(MyMyIndiaKeys.mapSKDKey);
      MapmyIndiaAccountManager.setRestAPIKey(MyMyIndiaKeys.MapRestAPIKey);
      MapmyIndiaAccountManager.setAtlasClientId(MyMyIndiaKeys.ClientId);
      MapmyIndiaAccountManager.setAtlasClientSecret(MyMyIndiaKeys.ClientSecretId);
    });
    _initUser();
    sharePre();
    setState(() {});
    OverlayLoadingProgress;
  }

  void sharePre() async {
    await Preferences.setPreferences();
    userId = Preferences.getId(Preferences.id).toString();
    await socketConnect(widget.socketToken);
    // Get.snackbar("title", widget.socketToken);
  }

  void _initUser() async {
    polyline_latlng = <LatLng>[];
    location = Location();

    location.enableBackgroundMode(enable: true);
    location.changeNotificationOptions(
        iconName: 'images/rider_launcher.png',
        channelName: 'Nirbhaya',
        title: 'Nirbhaya app is running');
    location.onLocationChanged.listen((LocationData cLoc) async {
      lat = cLoc.latitude!;
      lng = cLoc.longitude!;
      print('Start rIDER : LatLng${lat}');
      polyline_latlng.add(LatLng(cLoc.latitude!, cLoc.longitude!));
      LatLngBounds latLngBounds = boundsFromLatLngList(polyline_latlng);
      mapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds));
      line = await mapController.addLine(LineOptions(geometry: polyline_latlng, lineColor: "#4285F4",lineOpacity: 0.5, lineWidth: 6));
      marker(cLoc.latitude!,cLoc.longitude!);
      mapController.removeSymbol(symbol);
      await Preferences.setPreferences();
      Preferences.setStartLat(cLoc.latitude!.toString());
      Preferences.setStartLng(cLoc.longitude!.toString());
      socket.emit("message", {
        "message": {
          'lat': lat,
          'lng': lng,
          "timestamp": DateTime.now().millisecondsSinceEpoch.toString()
        },
        "roomName": widget.riderId,
      });
    });
  }
  void marker(double lat,double lng)async{
    mapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 15));
    final ByteData bytes = await rootBundle.load("assets/driver_map_min.png");
    final Uint8List list = bytes.buffer.asUint8List();
    mapController.addImage("icon", list);
    symbol = await mapController.addSymbol(SymbolOptions(geometry: LatLng(lat, lng), iconImage: "icon"));
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return WillPopScope(
      onWillPop: () => showExitPopup(context, "Do you want to stop ride?", () async {
        OverlayLoadingProgress.start(context);
        Navigator.pop(context, true);
        await endRide();

      }),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "On Going Journey",
              style:
                  TextStyle(color: CustomColor.black, fontFamily: 'transport'),
            ),
            elevation: 0,
            backgroundColor: CustomColor.lightYellow,
            leading: IconButton(
              onPressed: () {
                showExitPopup(context, "Do you want to stop ride?", () async {
                  OverlayLoadingProgress.start(context);
                  Navigator.pop(context, true);
                  await endRide();

                });
              },
              icon: Image.asset('assets/map_back.png'),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.share,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    shareData();
                  }),
            ],
          ),
          body: Stack(children: [
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return SizedBox(
                  height: constraints.maxHeight / 1.1,
                  child: MapmyIndiaMap(
                    initialCameraPosition: _cameraPosition,
                    scrollGesturesEnabled: true,
                    tiltGesturesEnabled: true,
                    compassEnabled: true,
                    compassViewPosition: CompassViewPosition.BottomLeft,
                    onMapCreated: (map) =>
                    {
                      mapController = map,
                    },
                    onStyleLoadedCallback: () => {
                    mapController,
                    },
                  )
              );
            }),
            DraggableScrollableSheet(
                initialChildSize: 0.15,
                minChildSize: 0.10,
                maxChildSize: 1,
                snapSizes: [0.5, 1],
                snap: true,
                builder: (BuildContext context, scrollSheetController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: CustomColor.white,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0.h, horizontal: 20.0.w),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showExitPopup(context,
                                            "Do you want to stop ride?", () async {
                                          OverlayLoadingProgress.start(context);
                                          Navigator.pop(context, true);
                                          await endRide();
                                            });
                                        //showAlertDialog(context);
                                      },
                                      child: Column(
                                        children: [
                                          Image.asset("images/End_Ride.png",
                                              width: 50.w, height: 50.h),
                                          SizedBox(height: 10.h),
                                          Text("End Ride",
                                              style: TextStyle(
                                                  fontFamily: 'transport',
                                                  fontSize: 14.sp)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    showMenu();
                                  },
                                  child: Column(
                                    children: [
                                      Image.asset("images/Ride_Details.png",
                                          width: 50.w, height: 50.h),
                                      SizedBox(height: 10.h),
                                      Text("Ride Details",
                                          style: TextStyle(
                                              fontFamily: 'transport',
                                              fontSize: 14.sp)),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(const MapFamilyAdd());
                                  },
                                  child: Column(
                                    children: [
                                      Image.asset("images/family_icons.png",
                                          width: 50.w, height: 50.h),
                                      SizedBox(height: 10.h),
                                      Text("Add Family",
                                          style: TextStyle(
                                              fontFamily: 'transport',
                                              fontSize: 14.sp)),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showExitPopup(context,
                                            "Are you in trouble?", () {
                                              OverlayLoadingProgress.start(context);
                                              SOSNotification();
                                            });
                                      },
                                      child: Column(
                                        children: [
                                          Image.asset("images/SOS.png",
                                              width: 50.w, height: 50.h),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ]),
        ),
      ),
    );
  }

  showMenu() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return DrawerInfo(
            dInfoImage: widget.dPhoto.toString(),
            dInfoName: widget.dName.toString(),
            dInfoMobile: widget.dMobile.toString(),
            vInfoImage: 'assets/car.png',
            vInfoModel: widget.model.toString(),
            vInfoOwnerName: widget.vOwnerName.toString(),
            vInfoRegNo: widget.vRegNo.toString(),
            dInfoLicense: widget.vRegNo.toString(),
            press: () {
              Navigator.of(context).pop();
            },
            visibility: visibility,
          );
        });
  }
/*  Future<http.Response> getSocketToken(rideId) async {
    final response = await http.post(
      Uri.parse(ApiUrl.socketUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': userId.toString(),
        'roomName': rideId.toString(),
      }),
    );
    print(jsonEncode(<String, String>{
      'userName': userId.toString(),
      'roomName': rideId.toString(),
    }));
    if (response.statusCode == 200) {
      print("Ride Id: " + rideId.toString());
      String socketToken = jsonDecode(response.body)['token'];
      socketConnect(socketToken);
      print("Token" + socketToken.toString());
      return response;
    } else {
      throw Exception('Failed');
    }
  }*/

  Future<void> socketConnect(String token) async {
    try {
      socket = IO.io(ApiUrl.socketUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
        'extraHeaders': {'authorization': widget.socketToken}
      });
      socket.connect();
      // Subscribe to events
      socket.on('connect', (_) {
        print('Connected to the server');
      });
      socket.on('disconnect', (_) {
        print('Disconnected from the server');
      });
      socket.on('event', (data) {
        print('Received event: $data');
      });
      socket.on('error', (error) {
        print('Error: $error');
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<http.Response> endRide() async {
    final response = await http.post(
        Uri.parse(
            'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/userRide/endRide'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'ride_id': widget.riderId,
          'end_point': {
            'time': DateTime.now().millisecondsSinceEpoch.toString(),
            'latitude': lat,
            'longitude': lng,
            'location': ""
          }
        }));
    print(json.encode({
      'ride_id': widget.riderId,
      'end_point': {
        'time': DateTime.now().millisecondsSinceEpoch.toString(),
        'latitude': lat,
        'longitude': lng,
        'location': ""
      }
    }));

    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      print("End Res: $response");
      if (status == true) {
        OverlayLoadingProgress.stop();
        ToastMessage.toast(msg);
        socket.disconnect();
        Get.to(const MainPage());
      } else {
        OverlayLoadingProgress.stop();
        ToastMessage.toast(msg);
      }
      return response;
    } else {
      throw Exception('Failed');
    }
  }

  Future<http.Response> SOSNotification() async {
    final response = await http.post(Uri.parse(ApiUrl.SOS_Push_Notification),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'user_id': userId.toString(),
          'ride_id': widget.riderId,
        }));
    print(json.encode({
      'user_id': userId.toString(),
      'ride_id': widget.riderId,
    }));

    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      if (status == true) {
        OverlayLoadingProgress.stop();
        ToastMessage.toast(msg.toString());
        Navigator.of(context).pop();
      } else {
        OverlayLoadingProgress.stop();
        ToastMessage.toast(msg.toString());
      }
      return response;
    } else {
      throw Exception('Failed');
    }
  }
  void shareData() {
    String dName = widget.dName.toString();
    String dMobile = widget.dMobile.toString();
    String model = widget.model.toString();
    String ownlerName = widget.vOwnerName.toString();
    String regNo = widget.vRegNo.toString();
    RenderBox box = context.findRenderObject() as RenderBox;
    Share.share(
        "Hi! Nirbhaya...Welcome to the new way to easily share your real-time location with your friends, family, co-workers, customers, suppliers, and more.\n\n"
        "Driver Name: $dName, Driver Mobile Number : $dMobile, Model : $model, Owner Name: $ownlerName, Registration Number: $regNo, "
        "Hey check out my app at: https://play.google.com/store/apps/details?id=com.rider_safe_travel.ride_safe_travel",
        subject: "Description",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }


  boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null || x1 == null || y0 == null || y1 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }
}
