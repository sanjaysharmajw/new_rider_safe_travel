
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';

class NotificationItems extends StatelessWidget {
  final String Title;
  final String Des;
  final String date;
  final Color border;
  final VoidCallback click;
  const NotificationItems({Key? key, required this.Title, required this.Des, required this.border, required this.click, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: click,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: border,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Title,style: TextStyle(fontFamily: 'transport',fontSize: 15)),
                    Text(date,style: TextStyle(fontFamily: 'transport',fontSize: 15)),
                  ],
                ),

                SizedBox(height: 10),
                Text(Des),
              ],
            ),
          ),

        ),
      ),
    );
  }
}
