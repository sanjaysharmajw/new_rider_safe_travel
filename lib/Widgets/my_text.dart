

import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final String fontName;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final int? maxLine;

  const MyText({Key? key, required this.text, required this.fontName, required this.fontSize, required this.fontWeight, required this.textColor, this.maxLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Text(text,
        maxLines: maxLine,
        style:  TextStyle(
            overflow: TextOverflow.ellipsis,
            fontFamily: fontName,fontSize: fontSize,fontWeight: fontWeight,color: textColor
        ));
  }
}
