import 'package:flutter/material.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';

class MainPageBtn extends StatelessWidget {
  final String icons;
  final String text;
  final VoidCallback press;

  const MainPageBtn({Key? key, required this.icons, required this.text, required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: Container(
          width: double.infinity,
          height: 65,
          decoration: BoxDecoration(
            color: CustomColor.lightYellow,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(icons, height: 25, width: 25),
              const SizedBox(width: 10),
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
