import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final String fontFamily;
  final Color color;
  final double fontSize;
  final FontWeight? fontWeight;

   MyText(
      {Key? key,
      required this.text,
      required this.fontFamily,
      required this.color,
      required this.fontSize, this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(fontSize: fontSize, color: color, fontFamily: fontFamily, fontWeight: fontWeight),
    );
  }
}
