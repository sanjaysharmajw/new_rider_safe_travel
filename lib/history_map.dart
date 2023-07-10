import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/Models/get_ride_data_live.dart';
import '../color_constant.dart';
import 'Models/rider_history_model.dart';
import 'MyText.dart';

class HistoryMap extends StatefulWidget {
  GetRideDataLive? riderHistoryData;
  RiderHistoryData? riderData;

   HistoryMap({Key? key,this.riderHistoryData,this.riderData}) : super(key: key);

  @override
  State<HistoryMap> createState() => _HistoryMapState();
}

class _HistoryMapState extends State<HistoryMap> {

   List<LatLng> listLocations = [];
   final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};
  final Completer<GoogleMapController> _controller = Completer();
  CameraPosition? _kGoogle;

  @override
  void initState() {
    setState(() {
      for(int i=0; i<widget.riderHistoryData!.data!.length; i++){
          double lat =double.parse(widget.riderHistoryData!.data![i].lat.toString());
          double lng =double.parse(widget.riderHistoryData!.data![i].lng.toString());
          double sized=widget.riderHistoryData!.data!.length/2;
          listLocations.add(LatLng(lat,lng));
        setState(()  {
          _kGoogle =  CameraPosition(
            target: LatLng(lat, lng),
            zoom: 11,
          );
        });
        _polyline.add(
            Polyline(
              polylineId: const PolylineId('1'),
              points: listLocations,
              color: Colors.black,
              width: 2
            )
        );
      }
      _markers.add(
          Marker(
            markerId:  MarkerId(listLocations.toString()),
            position: listLocations.first,
            icon: BitmapDescriptor.defaultMarker,
          )
      );
      debugPrint('lastpolyline');
      debugPrint(listLocations.last.toString());
      _markers.add(
          Marker(
            markerId:  MarkerId(listLocations.toString()),
            position: listLocations.last,
            icon: BitmapDescriptor.defaultMarker,
          )
      );
    });
    super.initState();
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
                      // Positioned(
                      //   width: 55,
                      //   height: 55,
                      //   top: 10,
                      //   right: 10,
                      //   child: InkWell(
                      //       onTap: () {
                      //
                      //       },
                      //       child:
                      //       Image.asset('assets/go_to_current_location.png')),
                      // ),
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
                  text: widget.riderData!.drivingLicenceNumber.toString() == "null" ? " " : widget.riderData!.drivingLicenceNumber.toString(),
                  fontFamily: 'Gilroy',
                  fontSize: 14,
                  color: Colors.black),
             /* MyText(
                  text: widget.riderData!.driverEmailId.toString() == "null" ? " " : widget.riderData!.driverEmailId.toString(),
                  fontFamily: 'Gilroy',
                  fontSize: 14,

                  color: Colors.black),*/
            ],
          ),
        ),
      ],
    );
  }

  Widget _getMap() {
    return widget.riderHistoryData!.data == null
        ?  Center(
        child: MyText(
            text: 'Please Wait\nMap is loading',
            fontFamily: 'Gilroy',
            fontSize: 14,
            color: appBlack))
        : GoogleMap(
      initialCameraPosition: _kGoogle!,
      markers: _markers,
      polylines: _polyline,
      zoomControlsEnabled: false,
      zoomGesturesEnabled: true,
      onMapCreated: (GoogleMapController controller){
        _controller.complete(controller);
      },
    );
  }
}
