import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/color_constant.dart';

import '../LoginModule/RiderLoginPage.dart';
import '../LoginModule/preferences.dart';

Future<bool> logoutPopup(context) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("do_you_want_to_logout ?".tr),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print('yes selected');
                          logout();
                          Get.to(RiderLoginPage());
                          // exit(0);
                        },
                        child: Text("yes".tr),
                        style: ElevatedButton.styleFrom(
                            primary: appBlue),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        print('no selected');
                        Navigator.of(context).pop();
                      },
                      child: Text("no".tr, style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      });
}

Future logout() async {
  await Preferences.setPreferences();
  await Preferences.clear();
  Preferences.setId(Preferences.id, "");
  Preferences.setMobileNumber(Preferences.mobileNumber, "");
}
