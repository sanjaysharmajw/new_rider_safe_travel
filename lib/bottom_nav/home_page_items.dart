
import 'package:flutter/material.dart';

import '../new_widgets/my_new_text.dart';
import '../new_widgets/new_my_image.dart';
class HomePageItems extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  //final String subtitle;
  //final int completed;
  final VoidCallback click;
  final double width;
  final double height;


  final String count;
  final String icons;


  const HomePageItems(
      {Key? key,
        required this.backgroundColor,
         required this.title,  required this.click, required this.count, required this.icons, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: click,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: backgroundColor,
        ),
        height: 100,
        child: Container(
          padding: const EdgeInsets.only(bottom: 20, left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  const EdgeInsets.only(right: 10),
                child:  Align(
                  alignment: Alignment.topRight,
                  child: NewMyText(textValue: count, fontName: 'Gilroy', color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),
              NewMyImage(image: icons, width: width, height: height, fit: BoxFit.cover, color: Colors.white),
              const SizedBox(height: 10),
              Text(title,style: const TextStyle(fontWeight: FontWeight.w100,fontFamily: 'Gilroy',color: Colors.white,fontSize: 16))
            ],
          ),
        ),
      ),
    );
    /*Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: backgroundColor,
      ),
      height: 125,
      child: Container(
        padding: const EdgeInsets.only(bottom: 20, left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w500,fontFamily: 'Gilroy',color: Colors.white,fontSize: 25)),
            const SizedBox(height: 20),
            Text(subtitle,style: const TextStyle(fontWeight: FontWeight.w100,fontFamily: 'Gilroy',color: Colors.white,fontSize: 16))
          ],
        ),
      ),
    );*/
  }

}
