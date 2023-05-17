


import 'package:flutter/material.dart';
import 'package:ride_safe_travel/color_constant.dart';

import 'MyText.dart';




class RequestWidget extends StatelessWidget {
  final String textValue;
  final VoidCallback onClick;
  const RequestWidget({Key? key, required this.textValue, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: double.infinity,
        height: 35,
        decoration: BoxDecoration(
          color: appBlue,
            border: Border.all(color: appBlue,width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(5))
        ),
        child: Center(child: MyText(text: textValue, fontSize: 14,  fontFamily: 'Gilroy', color: Colors.white,)),
      ),
    );
  }
}
