import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:badges/badges.dart' as badges;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:majascan/majascan.dart';
import 'package:location/location.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/SpinkitLoader.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';
import 'package:ride_safe_travel/bottom_nav/profile_nav.dart';
import 'package:ride_safe_travel/color_constant.dart';
import '../LoginModule/Map/RiderFamilyList.dart';
import '../MapAddFamily.dart';
import '../Models/CheckActiveUserRide.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';

import 'package:ride_safe_travel/bottom_nav/service_request_list.dart';
import '../DriverVehicleList.dart';
import '../Error.dart';
import '../LoginModule/Api_Url.dart';
import '../LoginModule/MainPage.dart';


import '../Models/Count.dart';
import '../MyRidesPage.dart';
import '../MyText.dart';
import '../Notification/NotificationScreen.dart';
import '../RejectedServiceList.dart';
import '../UserDriverInformation.dart';
import '../UserFamilyList.dart';
import '../Utils/exit_alert_dialog.dart';
import '../Utils/profile_horizontal_view.dart';
import '../Utils/toast.dart';
import '../Widgets/circle_icon_widget.dart';
import '../chat_bot/ChatScreen.dart';
import '../controller/checkActiveRideRequest.dart';
import '../controller/check_active_rider.dart';
import '../controller/end_ride_controller.dart';
import '../controller/get_count_notification_controller.dart';
import '../controller/permision_controller.dart';
import '../new_widgets/my_new_text.dart';
import '../rider_profile_view.dart';
import '../start_ride_map.dart';
import 'EmptyScreen.dart';
import 'home_page_items.dart';
import 'my_ride_item_list.dart';
import 'my_rider_controller.dart';

class HomePageNav extends StatefulWidget {
  const HomePageNav({Key? key}) : super(key: key);

