// import 'dart:convert';
// import 'package:http/http.dart';
// import 'dart:typed_data';
// import 'package:location/location.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:mapmyindia_gl/mapmyindia_gl.dart';
// import 'package:mapmyindia_gl/mapmyindia_gl.dart';
// import 'package:mapmyindia_place_widget/mapmyindia_place_widget.dart';
// import 'package:ride_safe_travel/Utils/toast.dart';
// import 'package:ride_safe_travel/search_place/plyline.dart';
// import '../Utils/MapMyIndiaKeys.dart';
//
// class POIAlongRouteWidget extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return POIAlongRouteWidgetState();
//   }
// }
//
// class POIAlongRouteWidgetState extends State {
//   static const CameraPosition _kInitialPosition = CameraPosition(
//     target: LatLng(25.321684, 82.987289),
//     zoom: 5.0,
//   );
//
//   final typeAddress = TextEditingController();
//
//   List<SuggestedPOI> result = [];
//   bool isShowList = false;
//
//   late MapmyIndiaMapController controller;
//   late Location location;
//   late double lati;
//   late double lng;
//   String? eloc;
//   late  ELocation eLocation;
//
//   double? desLat;
//   double? desLng;
//   late Symbol sourceSymbol;
//   late Symbol destinationSymbol;
//   late Line line;
//   late LatLng latLngSource;
//
//   @override
//   void initState() {
//     super.initState();
//     eLocation = ELocation();
//     setState(() {
//       MapmyIndiaAccountManager.setMapSDKKey(MyMyIndiaKeys.mapSKDKey);
//       MapmyIndiaAccountManager.setRestAPIKey(MyMyIndiaKeys.MapRestAPIKey);
//       MapmyIndiaAccountManager.setAtlasClientId(MyMyIndiaKeys.ClientId);
//       MapmyIndiaAccountManager.setAtlasClientSecret(MyMyIndiaKeys.ClientSecretId);
//     });
//     _initUser();
//   }
//
//   void _initUser() async {
//     location = Location();
//     location.onLocationChanged.listen((LocationData cLoc) async {
//       lati = cLoc.latitude!;
//       lng = cLoc.longitude!;
//       originMarker(lati, lng);
//       controller.removeSymbol(sourceSymbol);
//       latLngSource=LatLng(cLoc.latitude!, cLoc.longitude!);
//       //controller.removeLine(line);
//     });
//   }
//   openMapmyIndiaSearchWidget() async {
//     ELocation eLocation;
//     try {
//       eLocation = await openPlaceAutocomplete(PlaceOptions());
//       print('elocstion: $eLocation');
//     } on PlatformException {
//       eLocation = ELocation();
//     }
//     print('elocstion: $eLocation');
//     typeAddress.text=eLocation.placeName==null?'Destination:': eLocation.placeName.toString();
//     eloc=eLocation.eLoc;
//     destination(eLocation.eLoc!);
//     print(json.encode(eLocation.toJson()));
//     if (!mounted) return;
//     setState(() {
//       eLocation = eLocation;
//     });
//   }
//
//   destination(String eloc) async {
//     try {
//       DirectionResponse? directionResponse = await MapmyIndiaDirection(
//               origin: LatLng(lati, lng), destinationELoc: eloc)
//           .callDirection();
//       print('direction: $eloc');
//       desLat = directionResponse?.waypoints![0].location?.longitude;
//       desLng = directionResponse?.waypoints![0].location?.longitude;
//       destinationMarker(eloc);
//       callDirection();
//     } catch (e) {
//       PlatformException map = e as PlatformException;
//       print(map.code);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.yellow,
//         brightness: Brightness.dark,
//         title: const Text(
//           'POI Along Route API',
//           style: TextStyle(color: Colors.white),
//         ),
//         elevation: 0.2,
//       ),
//       body: Stack(children: <Widget>[
//         MapmyIndiaMap(
//           initialCameraPosition: _kInitialPosition,
//           onMapCreated: (map) => {
//             controller = map,
//           },
//           onStyleLoadedCallback: () {
//             callDirection();
//           },
//         ),
//         Container(
//             padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
//             decoration: const BoxDecoration(
//               color: Colors.white,
//             ),
//             child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   InkWell(
//                     onTap: (){
//                       openMapmyIndiaSearchWidget();
//                     },
//                     child: TextFormField(
//                       enabled: false,
//                       controller: typeAddress,
//                       decoration: const InputDecoration(
//                           hintText: 'Destination',
//                           fillColor: Colors.white),
//                     ),
//                   ),
//                 ])),
//         result.isNotEmpty && isShowList
//             ? BottomSheet(
//                 onClosing: () => {},
//                 builder: (context) => Expanded(
//                     child: ListView.builder(
//                         itemCount: result.length,
//                         itemBuilder: (context, index) {
//                           return Container(
//                               padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
//                               decoration: const BoxDecoration(
//                                 color: Colors.white,
//                               ),
//                               child: ListTile(
//                                 contentPadding: const EdgeInsets.all(5),
//                                 focusColor: Colors.white,
//                                 title: Text(result[index].address ?? ''),
//                               ));
//                         })))
//             : Container()
//       ]),
//     );
//   }
//
//   callDirection() async {
//     try {
//       setState(() {
//         result = [];
//       });
//       controller.clearLines();
//       controller.clearSymbols();
//       DirectionResponse? directionResponse = await MapmyIndiaDirection(
//         origin: latLngSource,
//         destinationELoc: eloc,
//       ).callDirection();
//       if (directionResponse != null &&
//           directionResponse.routes != null &&
//           directionResponse.routes!.isNotEmpty) {
//         Polyline polyline = Polyline.Decode(encodedString: directionResponse.routes![0].geometry, precision: 6);
//         List<LatLng> latLngList = [];
//         if (polyline.decodedCoords != null) {
//           polyline.decodedCoords?.forEach((element) {
//             latLngList.add(LatLng(element[0], element[1]));
//           });
//         }
//         drawPath(latLngList);
//       }
//     } on PlatformException catch (e) {
//       print(e.code);
//     }
//   }
//
//   void drawPath(List<LatLng> latlngList) {
//     //controller.addLine(LineOptions(geometry: latlngList, lineColor: "#3bb2d0", lineWidth: 4));
//     line = controller.addLine(LineOptions(geometry: latlngList, lineColor: "#3bb2d0", lineWidth: 4)) as Line;
//     LatLngBounds latLngBounds = boundsFromLatLngList(latlngList);
//     controller.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds));
//   }
//
//   boundsFromLatLngList(List<LatLng> list) {
//     assert(list.isNotEmpty);
//     double? x0, x1, y0, y1;
//     for (LatLng latLng in list) {
//       if (x0 == null || x1 == null || y0 == null || y1 == null) {
//         x0 = x1 = latLng.latitude;
//         y0 = y1 = latLng.longitude;
//       } else {
//         if (latLng.latitude > x1) x1 = latLng.latitude;
//         if (latLng.latitude < x0) x0 = latLng.latitude;
//         if (latLng.longitude > y1) y1 = latLng.longitude;
//         if (latLng.longitude < y0) y0 = latLng.longitude;
//       }
//     }
//     return LatLngBounds(
//         northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
//   }
//
//   void originMarker(double lat, double lng) async {
//     controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 15));
//     final ByteData bytes = await rootBundle.load("assets/driver_map_min.png");
//     final Uint8List list = bytes.buffer.asUint8List();
//     controller.addImage("icon", list);
//     sourceSymbol = await controller.addSymbol(
//         SymbolOptions(geometry: LatLng(lat, lng), iconImage: "icon"));
//   }
//
//   void destinationMarker(String eLoc) async {
//     controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(desLat!, desLng!), 15));
//     final ByteData bytes = await rootBundle.load("assets/driver_map_min.png");
//     final Uint8List list = bytes.buffer.asUint8List();
//     controller.addImage("icon", list);
//     destinationSymbol = await controller
//         .addSymbol(SymbolOptions(eLoc: eLoc, iconImage: "icon"));
//   }
//
// }
