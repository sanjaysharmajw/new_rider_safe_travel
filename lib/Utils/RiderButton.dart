import 'package:flutter/material.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';


class RiderButton extends StatelessWidget {
  final VoidCallback click;
  final String textBtn;
  const RiderButton({Key? key, required this.click, required this.textBtn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: click,
        child: Container(
          height: 55,
          width: 120,
          decoration: const BoxDecoration(
              color: CustomColor.yellow,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child:  Center(child: Text(textBtn,style: const TextStyle(color: CustomColor.white,fontFamily: 'transport',fontSize: 14))),
        ),
      ),
    );
  }
}
