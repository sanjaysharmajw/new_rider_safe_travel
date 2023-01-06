import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  final String imageLink;
  final double imageWidth;
  final double imageHeight;
  final Color borderColor;
  const CircularImage({Key? key, required this.imageLink, required this.imageWidth, required this.imageHeight, required this.borderColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: imageWidth,
      height: imageHeight,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor),
        image: DecorationImage(image: NetworkImage(imageLink), fit: BoxFit.fill),
      ),
    );
  }
}
