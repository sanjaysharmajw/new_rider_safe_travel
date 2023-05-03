import 'dart:async';
import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';
import '../LoginModule/Api_Url.dart';
import '../MyText.dart';
import '../color_constant.dart';
import '../controller/permision_controller.dart';
import 'RequestedListModel.dart';

import 'get_service_ride_details_models.dart';


class ServiceTrackingMap extends StatefulWidget {
  GetServiceRideDetailsModels? serviceRideData;
  requestedListData requestedList;
  ServiceTrackingMap({Key? key,required this.serviceRideData,required this.requestedList}) : super(key: key);

  @override
  State<ServiceTrackingMap> createState() => _TrackingMapState();
}

class _TrackingMapState extends State<ServiceTrackingMap> {
  final Completer<GoogleMapController> _completer = Completer();
  final permissionController = Get.put(PermissionController());

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
      liveLocation();
      setCustomMarkerIcon();
      if(widget.serviceRideData!.token!.isNotEmpty){
        socketConnect(widget.serviceRideData!.token.toString());
      }
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


  void liveLocation() async {
    location = Location();
    location.enableBackgroundMode(enable: true);
    location.changeNotificationOptions(
        channelName: 'Service App', title: 'Service app is running');
    location.onLocationChanged.listen((LocationData cLoc) async {
      currentLocation = cLoc;
      source = LatLng(cLoc.latitude!, cLoc.longitude!);
      setState(() {});
      // debugPrint('source');
      // debugPrint(source.toString());

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
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              MyText(
                  text: widget.requestedList.providername.toString(),
                  fontFamily: 'Gilroy',
                  fontSize: 18,

                  color: Colors.black),
              MyText(
                  text:  widget.requestedList.date.toString(),
                  fontFamily: 'Gilroy',
                  fontSize: 14,

                  color: Colors.black),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10,bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              MyText(
                  text: widget.requestedList.providermobilenumber.toString(),
                  fontFamily: 'Gilroy',
                  fontSize: 14,

                  color: Colors.black),
              MyText(
                  text: widget.requestedList.serviceStatus.toString(),
                  fontFamily: 'Gilroy',
                  fontSize: 14,

                  color: Colors.black),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getMap() {
    return currentLocation == null
        ?  Center(
        child: MyText(
            text: 'Please Wait\nMap is loading',
            fontFamily: 'Gilroy',
            fontSize: 14,

            color: appBlack))
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
        int width = 4}) async {
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
       // getSpeed = jsonDecode(data)['speed'];
        var sosStatus = jsonDecode(data)['status'];
        print('Received lat: $lat + $lng');
       // print('Speed: $getSpeed');
        destination = LatLng(lat, lng);
        final GoogleMapController controller = await _completer.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(lat, lng), zoom: 19)));
        addMarker();
      });

      socket.on('error', (error) {
        print('Error: $error');
      });
    } catch (e) {
      print(e.toString());
    }
  }

}