  @override
  State<HomePageNav> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageNav> {
  String result = "";
  String image = "";
  bool? dataVisibility=false;
  bool? floatingVisibility=false;
  final listController = Get.put(MyRiderController());
  final checkUserController = Get.put(CheckUserController());
  final getCountController = Get.put(GetNotificationController());
  final checkActiveRide = Get.put(CheckActiveRideController());
  LocationData? locationData;
   Location? location;

  static const LatLng destinationLocation = LatLng(19.067949048869405, 73.0039520555996);
  static CameraPosition _cameraPosition = CameraPosition(target: destinationLocation, zoom: 18,);

  var myRiderCount="wait...";
  var peopleTrackingMe="wait...";
  var trackFamily="wait...";

String? vehicleReg;
String? vehicleModel;
String? driverPhoto;
int? index;
bool ridestatus = false;

  String profileName = "";
  String profileMobile = "";
  String profileLastName = "";
  String profileEmailId = "";
  String? riderIdFromStartRider;
  late int countNitification = 0;
  final permissionController = Get.put(PermissionController());
  bool isLoading = true;
  final Completer<GoogleMapController> _completer = Completer();
  var userId;
  var riderOtp = "";
  void sharePre() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await getLocation();
    await Preferences.setPreferences();
    userId = Preferences.getId(Preferences.id).toString();
    riderOtp = Preferences.getRideOtp();
    setState(() {});
    location = Location();
    locationData = await location?.getLocation();
    if(locationData!=null){
     await listController.getServiceList(Preferences.getId(Preferences.id).toString());
    }
  }
  void currentLocation()async{
    await permissionController.permissionLocation();
    location=Location();
    location?.onLocationChanged.listen((LocationData cLoc) async {
      locationData=cLoc;
      final GoogleMapController controller = await _completer.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(cLoc.latitude!, cLoc.longitude!), zoom: 15)));
    });

  }
  void checkActiveRdieApi(){
    CheckActiveRideRequest checkActiveRideRequest=CheckActiveRideRequest(
      userId: Preferences.getId(Preferences.id).toString()
    );
    checkActiveRide.checkActiveRideApi(checkActiveRideRequest).then((value){
      if(value!=null){
        if(value.status == true){
          dataVisibility = true;
        }
else{
  floatingVisibility = true;
        }
        vehicleReg=value.data![0].vehicleRegistrationNumber;
         vehicleModel = value.data![0].vehicleModel;
         driverPhoto=value.data![0].driverPhoto.toString();


      }
    });
  }
  @override
  void initState() {

    currentLocation();
    getCount();
    super.initState();
    init();
    sharePre();
    checkActiveRdieApi();
    setState(() {
      sharePreferences();
    });
  }

  init() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      String? title = remoteMessage.notification!.title;
      String? description = remoteMessage.notification!.body;
      print(remoteMessage.toString());
      //im gonna have an alertdialog when clicking from push notification
      Alert(
        context: context,
        type: AlertType.error,
        title: title, // title from push notification data
        desc: description, // description from push notifcation data
        buttons: [
          DialogButton(
            child: Text(
              "COOL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    });
  }

  void sharePreferences() async {
    setState(() {});
    await Preferences.setPreferences();
    image = Preferences.getProfileImage().toString();
    profileName = Preferences.getFirstName(Preferences.firstname).toString() +
        " " +
        Preferences.getLastName(Preferences.lastname).toString();
    await countNotification();
    profileMobile =
        Preferences.getMobileNumber(Preferences.mobileNumber).toString();
    profileEmailId = Preferences.getEmailId(Preferences.emailId).toString();
    riderIdFromStartRider = Preferences.getNewRiderId().toString();

    //OverlayLoadingProgress.stop();
    print("Profile Details" +
        " " +
        profileMobile +
        " " +
        profileName +
        " " +
        profileEmailId);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 35,
          centerTitle: false,
          elevation: 40,
          automaticallyImplyLeading:  false,
          backgroundColor: appBlue,
          title: Text("Kite",style: TextStyle(fontFamily: "Gilroy",fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
          actions: [
            InkWell(
              onTap: () async {
                Get.to(const NotificationScreen());
                String refresh= await Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>const NotificationScreen()));
                if(refresh=='refresh'){
                  await countNotification();
                }
              },
              child: Center(
                child: badges.Badge(
                  badgeContent:  Text(
                    countNitification.toString(),
                    style: const TextStyle(color: CustomColor.white,fontSize: 15, fontFamily: 'Gilroy',),
                  ),
                  child: const Icon(FeatherIcons.bell, size: 27,color: CustomColor.white,),
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
              /*  Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.only(right: 15, left: 15, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                     /* Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           MyText(
                              text: 'Nirbhaya Rider',
                              fontFamily: 'Gilroy',
                              color: Colors.black,
                              fontSize: 22),
                          Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  Get.to(const NotificationScreen());
                                  String refresh= await Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=>const NotificationScreen()));
                                  if(refresh=='refresh'){
                                    await countNotification();
                                  }
                                },
                                child: Center(
                                  child: badges.Badge(
                                    badgeContent:  Text(
                                      countNitification.toString(),
                                      style: const TextStyle(color: CustomColor.black,fontSize: 15, fontFamily: 'Gilroy',),
                                    ),
                                    child: const Icon(Icons.notifications_outlined, size: 40,color: CustomColor.black,),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileNav(backbutton: '',)));
                                    },
                                  child: CircleAvatar(
                                    backgroundColor: CustomColor.black,
                                    radius: 27,
                                    child: CircleAvatar(
                                      radius: 26,
                                      backgroundColor: Colors.white,
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                              imageUrl: image.toString(),
                                              width: 30,
                                              height: 20,
                                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                  CircularProgressIndicator(value: downloadProgress.progress),
                                              errorWidget: (context, url, error) => Image(image: AssetImage("assets/user_avatar.png"))
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )

                        ],
                      ),*/
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(right: 5, left: 5),
                        child: ProfileHozontalView(
                            profileName: profileName,
                            profileMobile: Preferences.getMobileNumber(
                                    Preferences.mobileNumber)
                                .toString(),
                            click: () {
                              Get.to( RiderProfileView(backbutton: '',));
                            },
                            imageLink:
                                Preferences.getProfileImage().toString()),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: MyText(
                      text: 'Progress',
                      fontFamily: 'Gilroy',
                      color: Colors.black,
                      fontSize: 16),
                ), */
                GridView.count(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    crossAxisCount: 2,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10),
                    mainAxisSpacing: 20,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    children: [
                      HomePageItems(
                        backgroundColor: Colors.blue,
                        title: 'Ride History',
                        count: myRiderCount == "null"
                            ? '0'
                            : myRiderCount ?? "0",
                        icons: 'new_assets/car_direction.png',
                        click: () {
                          Get.to( MyRidesPage(changeAppbar: 'fromClass',));
                        }, width: 28, height: 28,
                      ),
                      HomePageItems(
                        backgroundColor: Colors.orange,
                        title: 'Tracking',
                        count: peopleTrackingMe == "null"
                            ? '0'
                            : peopleTrackingMe ?? "0",
                        icons: 'new_assets/eye-tracking.png',
                        click: () {
                          Get.to(const UserFamilyList());
                        }, width: 28, height: 28,
                      ),
                     /* HomePageItems(
                        backgroundColor: Colors.green,
                        title: 'Track Family & Friends',
                        count: trackFamily == "null"
                            ? '0'
                            : trackFamily ?? "0",
                        icons: 'images/my_family_icons.png',
                        click: () {
                          Get.to(const FamilyMemberListScreen(changeUiValue: 'fromClass'));
                        }, width: 25, height: 25,
                      ),
                      HomePageItems(
                        backgroundColor: Colors.orange,
                        title: 'Start New Ride',
                        count: "",
                        icons: 'new_assets/automobile.png',
                        click: () {
                          OverlayLoadingProgress.start(context);
                          checkActiveUser();
                        }, width: 28, height: 28,
                      ),*/

                     /* InkWell(
                        onTap: () {
                          Get.to( MyRidesPage(changeAppbar: 'fromClass',));
                        },
                        child:  HomePageItems(
                          completed: 58,
                          backgroundColor: Colors.blue,
                            title:  myRiderCount.toString(),
                          subtitle: 'My Rides'
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(const UserFamilyList());
                        },
                        child:  HomePageItems(
                          completed: 58,
                          backgroundColor: Colors.red,
                          title:  peopleTrackingMe.toString(),
                          subtitle: 'People Tracking Me'
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(const FamilyMemberListScreen(changeUiValue: 'fromClass'));
                        },
                        child:  HomePageItems(
                          completed: 58,
                          backgroundColor: Colors.green,
                          title: trackFamily.toString(),
                          subtitle: 'Track Family & Friends'
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          //SpinKitThreeBounce();
                          OverlayLoadingProgress.start(context);
                          checkActiveUser();
                        },
                        child: HomePageItems(
                          completed: 58,
                          backgroundColor: Colors.orange,
                          title:"",
                          subtitle: 'Start New Ride',
                        ),
                      ),*/
                    ]),
              ],
            ),

            Expanded(
              child: locationData==null ?const Center(child: Text('Please Wait...\nMap is loading')):
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: googleMap(),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: actionUi()),
                  Align(
                      alignment: Alignment.topRight,
                      child: vehicleNo())
                ],
              ),
            ),
           /* Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: checkActiveRide
                    ?
                LoaderUtils.loader():
                listController.getMyRiderData.isEmpty
                        ?*/  Visibility(
                  visible: floatingVisibility!,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 220,bottom: 10),
                            child: FloatingActionButton.extended(
                              elevation: 15,
                              onPressed: (){
                                OverlayLoadingProgress.start(context);
                                checkActiveUser();
                              },
                              label: Text("Start new ride"),
                              ),
                          ),
                        ),
                         Visibility(
                  visible: dataVisibility!,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,

                              children: [
                                Divider(thickness: 2,color: Colors.blueGrey,),

                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 15,bottom: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [


                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: CircleAvatar(
                                          backgroundColor: CustomColor.black,
                                          radius: 27,
                                          child: CircleAvatar(
                                            radius: 26,
                                            backgroundColor: Colors.white,
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: ClipOval(
                                                child: CachedNetworkImage(
                                                    imageUrl: driverPhoto.toString(),
                                                    width: 40,
                                                    height: 40,
                                                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                        CircularProgressIndicator(value: downloadProgress.progress),
                                                    errorWidget: (context, url, error) => Image(image: AssetImage("assets/user_avatar.png"))
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 10,width: 10,),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            MyText(text: vehicleReg.toString(), fontFamily: 'Gilroy', color: Colors.black, fontSize: 18),
                                            const SizedBox(height: 5),
                                            MyText(text: vehicleModel.toString(), fontFamily: 'Gilroy', color: Colors.black, fontSize: 16),
                                          ],
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8,right: 8),
                                      child: ClipOval(
                                        child: Material(
                                          //color:
                                          //theme.colorScheme.error.withAlpha(28), // button color
                                          child: InkWell(
                                            splashColor: theme.colorScheme.error.withAlpha(100),
                                            highlightColor: theme.colorScheme.error.withAlpha(28),
                                            child: SizedBox(
                                                width: 40,
                                                height: 40,
                                                child: Image.asset("new_assets/view.png")),
                                            onTap: (){},
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8,right: 20),
                                      child: ClipOval(
                                        child: Material(
                                          //color: CustomColor.lightYellow, // button color
                                          child: InkWell(
                                            splashColor: Colors.blue,
                                            highlightColor:
                                            theme.colorScheme.primary.withAlpha(28),
                                            child:  SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: Image.asset('new_assets/stop.png'),
                                            ),
                                            onTap: (){
                                              checkUser(userId.toString());
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(thickness: 2,color: Colors.blueGrey,),

                              ],
                          ),
     //                   ),
     // ),
    )
          ]
      )
    )

    );
  }
  Widget googleMap() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      compassEnabled: true,
      zoomControlsEnabled: false,
      mapToolbarEnabled: true,
      zoomGesturesEnabled: true,
      myLocationButtonEnabled: true,
      initialCameraPosition: _cameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _completer.complete(controller);
        controller.setMapStyle(permissionController.mapStyle);
      },
    );
  }
  Widget actionUi() {
    return Padding(
      padding: const EdgeInsets.only(left:25,right: 5,bottom: 45),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:  [
          Container(
            decoration: BoxDecoration(
                color: Colors.yellow.shade100,
              border: Border.all(color: appBlue),
              borderRadius: BorderRadius.all(Radius.circular(10.0))

            ),
            height: 75,
            width: 255,

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5,top: 3),
                  child: Text("Road Side Assistance Near By You",style: TextStyle(fontFamily: 'Gilroy', fontSize: 16 ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          CircleIcon(click: (){
                          }, imageAssets: 'new_assets/crane-truck.png', allPadding: 7),
                          Text("Towing",style: TextStyle(fontFamily: 'Gilroy', ),)
                        ],
                      ),
                      SizedBox(width: 6,),
                      Column(
                        children: [
                          CircleIcon(click: (){
                          }, imageAssets: 'new_assets/gas-pump-alt.png', allPadding: 10),
                          Text("Fuel",style: TextStyle(fontFamily: 'Gilroy', ),)
                        ],
                      ),
                      SizedBox(width: 6,),
                      Column(
                        children: [
                          CircleIcon(click: (){
                          }, imageAssets: 'new_assets/wrench.png', allPadding: 10),
                          Text("Mech.",style: TextStyle(fontFamily: 'Gilroy', ),)
                        ],
                      ),
                      SizedBox(width: 6,),
                      Column(
                        children: [
                          CircleIcon(click: (){
                          }, imageAssets: 'new_assets/wheels.png', allPadding: 7),
                          Text("Tyre",style: TextStyle(fontFamily: 'Gilroy', ),)
                        ],
                      ),
                      SizedBox(width: 6,),
                      Column(
                        children: [
                          CircleIcon(click: (){
                          }, imageAssets: 'new_assets/ambulance.png', allPadding: 10),
                          Text("Ambu.",style: TextStyle(fontFamily: 'Gilroy', ),)
                        ],
                      ),
                      SizedBox(width: 6,),
                      Column(
                        children: [
                          CircleIcon(click: (){
                          }, imageAssets: 'new_assets/search.png', allPadding: 10),
                          Text("More",style: TextStyle(fontFamily: 'Gilroy', ),)
                        ],
                      ),




                    ],
                  ),
                ),
              ],
            ),
          ),


          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: GestureDetector(
              onTap: (){},
                child: Image.asset("new_assets/sos_icons.png",height: 50,width: 50,))
          ),



          /*  CircleIcon(click: (){
            checkActiveUser();
          }, imageAssets: 'new_assets/car_direction.png', allPadding: 10),

          CircleIcon(click: (){
            Get.to(const MapFamilyAdd());
          }, imageAssets: 'new_assets/map_add_family.png', allPadding: 10),

          CircleIcon(click: (){
            Get.to(RejectedServiceList(changeColor: '',));
          }, imageAssets: 'new_assets/repair.png', allPadding: 10),

          CircleIcon(click: (){
          }, imageAssets: 'new_assets/sos_icons.png', allPadding: 0),*/

        ],
      ),
    );
  }
  Widget vehicleNo(){
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Container(
          width: 120,
          height: 30,
          decoration: const BoxDecoration(
              color: appBlack,
              borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          child:  Center(child:  NewMyText(textValue: vehicleReg.toString() == "null" ? "Vehicle No." : vehicleReg.toString(),
              fontName: 'Gilroy', color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16))),
    );
  }
  Future _scanQR() async {
    print("_scanQR");
    try {
      String? qrResult = await MajaScan.startScan(
          barColor: appBlue,
          title: "QR Code scanner",
          titleColor: CustomColor.white,
          qRCornerColor: appBlue,
          qRScannerColor: appBlue);
      setState(() async {
        print("qrResult" + qrResult.toString());
        result = qrResult ?? 'null string';
        print("ScanQRCode:" + result);
        if (result != "") {
          if (result.length == 24) {
            print("ScanQR:" + result);
            driverVehicleListApi(result);
          } else {
            print("Invalid QR Code");
          }
        }
      });
    } on PlatformException catch (ex) {
      if (ex.code == MajaScan.CameraAccessDenied) {
        setState(() {
          print("Something went wrong");
          Get.to(MainPage());
          //result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
          print(result);
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";

        print(result);
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error$ex ";
        print(result);
      });
    }
  }

  Future getLocation() async {
    bool? _serviceEnabled;
    Location location = Location();
    var _permissionGranted = await location.hasPermission();
    _serviceEnabled = await location.serviceEnabled();
    if (_permissionGranted != PermissionStatus.granted || !_serviceEnabled) {
      _permissionGranted = await location.requestPermission();
      _serviceEnabled = await location.requestService();
      ToastMessage.toast("Access Granted");
    }
    setState(() {});
  }

  Future<Count> countNotification() async {
    var mobileNumber = Preferences.getMobileNumber(Preferences.mobileNumber);
    final response = await http.post(Uri.parse(ApiUrl.countNotification),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'mobile_number': mobileNumber,
          'user_id': userId.toString(),
          'count': true,
          'unread': true,
        }));
    print(json.encode({
      'mobile_number': mobileNumber,
      'user_id': userId.toString(),
      'count': true,
      'unread': true,
    }));
    if (response.statusCode == 200) {
      //bool status = jsonDecode(response.body)[ErrorMessage.status];
      countNitification = jsonDecode(response.body);
      print(">>>>"+countNitification.toString()+"<<<<");
      //ToastMessage.toast(status.toString());
      setState(() {});
      return Count.fromJson(response.body);
    } else {
      throw Exception('Failed');
    }
  }

  Future<DriverVehicleList> driverVehicleListApi(String result) async {
    final response = await http.post(
      Uri.parse(ApiUrl.driverVehicleList),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'driver_id': result.toString(),
        "status": "Active"
      }),
    );
    print(jsonEncode(<String, String>{
      'driver_id': result.toString(),
      "status": "Active"
    }));

    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];

      if (status == true) {
        OverlayLoadingProgress.stop();
        List<VehicleListData> driverDetails = jsonDecode(response.body)['data']
            .map<VehicleListData>((data) => VehicleListData.fromJson(data))
            .toList();
        print('family: $driverDetails');
        var driverName = driverDetails[0].driverName;
        var driverMob = driverDetails[0].driverMobileNumber.toString();
        var driverLicense =
            driverDetails[0].drivingLicenceNumber.toString() ?? "";
        var vOwnerName = driverDetails[0].ownerName.toString();
        var vRegNumber =
            driverDetails[0].vehicledetails![0].registrationNumber.toString();

        var vPucvalidity =
            driverDetails[0].vehicledetails![0].pucValidity.toString();
        var vFitnessValidity =
            driverDetails[0].vehicledetails![0].fitnessValidity.toString();
        var vInsurance =
            driverDetails[0].vehicledetails![0].insuranceValidity.toString();
        var vModel = driverDetails[0].vehicledetails![0].model.toString();
        var dPhoto = driverDetails[0].driverPhoto.toString();
        var vPhoto = driverDetails[0].ownerPhoto.toString();
        var vehicleIds = driverDetails[0].vehicledetails![0].id.toString();
        var driverIds = driverDetails[0].driverId.toString();
        var rating = driverDetails[0].otherInfo?.rating?.toDouble();
        var comment = driverDetails[0].otherInfo?.totalComments.toString();
        print("Rating.."+rating.toString());

        // print("PUCValidityDate:"+DateFormat('dd-MM-yyyy').format(DateTime.parse(vPucvalidity)) );
        print(response.body);

        Get.to(UserDriverInformation(
            vehicleId: vehicleIds.toString(),
            driverId: driverIds.toString(),
            driverName: driverName.toString(),
            driverMob: driverMob.toString(),
            driverLicense: driverLicense.toString(),
            vOwnerName: vOwnerName.toString(),
            vRegNumber: vRegNumber.toString(),
            vPucvalidity: vPucvalidity.toString(),
            vFitnessValidity: vFitnessValidity.toString(),
            vInsurance:
                vInsurance.toString(),
            vModel: vModel.toString(),
            dPhoto: dPhoto.toString(),
            vPhoto: vPhoto.toString(),
          rating: rating!,
          totalComment: comment.toString(),
        ));
        setState(() {});
      } else if (status == false) {
        OverlayLoadingProgress.stop();
      }
        return DriverVehicleList.fromJson(response.body);
    } else {
      throw Exception('Failed to create.');
    }
  }

  Future<String> checkActiveUser() async {
    print(
      "USER" +
          jsonEncode(<String, String>{
            'user_id': userId,
          }),
    );

    final response = await http.post(
      Uri.parse(ApiUrl.checkActiveUserRide),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': userId,
      }),
    );
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      // var otpRide=jsonDecode(response.body)['data'][0]['ride_start_otp'];

      String socketToken = jsonDecode(response.body)['token'];
      if (socketToken != "") {
        OverlayLoadingProgress.stop();
        List<Data> userCheck = jsonDecode(response.body)['data']
            .map<Data>((data) => Data.fromJson(data))
            .toList();
        print("UserCheck" + userCheck.toString());
        var id = userCheck[0].id.toString();
        Get.to(StartRide(
            riderId: id.toString(),
            dName: userCheck[0].driverName.toString(),
            dMobile: userCheck[0].driverMobileNumber.toString(),
            dPhoto: userCheck[0].driverPhoto.toString(),
            model: userCheck[0].vehicleModel.toString(),
            vOwnerName: userCheck[0].ownerName.toString(),
            vRegNo: userCheck[0].vehicleRegistrationNumber.toString(),
            socketToken: socketToken.toString(),
            driverLicense: userCheck[0].drivingLicenceNumber.toString(),
            otpRide: riderOtp.toString()));
        var ids = userCheck[0].id.toString();
        print('IDssss: $ids');
        print(userCheck[0].driverName.toString());
        print(userCheck[0].driverMobileNumber.toString());
        print(userCheck[0].driverPhoto.toString());
        print(userCheck[0].vehicleModel.toString());
        print(userCheck[0].ownerName.toString());
        print(userCheck[0].vehicleRegistrationNumber.toString());
        print(socketToken.toString());
        setState(() {});
      } else if (socketToken == "") {
        OverlayLoadingProgress.stop();
        print("Print False........");
        _scanQR();
      }
      var userData = jsonDecode(response.body);
      print("userData:" + userData.toString());
      return userData.toString();
    } else {
      throw Exception('Failed to create.');
    }
  }

  Future<http.Response> endRide(
      String riderId, String lat, String lng) async {
    final response = await http.post(
        Uri.parse(
            'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/userRide/endRide'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'ride_id': riderId,
          'end_point': {
            'time': DateTime.now().millisecondsSinceEpoch.toString(),
            'latitude': lat.toString(),
            'longitude': lng.toString(),
            'location': ""
          }
        }));
    print("object");
    print(json.encode({
      'ride_id': riderId,
      'end_point': {
        'time': DateTime.now().millisecondsSinceEpoch.toString(),
        'latitude': lat.toString(),
        'longitude': lng.toString(),
        'location': ""
      }
    }));
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      print("response");
      print("$response");
      if (status == true) {
        LoaderUtils.closeLoader();
        ToastMessage.toast(msg);
        Preferences.setRideOtp(''); //MainPage
        await listController.getServiceList(userId.toString());
        setState(() {

        });

      } else {
        LoaderUtils.closeLoader();
        ToastMessage.toast(msg);
      }
      return response;
    } else {
      throw Exception('Failed');
    }
  }

  void checkUser(String userid) async {
    await checkUserController.checkActiveUser(userid).then((value) async {
      if (value != null) {

          var riderId = value.data![0].id.toString();

          await endRide(riderId, locationData!.latitude.toString(),
              locationData!.longitude.toString(),);
        }

    });
  }


  void getCount()async{
    await getCountController.getCount().then((value) async {
      if (value != null) {
        if (value.status == true) {

          myRiderCount=value.count.totalRides.toString();
          trackFamily=value.count.familymemberrides.toString();
          peopleTrackingMe=value.count.trackingmembers.toString();
          countNitification=value.data.length;
          print("RiderCount.."+myRiderCount + "TrackFamily.."+trackFamily + "PeopleTrackingMe.."+peopleTrackingMe);
          setState(() {

          });
        }
      }
    });
  }



}
