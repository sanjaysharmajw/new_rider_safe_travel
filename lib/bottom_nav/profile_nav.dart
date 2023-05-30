
import 'dart:async';
import 'dart:convert';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/PromoVideoScreen.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';
import 'package:ride_safe_travel/bottom_nav/profile_text.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/chat_bot/ChatScreen.dart';
import 'package:ride_safe_travel/color_constant.dart';
import 'package:ride_safe_travel/custom_button.dart';
import '../LoginModule/custom_color.dart';
import '../Models/sosReasonModel.dart';
import '../MyText.dart';
import '../Notification/NotificationScreen.dart';
import '../Utils/CustomLoader.dart';
import '../Utils/logout_dialog_box.dart';
import '../about_page.dart';
import '../constant_image.dart';
import '../controller/permision_controller.dart';
import '../controller/user_details_controller.dart';
import '../controller/volunteer_request.dart';
import '../controller/volunteer_select_controller.dart';
import '../home_page_controller/get_sos_controller_master.dart';
import '../new_widgets/profile_notification_with_switch.dart';
import '../rider_profile_view.dart';
import '../volunteer_screen/volunteer_screen_request_tab.dart';
import '../volunteer_sos_reason_controller.dart';
import 'custom_bottom_navi.dart';
import 'home_page_nav.dart';

class ProfileNav extends StatefulWidget {
  String backbutton;
   ProfileNav({Key? key, required this.backbutton}) : super(key: key);

  @override
  State<ProfileNav> createState() => _ProfileNavState();
}

class _ProfileNavState extends State<ProfileNav> {

  final volunteerController=Get.put(VolunteerController());
  final userDetailsController=Get.put(UserDetailsController());
  final getReason = Get.put(GetSosReasonController());
  final permissionController = Get.put(PermissionController());
  late Location location;
  LocationData? locationData;
  final Completer<GoogleMapController> _completer = Completer();

  bool? volunteerStatus=false;
  String? volunteer;
  String? option;
  String? volunteerId;
  List<String> selectedOptions = [];
  List<String> volunteerAri = [];
  List<ReasonMasterData>? reasons;

  String? userId;
  String? Name;
  String? firstname;
  String? lastname;
  String? getUserType;


