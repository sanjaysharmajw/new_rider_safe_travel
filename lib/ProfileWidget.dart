import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../rider_profile_edit.dart';
import 'LoginModule/custom_color.dart';
import 'MyText.dart';

class ProfileWidget extends StatelessWidget {
  final String profileName;
  final String profileMobile;
  final String assetsPath ;
  final VoidCallback onPress;

  const ProfileWidget({Key? key, required this.profileName, required this.profileMobile, required this.onPress, required this.assetsPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20),
          child:  CachedNetworkImage(
            imageUrl: assetsPath,
            width: 50,
            height: 30,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),

        ),
        SizedBox(
          width: 14,
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                    text: profileName,
                    fontFamily: 'transport',
                    color: CustomColor.black,
                    fontSize: 16),
                MyText(
                    text: profileMobile,
                    fontFamily: 'transport',
                    color: CustomColor.black,
                    fontSize: 16),
              ],
            ),
          ],
        ),
        SizedBox(width: 30,),
        Container(
          width: 110.0,
          height: 40.0,
          child: ElevatedButton(
            onPressed: onPress,
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              backgroundColor: CustomColor.yellow,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text(
                  'Edit Profile',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:12,
                      color: CustomColor.riderprofileColor),
                ),
                Image(image: AssetImage('assets/Union (1).png'),width: 10,height: 12,)
              ],
            ),
          ),
        ),
      ],
    );
  }
}