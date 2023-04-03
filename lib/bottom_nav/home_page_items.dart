
import 'package:flutter/material.dart';
class HomePageItems extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final String subtitle;
  final int completed;

  const HomePageItems(
      {Key? key,
        required this.backgroundColor,
        required this.completed, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }

}
