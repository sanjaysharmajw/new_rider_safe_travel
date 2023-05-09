



import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/bottom_nav/profile_text.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/chat_bot/ChatScreen.dart';
import 'package:ride_safe_travel/color_constant.dart';
import '../LoginModule/custom_color.dart';
import '../MyText.dart';
import '../Notification/NotificationScreen.dart';
import '../Utils/logout_dialog_box.dart';
import '../about_page.dart';
import '../new_widgets/profile_notification_with_switch.dart';
import '../rider_profile_view.dart';
import 'custom_bottom_navi.dart';
import 'home_page_nav.dart';

class ProfileNav extends StatefulWidget {
  String backbutton;
   ProfileNav({Key? key, required this.backbutton}) : super(key: key);

  @override
  State<ProfileNav> createState() => _ProfileNavState();
}

class _ProfileNavState extends State<ProfileNav> {

  bool volunteerToggle = false;

  final List locale = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'हिंदी', 'locale': const Locale('hi', 'IN')},
    {'name': 'मराठी', 'locale': const Locale('mr', 'IN')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
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
                       voidCallback: () {
                         buildLanguageDialog(context);
                       },),
                    ProfileText(title: 'notification'.tr, subTitle: 'check_notification'.tr, icons: FeatherIcons.bell,
                      voidCallback: () {
                        Get.to(const NotificationScreen());
                      },),
                    ProfileText(title: 'help'.tr, subTitle: 'contact_us'.tr, icons: FeatherIcons.messageCircle,
                      voidCallback: () {
                        Get.to(ChatBot());
                      },),
                    ProfileText(title: 'about'.tr, subTitle: 'about_the_application'.tr, icons: FeatherIcons.alertCircle,
                      voidCallback: () {
                        Get.to(AboutScreenPage());
                      },),
                    SizedBox(height: 5,),
                    ProfileNotification(
                      valueChanged: (values) {
                        values=volunteerToggle;

                        volunteerToggle = true;


                      },
                      status4: volunteerToggle,
                      title: "volunteer".tr,
                      subTitle: "join_as_a_volunteer?".tr, imageAssets: 'new_assets/volunteer.png',),
                    ProfileText(title: 'logout'.tr, subTitle: 'exit_from_your_account'.tr, icons: FeatherIcons.logOut,
                      voidCallback: () {
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
  
}