  final List locale = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'हिंदी', 'locale': const Locale('hi', 'IN')},
    {'name': 'मराठी', 'locale': const Locale('mr', 'IN')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  void currentLocation() async {
    await permissionController.permissionLocation();
    location = Location();
    locationData = await location.getLocation();
    location.onLocationChanged.listen((LocationData cLoc) async {
      final GoogleMapController controller = await _completer.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(cLoc.latitude!, cLoc.longitude!), zoom: 15)));
    });
    setState(() {});
  }

  Future<void> share(String language) async {
    await Preferences.setPreferences();
    Preferences.setLanguage(language);
  }

  buildLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Padding(
              padding: EdgeInsets.all(5.0),
              child: Text('choose_language'.tr,
                  style: TextStyle(fontFamily: 'Gilroy')),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        child: Text(locale[index]['name'],
                            style: const TextStyle(fontFamily: 'Gilroy')),
                        onTap: () {
                          if (index == 0) {
                            share('en');
                          } else if (index == 1) {
                            share('hi');
                          } else {
                            share('mr');
                          }
                          updateLanguage(locale[index]['locale']);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: appBlue,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }

  var profileName;

  void initState(){
    profileName = Preferences.getFirstName(Preferences.firstname).toString() +
        " " + Preferences.getLastName(Preferences.lastname).toString();
    print("ProifleName.."+profileName);


    userDetailsApi();
    currentLocation();


  }

  //String? volunteer;
  final List<String> _selectedReasonNames= [];
  // final List<String> selectedAri = [];
  final List<String> _reasonNames = [];

  void userDetailsApi()async{


    await userDetailsController.updateProfile();

    volunteer = userDetailsController.getUserDetailsData[0].volunteer!.toString();

    debugPrint("profile details api volunteer value: ${volunteer}");

    if(volunteer=="Yes"){
      volunteerStatus = true;
    }else {
      volunteerStatus=false;
    }

    if(_selectedReasonNames.isNotEmpty){
      reasons!.clear();
      _selectedReasonNames.clear();
      _reasonNames.clear();
    }

    debugPrint("profile details api ${volunteerStatus}");


    getUserType=Preferences.getUserType(Preferences.userType).toString();
    userId = Preferences.getId(Preferences.id).toString();
    firstname = Preferences.getFirstName(Preferences.firstname).toString();
    lastname = Preferences.getLastName(Preferences.lastname).toString();
    profileName = "$firstname $lastname";


    setState(() {});
  }



  void _showMultiSelect(BuildContext context) async {
    reasons = getReason.getSosReasonData.value;
    for (var i = 0; i < reasons!.length; i++) {
      _reasonNames.add(reasons![i].name.toString());
      debugPrint("reason ${i} ${_reasonNames[i]}");
    }

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return getReason.isLoading==true?CustomLoader.loader():
        Padding(
            padding: const EdgeInsets.all(15.0),
            child: MultiSelectBottomSheet(
              items: _reasonNames.map((e) => MultiSelectItem(e, e)).toList(),
              initialValue: _selectedReasonNames,
              selectedColor: Colors.black,
              cancelText: const Text("Cancel", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20,fontFamily: "Gilroy"),),
              confirmText: const Text("Confirm", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 20,fontFamily: "Gilroy")),
              title: Flexible(child: const Text("I want to help in following situations", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,fontFamily: "Gilroy"),)),
              onConfirm: (values) {
                for (var i = 0; i < values.length; i++) {
                  _selectedReasonNames.add(values[i].toString());
                  debugPrint("selected value : ${values[i].toString()}");
                  // make volunteer ari object list-
                }

                if(volunteerStatus==true){
                  volunteerApi("No");
                }else{
                  volunteerApi("Yes");
                }
              },
              maxChildSize: 0.9,
            ));
      },
    );
  }





  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(

            backgroundColor:  appBlue,
            elevation: 15,
            leading: IconButton(
              color:  appWhiteColor,
              onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomBottomNav()));
              },
              icon: const Icon(Icons.arrow_back_outlined),
            ),
            title: Text("profile".tr,style: TextStyle(fontFamily: 'Gilroy',fontSize: 22,color: Colors.white ),),
          ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 30),
                Column(
                  children: [
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children:  [

                          CircleAvatar(
                            backgroundColor: CustomColor.black,
                            radius: 50,
                            child: CircleAvatar(
                              radius: 48,
                              backgroundColor: Colors.white,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                      imageUrl:Preferences.getProfileImage().toString(),fit: BoxFit.cover,width: 100,height: 100,

                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          CircularProgressIndicator(value: downloadProgress.progress),
                                      errorWidget: (context, url, error) => Image(image: AssetImage("assets/user_avatar.png"))
                                  ),
                                ),
                              ),
                            ),
                          ),
                           Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: (){
                                Get.to( RiderProfileView(backbutton: '',));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                clipBehavior: Clip.none,
                                child:  Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                     MyText(text: profileName.toString(),  fontFamily: 'Gilroy', color: Colors.black, fontSize: 14),
                    const SizedBox(height: 60),
                     ProfileText(title: 'language'.tr, subTitle: 'change_your_language'.tr, icons: FeatherIcons.globe,
                       click: () {
                         buildLanguageDialog(context);
                       },),
                    ProfileText(title: 'notification'.tr, subTitle: 'check_notification'.tr, icons: FeatherIcons.bell,
                      click: () {
                        Get.to(const NotificationScreen());
                      },),

                    ProfileText(title: 'help'.tr, subTitle: 'contact_us'.tr, icons: FeatherIcons.messageCircle,
                      click: () {
                        Get.to(ChatBot());
                      },),
                    ProfileText(title: 'about'.tr, subTitle: 'about_the_application'.tr, icons: FeatherIcons.alertCircle,
                      click: () {
                        Get.to(AboutScreenPage());
                      },),
                    ProfileText(title: 'Promo Videos'.tr, subTitle: 'about_the_application'.tr, icons: FeatherIcons.video,
                      click: () {
                        Get.to(const PromoVideoScreen());
                      },),
                    SizedBox(height: 5,),

                    Visibility(
                      visible: volunteer == "Yes"? true : volunteer=="No"?false:false,
                      child: ProfileText(title: 'Volunteer Requests'.tr, subTitle: 'Check Requests'.tr, icons: FeatherIcons.user,
                        click: () {
                          Get.to(const VolunteerRequestListTabScreen());
                        },),
                    ),
                    ProfileNotification(
                        valueChanged: (values) {
                          setState(() {

                            if(volunteerStatus== false){
                              _showMultiSelect(context);
                            }else{
                              volunteerApi("No");
                            }


                          });
                        },
                        status4: volunteerStatus!,
                        title: "volunteer".tr,
                        subTitle: "join_as_a_volunteer?".tr, imageAssets:'new_assets/family_icon.png'),


                    ProfileText(title: 'logout'.tr, subTitle: 'exit_from_your_account'.tr, icons: FeatherIcons.logOut,
                      click: () {
                        logoutPopup(context);
                      },),
                  ],
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

  void volunteerApi(String status)async{
    print("volunteerApi..."+status);
   VolunteerRequest request = VolunteerRequest(userId:  Preferences.getId(Preferences.id),volunteer: status,
     lng: permissionController.locationData?.longitude.toString(),lat: permissionController.locationData?.latitude.toString(),volunteerAri: _selectedReasonNames);
    volunteerController.volunteerApi(request).then((value) async {
      final String json = jsonEncode(request.toJson());
      debugPrint("request body ${json}");
      if(value!=null){
        if(value.status==true){
          userDetailsApi();
         // await userDetailsController.updateProfile();
          LoaderUtils.message(value.message.toString());
        }
      }
    });
  }
}
