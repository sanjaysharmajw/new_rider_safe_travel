

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/color_constant.dart';
import 'package:ride_safe_travel/new_widgets/my_new_text.dart';

class VehicleRound extends StatelessWidget {
  final String vehicleReg;
  const VehicleRound({Key? key, required this.vehicleReg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 30, top: 30),
      child: Container(
          width: 120,
          height: 30,
          decoration: const BoxDecoration(
              color: appBlack,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: Center(
            child: NewMyText(
                textValue: vehicleReg.toString() == "null"
                    ? "vehicle_no.".tr
                    : vehicleReg.toString(),
                fontName: 'Gilroy',
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16),
          )),
    );
  }
}
