



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
import '../Utils/logout_dialog_box.dart';
import '../about_page.dart';
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
  String? option;
  String? volunteerId;
  List<String> selectedOptions = [];
  List<String> volunteerAri = [];


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
        " " +

        Preferences.getLastName(Preferences.lastname).toString();
    print("ProifleName.."+profileName);

    userDetailsApi();
    currentLocation();


  }

  //String? volunteer;
  final List<String> _selectedReasonNames= [];
  List<String> selectedAri = [];
  final List<String> _reasonNames = [];

  void userDetailsApi()async{
    await userDetailsController.updateProfile();
   // volunteer= userDetailsController.getUserDetailsData[].volunteer;

    if(_selectedReasonNames.isNotEmpty){
      _selectedReasonNames.clear();
      selectedAri.clear();
      _reasonNames.clear();

    }

    for(var i = 0; i< userDetailsController.getUserDetailsData[0].volunteerAri!.length;i++){
      debugPrint("selected reason ${userDetailsController.getUserDetailsData[0].volunteerAri![i].name}");
      _selectedReasonNames.add(userDetailsController.getUserDetailsData[0].volunteerAri![i].name.toString());
    }
    setState(() {});
    // debugPrint("volunteer ari items ${volunteer[].}");
  }

  void _showMultiSelect(BuildContext context) async {


    List<ReasonMasterData> reasons = getReason.getSosReasonData.value;




    for (var i = 0; i < reasons.length; i++) {
      _reasonNames.add(reasons[i].name.toString());
      debugPrint("selected value reason : ${reasons[i].name.toString()}");
    }




    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return getReason.isLoading==true?LoaderUtils.loader():

        Padding(
          padding: const EdgeInsets.all(15.0),
          child: MultiSelectBottomSheet(
            items: _reasonNames.map((e) => MultiSelectItem(e, e)).toList(),
            initialValue: _selectedReasonNames,
            selectedColor: Colors.black,
            cancelText: Text("Cancel", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
            confirmText: Text("Confirm", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 20),),
            title: Text("I want to help in following situations", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
            onConfirm: (values) {
              for (var i = 0; i < values.length; i++) {
                _selectedReasonNames.add(values[i].toString());
                debugPrint("selected value : ${values[i].toString()}");
                // make volunteer ari object list
               // ReasonMasterData rmd=values[i] as ReasonMasterData;
                selectedAri.add(values[i]);
                debugPrint("selected ari  value : ${values[i]}");
              }

              if(volunteerStatus==true){
                volunteerApi("Yes");
              }else{
                volunteerApi("No");
              }
            },
            maxChildSize: 0.9,
          ),
        );
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
               /* const SizedBox(height: 10),
                 Padding(
                  padding:  EdgeInsets.only(left: 10,right: 10),
                  child:  MyText(text: 'Profile',  fontFamily: 'Gilroy', color: Colors.black, fontSize: 22),
                ),*/
                const SizedBox(height: 30),
                Column(
                  children: [
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children:  [
                         /* InkWell(
                            onTap: (){
                              Get.to(const RiderProfileView());
                            },
                            child:  ClipRRect(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              borderRadius: BorderRadius.all(Radius.circular(60)),
                              child: Image.network(Preferences.getProfileImage().toString(),fit: BoxFit.cover,width: 100,height: 100,)
                            ),
                          ),*/
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
                    /*ProfileNotification(
                      valueChanged: (values) {
                        values=volunteerToggle;
                        volunteerToggle = true;
                        },
                      status4: volunteerToggle,
                      title: "volunteer".tr,
                      subTitle: "join_as_a_volunteer?".tr, imageAssets: 'new_assets/volunteer.png',),*/
                    Visibility(
                      visible: volunteerStatus == true? true : false,
                      child: ProfileText(title: 'Volunteer Requests'.tr, subTitle: 'Check Requests'.tr, icons: FeatherIcons.user,
                        click: () {
                          Get.to(const VolunteerRequestListTabScreen());
                        },),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 15,top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         /* ProfileText(title: 'volunteer'.tr, subTitle: 'join_as_a_volunteer?'.tr, icons: FeatherIcons.user,
                            voidCallback: () {
                              //Get.to(AboutScreenPage());
                            },),*/
                          Row(

                            children:  [
                              Icon(FeatherIcons.user),
                              const SizedBox(
                                height: 10,width: 25,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  MyText(text: 'volunteer'.tr,  fontFamily: 'Gilroy', color: Colors.black, fontSize: 16,),
                                  const SizedBox(height: 5),
                                  MyText(text: 'join_as_a_volunteer?'.tr,  fontFamily: 'Gilroy', color: Colors.black, fontSize: 12),
                                ],
                              ),

                            ],
                          ),
                          FlutterSwitch(
                            width: 50.0,
                            height: 25.0,
                            value: volunteerStatus!,
                            borderRadius: 30.0,
                            padding: 2.0,
                            activeColor: appBlue,
                            onToggle: (val) {
                              setState(() {
                                volunteerStatus = val;
                                if(volunteerStatus==true){

                                  _showMultiSelect(context);

                                  /*showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(

                                        builder: (BuildContext context, StateSetter setState) {
                                          final getSosMasterController = Get.put(GetSosMasterController());
                                          return Column(
                                            children: [
                                              Container(
                                                height: 420,
                                                child: ListView.builder(
                                                  itemCount: getSosMasterController.getSosReasonMasterData.length,
                                                  itemBuilder: (BuildContext context, int index) {
                                                    print("LENGTH..."+getSosMasterController.getSosReasonMasterData.length.toString());
                                                     option = getSosMasterController.getSosReasonMasterData[index].name.toString();
                                                     volunteerId = getSosMasterController.getSosReasonMasterData[index].id.toString();
                                                    final bool isSelected = selectedOptions.contains(option);
                                                    return ListTile(
                                                      title: Text(option.toString()),
                                                      leading: isSelected
                                                          ? Icon(Icons.check_box)
                                                          : Icon(Icons.check_box_outline_blank),
                                                      onTap: () {
                                                        setState(() {
                                                          if (isSelected) {
                                                            print("RemoveOption"+option.toString());

                                                            selectedOptions.remove(option);
                                                          } else {
                                                           print("AddOption"+option.toString());

                                                            selectedOptions.add(option.toString());
                                                            }
                                                        });
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 30,right: 30),
                                                child: CustomButton(press: (){
                                                  volunteerApi("Yes");
                                                }, buttonText: 'Submit'),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },

                                  );*/

                                }else{
                                  volunteerApi("No");
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),

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
     lng: permissionController.locationData?.longitude.toString(),lat: permissionController.locationData?.latitude.toString(),volunteerAri: selectedAri);
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
