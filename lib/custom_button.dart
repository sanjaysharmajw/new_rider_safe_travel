import 'package:flutter/material.dart';

import '../color_constant.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback press;
  final String buttonText;
  const CustomButton({Key? key, required this.press, required this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: press,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(appBlue),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        child:  Text(buttonText,style: const TextStyle(fontSize: 16,color: Colors.white,fontFamily: 'Gilroy')),
      ),

    );


  }
}
