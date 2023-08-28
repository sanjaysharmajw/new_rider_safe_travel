import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/Widgets/my_text.dart';
import '../color_constant.dart';


exitShowDialog(BuildContext context,String title,String subTitle,VoidCallback cancelClick,VoidCallback okClick) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText(text: title, fontName: 'Gilroy', textColor: appBlack, fontWeight: FontWeight.w700, fontSize: 18),
          const SizedBox(height: 10),
          MyText(text: subTitle, fontName: 'Gilroy', textColor: appBlack, fontWeight: FontWeight.w500, fontSize: 16),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: cancelClick,
          child: const MyText(text: 'Cancel', fontName: 'Gilroy', textColor: appBlack, fontWeight: FontWeight.w600, fontSize: 14),
        ),
        TextButton(
          onPressed: okClick,
          child: const MyText(text: 'Ok', fontName: 'Gilroy', textColor: appBlack, fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ],
    ),
  );
}