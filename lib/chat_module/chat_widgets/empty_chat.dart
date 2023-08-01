

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/Widgets/my_text.dart';


class EmptyChat extends StatelessWidget {
  const EmptyChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/chat_empty.json',
          width: 150,
          height: 150,
          fit: BoxFit.fill,
        ),
        const SizedBox(height: 20),
        const MyText(text: 'No messages yet...', fontName: 'Gilroy', fontSize: 18, fontWeight: FontWeight.w600, textColor: CustomColor.black),
        const SizedBox(height: 5),
        const MyText(
            text: 'Send a messages or reply\nwith a our agent',
            fontName: 'Gilroy',
            fontSize: 14,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
            textColor: CustomColor.text),
      ],
    );
  }
}
