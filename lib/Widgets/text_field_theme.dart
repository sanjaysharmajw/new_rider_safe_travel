

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../color_constant.dart';


class TextFieldTheme{
  const TextFieldTheme(Key? key);

  static buildTextField(
      {required String hint,
        required TextEditingController controller,
        IconData? icon,
        required String? Function(String?) validator,
        TextInputType keyboardType = TextInputType.text,
        List<TextInputFormatter>? inputFormatters,

        bool obscureText = true,
        bool enabled = true,
        bool readOnly=false,
        EdgeInsets contentPadding = EdgeInsets.zero,
        maxLine = 1,
        maxLength = 1,
        double fontSize=16,
        required VoidCallback onTap,
        }) {
    return TextFormField(
      inputFormatters: inputFormatters,
      obscureText: !obscureText,
      validator: validator,
      keyboardType: keyboardType,
      textCapitalization: TextCapitalization.sentences,
      controller: controller,
      maxLines: maxLine,
      maxLength: maxLength,
      onTap: onTap,
      readOnly: readOnly,
      enabled: enabled,
      style:
      TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.w500,fontSize: fontSize),
      decoration: InputDecoration(
        counter: const Offstage(),
        hintText: hint,
        hintStyle:
        const TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Gilroy'),
        labelStyle: const TextStyle(
            color: appBlue, fontFamily: 'Gilroy', fontWeight: FontWeight.w500),
      ),
    );
  }
}