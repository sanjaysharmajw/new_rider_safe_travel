import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class RiderMap extends StatefulWidget {
   RiderMap({Key? key,required this.riderId}) : super(key: key);

  @override
  State<RiderMap> createState() => _RiderMapState();
  String riderId;
}

class _RiderMapState extends State<RiderMap> {
  Timer? timer;
  late Location location;
  late LocationData currentLocation;
  String id = '';
  late IO.Socket socket;
  var vehicleId = '', driverId = '', userId = '', riderId = '';
  String date = '';

  late Map<MarkerId, Marker> _markers;
  Completer<GoogleMapController> _completer = Completer();
  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(19.0654285394954, 73.00269069070602),
    zoom: 14,
  );

  @override
  void initState() {
    super.initState();
    // getDataEverySec();
    _markers = <MarkerId, Marker>{};
    _markers.clear();
    sharePre();
    //getRideData();
    //_initUser();
    final now = DateTime.now();
    date = DateFormat('yMd').format(now);
  }

  void sharePre() async {
    await Preferences.setPreferences();
    id = Preferences.getUserRiderId().toString();
    userId = Preferences.getId(Preferences.id).toString();
    vehicleId = Preferences.getVehicleId(Preferences.vehicleId).toString();
    driverId = Preferences.getDriverId().toString();
    riderId = Preferences.getRiderIdFromFamilyMem().toString();
    getSocketToken();
    //Get.snackbar("Hit with time", riderId);
  }

  // void getDataEverySec() async {
  //   setState(() {
  //     timer = Timer.periodic(
  //         const Duration(seconds: 2), (Timer t) => getRideData());
  //   });
  // }

  // void cameraUpdate(kInitialPosition) async {
  //   CameraPosition kInitialPosition = CameraPosition(
  //     target: LatLng(lat, lng),
  //     zoom: 10.0,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Family",
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
          SizedBox(
            child: GoogleMap(
              initialCameraPosition: _cameraPosition,
              mapType: MapType.normal,
              myLocationEnabled: true,
              compassEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _completer.complete(controller);
              },
              markers: Set<Marker>.of(_markers.values),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: AlignmentDirectional.topEnd, // <-- SEE HERE
              child:
                  Image.asset("images/information.png", width: 30, height: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: AlignmentDirectional.bottomEnd, // <-- SEE HERE
              child: Image.asset("images/SOS.png", width: 50, height: 50),
            ),
          ),
        ]),

        // body: GoogleMap(
        //   initialCameraPosition: _cameraPosition,
        //   mapType: MapType.normal,
        //   myLocationEnabled: true,
        //   compassEnabled: true,
        //   onMapCreated: (GoogleMapController controller) {
        //     _completer.complete(controller);
        //   },
        //   markers: Set<Marker>.of(_markers.values),
        // ),

        /*      bottomSheet: Container(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Image.asset("images/End_Ride.png",width: 50,height: 50),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset("images/Ride_Details.png",width: 50,height: 50),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset("images/SOS.png",width: 50,height: 50),
                    ],
                  ),
                ],
            ),
          ),
        ),*/
      ),
    );
  }

  /*Future<FamilyMemberReadRideDataModels> getRideData() async {
    final response = await http.post(
      Uri.parse(ApiUrl.getRideCurrentApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'ride_id': widget.rideId.toString(),
      }),
    );
    print('Response:!${response.body}');
    if (response.statusCode == 200) {
      Get.snackbar("Ride Id", widget.rideId.toString());
      print('Ride Id:!${widget.rideId}');
      Get.snackbar("Response", jsonDecode(response.body).toString());
      return FamilyMemberReadRideDataModels.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }*/

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

        final GoogleMapController controller = await _completer.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(lat, lng), zoom: 19)));
        var image = await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "images/map_marker.png");
        Marker marker = Marker(
            markerId: MarkerId('ID'), icon: image, position: LatLng(lat, lng));
        setState(() {
          _markers[MarkerId('ID')] = marker;
        });
      });
      socket.on('error', (error) {
        print('Error: $error');
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
