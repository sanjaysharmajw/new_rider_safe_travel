import 'dart:async';
import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';

import '../LoginModule/preferences.dart';
import '../MyText.dart';
import '../SearchServicesModel.dart';
import '../bottom_nav/custom_bottom_navi.dart';
import '../color_constant.dart';
import '../controller/permision_controller.dart';

class TrackingMap extends StatefulWidget {
  final ServiceListData? serviceListData;
 // final StartRideModesl? socketToken;
  const TrackingMap({Key? key, this.serviceListData,
    //this.socketToken
  }) : super(key: key);
  
  @override
  State<TrackingMap> createState() => _TrackingMapState();
}

class _TrackingMapState extends State<TrackingMap> {
  final Completer<GoogleMapController> _completer = Completer();
  //final userServiceListController = Get.put(UserServiceListController());
  final permissionController = Get.put(PermissionController());
 // final serviceCompleteController = Get.put(ServiceCompleteRequestController());

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor endSourceIcon = BitmapDescriptor.defaultMarker;
  List<LatLng> polylineCoordinates = [];
  List<LatLng> livePolylineCoordinates = [];
  Map<PolylineId, Polyline> polyLines = <PolylineId, Polyline>{};
  int polyLineIdCounter = 1;
  Timer? timer;
  late IO.Socket socket;
  LatLng? source;
  LatLng? destination;
  late Location location;
  LocationData? currentLocation;
  Set<Marker> markers = {};

  @override
  void initState() {
    setState(() {
      print("DESTINATION");
      double userLat = double.parse(widget.serviceListData!.addressDetails!.lat.toString());
      double userLng = double.parse(widget.serviceListData!.addressDetails!.lng.toString());
      destination = LatLng(userLat, userLng);
      print("destination::::"+destination.toString());
      socketApi();
      liveLocation();
      setCustomMarkerIcon();

    });
    super.initState();
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/source_pin.png',
    ).then((icon) {
      sourceIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, 'assets/source_pin.png')
        .then((icon) {
      endSourceIcon = icon;
    });
  }

  void socketApi() async {
    await permissionController.permissionLocation();
   // await socketConnect(widget.socketToken!.sockettoken.toString());
  }

