import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';

Future<bool> showExitPopup(context, String title, VoidCallback press) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: press,
                        child: Text("Yes"),
                        style: ElevatedButton.styleFrom(
                            primary: CustomColor.yellow),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        print('no selected');
                        Navigator.of(context).pop();
                      },
                      child: Text("No", style: TextStyle(color: Colors.black)),
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
