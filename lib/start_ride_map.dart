import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/LoginModule/Map/Drawer.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/Utils/make_a_call.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:url_launcher/url_launcher.dart';
import 'DriverVehicleList.dart';
import 'LoginModule/Error.dart';

class StartRide extends StatefulWidget {
   StartRide({Key? key,required this.riderId,required this.dName,required this.dMobile,required this.dPhoto,
     required this.model,required this.vOwnerName,required this.vRegNo}) : super(key: key);

  @override
  State<StartRide> createState() => _SignUpState();
  final String riderId;

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
  late  double lng;
  String id = '';
  var userId = '';
  String socketToken = '';
  bool visibility = false;

  late Map<MarkerId, Marker> _markers;
  Completer<GoogleMapController> _completer = Completer();
  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(19.0654285394954, 73.00269069070602),
    zoom: 14,
  );

  @override
  void initState() {
    super.initState();
    _initUser();
    sharePre();
    setState(() {
    });
  }

  void sharePre() async {
    await Preferences.setPreferences();
    userId = Preferences.getId(Preferences.id).toString();
    await getSocketToken(widget.riderId);
  }

  void _initUser() async {
    location = Location();
    location.onLocationChanged.listen((LocationData cLoc) async {
      lat = cLoc.latitude!;
      lng = cLoc.longitude!;
      print('LatLng${lat}');
      await Preferences.setPreferences();
      Preferences.setStartLat(cLoc.latitude!.toString());
      Preferences.setStartLng(cLoc.longitude!.toString());
      socket.emit("message", {
        "message": {'lat': lat, 'lng': lng},
        "roomName": widget.riderId,
      });
      final GoogleMapController controller = await _completer.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(cLoc.latitude!, cLoc.longitude!), zoom: 19)));
      var image = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), "images/map_marker.png");
      Marker marker = Marker(
          markerId: MarkerId('ID'), icon: image, position: LatLng(cLoc.latitude!, cLoc.longitude!));
      setState(() {
        _markers[MarkerId('ID')] = marker;
      });
    });
    _markers = <MarkerId, Marker>{};
    _markers.clear();
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Start Ride",
            style: TextStyle(color: CustomColor.black, fontFamily: 'transport'),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
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
                  child: GoogleMap(
                    initialCameraPosition: _cameraPosition,
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    compassEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                  _completer.complete(controller);
                },
                markers: Set<Marker>.of(_markers.values),
                ));
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
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Make_a_call.makePhoneCall("21616");
                                  },
                                  child: Column(
                                    children: [
                                      Image.asset("images/contact_driver.png",
                                          width: 50, height: 50),
                                      const SizedBox(height: 10),

                                      const Text("Contact Ride",
                                          style: TextStyle(
                                              fontFamily: 'transport', fontSize: 16)),
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
                                      width: 50, height: 50),
                                  const SizedBox(height: 10),
                                  const Text("Ride Details",
                                      style: TextStyle(
                                          fontFamily: 'transport',
                                          fontSize: 16)),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Make_a_call.makePhoneCall("100");
                                  },
                                  child: Column(
                                    children: [
                                      Image.asset("images/hundred_number.png",
                                          width: 50, height: 50),
                                      const SizedBox(height: 10),
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
                      ],
                    ),
                  ),
                );
              }),
        ]),
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
            vInfoModel:  widget.model.toString(),
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
  Future<http.Response> getSocketToken(rideId) async {
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
  }

  Future<void> socketConnect(String token) async {
    try {
      socket = IO.io(ApiUrl.socketUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
        'extraHeaders': {'authorization': token.toString()}
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

}



