import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/LoginModule/Map/Drawer.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/Utils/make_a_call.dart';
import 'package:ride_safe_travel/Utils/toast.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../Utils/MapMyIndiaKeys.dart';
import '../../Utils/exit_alert_dialog.dart';

class RiderMap extends StatefulWidget {
  RiderMap({
    Key? key,
    required this.riderId,
    required this.dName,
    required this.dLicenseNo,
    required this.vModel,
    required this.vOwnerName,
    required this.vRegistration,
    required this.dMobile,
    required this.dImage,
    required this.memberName,
  }) : super(key: key);

  @override
  State<RiderMap> createState() => _RiderMapState();
  String riderId;
  String memberName;
  String dName;
  String dLicenseNo;
  String vModel;
  String vOwnerName;
  String vRegistration;
  String dMobile;
  String dImage;
}

class _RiderMapState extends State<RiderMap> {
  Timer? timer;
  late Location location;
  late LocationData currentLocation;
  String id = '';
  late IO.Socket socket;
  var vehicleId = '', driverId = '', userId = '', riderId = '';
  String date = '';
  bool visibility = false;
  late MapmyIndiaMapController mapController;
  late Symbol symbol;

  //Polyline
  late Line line;
  late List<LatLng> polyline_latlng;

  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(19.0654285394954, 73.00269069070602),
    zoom: 14,
  );


  @override
  void initState() {
    super.initState();
    polyline_latlng = <LatLng>[];
    setState(() {
      MapmyIndiaAccountManager.setMapSDKKey(MyMyIndiaKeys.mapSKDKey);
      MapmyIndiaAccountManager.setRestAPIKey(MyMyIndiaKeys.MapRestAPIKey);
      MapmyIndiaAccountManager.setAtlasClientId(MyMyIndiaKeys.ClientId);
      MapmyIndiaAccountManager.setAtlasClientSecret(MyMyIndiaKeys.ClientSecretId);
    });
    sharePre();
    //getRideData();
    //_initUser();
    final now = DateTime.now();
    date = DateFormat('yMd').format(now);
    if (widget.dLicenseNo.isEmpty) {
      visibility = false;
    } else {
      visibility = true;
    }
  }

  void sharePre() async {
    await Preferences.setPreferences();
    id = Preferences.getUserRiderId().toString();
    userId = Preferences.getId(Preferences.id).toString();
    vehicleId = Preferences.getVehicleId(Preferences.vehicleId).toString();
    driverId = Preferences.getDriverId().toString();
    riderId = Preferences.getRiderIdFromFamilyMem().toString();
    OverlayLoadingProgress.stop();
    getSocketToken();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.memberName.toString(),
            style: const TextStyle(color: CustomColor.black, fontFamily: 'transport'),
          ),
          elevation: 0,
          backgroundColor: CustomColor.lightYellow,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: Image.asset('assets/map_back.png'),
          ),
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
              ),
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
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: CustomColor.white,
                    borderRadius: BorderRadius.circular(15.h),
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
                              InkWell(
                                onTap: () {
                                  Make_a_call.makePhoneCall(widget.dMobile);
                                },
                                child:   Column(
                                  children: [
                                    Image.asset("images/contact_driver.png",
                                        width: 50.w, height: 50.h),
                                    SizedBox(height: 10.h),
                                    Text("Contact Driver",
                                        style: TextStyle(
                                            fontFamily: 'transport',
                                            fontSize: 16.sp)),
                                  ],
                                ),
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
                                            fontSize: 16.sp)),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showExitPopup(context,"Do you really want to call on 100 ?",(){
                                    Make_a_call.makePhoneCall("100");
                                    Navigator.pop(context, true);
                                  });
                                },
                                child: Column(
                                  children: [
                                    Image.asset("images/hundred_number.png",
                                        width: 50.w, height: 50.h),
                                    SizedBox(height: 10.h),
                                    const Text("100",
                                        style: TextStyle(
                                            fontFamily: 'transport',
                                            fontSize: 16)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ]
        ),
      ),
    );
  }

  showMenu() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return DrawerInfo(
            dInfoImage: widget.dImage,
            dInfoName: widget.dName,
            dInfoMobile: widget.dMobile,
            vInfoImage: 'images/bottom_drawer_comp.png',
            vInfoModel: widget.vModel,
            vInfoOwnerName: widget.vOwnerName,
            vInfoRegNo: widget.vRegistration,
            dInfoLicense: widget.dLicenseNo,
            press: () {
              Navigator.of(context).pop();
            },
            visibility: visibility,
          );
        });
  }

  Future<http.Response> getSocketToken() async {
    final response = await http.post(
      Uri.parse(ApiUrl.socketUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': userId.toString(),
        'roomName': widget.riderId.toString(),
      }),
    );
    if (response.statusCode == 200) {
      String socketToken = jsonDecode(response.body)['token'];
      socketConnect(socketToken);
      print("Token" + socketToken.toString());
      return response;
    } else {
      throw Exception('Failed');
    }
  }

  Future<void> socketConnect(String token) async {
    try {
      socket = IO.io(ApiUrl.socketUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
        'extraHeaders': {
          'authorization': token.toString(),
          'Content-Type': 'application/json; charset=UTF-8'
        }
      });
      socket.connect();
      // Subscribe to events
      socket.on('connect', (_) {
        print('Connected to the server');
      });
      socket.on('disconnect', (_) {
        print('Disconnected from the server');
      });
      socket.on('message', (data) async {
        print('Received event: $data');
        var lat = jsonDecode(data)['lat'];
        var lng = jsonDecode(data)['lng'];
        print('Received lat: $lat + $lng');
        polyline_latlng.add(LatLng(lat, lng));
        LatLngBounds latLngBounds = boundsFromLatLngList(polyline_latlng);
        mapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds));
        line = await mapController.addLine(LineOptions(geometry: polyline_latlng, lineColor: "#4285F4",lineOpacity: 0.5, lineWidth: 6));
        marker(lat,lng);
        mapController.removeSymbol(symbol);
      });
      socket.on('error', (error) {
        print('Error: $error');
      });
    } catch (e) {
      print(e.toString());
    }
  }
  void marker(double lat,double lng)async{
    mapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 16));
    final ByteData bytes = await rootBundle.load("assets/family_map_pin.png");
    final Uint8List list = bytes.buffer.asUint8List();
    mapController.addImage("icon", list);
    symbol = await mapController.addSymbol(SymbolOptions(geometry: LatLng(lat, lng), iconImage: "icon"));
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
