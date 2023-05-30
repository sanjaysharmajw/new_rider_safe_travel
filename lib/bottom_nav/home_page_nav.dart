import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:ui' as ui;
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:majascan/majascan.dart';
import 'package:ride_safe_travel/LoginModule/Map/RiderMap.dart';
import 'package:ride_safe_travel/Models/family_list_ride_request.dart';
import 'package:ride_safe_travel/Models/family_member_ride_list_model.dart';
import 'package:ride_safe_travel/MyText.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';
import 'package:ride_safe_travel/bottom_nav/EmptyScreen.dart';
import 'package:ride_safe_travel/color_constant.dart';
import 'package:ride_safe_travel/controller/check_active_ride_models.dart';
import 'package:ride_safe_travel/controller/family_ride_controller.dart';
import 'package:ride_safe_travel/controller/location_controller.dart';
import 'package:ride_safe_travel/home_page_controller/driver_vehicle_controller.dart';
import 'package:ride_safe_travel/home_page_controller/end_ride_controller.dart';
import 'package:ride_safe_travel/home_page_controller/floating_button.dart';
import 'package:ride_safe_travel/home_page_controller/get_sos_controller_master.dart';
import 'package:ride_safe_travel/home_page_controller/homepage_action_items.dart';
import 'package:ride_safe_travel/home_page_controller/homepage_details_items.dart';
import 'package:ride_safe_travel/home_page_controller/sos_controller.dart';
import 'package:ride_safe_travel/home_page_controller/vehicle_round.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/ride_start_screens/start_ride_with_driverid.dart';
import '../MyRidesPage.dart';
import '../Notification/NotificationScreen.dart';
import '../ServiceTypeModel.dart';
import '../Services_Module/servicelist_controller.dart';
import '../UserDriverInformation.dart';
import '../UserFamilyList.dart';
import '../Utils/exit_alert_dialog.dart';
import '../chat_bot/ChatScreen.dart';
import '../controller/checkActiveRideRequest.dart';
import '../controller/check_active_rider.dart';
import '../controller/end_ride_controller.dart';
import '../controller/get_count_notification_controller.dart';
import '../controller/permision_controller.dart';
import '../home_page_controller/sos_dialogBox.dart';
import '../start_ride_map.dart';
import 'custom_bottom_navi.dart';
import 'home_page_items.dart';
import 'my_rider_controller.dart';

class HomePageNav extends StatefulWidget {
  const HomePageNav({Key? key}) : super(key: key);

  @override
  State<HomePageNav> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageNav> {
  ServiceTypeData serviceTypeData = ServiceTypeData();
  String qrCodeResult = "";
  final getCountController = Get.put(GetNotificationController());
  final checkActiveRide = Get.put(CheckActiveRideController());
  final sosPushController = Get.put(SOSController());
  final endRideController = Get.put(EndRideController());
  final familyRideDataController = Get.put(FamilyRideController());
  final driverVehicelListController = Get.put(DriverVehicelListController());
  final permissionController = Get.put(PermissionController());
  final locationPermission = Get.put(LocationController());

  final Completer<GoogleMapController> _completer = Completer();

  LocationData? locationData;
  late Location location;
  bool isSelected = false;
  Timer? timers;
  String? sosStatus = 'Ok';
  String? reason;
  String? userId;
  String? riderOtp = "";
  String? driverPhoto, driverName, driverReg, driverModel, driverRating, token;
  String? riderIdFromStartRider;
  Set<Marker> markers = Set();
  LatLng endLocation = const LatLng(27.6599592, 85.3102498);


  static const LatLng destinationLocation =
  LatLng(19.067949048869405, 73.0039520555996);
  static const CameraPosition _cameraPosition = CameraPosition(
    target: destinationLocation,
  );

  void sharePre() async {
    loadCustomMarker();
    await getCountController.getCount();
    await Preferences.setPreferences();
    userId = Preferences.getId(Preferences.id).toString();
    riderOtp = Preferences.getRideOtp();

    await locationPermission.permissionLocation();
  }

  loadCustomMarker() async {
    FamilyListRideRequest request = FamilyListRideRequest(
        userId: Preferences.getId(Preferences.id.toString()),
        mobileNumber: Preferences.getMobileNumber(
            Preferences.mobileNumber.toString())
    );
    await familyRideDataController.familyRideListApi(request);
    for (int i = 0; i <
        familyRideDataController.getFamilyRideListData.length; i++) {
      double lat = double.parse(
          familyRideDataController.getFamilyRideListData[i].startPoint!
              .latitude!.toString());
      double lng = double.parse(
          familyRideDataController.getFamilyRideListData[i].startPoint!
              .longitude!.toString());
      String? memberName = familyRideDataController.getFamilyRideListData[i]
          .memberName.toString();
      String memberPhoto = familyRideDataController.getFamilyRideListData[i]
          .memberPhoto.toString();
      String defaultImage = 'https://cdn2.iconfinder.com/data/icons/flat-style-svg-icons-part-1/512/user_man_male_profile_account-512.png';
      Uint8List? image = await loadImage(
          memberPhoto == "" ? defaultImage : memberPhoto.toString());
      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetHeight: 150,
        targetWidth: 150,
      );
      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(
          format: ui.ImageByteFormat.png);
      final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();
      markers.add(
        Marker(
            icon: BitmapDescriptor.fromBytes(resizedImageMarker),
            markerId: MarkerId(i.toString()),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(
              onTap: (){
                mapNavigate(familyRideDataController.getFamilyRideListData[i]);
              },
                title: "Member Name: $memberName"
            )
        ),
      );

    }
  }

