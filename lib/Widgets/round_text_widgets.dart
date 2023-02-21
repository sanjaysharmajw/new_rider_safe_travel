

import 'package:flutter/material.dart';

import '../LoginModule/custom_color.dart';

class roundTextWidget extends StatelessWidget {
  final String? textValue;
  const roundTextWidget({Key? key, required this.textValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.all(8.0),
      child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: CustomColor.yellow,
              borderRadius: BorderRadius.circular(100)
          ),
          child: Center(
            child: Text(
                "$textValue\nkm/h"),
          )
      ),
    );
  }
}
