
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
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,style: const TextStyle(fontWeight: FontWeight.w500,fontFamily: 'transport',color: Colors.white,fontSize: 16)),
            const SizedBox(height: 5),
            Text(subtitle,style: const TextStyle(fontWeight: FontWeight.w100,fontFamily: 'transport',color: Colors.white))
          ],
        ),
      ),
    );
  }
}