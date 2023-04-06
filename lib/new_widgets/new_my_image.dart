

import 'package:flutter/material.dart';

class NewMyImage extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final BoxFit fit;
  final Color color;
  const NewMyImage({Key? key, required this.image, required
  this.width, required this.height, required this.fit, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(image,width: width,height: height,fit: fit,color: color);
  }
}
