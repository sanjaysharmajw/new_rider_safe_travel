import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/LoginModule/MainPage.dart';
import 'package:ride_safe_travel/LoginModule/Map/Drawer.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/MapAddFamily.dart';
import 'package:ride_safe_travel/Utils/constant.dart';
import 'package:ride_safe_travel/Utils/toast.dart';
import 'package:ride_safe_travel/Widgets/round_text_widgets.dart';
import 'package:ride_safe_travel/bottom_nav/custom_bottom_navi.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:url_launcher/url_launcher.dart';
import 'BottomSheet/GeocodeResultModel.dart';
import 'LoginModule/Error.dart';
import 'Models/sosReasonModel.dart';
import 'UserFamilyList.dart';
import 'Utils/exit_alert_dialog.dart';
import 'Utils/rider_otp.dart';
import 'bottom_nav/home_page_nav.dart';
import 'chat_bot/ChatScreen.dart';
import 'co_passanger/co_passanger_screen.dart';
import 'color_constant.dart';

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
      required this.vRegNo,
      required this.driverLicense,
      required this.otpRide})
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
  final String driverLicense;
  final String otpRide;
}

class _SignUpState extends State<StartRide> {
  Timer? timer;
  late IO.Socket socket;
  late Location location;
  LocationData? currentLocation;
  double speed = 0.0;
  // late double lat;
  // late double lng;
  late Timer timers;
  String id = '';
  var userId = '';
  var gender = '';
  var Sos_status = 'Ok';
  var stopAlertValue = 'No';
  String socketToken = '';
  bool visibility = false;

  List mySelection = [];
  // List<SosReasonModel> reasonmodel = [] ;
  var myreason;

  late double destinationMarkerLat = 0.0;
  late double destinationMarkerLng = 0.0;
  Completer<GoogleMapController> _completer = Completer();
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  static const LatLng destinationLocation =
      LatLng(19.067949048869405, 73.0039520555996);
  List<LatLng> polylineCoordinates = [];
  List<LatLng> live_polylineCoordinates = [];
  static const CameraPosition _cameraPosition = CameraPosition(
    target: destinationLocation,
    zoom: 10,
  );

 

  @override
  void initState() {
    Preferences.setNewRiderId(widget.riderId.toString());
    super.initState();
    getSosReason();
    _initUser();
    setCustomMarkerIcon();
    sharePre();
    setState(() {});
    OverlayLoadingProgress;
    //ToastMessage.toast(widget.riderId);
  }

  Future getLocation() async {
    bool? _serviceEnabled;
    Location location = Location();
    var _permissionGranted = await location.hasPermission();
    _serviceEnabled = await location.serviceEnabled();
    if (_permissionGranted != PermissionStatus.granted || !_serviceEnabled) {
      _permissionGranted = await location.requestPermission();
      _serviceEnabled = await location.requestService();
      ToastMessage.toast("Access Granted");
    }
  }

