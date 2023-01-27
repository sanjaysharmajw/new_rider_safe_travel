


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';

class CardMatrix extends StatelessWidget {
  final String kilometerValue;
  final String timeValue;
  const CardMatrix({Key? key, required this.kilometerValue, required this.timeValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.r),
      ),
      color: CustomColor.transparent,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('KM: $kilometerValue',style:  TextStyle(fontSize: 12.sp,fontFamily: 'transport')),
            Text('Hours: $timeValue',style:  TextStyle(fontSize: 12.sp,fontFamily: 'transport')),
          ],
        ),
      ),
    );
  }
}
