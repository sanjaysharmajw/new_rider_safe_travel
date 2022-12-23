import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'LoginModule/Error.dart';

class StartRide extends StatefulWidget {
   StartRide({Key? key}) : super(key: key);

  @override
  State<StartRide> createState() => _SignUpState();
}

class _SignUpState extends State<StartRide> {

  Timer? timer;
  late IO.Socket socket;
  late Location location;
  late LocationData currentLocation;
  late double lat = 0.0;
  late double lng = 0.0;
  String id = '';
  String rideId = '';
  var vehicleId = '', driverId = '';
  var userId = '';
  String date = '';
  String socketToken = '';

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

    //timer = Timer.periodic(const Duration(seconds: 2), (Timer t) => rideDataSave());

    setState(() {
    });
    sharePre();
    final now = DateTime.now();
    date = DateFormat('yMd').format(now);
    Get.snackbar("date", date);
  }

  void sharePre() async {
    await Preferences.setPreferences();
    //  id = Preferences.getUserRiderId().toString();
    userId = Preferences.getId(Preferences.id).toString();
    vehicleId = Preferences.getVehicleId(Preferences.vehicleId).toString();
    driverId = Preferences.getDriverId().toString();
    await userRideAdd(userId, vehicleId, driverId);
    print(userId+ vehicleId+driverId);
  }

  void _initUser() async {
    location = Location();
    location.onLocationChanged.listen((LocationData cLoc) async {
      lat = cLoc.latitude!;
      lng = cLoc.longitude!;
      print('LatLng${lat}');
      socket.emit("message", {
        "message": {'lat': lat, 'lng': lng},
        "roomName": rideId,
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
    await getSocketToken();


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
        body:  GoogleMap(
        initialCameraPosition: _cameraPosition,
        mapType: MapType.normal,
        myLocationEnabled: true,
        compassEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _completer.complete(controller);
        },
        markers: Set<Marker>.of(_markers.values),
      ),
      ),
    );
  }
  Future<http.Response> userRideAdd(
      String userId, String vehicleId, String driverId) async {
    final response = await http.post(Uri.parse(ApiUrl.userRideAdd),
        body: json.encode({
          'user_id': userId,
          'vehicle_id': vehicleId,
          'driver_id': driverId,
          'date': date.toString(),
          'start_point': {
            'time': DateTime.now().millisecondsSinceEpoch.toString(),
            'latitude': lat.toString(),
            'longitude': lng.toString(),
            'location': ""
          }
        }));
    print(json.encode({
      'user_id': userId,
      'vehicle_id': vehicleId,
      'driver_id': driverId,
      'date': date,
      'start_point': {
        'time': DateTime.now().millisecondsSinceEpoch.toString(),
        'latitude': lat,
        'longitude': lng,
        'location': ""
      }
    }));

    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];

      if (status == true) {
        Get.snackbar(response.body, 'successful');
        // Preferences.setUserRiderId(rideId);
        // rideDataSave();
        if (jsonDecode(response.body)['data'] != null) {
          rideId = jsonDecode(response.body)['data'];
        }
        getSocketToken();
        print("rideId"+rideId);
      } else if (status == false) {
        Get.snackbar(response.body, 'Failed');
      }
      return response;
    } else {
      throw Exception('Failed to create album.');
    }
  }

/*  Future<http.Response> rideDataSave() async {
    final response = await http.post(Uri.parse(ApiUrl.rideDataSave),
        body: json.encode({
          'ride_id': rideId,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          'latitude': lat,
          'longitude': lng,
          'speed': "40",
          'lateralmovement': '',
          'action': ''
        }));
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      if (status == true) {
        Get.snackbar(response.body, 'successful');
        print(id);
      } else if (status == false) {
        Get.snackbar(response.body, 'Failed');
      }
      return response;
    } else {
      throw Exception('Failed');
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
        'roomName': rideId.toString(),
      }),
    );
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



