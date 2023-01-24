import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/BottomSheet/GeocodeModel.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/LoginModule/MainPage.dart';
import 'package:ride_safe_travel/LoginModule/Map/Drawer.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/MapAddFamily.dart';
import 'package:ride_safe_travel/Utils/toast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'BottomSheet/GeocodeResultModel.dart';
import 'LoginModule/Error.dart';
import 'Utils/exit_alert_dialog.dart';

class StartRide extends StatefulWidget {
  const StartRide(
      {Key? key,
        required this.riderId,
        required this.socketToken,
        required this.dName,
        required this.dMobile,
        required this.dPhoto,
        required this.model,
        required this.vOwnerName,
        required this.vRegNo})
      : super(key: key);

  @override
  State<StartRide> createState() => _SignUpState();
  final String riderId;
  final String socketToken;
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
  late double lng;
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
    setState(() {});
    OverlayLoadingProgress;
    ToastMessage.toast(widget.riderId);
  }

  void sharePre() async {
    await Preferences.setPreferences();
    userId = Preferences.getId(Preferences.id).toString();
    await socketConnect(widget.socketToken);
    // Get.snackbar("title", widget.socketToken);
  }

  void _initUser() async {
    location = Location();
    location.enableBackgroundMode(enable: true);
    location.changeNotificationOptions(
        iconName: 'images/rider_launcher.png',
        channelName: 'Nirbhaya',
        title: 'Nirbhaya app is running');
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
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(cLoc.latitude!, cLoc.longitude!), zoom: 19)));
      var image = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), "assets/driver_map_min.png");
      Marker marker = Marker(
          markerId: MarkerId('ID'),
          icon: image,
          position: LatLng(cLoc.latitude!, cLoc.longitude!));
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

  final TextEditingController destinationController = TextEditingController();
  final TextEditingController fieldTextEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  List<Result> locationData=[];
  String searchString = "";

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return WillPopScope(
      onWillPop: () =>
          showExitPopup(context, "Do you want to stop ride?", () async {
            OverlayLoadingProgress.start(context);
            Navigator.pop(context, true);
            await endRide();
          }),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "On Going Journey",
            style:
            TextStyle(color: CustomColor.black, fontFamily: 'transport'),
          ),
          elevation: 0,
          backgroundColor: CustomColor.lightYellow,
          leading: IconButton(
            onPressed: () {
              showExitPopup(context, "Do you want to stop ride?", () async {
                // OverlayLoadingProgress.start(context);
                //Navigator.pop(context, true);
                await endRide();
              });
            },
            icon: Image.asset('assets/map_back.png'),
          ),
          actions: <Widget>[
            IconButton(
                icon: const Icon(
                  Icons.share,
                  color: Colors.black,
                ),
                onPressed: () {
                  shareData();
                }),
          ],
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
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      compassEnabled: true,
                      zoomControlsEnabled: true,
                      mapToolbarEnabled: true,
                      zoomGesturesEnabled: true,
                      myLocationButtonEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        _completer.complete(controller);
                      },
                      markers: Set<Marker>.of(_markers.values),
                    )
                );
              }),
          DraggableScrollableSheet(
              initialChildSize: 0.25,
              minChildSize: 0.10,
              maxChildSize: 1,
              snapSizes: [0.5, 1],
              snap: true,
              builder: (BuildContext context, scrollSheetController) {
                return Container(
                  decoration: BoxDecoration(
                    color: CustomColor.white,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0.h, horizontal: 20.0.w),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            child: ListTile(
                              title: TextFormField(
                                controller: destinationController,
                                decoration: InputDecoration(
                                    hintText: "Destination",
                                    hintStyle: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                    border: InputBorder.none
                                ),
                                readOnly: true,
                                onTap: () {
                                 // getSuggestions();
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,

                                      builder: (context) {
                                        return ListView(
                                          controller: scrollController,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 12.0,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: <Widget>[
                                                Container(
                                                  width: 30,
                                                  height: 5,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius: BorderRadius
                                                          .all(Radius.circular(
                                                          12.0))),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 18.0,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .only(left: 15),
                                                  child: Text(
                                                    "Select a location",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .normal,
                                                      fontSize: 20.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 30.0,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.all(15.0),
                                                child:
                                               /* TypeAheadField(
                                                  textFieldConfiguration: TextFieldConfiguration(
                                                      autofocus: true,
                                                      style: DefaultTextStyle.of(context).style.copyWith(
                                                          fontStyle: FontStyle.italic
                                                      ),
                                                      decoration: InputDecoration(
                                                          border: OutlineInputBorder()
                                                      )
                                                  ),
                                                  suggestionsCallback: (pattern)  {
                                                    return getSuggestions();
                                                  },
                                                  itemBuilder: (context, suggestion) {
                                                    return ListTile(
                                                      leading: Icon(Icons.location_on_rounded),
                                                      title: Text(suggestion.text.toString()),

                                                    );
                                                  },
                                                  onSuggestionSelected: (suggestion) {
                                                    print('Selected: ${suggestion.text}');
                                                    fieldTextEditingController.text=suggestion.text!;
                                                    //Navigator.of(context).push(MaterialPageRoute(
                                                      //  builder: (context) => ProductPage(product: suggestion)
                                                    //)
                                                   // );
                                                  },
                                                )*/

                                                Autocomplete<Result>(
                                                    optionsBuilder:
                                                        (TextEditingValue textEditingValue) {
                                                      return getSuggestions(textEditingValue);
                                                    },
                                                    displayStringForOption: (Result option) =>
                                                    option.text.toString(),
                                                    fieldViewBuilder: (BuildContext context,
                                                        TextEditingController
                                                        fieldTextEditingController,
                                                        FocusNode fieldFocusNode,
                                                        VoidCallback onFieldSubmitted) {
                                                      return Card(
                                                        child: ListTile(
                                                          //leading: Icon(Icons.search),
                                                          title: TextFormField(
                                                            onChanged: (value) {
                                                              setState(() {
                                                                searchString = value.toString();
                                                              });
                                                            },
                                                            controller: fieldTextEditingController,
                                                            focusNode: fieldFocusNode,
                                                            decoration: InputDecoration(
                                                                hintText: "Search",
                                                                border: InputBorder.none,
                                                                prefixIcon: IconButton(
                                                                    onPressed: (){
                                                                      // searchMemberApi(mobileController.text,widget.userId);
                                                                    }, icon:  Icon(Icons.search,))
                                                            ),
                                                          ),
                                                          trailing: IconButton(onPressed: (){
                                                            fieldTextEditingController.clear();
                                                          }, icon: Icon(Icons.clear)),
                                                        ),
                                                      );
                                                    },

                                                    onSelected: (Result selection) {
                                                      print('Selected: ${selection.text}');
                                                      fieldTextEditingController.text=selection.text.toString();
                                                    },
                                                    optionsViewBuilder: (BuildContext context,
                                                        AutocompleteOnSelected<Result>
                                                        onSelected,
                                                        Iterable<Result> options) {
                                                      return Align(
                                                        alignment: Alignment.topLeft,
                                                        child: Material(
                                                          child: Container(
                                                            width: 365,
                                                            //color: Colors.grey,
                                                            child: ListView.builder(
                                                              padding: EdgeInsets.all(10.0),
                                                              itemCount: options.length,
                                                              itemBuilder:
                                                                  (BuildContext context,
                                                                  int index) {
                                                                final Result option =
                                                                options.elementAt(index);

                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    onSelected(option);
                                                                    destinationController.text=option.text.toString();
                                                                    Navigator.pop(context);

                                                                  },
                                                                  child: Card(
                                                                    elevation: 1,
                                                                    margin: EdgeInsets.symmetric(vertical: 2),
                                                                    child: ListTile(
                                                                      leading: Icon(Icons.location_on_rounded,color: Colors.red,),
                                                                      title: Text(option.text.toString(),
                                                                          style: const TextStyle(
                                                                              color:
                                                                              Colors.black)
                                                                      ),


                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    })
                                            )

                                          ],
                                        );
                                      });
                                },
                              ),

                            ),
                          ),
                          SizedBox(height: 12,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showExitPopup(context,
                                          "Do you want to stop ride?",
                                              () async {
                                            OverlayLoadingProgress.start(
                                                context);
                                            Navigator.pop(context, true);
                                            await endRide();
                                          });
                                      //showAlertDialog(context);
                                    },
                                    child: Column(
                                      children: [
                                        Image.asset("images/End_Ride.png",
                                            width: 50.w, height: 50.h),
                                        SizedBox(height: 10.h),
                                        Text("End Ride",
                                            style: TextStyle(
                                                fontFamily: 'transport',
                                                fontSize: 14.sp)),
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
                                        width: 50.w, height: 50.h),
                                    SizedBox(height: 10.h),
                                    Text("Ride Details",
                                        style: TextStyle(
                                            fontFamily: 'transport',
                                            fontSize: 14.sp)),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(const MapFamilyAdd());
                                },
                                child: Column(
                                  children: [
                                    Image.asset("images/family_icons.png",
                                        width: 50.w, height: 50.h),
                                    SizedBox(height: 10.h),
                                    Text("Add Family",
                                        style: TextStyle(
                                            fontFamily: 'transport',
                                            fontSize: 14.sp)),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showExitPopup(
                                          context, "Are you in trouble?", () {
                                        OverlayLoadingProgress.start(context);
                                        SOSNotification();
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Image.asset("images/SOS.png",
                                            width: 50.w, height: 50.h),
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
            vInfoModel: widget.model.toString(),
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

  Future<void> socketConnect(String token) async {
    try {
      socket = IO.io(ApiUrl.socketUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
        'extraHeaders': {'authorization': widget.socketToken}
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

  Future<http.Response> endRide() async {
    final response = await http.post(
        Uri.parse(
            'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/userRide/endRide'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'ride_id': widget.riderId,
          'end_point': {
            'time': DateTime
                .now()
                .millisecondsSinceEpoch
                .toString(),
            'latitude': lat.toString(),
            'longitude': lng.toString(),
            'location': ""
          }
        }));
    print(json.encode({
      'ride_id': widget.riderId,
      'end_point': {
        'time': DateTime
            .now()
            .millisecondsSinceEpoch
            .toString(),
        'latitude': lat,
        'longitude': lng,
        'location': ""
      }
    }));
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      print("End Res: $response");
      if (status == true) {
        OverlayLoadingProgress.stop();
        ToastMessage.toast(msg);
        socket.disconnect();
        Get.to(const MainPage());
      } else {
        OverlayLoadingProgress.stop();
        ToastMessage.toast(msg);
      }
      return response;
    } else {
      throw Exception('Failed');
    }
  }

  Future<http.Response> SOSNotification() async {
    final response = await http.post(Uri.parse(ApiUrl.SOS_Push_Notification),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'user_id': userId.toString(),
          'ride_id': widget.riderId,
          "lat": lat.toString(),
          "lng": lng.toString(),
          "timestamp": DateTime
              .now()
              .millisecondsSinceEpoch
              .toString()
        }));
    print(json.encode({
      'user_id': userId.toString(),
      'ride_id': widget.riderId,
    }));

    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      if (status == true) {
        OverlayLoadingProgress.stop();
        ToastMessage.toast(msg.toString());
        Navigator.of(context).pop();
      } else {
        OverlayLoadingProgress.stop();
        ToastMessage.toast(msg.toString());
      }
      return response;
    } else {
      throw Exception('Failed');
    }
  }

  void shareData() {
    String dName = widget.dName.toString();
    String dMobile = widget.dMobile.toString();
    String model = widget.model.toString();
    String ownlerName = widget.vOwnerName.toString();
    String regNo = widget.vRegNo.toString();
    RenderBox box = context.findRenderObject() as RenderBox;
    Share.share(
        "Hi! Nirbhaya...Welcome to the new way to easily share your real-time location with your friends, family, co-workers, customers, suppliers, and more.\n\n"
            "Driver Name: $dName, Driver Mobile Number : $dMobile, Model : $model, Owner Name: $ownlerName, Registration Number: $regNo, "
            "Hey check out my app at: https://play.google.com/store/apps/details?id=com.rider_safe_travel.ride_safe_travel",
        subject: "Description",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  Future<List<Result>> getSuggestions(TextEditingValue textEditingValue) async {
    if(textEditingValue.text.toString().length > 3){

      final response = await http.post(
        Uri.parse(ApiUrl.geolocatelist),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "search": textEditingValue.text.toString()
        }),
      );
      print('getSuggestions:${ jsonEncode(<String, String>{
        "search": textEditingValue.text.toString()
      })}');

      if (response.statusCode == 200) {
        print("getData"+response.body);
        String placeId = jsonDecode(response.body)['result'][0]['PlaceId'];
        print("getPlaceId::::"+placeId);
        await getDestination(placeId);
        locationData = jsonDecode(response.body)['result']
            .map<Result>((data) => Result.fromJson(data))
            .toList();
        return locationData;
      } else {
        throw Exception('Failed to load');
      }
    }else {
      throw Exception('No Result');
    }

  }


  Future<List<Result>> getDestination(String placeId) async {
    final response = await http.post(
      Uri.parse(ApiUrl.geolocationDetails),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "PlaceId": placeId
      }),
    );
    print('getDestination:${ jsonEncode(<String, String>{
       "PlaceId": placeId
    })}');

    if (response.statusCode == 200) {
      print("getDetails"+response.body);
      var locationDetails= jsonDecode(response.body)['result']
          .map<Result>((data) => Result.fromJson(data))
          .toList();
      return locationDetails;
    } else {
      throw Exception('Failed to load');
    }
  }



}