  void liveLocation() async {
    location = Location();
    location.enableBackgroundMode(enable: true);
    location.changeNotificationOptions(
        channelName: 'Service App', title: 'Service app is running');
    location.onLocationChanged.listen((LocationData cLoc) async {
      currentLocation = cLoc;
      source = LatLng(cLoc.latitude!, cLoc.longitude!);
      addMarker();
      setState(() {});
      // debugPrint('source');
      // debugPrint(source.toString());
      final GoogleMapController controller = await _completer.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(cLoc.latitude!, cLoc.longitude!), zoom: 19)));
      await Preferences.setPreferences();
      var socketEmit = {
        "message": {
          'lat': currentLocation!.latitude!,
          'lng': currentLocation!.longitude!,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
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
        "roomName": "",
      };
      socket.emit("message", socketEmit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      _getMap(),
                      Positioned(
                        width: 55,
                        height: 55,
                        top: 10,
                        left: 10,
                        child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Image.asset('assets/rounded_back.png')),
                      ),
                      Positioned(
                        width: 55,
                        height: 55,
                        top: 10,
                        right: 10,
                        child: InkWell(
                            onTap: () {
                              LoaderUtils.showLoader('Please wait...');
                            },
                            child:
                            Image.asset('assets/go_to_current_location.png')),
                      ),
                      // _getCustomPin(),
                    ],
                  )),
              Expanded(
                  flex: 0,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                              const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: _showDraggedAddress(),
                      ),
                    ],
                  ))
            ],
          )),
    );
  }

  Widget _showDraggedAddress() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(


                  fontSize: 18,

                  fontFamily: 'Gilroy', color: Colors.black, text: 'Maduri',),
              MyText(
                  text: "28/04/2023",
                
                  fontSize: 14,
                  
                   fontFamily: 'Gilroy', color: Colors.black,),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                  text: "9623677128",
                 
                  fontSize: 14,
                
                   fontFamily: 'Gilroy', color: Colors.black,),
            /*  RequestStatus(
                  color: widget.serviceListData!.serviceStatus == "Pending"
                      ? pendingColor
                      : widget.serviceListData!.serviceStatus == "Reject"
                      ? rejectColor
                      : widget.serviceListData!.serviceStatus == "Accept"
                      ? acceptColor
                      : acceptColor,
                  statusText: widget.serviceListData!.serviceStatus.toString()),*/
            ],
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: MyText(
              text:
              'Comment: Comment',

              fontSize: 14,

               fontFamily: 'Gilroy', color: appBlack,),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: MyText(
            text:
            'Comment: Comment',

            fontSize: 14,

            fontFamily: 'Gilroy', color: appBlack,),
        ),

        ElevatedButton(onPressed: (){}, child: Text("Completed"))
      ],
    );
  }

  Widget _getMap() {
    return currentLocation == null
        ?  Center(
        child: MyText(
            text: 'Please Wait\nMap is loading',
            fontSize: 14,

             fontFamily: 'Gilroy', color: appBlack,))
        : GoogleMap(
      initialCameraPosition: CameraPosition(
        target: source!,
        zoom: 14.0,
      ),
      markers: markers,
      zoomControlsEnabled: false,
      zoomGesturesEnabled: true,
      polylines: Set<Polyline>.of(polyLines.values),
      onMapCreated: (GoogleMapController controller) {
        _completer.complete(controller);
        controller.setMapStyle(permissionController.mapStyle);
      },
    );
  }

  Future<void> addMarker() async {
    markers.add(Marker(
        anchor: const Offset(0.5, 0.5),
        markerId: const MarkerId('source'),
        position: source!,
        icon: sourceIcon));
    markers.add(Marker(
        anchor: const Offset(0.5, 0.5),
        markerId: const MarkerId('destination'),
        position: destination!,
        icon: endSourceIcon));
    polyLinesDraw();
  }

  polyLinesDraw() async {
    await _getRoutePolyline(
      start: source!,
      finish: destination!,
      color: appBlack,
      id: 'ServicePolyline',
      width: 4,
    );
    setState(() {});
  }

  Future<Polyline> _getRoutePolyline(
      {required LatLng start,
        required LatLng finish,
        required Color color,
        required String id,
        int width = 6}) async {
    final polylinePoints = PolylinePoints();
    final List<LatLng> polylineCoordinates = [];
    final startPoint = PointLatLng(start.latitude, start.longitude);
    final finishPoint = PointLatLng(finish.latitude, finish.longitude);
    final result = await polylinePoints.getRouteBetweenCoordinates(
      ApiUrl.googleMapGetDirection,
      travelMode: TravelMode.driving,
      startPoint,
      finishPoint,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
    }
    final Polyline polyline = Polyline(
        polylineId: PolylineId(id),
        consumeTapEvents: true,
        points: polylineCoordinates,
        color: appBlack,
        width: 4);
    setState(() {
      polyLines[PolylineId(id)] = polyline;
    });
    return polyline;
  }

  /*void serviceCompleteApi()async{
    CompleteServiceRequestBody requestBody =CompleteServiceRequestBody(
        serviceId: widget.serviceListData!.id.toString(),
        userId: Preferences.getId(Preferences.id).toString()
    );
    await serviceCompleteController.completeServiceApi(requestBody).then((value){
      if(value!=null){
        if(value.status==true){
          LoaderUtils.message(value.message.toString());
          Get.to(const CustomBottomNav());
        }else{
          LoaderUtils.message(value.message.toString());
        }
      }
    });
  }*/

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
        debugPrint('Connected to the server');
      });
      socket.on('disconnect', (_) {
        debugPrint('Disconnected from the server');
      });
      socket.on('event', (data) {
        debugPrint('Received event: $data');
      });
      socket.on('error', (error) {
        debugPrint('Error: $error');
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}