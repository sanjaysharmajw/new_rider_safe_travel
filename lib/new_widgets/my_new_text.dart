

import 'package:flutter/cupertino.dart';

class NewMyText extends StatelessWidget {
  final String textValue;
  final int? textMaxLine;
  final String fontName;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  const NewMyText({Key? key, required this.textValue, required this.fontName, required this.color,
    required this.fontWeight, required this.fontSize, this.textMaxLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Text(
      textValue,
      maxLines: textMaxLine,
      overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style: TextStyle(
      color: color,  fontFamily: fontName,
      fontSize: fontSize, fontWeight: fontWeight,

    ),);
  }
}
