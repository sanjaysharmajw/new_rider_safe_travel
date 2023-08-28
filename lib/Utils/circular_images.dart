
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../color_constant.dart';

class CircularImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit boxFit;
  final double width;
  final double height;
  const CircularImage({Key? key, required this.imageUrl, required this.boxFit, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: appBlack),
            borderRadius: const BorderRadius.all(Radius.circular(50))
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children:  [
            InkWell(
              onTap: (){
              },
              child:  ClipRRect(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                borderRadius: const BorderRadius.all(Radius.circular(60)),
                child: CachedNetworkImage(
                  width: width,
                  height: height,
                  fit: boxFit,
                  imageUrl: imageUrl!,
                  placeholder: (context, url) => const CircularProgressIndicator(
                      color: appBlue,strokeWidth: 2),
                  errorWidget: (context, url, error) => Image.asset('new_assets/no_image.png',width: width,height: height,fit: boxFit),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
