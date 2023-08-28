import 'package:flutter/material.dart';
import 'package:ride_safe_travel/color_constant.dart';

Future<bool> showChatExitPopup(context, String title, VoidCallback press,VoidCallback cancelClick) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: press,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: appBlue),
                        child: const Text("Yes"),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                        child: ElevatedButton(
                          onPressed: cancelClick,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: const Text("No", style: TextStyle(color: Colors.black)),
                        ))
                  ],
                )
              ],
            ),
          ),
        );
      });
}