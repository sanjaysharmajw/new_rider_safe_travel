import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
import 'package:ride_safe_travel/Utils/toast.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../BottomSheet/Country.dart';
import '../../BottomSheet/TabWidget.dart';
import '../../Utils/MapMyIndiaKeys.dart';
import '../../Utils/exit_alert_dialog.dart';

class RiderMap extends StatefulWidget {
  RiderMap({
    Key? key,
    required this.riderId,
    required this.dName,
    required this.dLicenseNo,
    required this.vModel,
    required this.vOwnerName,
    required this.vRegistration,
    required this.dMobile,
    required this.dImage,
    required this.memberName,
  }) : super(key: key);

  @override
  State<RiderMap> createState() => _RiderMapState();
  String riderId;
  String memberName;
  String dName;
  String dLicenseNo;
  String vModel;
  String vOwnerName;
  String vRegistration;
  String dMobile;
  String dImage;
}

class _RiderMapState extends State<RiderMap> {
  Timer? timer;
  late Location location;
  late LocationData currentLocation;
  String id = '';
  late IO.Socket socket;
  var vehicleId = '', driverId = '', userId = '', riderId = '';
  String date = '';
  bool visibility = false;
  late MapmyIndiaMapController mapController;
  late Symbol symbol;

  //Polyline
  late Line line;
  late List<LatLng> polyline_latlng;

  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(19.0654285394954, 73.00269069070602),
    zoom: 14,
  );

  final TextEditingController destinationController = TextEditingController();
  final TextEditingController fieldTextEditingController = TextEditingController();
