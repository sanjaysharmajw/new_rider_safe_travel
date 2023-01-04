import 'package:flutter/material.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';

class Button extends StatelessWidget {
  final Color textColor;
  final double size;
  final String? buttonTitle;
  final VoidCallback onPressed;

  const Button({
    Key? key,
    required this.textColor,
    required this.size,
    required this.buttonTitle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
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
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
