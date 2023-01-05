import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../rider_profile_edit.dart';
import 'LoginModule/custom_color.dart';
import 'MyText.dart';

class ProfileWidget extends StatelessWidget {
  final String profileName;
  final String profileMobile;
  final String assetsPath;
  final VoidCallback onPress;

  const ProfileWidget(
      {Key? key,
      required this.profileName,
      required this.profileMobile,
      required this.onPress,
      required this.assetsPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.h),
          child: CircleAvatar(
            backgroundColor: CustomColor.yellow,
            radius: 23.r,
            child: CircleAvatar(
              radius: 22.r,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: (assetsPath != null)
                    ? Image.network(
                  assetsPath,
                  width: 80.w,
                  height: 80.w,
                  fit: BoxFit.cover,
                )
                    : Image.asset('assets/user_avatar.png'),
              ),

              /*CachedNetworkImage(
                imageUrl: assetsPath,

                fit: BoxFit.contain,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),*/
            ),
          ),
        ),
        SizedBox(
          width: 14.w,
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
                    fontSize: 16.sp),
                MyText(
                    text: profileMobile,
                    fontFamily: 'transport',
                    color: CustomColor.black,
                    fontSize: 16.sp),
              ],
            ),
          ],
        ),
        SizedBox(
          width: 30,
        ),
        Container(
          width: 110.0.w,
          height: 40.0.h,
          child: ElevatedButton(
            onPressed: onPress,
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              backgroundColor: CustomColor.yellow,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Edit Profile',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: CustomColor.riderprofileColor),
                ),
                Image(
                  image: AssetImage('assets/Union (1).png'),
                  width: 10.w,
                  height: 12.h,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
