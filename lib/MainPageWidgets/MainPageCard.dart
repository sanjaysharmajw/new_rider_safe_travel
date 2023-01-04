import 'package:flutter/material.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';

class MainPageCard extends StatelessWidget {
  final String icons;
  final String text;
  final VoidCallback press;
  final double width;
  final double height;

  final double widthImage;
  final double heightImage;

  const MainPageCard(
      {Key? key,
      required this.icons,
      required this.text,
      required this.press,
      required this.width,
      required this.height,
      required this.widthImage,
      required this.heightImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: press,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: CustomColor.lightYellow,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(icons, height: heightImage, width: widthImage),
              const SizedBox(height: 10),
              Text(text,
                  style: const TextStyle(
                      fontFamily: 'transport', fontWeight: FontWeight.w500))
            ],
          ),
        ),
      ),
    );
  }
}
