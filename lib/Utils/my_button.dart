import 'package:flutter/material.dart';

import '../color_constant.dart';

class MyButton extends StatelessWidget {
  final VoidCallback press;
  final String buttonText;
  const MyButton({Key? key, required this.press, required this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: SizedBox(
        width: double.infinity,
        height: 50,
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

      ),
    );


  }
}
