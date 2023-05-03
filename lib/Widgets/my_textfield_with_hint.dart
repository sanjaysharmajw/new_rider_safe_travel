import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../color_constant.dart';


class MyTextFieldWithHint extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final double fontSize;
  final bool  readOnly;
  final VoidCallback onTap;
  final TextInputType keyboardType;
  List<TextInputFormatter>? inputFormatters;

   MyTextFieldWithHint(
      {Key? key,
        required this.hintText,
        required this.controller,
        required this.validator, required this.fontSize, required this.readOnly, required this.onTap, required this.keyboardType,
      required this.inputFormatters})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      controller: controller,
      onTap: onTap,
      style:
      TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.w500,fontSize: fontSize),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:
        const TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Gilroy'),
        labelStyle: const TextStyle(
            color: appBlue, fontFamily: 'Gilroy', fontWeight: FontWeight.w500),
      ),
      validator: validator,
    );
  }
}
