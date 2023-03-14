

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';

class NewButton extends StatelessWidget {
  final String BtnName;
  final VoidCallback press;
  const NewButton({Key? key, required this.BtnName, required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: press,
          style: ElevatedButton.styleFrom(
              backgroundColor: CustomColor.yellow,
              textStyle:
              const TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.bold,fontFamily: 'transport')),
          child: Text(BtnName,style: TextStyle(color: Colors.black),),
        ),
      ),
    );
  }
}