final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    sharePre();
    _markers = <MarkerId, Marker>{};
    _markers.clear();
    //getRideData();
    //_initUser();
    final now = DateTime.now();
    date = DateFormat('yMd').format(now);
    if (widget.dLicenseNo.isEmpty) {
      visibility = false;
    } else {
      visibility = true;
    }
  }

  void sharePre() async {
    await Preferences.setPreferences();
    id = Preferences.getUserRiderId().toString();
    userId = Preferences.getId(Preferences.id).toString();
    vehicleId = Preferences.getVehicleId(Preferences.vehicleId).toString();
    driverId = Preferences.getDriverId().toString();
    riderId = Preferences.getRiderIdFromFamilyMem().toString();
    OverlayLoadingProgress.stop();
    getSocketToken();
  }
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 95.0;

  List<Country> countryOptions = <Country>[
    Country(name: 'Mumbai', address: "Maharashtra, India"),
    Country(name: 'Thiruvananthapuram', address: "Kerala, India"),
    Country(name: 'Bangalore', address: "Karnataka, India"),
    Country(name: 'Ranchi', address: "Jharkhand, India"),
    Country(name: 'Shimla', address: "Himachal Pradesh, India"),
    Country(name: 'Chandigarh', address: "Haryana, India"),
    Country(name: 'Panji', address: "Goa, India"),
    Country(name: 'Chennai', address: "TamilNadu, India"),
    Country(name: 'Lucknow', address: "Uttar Pradesh, India"),
    Country(name: 'Dehradun', address: "Uttarakhand, India"),
  ];


  String searchString = "";


  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery
        .of(context)
        .size
        .height * .80;
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.memberName.toString(),
            style: const TextStyle(color: CustomColor.black, fontFamily: 'transport'),
          ),
          elevation: 0,
          backgroundColor: CustomColor.lightYellow,
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
                padding: const EdgeInsets.symmetric(vertical: 50),
                compassEnabled: true,
                zoomControlsEnabled: true,
                myLocationButtonEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _completer.complete(controller);
                },
                markers: Set<Marker>.of(_markers.values),
              ),
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
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: CustomColor.white,
                    borderRadius: BorderRadius.circular(15.h),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0.w),
                    child: Column(
                      children: [
                    Card(
                    child: ListTile(
                      title: TextFormField(
                        controller: destinationController,
                        decoration: InputDecoration(
                         hintText: "Destination",
                       hintStyle: TextStyle(fontSize: 18,color: Colors.black),
                       border: InputBorder.none
                     ),
                        readOnly: true,
                      onTap: (){
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 30,
                                        height: 5,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.all(Radius.circular(12.0))),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 18.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15),
                                        child: Text(
                                          "Select a location",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
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
                                      Autocomplete<Country>(
                                          optionsBuilder:
                                              (TextEditingValue textEditingValue) {
                                            return countryOptions
                                                .where((Country county) => county.name
                                                .toLowerCase()
                                                .startsWith(textEditingValue.text
                                                .toLowerCase()))
                                                .toList();
                                          },
                                          displayStringForOption: (Country option) =>
                                          option.name,
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

                                          onSelected: (Country selection) {
                                            print('Selected: ${selection.name}');
                                            fieldTextEditingController.text=selection.name;
                                          },
                                          optionsViewBuilder: (BuildContext context,
                                              AutocompleteOnSelected<Country>
                                              onSelected,
                                              Iterable<Country> options) {
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
                                                      final Country option =
                                                      options.elementAt(index);

                                                      return GestureDetector(
                                                        onTap: () {
                                                          onSelected(option);
                                                          destinationController.text=option.name.toString();
                                                          Navigator.pop(context);

                                                        },
                                                        child: Card(
                                                          elevation: 1,
                                                          margin: EdgeInsets.symmetric(vertical: 2),
                                                          child: ListTile(
                                                            leading: Icon(Icons.location_on_rounded,color: Colors.red,),
                                                            title: Text(option.name,
                                                                style: const TextStyle(
                                                                    color:
                                                                    Colors.black)
                                                            ),
                                                            subtitle: Text(option.address.toString()),

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
                            InkWell(
                              onTap: () {
                                Make_a_call.makePhoneCall(widget.dMobile);
                              },
                              child:   Column(
                                children: [
                                  Image.asset("images/contact_driver.png",
                                      width: 50.w, height: 50.h),
                                  SizedBox(height: 10.h),
                                  Text("Contact Driver",
                                      style: TextStyle(
                                          fontFamily: 'transport',
                                          fontSize: 16.sp)),
                                ],
                              ),
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
                                          fontSize: 16.sp)),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showExitPopup(context,"Do you really want to call on 100 ?",(){
                                  Make_a_call.makePhoneCall("100");
                                  Navigator.pop(context, true);
                                });
                              },
                              child: Column(
                                children: [
                                  Image.asset("images/hundred_number.png",
                                      width: 50.w, height: 50.h),
                                  SizedBox(height: 10.h),
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
                  ),
                );
              }),
        ]
        ),
      ),
    );
  }

  showMenu() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return DrawerInfo(
            dInfoImage: widget.dImage,
            dInfoName: widget.dName,
            dInfoMobile: widget.dMobile,
            vInfoImage: 'images/bottom_drawer_comp.png',
            vInfoModel: widget.vModel,
            vInfoOwnerName: widget.vOwnerName,
            vInfoRegNo: widget.vRegistration,
            dInfoLicense: widget.dLicenseNo,
            press: () {
              Navigator.of(context).pop();
            },
            visibility: visibility,
          );
        });
  }

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

  Widget _panel() {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: null,
          children: <Widget>[
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            SizedBox(
              height: 18.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Select a location",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
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
                Autocomplete<Country>(
                    optionsBuilder:
                        (TextEditingValue textEditingValue) {
                      return countryOptions
                          .where((Country county) => county.name
                          .toLowerCase()
                          .startsWith(textEditingValue.text
                          .toLowerCase()))
                          .toList();
                    },
                    displayStringForOption: (Country option) =>
                    option.name,
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
                      /* ListTile(
                        title: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                  onPressed: (){
                                   // searchMemberApi(mobileController.text,widget.userId);
                                  }, icon:  Icon(Icons.search)),

                          ),


                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: IconButton(onPressed: (){
                         // mobileController.clear();
                        }, icon: Icon(Icons.clear)),
                      ); */


                    },

                    onSelected: (Country selection) {
                      print('Selected: ${selection.name}');
                    },
                    optionsViewBuilder: (BuildContext context,
                        AutocompleteOnSelected<Country>
                        onSelected,
                        Iterable<Country> options) {
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
                                final Country option =
                                options.elementAt(index);

                                return GestureDetector(
                                  onTap: () {
                                    onSelected(option);
                                  },
                                  child: Card(
                                    elevation: 1,
                                    margin: EdgeInsets.symmetric(vertical: 2),
                                    child: ListTile(
                                      leading: Icon(Icons.location_on_rounded,color: Colors.red,),
                                      title: Text(option.name,
                                          style: const TextStyle(
                                              color:
                                              Colors.black)
                                      ),
                                      subtitle: Text(option.address.toString()),

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
        ));
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
