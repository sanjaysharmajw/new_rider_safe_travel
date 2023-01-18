// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:location/location.dart';
// import 'package:mapmyindia_gl/mapmyindia_gl.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:mapmyindia_place_widget/mapmyindia_place_widget.dart';
// import 'package:ride_safe_travel/Utils/toast.dart';
//
// import '../Utils/MapMyIndiaKeys.dart';
//
// class PlaceSearchWidget extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return PlaceSearchWidgetState();
//   }
// }
//
// class PlaceSearchWidgetState extends State {
//   ELocation _eLocation = ELocation();
//   late Location location;
//   late double lati;
//   late double lng;
//
//   @override
//   void initState() {
//     super.initState();
//     ToastMessage.toast(_eLocation.latitude.toString());
//     print("Latitude: $_eLocation");
//     _initUser();
//     setState(() {
//       MapmyIndiaAccountManager.setMapSDKKey(MyMyIndiaKeys.mapSKDKey);
//       MapmyIndiaAccountManager.setRestAPIKey(MyMyIndiaKeys.MapRestAPIKey);
//       MapmyIndiaAccountManager.setAtlasClientId(MyMyIndiaKeys.ClientId);
//       MapmyIndiaAccountManager.setAtlasClientSecret(MyMyIndiaKeys.ClientSecretId);
//     });
//     add();
//   }
//   void _initUser() async {
//     location = Location();
//     location.onLocationChanged.listen((LocationData cLoc) async {
//       lati = cLoc.latitude!;
//       lng = cLoc.longitude!;
//       print('Start rIDER : LatLng${lati}');
//     });
//   }
//   void add()async{
//     try {
//       GeocodeResponse? response = await MapmyIndiaGeoCoding(address: "Panvel").callGeocoding();
//       String? lat=response?.results![0].eLoc;
//       print('Latitude: $lat');
//       print(response?.toJson());
//
//       try {
//         DirectionResponse? directionResponse = await MapmyIndiaDirection(originELoc: lat,destination: LatLng(lati, lng)).callDirection();
//         print('direction:');
//         print(directionResponse?.waypoints![0].location?.latitude);
//         print(directionResponse?.waypoints![0].location?.longitude);
//       } catch(e) {
//         PlatformException map = e as PlatformException;
//         print(map.code);
//       }
//     } catch(e) {
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
//         title: Text(
//           'Place Search Widget',
//           style: TextStyle(color: Colors.white),
//         ),
//         elevation: 0.2,
//       ),
//       body: Center(
//           child: Column(
//               children: [
//                 SizedBox(height: 20,),
//                 Text(_eLocation.eLoc == null? 'ELoc: ':'ELoc: ${_eLocation.eLoc}'),
//                 SizedBox(height: 20,),
//                 Text( _eLocation.placeName == null? 'Place Name: ': 'Place Name: ${_eLocation.placeName}'),
//                 SizedBox(height: 20,),
//                 Text( _eLocation.placeAddress == null? 'Place Address: ': 'Place Address: ${_eLocation.placeAddress}'),
//                 SizedBox(height: 20,),
//                 Text( _eLocation.latitude == null? 'Latitude: ': 'Latitude: ${_eLocation.latitude}'),
//                 SizedBox(height: 20,),
//                 Text( _eLocation.longitude == null? 'Longitude: ': 'Longitude: ${_eLocation.longitude}'),
//                 SizedBox(height: 20,),
//                 Text( _eLocation.type == null? 'Type: ': 'Type: ${_eLocation.type}'),
//                 SizedBox(height: 20,),
//                 Text( _eLocation.entryLatitude == null? 'Entry Latitude: ': 'Entry Latitude: ${_eLocation.entryLatitude?.toString()}'),
//                 SizedBox(height: 20,),
//                 Text( _eLocation.entryLongitude == null? 'Entry Longitude: ': 'Entry Longitude: ${_eLocation.entryLongitude?.toString()}'),
//                 SizedBox(height: 20,),
//                 Text( _eLocation.orderIndex == null? 'Order Index: ': 'Order Index: ${_eLocation.orderIndex?.toString()}'),
//                 SizedBox(height: 20,),
//                 Text( _eLocation.keywords == null? 'Keywords: ': 'Keywords: ${_eLocation.keywords?.toString()}'),
//                 SizedBox(height: 20,),
//                 Text( _eLocation.typeX == null? 'Type X: ': 'Type X: ${_eLocation.typeX}'),
//                 SizedBox(height: 20,),
//                 TextButton(onPressed: openMapmyIndiaSearchWidget ,child:Text("Open Place Autocomplete")),
//               ]
//           )
//         //    RaisedButton(onPressed: initPlatformState ,child: Text("Go to native"),)
//       ),
//     );
//   }
//
//   openMapmyIndiaSearchWidget() async {
//     ELocation eLocation;
//     try {
//       eLocation = await openPlaceAutocomplete(PlaceOptions());
//     } on PlatformException {
//       eLocation = ELocation();
//     }
//     print('elocstion: $eLocation');
//     print(json.encode(eLocation.toJson()));
//     if (!mounted) return;
//     setState(() {
//       _eLocation = eLocation;
//     });
//   }
//
// }