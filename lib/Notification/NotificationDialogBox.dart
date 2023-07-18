import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/color_constant.dart';

Future<bool> NotificationPopup(context, String title,String description, VoidCallback press) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 165,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                SizedBox(
                  height: 20
                ),
                Text(description),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: press,
                        child: Text("Ok"),
                        style: ElevatedButton.styleFrom(
                            primary: appBlue),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
