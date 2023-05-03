
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
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
import 'package:location/location.dart';
import 'package:majascan/majascan.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/SpinkitLoader.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';
import 'package:ride_safe_travel/bottom_nav/profile_nav.dart';
import 'package:ride_safe_travel/bottom_nav/profile_text.dart';
import 'package:ride_safe_travel/color_constant.dart';
import 'package:ride_safe_travel/controller/location_controller.dart';
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
import '../Models/sosReasonModel.dart';
import '../MyRidesPage.dart';
import '../MyText.dart';
import '../Notification/NotificationScreen.dart';
import '../RejectedServiceList.dart';
import '../ServiceTypeModel.dart';
import '../Services_Module/selected_service_list.dart';
import '../Services_Module/service_types.dart';
import '../Services_Module/servicelist_controller.dart';
import '../UserDriverInformation.dart';
import '../UserFamilyList.dart';
import '../Utils/exit_alert_dialog.dart';
import '../Utils/logout_dialog_box.dart';
import '../Utils/profile_horizontal_view.dart';
import '../Utils/toast.dart';
import '../Widgets/circle_icon_widget.dart';
import '../about_page.dart';
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
import 'custom_bottom_navi.dart';
import 'home_page_items.dart';
import 'my_ride_item_list.dart';
import 'my_rider_controller.dart';

class HomePageNav extends StatefulWidget {
  const HomePageNav({Key? key}) : super(key: key);

