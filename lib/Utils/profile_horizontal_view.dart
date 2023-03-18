

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../LoginModule/custom_color.dart';
import '../MyText.dart';

class ProfileHozontalView extends StatelessWidget {
  final String profileName;
  final String profileMobile;
  final String imageLink;
  final VoidCallback click;
  const ProfileHozontalView({Key? key, required this.profileName, required this.profileMobile, required this.click, required this.imageLink }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
              /*  Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children:  [
                      InkWell(
                        onTap: (){
                        },
                        child:  ClipRRect(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                          child: Image.network(imageLink,fit: BoxFit.cover,width: 60,height: 60)
                        ),
                      ),
                    ],
                  ),
                ), */
                CircleAvatar(
                  backgroundColor: CustomColor.black,
                  radius: 27,
                  child: CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ClipOval(
                        child: CachedNetworkImage(
                            imageUrl:  imageLink,fit: BoxFit.cover,width: 60,height: 60,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                CircularProgressIndicator(value: downloadProgress.progress),
                            errorWidget: (context, url, error) => Image(image: AssetImage("assets/user_avatar.png"))
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      MyText(text: profileName, fontFamily: 'Gilroy', color: Colors.black, fontSize: 16),
                      const SizedBox(height: 4),
                      MyText(text: profileMobile, fontFamily: 'Gilroy', color: Colors.black, fontSize: 16)
                    ],
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: click,
              child: const Icon(
                FeatherIcons.edit,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
