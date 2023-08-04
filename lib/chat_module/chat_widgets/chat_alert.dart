import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/bottom_nav/custom_bottom_navi.dart';

chatAlertDialog(BuildContext context,String token,VoidCallback cancel,VoidCallback continueClick) {
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed:  cancel,
  );
  Widget continueButton = TextButton(
    child: const Text("Continue"),
    onPressed:  continueClick,
  );
  AlertDialog alert = AlertDialog(
    title: const Text("Alert"),
    content: const Text("Would you like to continue to chat with Agent?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}