  @override
  State<HomePageNav> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageNav> {


ServiceTypeData serviceTypeData = ServiceTypeData();

  String result = "";
  String image = "";
  bool? dataVisibility=false;
  bool? floatingVisibility=false;
  bool? RegVisibility=false;
  final listController = Get.put(MyRiderController());
  final checkUserController = Get.put(CheckUserController());
  final getCountController = Get.put(GetNotificationController());
  final checkActiveRide = Get.put(CheckActiveRideController());
  final servicelistController = Get.put(ServiceListController());
  LocationData? locationData;
   late Location location;
var stopAlertValue = 'No';

var selectedReason = [];
var reason;
bool isSelected = false;
var Sos_status = 'Ok';
 Timer? timers;

  static const LatLng destinationLocation = LatLng(19.067949048869405, 73.0039520555996);
  static CameraPosition _cameraPosition = CameraPosition(target: destinationLocation, zoom: 18,);

  var myRiderCount="wait...";
  var peopleTrackingMe="wait...";
  var trackFamily="wait...";

String? vehicleReg;
String? vehicleModel;
String? driverPhoto;
String? driverName;
String? driverMobile;
String? oName;
String? dLicense;
String? riderID;
String? socketoken;
String? vehicleMake;
String? vehiclePhoto;
double? rating;

int? index;
bool ridestatus = false;

  String profileName = "";
  String profileMobile = "";
  String profileLastName = "";
  String profileEmailId = "";
  String? riderIdFromStartRider;
  late int countNitification = 0;
  final permissionController = Get.put(PermissionController());
  final locationPermission = Get.put(LocationController());

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
    if(locationData!=null){
     await listController.getServiceList(Preferences.getId(Preferences.id).toString());
    }else{
     await locationPermission.permissionLocation();
    }
  }
  void currentLocation()async{
  //  await permissionController.permissionLocation();
    location=Location();
    location.onLocationChanged.listen((LocationData cLoc) async {
      locationData=cLoc;


      print(locationData?.latitude.toString());
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
          floatingVisibility = false;
          RegVisibility=true;
        }
else{
          dataVisibility = false;
          floatingVisibility = true;
          RegVisibility=false;
        }
        vehicleReg=value.data![0].vehicleRegistrationNumber;
         vehicleModel = value.data![0].vehicleModel;
         driverPhoto=value.data![0].driverPhoto.toString();
         driverName=value.data![0].driverName.toString();
         driverMobile=value.data![0].driverMobileNumber.toString();
        dLicense=value.data![0].drivingLicenceNumber.toString();
        vehicleMake=value.data![0].vehicleMake.toString();
        oName=value.data![0].ownerName.toString();
        riderID=value.data![0].id.toString();
        socketoken=value.token.toString();
        rating=value.data![0].rating;
        vehiclePhoto=value.data![0].vehiclePhoto.toString();


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
    getSosReason();
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
    ScreenUtil.init(context, designSize: const Size(375, 812));
    ThemeData theme = Theme.of(context);
    return Scaffold(

      appBar: AppBar(
        titleSpacing: 35,
        centerTitle: false,
        elevation: 40,
        automaticallyImplyLeading:  false,
        backgroundColor: appBlue,
        title: /*Row(
          children: [
            Image.asset("new_assets/letter-k (1).png",height: 40,width: 40,color: appWhiteColor,),
            Image.asset("new_assets/i.png",height: 26,width: 26,color: appWhiteColor,),
            Image.asset("new_assets/t.png",height: 25,width: 25,color: appWhiteColor,),
            Image.asset("new_assets/e.png",height: 25,width: 25,color: appWhiteColor,),
          ],
        ),*/
        Text("Kite",style: TextStyle(fontFamily: "Gilroy",fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
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
                  style: TextStyle(color: CustomColor.white,fontSize: 13, fontFamily: 'Gilroy',),
                ),
                child: Icon(FeatherIcons.bell, size: 27,color: CustomColor.white,),
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
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),

          GridView.count(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              crossAxisCount: 2,
              padding: EdgeInsets.only(
                  left: 20, right: 20, top: 10),
              mainAxisSpacing: 20,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 15,
              children: [
                HomePageItems(
                  backgroundColor: Colors.blue,
                  title: 'ride_history'.tr,
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
                  title: 'tracking'.tr,
                  count: peopleTrackingMe == "null"
                      ? '0'
                      : peopleTrackingMe ?? "0",
                  icons: 'new_assets/eye-tracking.png',
                  click: () {
                    //Get.to(const FamilyMemberListScreen(changeUiValue: 'fromClass'));
                    Get.to(const FamilyList());
                  }, width: 28, height: 28,
                ),
              /*  HomePageItems(
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

          Expanded(child: googleMap()),
         /* Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: checkActiveRide
                  ?
              LoaderUtils.loader():
              listController.getMyRiderData.isEmpty
                      ?*/
         Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Visibility(
               visible: floatingVisibility!,
               child: Align(
                 alignment: Alignment.bottomRight,
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: FloatingActionButton.extended(
                     elevation: 15,
                     onPressed: (){
                       OverlayLoadingProgress.start(context);
                       checkActiveUser();
                     },
                     label: Text("start_new_ride".tr),
                   ),
                 ),
               ),
             ),
             Visibility(
               visible: dataVisibility!,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.end,

                 children: [
                   Divider(thickness: 2,color: Colors.blueGrey,),
                   Divider(thickness: 1,color: Colors.blueGrey,),



                   Padding(
                     padding: EdgeInsets.only(left: 25,right: 20,),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,

                       children: [
                         Column(
                           children: [
                             Center(
                               child: Stack(
                                 clipBehavior: Clip.none,
                                 children:  [
                                   ClipRRect(
                                     child: CachedNetworkImage(
                                         imageUrl: vehiclePhoto.toString(),
                                         width: 80,
                                         height: 60,
                                         progressIndicatorBuilder: (context, url, downloadProgress) =>
                                             CircularProgressIndicator(value: downloadProgress.progress),
                                         errorWidget: (context, url, error) => Image(image: AssetImage("assets/carImage.png",),height: 50,width: 50,)
                                     ),
                                   ),
                                   /*ClipRRect(
                                                borderRadius: new BorderRadius.circular(40.0),
                                                child: Image.asset('assets/carImage.png', height: 60, width: 150),
                                              ),*/
                                   Positioned(
                                     bottom: 0,
                                     right: 35,
                                     top: 4,
                                     child: CircleAvatar(
                                       backgroundColor: CustomColor.black,
                                       radius: 22,
                                       child: CircleAvatar(
                                         radius: 21,
                                         backgroundColor: Colors.white,
                                         child: AspectRatio(
                                           aspectRatio: 1,
                                           child: ClipOval(
                                             child: CachedNetworkImage(
                                                 imageUrl: driverPhoto.toString(),
                                                 width: 25,
                                                 height: 25,
                                                 progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                     CircularProgressIndicator(value: downloadProgress.progress),
                                                 errorWidget: (context, url, error) => Image(image: AssetImage("assets/user_avatar.png"))
                                             ),
                                           ),
                                         ),
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                             ),

                           ],
                         ),

                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             MyText(text: vehicleReg.toString(), fontFamily: 'Gilroy', color: Colors.black, fontSize: 22,),
                             const SizedBox(height: 5),
                             Row(
                               children: [
                                 MyText(text: vehicleMake.toString(), fontFamily: 'Gilroy',
                                     color: Colors.black, fontSize: 17),
                                 const SizedBox(width: 3),
                                 MyText(text: vehicleModel.toString(), fontFamily: 'Gilroy',
                                     color: Colors.black, fontSize: 17),
                               ],
                             )

                           ],
                         )

                       ],
                     ),
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(left: 25,top: 10),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Text(
                               driverName.toString(),
                               style:
                               TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Gilroy',
                                   decoration: TextDecoration.underline),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(left: 3,right: 3),
                               child: Text("."),
                             ),
                             Text(
                               rating.toString() == "null" ? " " : rating.toString(),
                               style:
                               TextStyle(fontSize: 14, color: Colors.black, fontFamily: 'Gilroy',
                               ),
                             ),
                             Icon(
                               Icons.star_outlined,
                               color: Colors.blueGrey,
                               size: 14.0,
                             ),

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
                                       width: 35,
                                       height: 35,
                                       child: Image.asset("new_assets/viewRide.png")),
                                   onTap: (){
                                     Get.to(StartRide(riderId: riderID.toString(), socketToken: socketoken.toString(), dName: driverName.toString(),
                                       dMobile: driverMobile.toString(), dPhoto: driverPhoto.toString(),
                                       model: vehicleModel.toString(), vOwnerName: oName.toString(), vRegNo: vehicleReg.toString(),
                                       driverLicense: dLicense.toString(), otpRide: riderOtp,));
                                     print("ViewRide");
                                     print(StartRide(riderId: riderID.toString(), socketToken: socketoken.toString(), dName: driverName.toString(),
                                       dMobile: driverMobile.toString(), dPhoto: driverPhoto.toString(),
                                       model: vehicleModel.toString(), vOwnerName: oName.toString(), vRegNo: vehicleReg.toString(),
                                       driverLicense: dLicense.toString(), otpRide: riderOtp,));

                                   },
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
                                     width: 32,
                                     height: 32,
                                     child: Image.asset('new_assets/stop-sign (2).png'),
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
                     ],
                   ),



                   Divider(thickness: 1,color: Colors.blueGrey,),
                   Divider(thickness: 2,color: Colors.blueGrey,),

                 ],
               ),
               //                   ),
               // ),
             )
           ],
         )
        ]
    )
    );
  }
  Widget googleMap() {
    return locationData == null
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text('Please Wait...\nMap is loading', style: TextStyle( fontSize: 16),   )
        ],
      ),
    )
        : Stack(
      clipBehavior: Clip.none,
      children: [

        Positioned(
          child: Padding(
            padding: const EdgeInsets.all(5.0),

              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    compassEnabled: true,
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: true,
                    zoomGesturesEnabled: true,
                    myLocationButtonEnabled: false,
                    initialCameraPosition: _cameraPosition,
                    onMapCreated: (GoogleMapController controller) {
                      _completer.complete(controller);
                      controller.setMapStyle(permissionController.mapStyle);
                    },

                ),
              ),
            ),
        ),


        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomLeft,
              child: actionUi()
          ),
        ),

        Positioned(
          bottom: 350,

              child: vehicleNo()),


      ],
    );
    /*GoogleMap(
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
    );*/
  }
  Widget actionUi() {
    return Padding(
      padding: const EdgeInsets.only(left:10,right: 5,bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:  [
          Container(
            decoration: BoxDecoration(
                color: Colors.white60,
              border: Border.all(color: appBlue),
              borderRadius: BorderRadius.all(Radius.circular(10.0))

            ),
            //height: 75,
            //width: 220,
            height : MediaQuery.of(context).size.height * 0.10,
            //width : MediaQuery.of(context).size.width * 5,

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5,top: 3,right: 15),
                  child: Text("road_side_assistance_near_by_you".tr,style: TextStyle(fontFamily: 'Gilroy', fontSize: 16 ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          CircleIcon(click: (){
                            Get.to(SelectedServiceLists(serviceId: "63fc74202e0ec5faaf772783", backToDashboard: 'DashBoard',));

                          },
                              imageAssets: 'new_assets/crane-truck.png', allPadding: 7),
                          Text("towing".tr,style: TextStyle(fontFamily: 'Gilroy', ),)
                        ],
                      ),
                      SizedBox(width: 6,),
                      Column(
                        children: [
                          CircleIcon(click: (){
                            Get.to(SelectedServiceLists(serviceId: "63fc74d82e0ec5faaf772787", backToDashboard: 'DashBoard',));

                          }, imageAssets: 'new_assets/gas-pump-alt.png', allPadding: 10),
                          Text("fuel".tr,style: TextStyle(fontFamily: 'Gilroy', ),)
                        ],
                      ),
                      SizedBox(width: 6,),
                      Column(
                        children: [
                          CircleIcon(click: (){
                            Get.to(SelectedServiceLists(serviceId: "63fc74c62e0ec5faaf772786", backToDashboard: 'DashBoard',));
                           ;
                          }, imageAssets: 'new_assets/wrench.png', allPadding: 10),
                          Text("mech.".tr,style: TextStyle(fontFamily: 'Gilroy', ),)
                        ],
                      ),
                      SizedBox(width: 6,),
                      Column(
                        children: [
                          CircleIcon(click: (){
                            Get.to(SelectedServiceLists(serviceId: "63fc74b12e0ec5faaf772785", backToDashboard: 'DashBoard',));

                          }, imageAssets: 'new_assets/wheels.png', allPadding: 7),
                          Text("tyre".tr,style: TextStyle(fontFamily: 'Gilroy', ),)
                        ],
                      ),
                      SizedBox(width: 6,),
                      Column(
                        children: [
                          CircleIcon(click: (){
                            Get.to(SelectedServiceLists(serviceId: "63fc74e72e0ec5faaf772788", backToDashboard: 'DashBoard',));

                          }, imageAssets: 'new_assets/ambulance.png', allPadding: 10),
                          Text("ambu.".tr,style: TextStyle(fontFamily: 'Gilroy', ),)
                        ],
                      ),
                      SizedBox(width: 6,),
                      Column(
                        children: [
                          CircleIcon(click: (){
                            Get.to(ServiceListsScreen());
                          }, imageAssets: 'new_assets/search.png', allPadding: 10),
                          Text("more".tr,style: TextStyle(fontFamily: 'Gilroy', ),)
                        ],
                      ),




                    ],
                  ),
                ),
              ],
            ),
          ),


          Padding(
            padding: const EdgeInsets.only(left:40),
            child: Positioned(

              child: GestureDetector(
                onTap: (){
                  sos();
                },
                  child: Image.asset("new_assets/sos_icons.png",height: 50,width: 50,)),
            ),
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
      padding: const EdgeInsets.only(left: 10,right: 30,bottom: 30,top: 10),
      child: Visibility(
        visible: RegVisibility!,
        child: Container(
            width: 120,
            height: 30,
            decoration: const BoxDecoration(
                color: appBlack,
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            child: Center(
              child: NewMyText(textValue: vehicleReg.toString() == "null" ? "vehicle_no.".tr : vehicleReg.toString(),
                  fontName: 'Gilroy', color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
            )

        ),
      ),
    );
  }
  Future _scanQR() async {
    print("_scanQR");
    try {
      String? qrResult = await MajaScan.startScan(
          barColor: appBlue,
          title: "qr_code_scanner".tr,
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
          Get.to(CustomBottomNav());
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
            'https://l8olgbtnbj.execute-api.ap-south-1.amazonaws.com/dev/api/userRide/endRide'),
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
        print("END RIDE....."+msg);
        ToastMessage.toast(msg);
        floatingVisibility = true;
        dataVisibility = false;

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
          var userId = Preferences.getId(Preferences.id);



          await  showExitPopup(
              context, "do_you_want_to_stop_ride?".tr,
                  () async {
               LoaderUtils.showLoader("Please wait...");
                Navigator.pop(context, true);
                await endRide(riderId, locationData!.latitude.toString(),
                  locationData!.longitude.toString(),);
              });
         // CheckActiveRideRequest check = CheckActiveRideRequest(userId:userId);
         // await checkActiveRide.checkActiveRideApi(check);
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

void sos(){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder:
            (BuildContext context,
            StateSetter setState) {
          return AlertDialog(
            content: Container(
              height: 190,
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,
                children: [
                  Text(
                      "are_you_in_trouble_?_please_select_your_reason_: "),
                  SizedBox(height: 15),
                  Column(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .center,
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .center,
                    children: <Widget>[
                      SizedBox(
                        height: 65,
                        child: Card(
                          color:
                          Colors.white,
                          shape: UnderlineInputBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  10),
                              borderSide:
                              BorderSide(
                                  color:
                                  appBlue)),
                          child: Padding(
                            padding:
                            EdgeInsets
                                .all(
                                15),
                            child:
                            DropdownButton(
                              underline:
                              Container(),
                              // hint: Text("Select State"),
                              icon: Icon(Icons
                                  .keyboard_arrow_down),
                              isDense: true,
                              isExpanded:
                              true,

                              items: selectedReason
                                  .map((e) {
                                return DropdownMenuItem(
                                  value: e[
                                  'name']
                                      .toString(),
                                  child: Text(
                                      e['name']
                                          .toString()),
                                );
                              }).toList(),
                              value: reason,
                              onChanged:
                                  (value) {
                                setState(
                                        () {
                                      Sos_status =
                                      "SOS";
                                      reason =
                                          value;
                                      isSelected =
                                      true;
                                    });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child:
                        ElevatedButton(
                          onPressed: () {
                            OverlayLoadingProgress
                                .start(
                                context);
                            SOSNotification();
                          },
                          child:
                          Text("yes".tr),
                          style: ElevatedButton
                              .styleFrom(
                              primary:
                              appBlue),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child:
                          ElevatedButton(
                            onPressed: () {
                              print(
                                  'no selected');
                              Navigator.of(
                                  context)
                                  .pop();
                            },
                            child: Text("no".tr,
                                style: TextStyle(
                                    color: Colors
                                        .black)),
                            style:
                            ElevatedButton
                                .styleFrom(
                              primary:
                              Colors.white,
                            ),
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

Future<http.Response> SOSNotification() async {
  var loginToken = Preferences.getLoginToken(Preferences.loginToken);
  final response = await http.post(Uri.parse(ApiUrl.SOS_Push_Notification),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': loginToken
      },
      body: json.encode({
        'reason': reason.toString(),
        'user_id': userId.toString(),
        'ride_id': riderID,
        "lat": locationData?.latitude.toString(),
        "lng": locationData?.longitude.toString(),
        "timestamp": DateTime.now().millisecondsSinceEpoch
      }));
  print(json.encode({
    'reason': reason ?? "Ok",
    'user_id': userId.toString(),
    'ride_id': riderID,
    "lat": locationData?.latitude,
    "lng": locationData?.longitude,
    "timestamp": DateTime.now().millisecondsSinceEpoch
  }));

  if (response.statusCode == 200) {
    bool status = jsonDecode(response.body)[ErrorMessage.status];
    var msg = jsonDecode(response.body)[ErrorMessage.message];
    if (status == true) {
      OverlayLoadingProgress.stop();
      ToastMessage.toast(msg.toString());
      Navigator.of(context).pop();
      stopAlertValue="Yes";
      setState(() {
        sosStatus();
      });

    } else {
      OverlayLoadingProgress.stop();
      ToastMessage.toast(msg.toString());
    }
    return response;
  } else {
    throw Exception('Failed');
  }
}

void sosStatus() {
  Timer.periodic(const Duration(minutes: 10), (timers) {
    if(Sos_status=="Yes") {
      setState(() {
        timers.cancel();
      });
    }else{
      sosHelpAlert();
    }
  });
}

Future<void> sosHelpAlert() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text('alert'),
        content: SingleChildScrollView(
          child: ListBody(
            children:  <Widget>[
              Text('do_you_received_help?'.tr),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child:  Text('no'.tr),
            onPressed: () {
              Navigator.pop(context, true);
              Sos_status="No";
            },
          ),
          TextButton(
            child:  Text('yes'.tr),
            onPressed: () {
              Navigator.pop(context, true);
              Sos_status="Yes";
              setState(() {
                timers?.cancel();
              });
            },
          ),
        ],
      );
    },
  );
}

Future<SosReasonModel> getSosReason() async {
  var loginToken = Preferences.getLoginToken(Preferences.loginToken);
  final response = await http.post(
    Uri.parse(
        "https://l8olgbtnbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/sosReasonMaster"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': loginToken
    },
  );

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body)['data'];
    bool status = jsonDecode(response.body)[ErrorMessage.status];
    var msg = jsonDecode(response.body)[ErrorMessage.message];
    if (status == true) {
      setState(() {
        selectedReason = jsonResponse;
      });
      print(selectedReason.toString());
    }
    return SosReasonModel.fromJson(jsonDecode(response.body));
  } else {
    print("----------------------------");
    print(response.statusCode);
    print("----------------------------");

    throw Exception('Unexpected error occured!');
  }
}
}