  void sharePre() async {
    await Preferences.setPreferences();
    userId = Preferences.getId(Preferences.id).toString();
    gender = Preferences.getgender().toString();
    await socketConnect(widget.socketToken);
    setState(() async {
      await getLocation();
    });
    // Get.snackbar("title", widget.socketToken);
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/driver_map_min.png').then((icon) {
      sourceIcon = icon;
    });

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, 'assets/to_map_pin.png')
        .then((icon) {
      destinationIcon = icon;
    });
  }

  void _initUser() async {
    location = Location();
    location.enableBackgroundMode(enable: true);
    location.changeNotificationOptions(
        iconName: 'images/rider_launcher.png',
        channelName: 'Nirbhaya',
        title: 'Nirbhaya app is running');
    location.onLocationChanged.listen((LocationData cLoc) async {
      currentLocation = cLoc;
      speed = cLoc.speed!;
      //setState(() {});
      if (cLoc.speed.toString().length > 5) {
        stopAlertTimer();
      }
      setState(() {});
      final GoogleMapController controller = await _completer.future;
      if (destinationMarkerLat == 0.0) {
        if (speed > 5) {
          ToastMessage.toast(speed.toString());
          live_polylineCoordinates.add(LatLng(currentLocation!.latitude!, currentLocation!.longitude!));
        }
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(cLoc.latitude!, cLoc.longitude!), zoom: 19)));
      } else {
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(cLoc.latitude!, cLoc.longitude!), zoom: 11)));
      }

      await Preferences.setPreferences();
      Preferences.setStartLat(cLoc.latitude!.toString());
      Preferences.setStartLng(cLoc.longitude!.toString());
      socket.emit("message", {
        "message": {
          'lat': currentLocation!.latitude!,
          'lng': currentLocation!.longitude!,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          //'status':"Ok/sos/resolved/responded/escalated",

          'status': Sos_status.toString(),
          'sub_status': reason.toString(),
          'vehicle_type': widget.model.toString(),
          'gender': gender.toString(),
          'driver_license': widget.driverLicense.toString(),
          'vehicle_no': widget.vRegNo.toString(),
          'altitude': currentLocation!.altitude,
          'speed': currentLocation!.speed.toString(),
          'speedAccuracy': currentLocation!.speedAccuracy.toString(),
          'elapsedRealtimeNanos':
              currentLocation!.elapsedRealtimeNanos.toString(),
          'elapsedRealtimeUncertaintyNanos':
              currentLocation!.elapsedRealtimeUncertaintyNanos.toString(),
          'accuracy': currentLocation!.accuracy.toString(),
          'heading': currentLocation!.heading.toString(),
          'headingAccuracy': currentLocation!.headingAccuracy.toString(),
          'provider': currentLocation!.provider.toString(),
          'satelliteNumber': currentLocation!.satelliteNumber
              .toString(), //satellite no 0 check it
          'verticalAccuracy': currentLocation!.verticalAccuracy.toString(),
          'h_dop': currentLocation!.accuracy! / 5,
          'v_dop':
              currentLocation!.accuracy! / currentLocation!.verticalAccuracy!,
          'time': currentLocation!.time.toString()
        },
        "roomName": widget.riderId,
      });
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  final TextEditingController destinationController = TextEditingController();
  final TextEditingController fieldTextEditingController =
      TextEditingController();
  final ScrollController scrollController = ScrollController();
  List<Result> locationData = [];
  String searchString = "";
  var selectedReason = [];
  var reason;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return 
        Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "ongoing_journey".tr,
          style: TextStyle(
              color: CustomColor.white, fontFamily: 'Gilroy', fontSize: 22),
        ),
        elevation: 0,
        backgroundColor: appBlue,
        leading: IconButton(
          onPressed: () {
            OverlayLoadingProgress.stop();
            Get.offAll(CustomBottomNav());
          },
          icon: Image.asset(
            'assets/map_back.png',
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.chat),
              color: CustomColor.white,
              onPressed: () {
                Get.to(const ChatScreen());
              }),
          IconButton(
              icon: const Icon(
                Icons.share,
                color: Colors.white,
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
            height: constraints.maxHeight / 1.2,
            child: currentLocation == null
                ? const Center(child: Text("Loading Map..."))
                : GoogleMap(
                    initialCameraPosition: _cameraPosition,
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    padding: const EdgeInsets.only(bottom: 60),
                    compassEnabled: true,
                    mapToolbarEnabled: true,
                    myLocationButtonEnabled: true,
                    polylines: {
                      Polyline(
                          polylineId: PolylineId("live_polyline"),
                          points: live_polylineCoordinates,
                          color: Colors.blueAccent,
                          width: 4),
                      Polyline(
                          polylineId: PolylineId("route"),
                          points: polylineCoordinates,
                          color: Colors.blueAccent,
                          width: 4)
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _completer.complete(controller);
                    },
                    markers: {
                      Marker(
                        markerId: const MarkerId("source"),
                        position: LatLng(currentLocation!.latitude!,
                            currentLocation!.longitude!),
                        icon: sourceIcon,
                      ),
                      Marker(
                        markerId: const MarkerId("destination"),
                        position:
                            LatLng(destinationMarkerLat, destinationMarkerLng),
                        icon: destinationIcon,
                      )
                    },

                    // markers: Set<Marker>.of(_markers.values),
                  ),
          );
        }),
        DraggableScrollableSheet(
            initialChildSize: 0.30,
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
                        Text('otp: ${widget.otpRide.toString()}'.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Gilroy')),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          child: ListTile(
                            title: TextFormField(
                              controller: destinationController,
                              decoration: InputDecoration(
                                  hintText: "destination".tr,
                                  hintStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontFamily: 'Gilroy'),
                                  border: InputBorder.none),
                              readOnly: true,
                              onTap: () {
                                // getSuggestions();
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return ListView(
                                        controller: scrollController,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 12.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: 30,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                12.0))),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 30.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const <Widget>[
                                              Text(
                                                "Select a location",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 20.0,
                                                    fontFamily: 'Gilroy'),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 30.0,
                                          ),
                                          Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Autocomplete<Result>(
                                                  optionsBuilder:
                                                      (TextEditingValue
                                                          textEditingValue) {
                                                    return getSuggestions(
                                                        textEditingValue);
                                                  },
                                                  displayStringForOption:
                                                      (Result option) =>
                                                          option
                                                              .text
                                                              .toString(),
                                                  fieldViewBuilder: (BuildContext
                                                          context,
                                                      TextEditingController
                                                          fieldTextEditingController,
                                                      FocusNode fieldFocusNode,
                                                      VoidCallback
                                                          onFieldSubmitted) {
                                                    return Card(
                                                      child: ListTile(
                                                        //leading: Icon(Icons.search),
                                                        title: TextFormField(
                                                          onChanged: (value) {
                                                            setState(() {
                                                              searchString = value
                                                                  .toString();
                                                            });
                                                          },
                                                          controller:
                                                              fieldTextEditingController,
                                                          focusNode:
                                                              fieldFocusNode,
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      "Search",
                                                                  hintStyle: TextStyle(
                                                                      fontFamily:
                                                                          'Gilroy'),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  prefixIcon:
                                                                      IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            // searchMemberApi(mobileController.text,widget.userId);
                                                                          },
                                                                          icon:
                                                                              Icon(
                                                                            Icons.search,
                                                                          ))),
                                                        ),
                                                        trailing: IconButton(
                                                            onPressed: () {
                                                              fieldTextEditingController
                                                                  .clear();
                                                            },
                                                            icon: Icon(
                                                                Icons.clear)),
                                                      ),
                                                    );
                                                  },
                                                  onSelected:
                                                      (Result selection) {
                                                    print(
                                                        'Selected: ${selection.text}');
                                                    fieldTextEditingController
                                                            .text =
                                                        selection.text
                                                            .toString();
                                                  },
                                                  optionsViewBuilder:
                                                      (BuildContext context,
                                                          AutocompleteOnSelected<
                                                                  Result>
                                                              onSelected,
                                                          Iterable<Result>
                                                              options) {
                                                    return Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Material(
                                                        child: Container(
                                                          width: 365,
                                                          //color: Colors.grey,
                                                          child:
                                                              ListView.builder(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10.0),
                                                            itemCount:
                                                                options.length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              final Result option = options.elementAt(index);

                                                              return GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  onSelected(option);
                                                                  destinationController
                                                                          .text =
                                                                      option
                                                                          .text
                                                                          .toString();
                                                                  OverlayLoadingProgress
                                                                      .start(
                                                                          context);
                                                                  await getDestination(option.placeId);

                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Card(
                                                                  elevation: 1,
                                                                  margin: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              2),
                                                                  child:
                                                                      ListTile(
                                                                    leading:
                                                                        Icon(
                                                                      Icons
                                                                          .location_on_rounded,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                    title: Text(
                                                                        option
                                                                            .text
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black)),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }))
                                        ],
                                      );
                                    });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    showExitPopup(
                                        context, "Do you want to stop ride?",
                                        () async {
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
                                              fontFamily: 'Gilroy',
                                              fontSize: 12.sp)),
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
                                          fontFamily: 'Gilroy',
                                          fontSize: 12.sp)),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                Get.to(FamilyList());
                                // Get.to(const MapFamilyAdd());
                              },
                              child: Column(
                                children: [
                                  Image.asset("images/family_icons.png",
                                      width: 50.w, height: 50.h),
                                  SizedBox(height: 10.h),
                                  Text("Add Family",
                                      style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: 12.sp)),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration:  BoxDecoration(
                                   // borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                      shape: BoxShape.circle, color: appBlue,),
                                  child: Center(
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.navigation_outlined,
                                        color: Colors.black,
                                        size: 20,

                                      ),
                                      onPressed: () async {
                                        await launchUrl(Uri.parse(
                                            'google.navigation:q=$destinationMarkerLat, $destinationMarkerLng&key=AIzaSyAmOl-QJnc2Spwuh8GAoqx9Z3Wz-ez73V8'));
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text("Navigate",
                                    style: TextStyle(
                                        fontFamily: 'Gilroy', fontSize: 12.sp)),
                              ],
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    sos();
                                    //showExitPopup(
                                    //context, "Are you in trouble?", "Reason" , () {
                                    //OverlayLoadingProgress.start(context);
                                    //  SOSNotification();
                                    //  });
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
        roundTextWidget(textValue: speed.toStringAsFixed(1)),
        Positioned(
            top: 50,
            child: InkWell(
              onTap: () {
                Get.to(DriverCoPassScreen(rideId: widget.riderId.toString()));
              },
              child: Padding(
                  padding: EdgeInsets.only(left: 8,right: 8,top: 13),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: CustomColor.yellow,
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                        child: Image.asset('new_assets/guest.png',
                            width: 30, height: 30)),
                  )),
            )),
      ]),
      //   ),
    );
  }

  showMenu() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return DrawerInfo(
            dInfoImage: widget.dPhoto.toString() == "null"
                ? " "
                : widget.dPhoto.toString(),
            dInfoName: widget.dName.toString() == "null"
                ? " "
                : widget.dName.toString(),
            dInfoMobile: widget.dMobile.toString() == "null"
                ? " "
                : widget.dMobile.toString(),
            vInfoImage: 'assets/car.png',
            vInfoModel: widget.model.toString() == "null"
                ? " "
                : widget.model.toString(),
            vInfoOwnerName: widget.vOwnerName.toString() == "null"
                ? " "
                : widget.vOwnerName.toString(),
            vInfoRegNo: widget.vRegNo.toString() == "null"
                ? " "
                : widget.vRegNo.toString(),
            dInfoLicense: widget.vRegNo.toString() == "null"
                ? " "
                : widget.vRegNo.toString(),
            press: () {
              Navigator.of(context).pop();
            },
            visibility: visibility,
          );
        });
  }

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
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    final response = await http.post(
        Uri.parse(
            ApiUrl.endRide),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': loginToken
        },
        body: json.encode({
          'ride_id': widget.riderId,
          'end_point': {
            'time': DateTime.now().millisecondsSinceEpoch.toString(),
            'latitude': currentLocation!.latitude.toString(),
            'longitude': currentLocation!.longitude.toString(),
            'location': ""
          }
        }));
    print(json.encode({
      'ride_id': widget.riderId,
      'end_point': {
        'time': DateTime.now().millisecondsSinceEpoch.toString(),
        'latitude': currentLocation!.latitude.toString(),
        'longitude': currentLocation!.longitude.toString(),
        'location': ""
      }
    }));
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      print("$response");
      if (status == true) {
        OverlayLoadingProgress.stop();
        ToastMessage.toast(msg);
        socket.disconnect();
        stopAlertValue = "Yes";
        Preferences.setRideOtp('');
        Get.to(const CustomBottomNav()); //MainPage
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
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    final response = await http.post(Uri.parse(ApiUrl.SOS_Push_Notification),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': loginToken
        },
        body: json.encode({
          'reason': reason.toString(),
          'user_id': userId.toString(),
          'ride_id': widget.riderId,
          "lat": currentLocation!.latitude.toString(),
          "lng": currentLocation!.longitude.toString(),
          "timestamp": DateTime.now().millisecondsSinceEpoch.toString()
        }));
    print(json.encode({
      'reason': reason ?? "Ok",
      'user_id': userId.toString(),
      'ride_id': widget.riderId,
      "lat": currentLocation!.latitude.toString(),
      "lng": currentLocation!.longitude.toString(),
      "timestamp": DateTime.now().millisecondsSinceEpoch.toString()
    }));

    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      if (status == true) {
        OverlayLoadingProgress.stop();
        ToastMessage.toast(msg.toString());
        Navigator.of(context).pop();
        stopAlertValue = "Yes";
        setState(() {
          sosStatus();
        });
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

  Future<List<Result>> getSuggestions(TextEditingValue textEditingValue) async {
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    if (textEditingValue.text.toString().length > 3) {
      OverlayLoadingProgress.start(context);
      final response = await http.post(
        Uri.parse(ApiUrl.geolocatelist),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': loginToken
        },
        body: jsonEncode(
            <String, String>{"search": textEditingValue.text.toString()}),
      );
      print('getSuggestions:${jsonEncode(<String, String>{
            "search": textEditingValue.text.toString()
          })}');
      if (response.statusCode == 200) {
        OverlayLoadingProgress.stop();
        print("getData" + response.body);
        String placeId = jsonDecode(response.body)['result'][0]['PlaceId'];
        print("getPlaceId::::" + placeId);
        // await getDestination(placeId);
        locationData = jsonDecode(response.body)['result']
            .map<Result>((data) => Result.fromJson(data))
            .toList();
        return locationData;
      } else {
        throw Exception('Failed to load');
      }
    } else {
      throw Exception('No Result');
    }
  }

  Future<List<Result>> getDestination(String? placeId) async {
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    final response = await http.post(
      Uri.parse(ApiUrl.geolocationDetails),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': loginToken
      },
      body: jsonEncode(<String, String>{"PlaceId": placeId.toString()}),
    );
    print('getDestination:${jsonEncode(<String, String>{
          "PlaceId": placeId.toString()
        })}');

    if (response.statusCode == 200) {
      OverlayLoadingProgress.stop();
      print("getDetails" + response.body);
      double destinationLat = jsonDecode(response.body)['result'][0]['lat'];
      double destinationLng = jsonDecode(response.body)['result'][0]['lng'];
      destinationMarkerLat = destinationLat;
      destinationMarkerLng = destinationLng;
      String wayPoints = "$destinationLat,$destinationLng";
      print('wayPoints $wayPoints');
      polylineCoordinates.clear();
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleMapKey,
        travelMode: TravelMode.driving,
        PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        PointLatLng(destinationLat, destinationLng),
        wayPoints: [PolylineWayPoint(location: wayPoints, stopOver: false)],
      );
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) => {
              // ToastMessage.toast(speed.toString()),
              // if(speed>=5) //kilometer check if greater than 10 meter
              // {
              polylineCoordinates.add(LatLng(point.latitude, point.longitude))
              //}
              //else
              // {
              //}
            });
        setState(() {});
      }
      //await getDistance(currentLocation!.latitude!,currentLocation!.longitude!,destinationMarkerLat,destinationMarkerLng);
      Navigator.pop(context);
      var locationDetails = jsonDecode(response.body)['result']
          .map<Result>((data) => Result.fromJson(data))
          .toList();
      return locationDetails;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<dynamic> getDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) async {
    String Url =
        'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${startLatitude},${startLongitude}&origins=${endLatitude},${endLongitude}&key=AIzaSyBu3-_hcaqdnAYTFEMIKbyNtoOJWPBaKmc';
    try {
      var response = await http.get(
        Uri.parse(Url),
      );
      if (response.statusCode == 200) {
        print('distance: $response');
        return jsonDecode(response.body);
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<ReasonMasterData> getSosReason() async {
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    final response = await http.post(
      Uri.parse(ApiUrl.sosReason),
      headers: ApiUrl.headerToken,
        body: jsonEncode({
          "type":""
        })
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body)['data'];
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      if (status == true) {
        setState(() {
          selectedReason = jsonResponse;
        });
        print(selectedReason.toString());
      }
      return ReasonMasterData.fromJson(jsonDecode(response.body));
    } else {
      print("----------------------------");
      print(response.statusCode);
      print("----------------------------");

      throw Exception('Unexpected error occured!');
    }
  }

//stopAlert
  void stopAlertTimer() {
    Timer.periodic(const Duration(minutes: 10), (timers) {
      if (stopAlertValue == "Yes") {
        setState(() {
          timers.cancel();
        });
      } else {
        stopAlert();
      }
    });

    // Timer(const Duration(minutes: 10), () {
    //   stopAlert();
    // });
  }

  void sosStatus() {
    Timer.periodic(const Duration(minutes: 10), (timers) {
      if (Sos_status == "Yes") {
        setState(() {
          timers.cancel();
        });
      } else {
        sosHelpAlert();
      }
    });
  }

  Future<void> stopAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Do you want to stop?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            TextButton(
              child: const Text('End Rider'),
              onPressed: () {
                showExitPopup(context, "Do you want to stop ride?", () async {
                  OverlayLoadingProgress.start(context);
                  //Navigator.pop(context, true);
                  await endRide();
                });
              },
            ),
            TextButton(
              child: const Text('SOS'),
              onPressed: () {
                sos();
              },
            ),
          ],
        );
      },
    );
  }

  void sos() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              content: Container(
                height: 190,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Are you in trouble? Please select your reason : "),
                    SizedBox(height: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 65,
                          child: Card(
                            color: Colors.white,
                            shape: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: appBlue)),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: DropdownButton(
                                underline: Container(),
                                // hint: Text("Select State"),
                                icon: Icon(Icons.keyboard_arrow_down),
                                isDense: true,
                                isExpanded: true,

                                items: selectedReason.map((e) {
                                  return DropdownMenuItem(
                                    value: e['name'].toString(),
                                    child: Text(e['name'].toString()),
                                  );
                                }).toList(),
                                value: reason,
                                onChanged: (value) {
                                  setState(() {
                                    Sos_status = "SOS";
                                    reason = value;
                                    isSelected = true;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              OverlayLoadingProgress.start(context);
                              SOSNotification();
                            },
                            child: Text("Yes"),
                            style: ElevatedButton.styleFrom(primary: appBlue),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {
                            print('no selected');
                            Navigator.of(context).pop();
                          },
                          child:
                              Text("No", style: TextStyle(color: Colors.black)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                        ))
                      ],
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  Future<void> sosHelpAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Do you received help?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context, true);
                Sos_status = "No";
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.pop(context, true);
                Sos_status = "Yes";
                setState(() {
                  timers.cancel();
                });
              },
            ),
          ],
        );
      },
    );
  }
}
