

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/bottom_nav/profile_text.dart';
import 'package:get/get.dart';
import '../MyText.dart';
import '../Utils/logout_dialog_box.dart';
import '../rider_profile_view.dart';

class ProfileNav extends StatefulWidget {
  const ProfileNav({Key? key}) : super(key: key);

  @override
  State<ProfileNav> createState() => _ProfileNavState();
}

class _ProfileNavState extends State<ProfileNav> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Padding(
                padding:  EdgeInsets.only(left: 10,right: 10),
                child:  MyText(text: 'Profile', fontFamily: 'transport', color: Colors.black, fontSize: 22),
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children:  [
                        InkWell(
                          onTap: (){
                            Get.to(const RiderProfileView());
                          },
                          child:  ClipRRect(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                            child: Image.network(Preferences.getProfileImage().toString(),fit: BoxFit.cover,width: 100,height: 100,)
                          ),
                        ),
                         Positioned(
                          bottom: 0,
                          right: 0,
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const MyText(text: 'Sanjay Sahrma', fontFamily: 'transport', color: Colors.black, fontSize: 14),
                  const SizedBox(height: 60),
                  const ProfileText(title: 'Language', subTitle: 'Change your language', icons: FeatherIcons.edit),
                  const ProfileText(title: 'Notification', subTitle: 'Check notification', icons: FeatherIcons.bell),
                  const ProfileText(title: 'Help', subTitle: 'Contact Us', icons: FeatherIcons.messageCircle),
                  const ProfileText(title: 'About', subTitle: 'About the application', icons: FeatherIcons.alertCircle),
                  InkWell(
                      onTap: (){
                        logoutPopup(context);
                      },
                      child: const ProfileText(title: 'Logout', subTitle: 'Exit from your account', icons: FeatherIcons.logOut)),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}
