import 'package:flutter/material.dart';


class MyTextField extends StatelessWidget {
  final String fontName;
  final double fontSize;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final int width;
  final double broad;
final TextInputType textInputType;
final bool enable ;
final String hintText;

  TextEditingController textEditingController;




  MyTextField(
      {Key? key,
      required this.fontName,
      required this.fontSize,
      required this.enabledBorderColor,
      required this.width, required this.textEditingController,
        required this.focusedBorderColor,
        required this.broad, required this.textInputType,
        required this.enable,  required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enable,
      keyboardType: textInputType,
      style: TextStyle(fontFamily: fontName, fontSize: fontSize),
      maxLines: width,
      controller: textEditingController,

      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: broad, color: enabledBorderColor)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: broad, color: focusedBorderColor)),
        hintText: hintText
        ),
    );
  }
}
