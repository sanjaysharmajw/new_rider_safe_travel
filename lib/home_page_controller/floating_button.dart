
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/color_constant.dart';
import 'package:ride_safe_travel/new_widgets/my_new_text.dart';

class FloatingButton extends StatelessWidget {
  final VoidCallback click;
  const FloatingButton({Key? key, required this.click}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: FloatingActionButton.extended(
        onPressed: click,
        label:  NewMyText(textValue: 'Start Ride'.tr, fontName: 'Gilroy', color: appWhiteColor, fontWeight: FontWeight.w500, fontSize: 14),
        backgroundColor: appBlack,
      ),
    );
  }
}
