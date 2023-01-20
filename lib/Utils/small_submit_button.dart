import 'package:flutter/material.dart';

import '../LoginModule/custom_color.dart';


class SmallButton extends StatelessWidget {
  final Color textColor;
  final double height;
  final double width ;
  final String? buttonTitle;
  final VoidCallback onPressed;

  const SmallButton({
    Key? key,
    required this.textColor,
    required this.height,
    required this.buttonTitle,
    required this.onPressed,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: CustomColor.yellow, width: 1.5)),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: CustomColor.yellow,
                foregroundColor: CustomColor.black),
            child: Text(
              buttonTitle!,
              style: TextStyle(
                  color: textColor,
                  fontFamily: "transport",
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