  void mapNavigate(FamilyData familyRideListData){
    Get.to(RiderMap(
      riderId: familyRideListData.rideId.toString(),
      dName:
      familyRideListData.driverName.toString() == "null" ? "" : familyRideListData.driverName.toString(),
      dLicenseNo: familyRideListData.drivingLicenceNumber.toString() == "null" ?
      "" :  familyRideListData.drivingLicenceNumber.toString(),
      vModel: familyRideListData.vehicleModel.toString() == "null" ? " " : familyRideListData.vehicleModel.toString(),
      vOwnerName:
      familyRideListData.ownerName.toString() == "null" ? "" : familyRideListData.ownerName.toString(),
      vRegistration: familyRideListData.vehicleRegistrationNumber.toString() == "null" ?
      "" : familyRideListData.vehicleRegistrationNumber.toString(),
      dMobile: familyRideListData.driverMobileNumber.toString() == "null" ? "" : familyRideListData.driverMobileNumber.toString(),
      dImage: familyRideListData.driverPhoto.toString() == "null" ? "" : familyRideListData.driverPhoto.toString(),
      memberName:
      familyRideListData.memberName.toString() == "null" ? "" : familyRideListData.memberName.toString(), userId: familyRideListData.userId.toString(),
    ));
  }

  Future<Uint8List?> loadImage(String path) async {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));
    final imageInfo = await completer.future;
    final byteData = await imageInfo.image.toByteData(
        format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }


  void currentLocation() async {
    await permissionController.permissionLocation();
    location = Location();
    locationData = await location.getLocation();
    final GoogleMapController controller = await _completer.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(locationData!.latitude!, locationData!.longitude!),
        zoom: 15)));
    setState(() {});
  }

  @override
  void initState() {
    currentLocation();
    super.initState();
    sharePre();
    setState(() {
      sharePreferences();
    });
  }

  void sharePreferences() async {
    setState(() {});
    await Preferences.setPreferences();
    riderIdFromStartRider = Preferences.getNewRiderId().toString();
    debugPrint('LoginToken');
    debugPrint(Preferences.getLoginToken(Preferences.loginToken));
    debugPrint('UserId');
    debugPrint(Preferences.getId(Preferences.id));
  }

  @override
  Widget build(BuildContext context) {

   // ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 35,
          centerTitle: false,
          elevation: 40,
          automaticallyImplyLeading: false,
          backgroundColor: appBlue,
          title: const Text(
            "Kite",
            style: TextStyle(
                fontFamily: "Gilroy",
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            InkWell(
              onTap: () async {
                Get.to(const NotificationScreen());
                String refresh = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()));
              },
              child: Center(
                child: badges.Badge(
                  badgeContent: Text(
                    getCountController.countNotification.toString().toString(),
                    style: const TextStyle(
                      color: CustomColor.white,
                      fontSize: 13,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                  child: const Icon(
                    FeatherIcons.bell,
                    size: 27,
                    color: CustomColor.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            InkWell(
              onTap: () async {
                Get.to(const FamilyList());
              },
              child: Center(
                child: badges.Badge(
                  badgeContent: Text(
                    getCountController.peopleTrackingMe.toString() == "null"
                        ? '0' : getCountController.peopleTrackingMe
                        .toString() ?? "",
                    style: const TextStyle(
                      color: CustomColor.white,
                      fontSize: 13,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                  child: const Icon(
                    FeatherIcons.compass,
                    size: 27,
                    color: CustomColor.white,
                  ),
                ),
              ),
            ),
            IconButton(
                icon: const Icon(Icons.chat),
                color: CustomColor.white,
                onPressed: () {
                  Get.to(const ChatScreen());
                }),
          ],
        ),
        backgroundColor: Colors.white,
        body: Obx(() {
          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: googleMap()),
                Visibility(
                    visible: checkActiveRide.getToken.toString() == ""
                        ? true
                        : false,
                    child: floatingButton()),
                Visibility(
                  visible:
                  checkActiveRide.getToken.toString() == "" ? false : true,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return HomePageDetails(
                            goRide: () {
                              navigateRide();
                            },
                            stopRide: () {
                              showExitPopup(
                                  context, "Do you want to stop ride?",
                                      () async {
                                    Navigator.pop(context, true);
                                    rideEnd(
                                        checkActiveRide.getCheckRideData[0].id
                                            .toString());
                                  });
                            },
                            data: checkActiveRide.getCheckRideData[0]);
                      }),
                )
              ]);
        }));
  }

  googleMap() {
    return locationData == null
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text('Please Wait...\nMap is loading',
              style: TextStyle(fontSize: 16))
        ],
      ),
    )
        : Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              compassEnabled: true,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              zoomGesturesEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: _cameraPosition,
              markers: markers,
              onMapCreated: (GoogleMapController controller) {
                _completer.complete(controller);
                // controller.setMapStyle(permissionController.mapStyle);
              },
            ),
          ),
        ),
        Align(alignment: Alignment.bottomCenter, child: actionUi()),
        Visibility(
            visible: checkActiveRide.getToken.toString() == "" ? false : true,
            child:
            Align(alignment: Alignment.topLeft, child: vehicleNo())),
      ],
    );
  }

  Widget actionUi() {
    return HomePageAction(
        sosClick: () {
          if (checkActiveRide.getToken.isNotEmpty) {
            sos();
          } else {
            LoaderUtils.message("Ride not started");
          }
        },
        rideClick: () {
          _scanQR();
        },
        startRideVisibility: true);
  }

  Widget vehicleNo() {
    return VehicleRound(
        vehicleReg: checkActiveRide.getCheckRideData.isEmpty ? " " :
        checkActiveRide.getCheckRideData[0].vehicleRegistrationNumber.toString()
    );
  }

  Future _scanQR() async {
    try {
      String? qrResult = await MajaScan.startScan(
          barColor: appBlue,
          title: "qr_code_scanner".tr,
          titleColor: CustomColor.white,
          qRCornerColor: appBlue,
          qRScannerColor: appBlue);
      setState(() async {
        qrCodeResult = qrResult ?? 'null string';
        if (qrCodeResult != "") {
          if (qrCodeResult.length == 24) {
            driverVehicleListApi(qrCodeResult);
          } else {
            debugPrint("Invalid QR Code");
          }
        }
      });
    } on PlatformException catch (ex) {
      if (ex.code == MajaScan.CameraAccessDenied) {
        setState(() {
          Get.to(const CustomBottomNav());
          //result = "Camera permission was denied";
        });
      } else {
        setState(() {
          qrCodeResult = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        qrCodeResult = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        qrCodeResult = "Unknown Error$ex ";
      });
    }
  }

  rideEnd(String RideId) async {
    await endRideController
        .endRide(RideId, locationData!.latitude.toString(),
        locationData!.longitude.toString())
        .then((value) async {
      if (value != null) {
        if (value.status == true) {
          LoaderUtils.message(value.message.toString());
          await checkActiveRide.checkActiveRideApi();
        } else {
          LoaderUtils.message(value.message.toString());
        }
      }
    });
  }

  void navigateRide() {
    Get.to(StartRide(
      riderId: checkActiveRide.getCheckRideData[0].id.toString(),
      socketToken: checkActiveRide.getToken.toString(),
      dName: checkActiveRide.getCheckRideData[0].driverName.toString(),
      dMobile:
      checkActiveRide.getCheckRideData[0].driverMobileNumber.toString(),
      dPhoto: checkActiveRide.getCheckRideData[0].driverPhoto.toString(),
      model: checkActiveRide.getCheckRideData[0].vehicleModel.toString(),
      vOwnerName: checkActiveRide.getCheckRideData[0].ownerName.toString(),
      vRegNo: checkActiveRide.getCheckRideData[0].vehicleRegistrationNumber
          .toString(),
      driverLicense:
      checkActiveRide.getCheckRideData[0].drivingLicenceNumber.toString(),
      otpRide: checkActiveRide.getCheckRideData[0].rideStartOtp.toString(),
    ));
  }

  void driverVehicleListApi(String result) async {
    await driverVehicelListController
        .driverVehicleListApi(result)
        .then((value) {
      if (value != null) {
        String? rating = value.data![0].otherInfo!.rating.toString();
        Get.to(UserDriverInformation(
          vehicleId: value.data![0].vehicleId.toString(),
          driverId: value.data![0].driverId.toString(),
          driverName: value.data![0].driverName.toString(),
          driverMob: value.data![0].driverMobileNumber.toString(),
          driverLicense: value.data![0].drivingLicenceNumber.toString(),
          vOwnerName: value.data![0].ownerName.toString(),
          vRegNumber:
          value.data![0].vehicledetails![0].registrationNumber.toString(),
          vPucvalidity:
          value.data![0].vehicledetails![0].pucValidity.toString(),
          vFitnessValidity:
          value.data![0].vehicledetails![0].fitnessValidity.toString(),
          vInsurance:
          value.data![0].vehicledetails![0].insuranceValidity.toString(),
          vModel: value.data![0].vehicledetails![0].model.toString(),
          dPhoto: value.data![0].driverPhoto.toString(),
          vPhoto: value.data![0].vehicledetails![0].photos.toString(),
          rating: rating!.toString(),
          totalComment: value.data![0].otherInfo!.rating.toString(),
        ));
      } else {
        LoaderUtils.message("Data not available");
      }
    });
  }

  Widget floatingButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Align(
          alignment: Alignment.topRight,
          child: FloatingButton(click: () {
            showSheet(context);
          })),
    );
  }

  showSheet(context) {
    showModalBottomSheet(context: context, builder: (BuildContext bc) {
      return Container(
        color: Colors.white,
        width: double.infinity,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    _scanQR();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20, top: 20),
                    child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                            color: appBlack,
                            borderRadius: const BorderRadius.all(Radius
                                .circular(5)),
                            border: Border.all(color: Colors.black, width: 1)
                        ),
                        child: Center(child: MyText(text: 'By QR Code',
                            fontFamily: 'Gilroy',
                            color: Colors.white,
                            fontSize: 18))),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(const StartRideWithDriverId());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20, top: 20, bottom: 20),
                    child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                            color: appBlack,
                            borderRadius: const BorderRadius.all(Radius
                                .circular(5)),
                            border: Border.all(color: Colors.black, width: 1)
                        ),
                        child: Center(child: MyText(text: 'By Vehicle No',
                            fontFamily: 'Gilroy',
                            color: Colors.white,
                            fontSize: 18))),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }

    void sos() async {
      final getSosMasterController = Get.put(GetSosMasterController());
      await getSosMasterController.getSopsReason();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return AlertDialog(
                    content: SizedBox(
                      height: 190,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "are_you_in_trouble_?_please_select_your_reason_: "
                                  .tr),
                          const SizedBox(height: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 65,
                                child: Card(
                                  color: Colors.white,
                                  shape: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: appBlue)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: DropdownButton(
                                      underline: Container(),
                                      // hint: Text("Select State"),
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down),
                                      isDense: true,
                                      isExpanded: true,
                                      items: getSosMasterController
                                          .getSosReasonMasterData
                                          .map((e) {
                                        return DropdownMenuItem(
                                          value: e.name.toString(),
                                          child: Text(e.name.toString()),
                                        );
                                      }).toList(),
                                      value: reason,
                                      onChanged: (value) {
                                        setState(() {
                                          sosStatus = "SOS";
                                          reason = value;
                                          isSelected = true;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    sosApi();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: appBlue),
                                  child: const Text("Yes"),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                    ),
                                    child: const Text("No",
                                        style: TextStyle(color: Colors.black)),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          });
    }

    void sosApi() async {
      await sosPushController.SOSNotification(
          reason.toString(),
          checkActiveRide.getCheckRideData[0].id.toString(),
          locationData!.latitude.toString(),
          locationData!.longitude.toString())
          .then((value) {
        if (value != null) {
          Get.back();
          LoaderUtils.message(value.message.toString());
        } else {
          LoaderUtils.message(value!.message.toString());
        }
      });
    }
  }

