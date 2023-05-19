import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../color_constant.dart';


class MyTextFieldWithIcon extends StatelessWidget {
  final Icon icon;
  final Text text;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final double fontSize;
  final bool  readOnly;
  final VoidCallback onTap;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  List<TextInputFormatter>? inputFormatters;

  MyTextFieldWithIcon(
      {Key? key,
        required this.text,
        required this.icon,
        required this.controller,
        required this.validator, required this.fontSize, required this.readOnly, required this.onTap, required this.keyboardType,
      required this.inputFormatters, required this.textCapitalization})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(data)
  }
}
