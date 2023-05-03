import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import '../color_constant.dart';
import 'Models/rider_history_model.dart';
import 'MyText.dart';
import 'controller/permision_controller.dart';
import 'get_ride_data_models.dart';

class HistoryMap extends StatefulWidget {
  num? sourceLat,sourceLng;
  GetRideDataModels? riderHistoryData;
  RiderHistoryData? riderData;
   HistoryMap({Key? key,this.riderHistoryData,this.riderData,this.sourceLat,this.sourceLng}) : super(key: key);

  @override
  State<HistoryMap> createState() => _HistoryMapState();
}

class _HistoryMapState extends State<HistoryMap> {
  final Completer<GoogleMapController> _completer = Completer();
  final permissionController = Get.put(PermissionController());

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor endSourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor startSourceIcon = BitmapDescriptor.defaultMarker;

  BitmapDescriptor stopIcons = BitmapDescriptor.defaultMarker;

  List<LatLng> polylineCoordinates = [];
  List<LatLng> livePolylineCoordinates = [];
  Map<PolylineId, Polyline> polyLines = <PolylineId, Polyline>{};
  int polyLineIdCounter = 1;
  LatLng? source;
  LatLng? destination;
  late Location location;
  LocationData? currentLocation;
  Set<Marker> markers = {};
  List<LatLng> listLocations = [];


  @override
  void initState() {
    setState(() {
      liveLocation();
      setCustomMarkerIcon();
      double sourceLat=double.parse(widget.sourceLat!.toString());
      double sourceLng=double.parse(widget.sourceLng!.toString());
      source=LatLng(sourceLat, sourceLng);
      for(int i=0;i<widget.riderHistoryData!.data!.length; i++){
        double lat =double.parse(widget.riderHistoryData!.data![i].lat.toString());
        double lng =double.parse(widget.riderHistoryData!.data![i].lng.toString());
        listLocations.add(LatLng(lat,lng));
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
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, 'new_assets/stop_marker.png')
        .then((icon) {
      stopIcons = icon;
    });

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, 'new_assets/destination_marker.png')
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
     // source=LatLng(cLoc.latitude!, cLoc.longitude!);
      sendRequest();
      // final GoogleMapController controller = await _completer.future;
      // controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      //     target: LatLng(cLoc.latitude!, cLoc.longitude!), zoom: 19)));
      setState(() {});

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
            children:   [
              MyText(
                  text: widget.riderData!.driverName.toString() == "null" ? " " : widget.riderData!.driverName.toString(),
                  fontFamily: 'Gilroy',
                  fontSize: 18,

                  color: Colors.black),
              MyText(
                  text:  widget.riderData!.driverMobileNumber.toString() == "null" ? " " : widget.riderData!.driverMobileNumber.toString(),
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
                  text: widget.riderData!.driverMobileNumber.toString() == "null" ? " " : widget.riderData!.driverMobileNumber.toString(),
                  fontFamily: 'Gilroy',
                  fontSize: 14,

                  color: Colors.black),
              MyText(
                  text: widget.riderData!.driverEmailId.toString() == "null" ? " " : widget.riderData!.driverMobileNumber.toString(),
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
    return widget.sourceLng == null
        ?  Center(
        child: MyText(
            text: 'Please Wait\nMap is loading',
            fontFamily: 'Gilroy',
            fontSize: 14,

            color: appBlack))
        : GoogleMap(
      initialCameraPosition: CameraPosition(
        target: source!,
        zoom: 10.0,
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
  void sendRequest() {
    polyLinesDraw();
    addMarker();
  }
  Future<void> addMarker() async {
    markers.add(Marker(
        anchor: const Offset(0.5, 0.5),
        markerId: const MarkerId('source'),
        position: source!,
        icon: sourceIcon));
    // markers.add(Marker(
    //     anchor: const Offset(0.5, 0.5),
    //     markerId: const MarkerId('destination'),
    //     position: destination!,
    //     icon: endSourceIcon));


    // markers.add(Marker(
    //     rotation: currentLocation!.heading!,
    //     anchor: const Offset(0.5, 0.5),
    //     markerId: MarkerId(source.toString()),
    //     position: source!,
    //     icon: sourceIcon
    // ));

    // for(int i=0;i<listLocations.length;i++){
    //   markers.add(Marker(
    //     markerId: MarkerId(listLocations[i].toString()),
    //     icon: stopIcons,
    //     anchor: const Offset(0.5, 0.5),
    //     position: listLocations[i],
    //   ));
    //   markers.remove(listLocations.last);
    // }

    markers.add(Marker(
        anchor: const Offset(0.5, 0.5),
        markerId: MarkerId(listLocations.last.toString()),
        position: listLocations.last,
        icon: endSourceIcon
    ));
  }

  polyLinesDraw() async {
      await Future.forEach(listLocations, (LatLng elem) async {
        await _getRoutePolyline(
          start: source!,
          finish: elem,
          color: appBlack,
          id: 'ServicePolyline $elem',
          width: 4,
        );
      });
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

    // for(int i=0;i<listLocations.length;i++){
    //   markers.add(Marker(
    //     markerId: MarkerId(listLocations[i].toString()),
    //     icon: stopIcons,
    //     anchor: const Offset(0.5, 0.5),
    //     position: listLocations[i],
    //   ));
    //   markers.remove(listLocations.last);
    // }

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

}
