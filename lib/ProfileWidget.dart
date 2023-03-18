import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:ride_safe_travel/color_constant.dart';

import '../rider_profile_edit.dart';
import 'LoginModule/custom_color.dart';
import 'MyText.dart';

class ProfileWidget extends StatelessWidget {
  final String profileName;
  final String profileMobile;
  final String assetsPath;
  final VoidCallback onPress;
  final int progressIndicator;
  final String progressValue;

  const ProfileWidget(
      {Key? key,
      required this.profileName,
      required this.profileMobile,
      required this.onPress,
      required this.assetsPath, required this.progressIndicator, required this.progressValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    double indicator=progressIndicator/100;


    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: CircleAvatar(
                backgroundColor: CustomColor.black,
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
                        fontFamily: 'Gilroy',
                        color: CustomColor.black,
                        fontSize: 16.sp),
                    MyText(
                        text: profileMobile,
                        fontFamily: 'Gilroy',
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
                  backgroundColor: appBlue,
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
                          fontFamily: "Gilroy",
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
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: [
            LinearPercentIndicator(
              animation: true,
              lineHeight: 20.0,
              animationDuration: 2000,
              percent: indicator,
              center: Text('Complete Profile: $progressValue%'),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: appBlue,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ],
    );
  }
}
