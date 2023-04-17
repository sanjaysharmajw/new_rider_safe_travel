

import 'package:flutter/material.dart';

import '../color_constant.dart';

class CircleIcon extends StatelessWidget {
  final VoidCallback click;
  final String imageAssets;
  final double allPadding;
  const CircleIcon({Key? key, required this.click, required this.imageAssets, required this.allPadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: click,
      child: Container(
        height: 35,
        width: 35,
        decoration:  const BoxDecoration(
          color: appWhiteColor,
          borderRadius: BorderRadius.all(Radius.circular(100)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black26,
                blurRadius: 15.0,
                offset: Offset(0.0, 0.75)
            )
          ],
        ),
        child: Padding(
          padding:  EdgeInsets.all(allPadding),
          child: Image.asset(imageAssets),
        ),
      ),
    );
  }
}
