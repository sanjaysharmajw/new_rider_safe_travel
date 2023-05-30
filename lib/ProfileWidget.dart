import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:ride_safe_travel/color_constant.dart';

import '../rider_profile_edit.dart';
import 'LoginModule/custom_color.dart';
import 'MyText.dart';
import 'Utils/circular_image_widgets.dart';

class ProfileWidget extends StatelessWidget {
  final String profileName;
  final String profileMobile;
  final String assetsPath;
  final VoidCallback onPress;
  final num progressIndicator;
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
              padding: const EdgeInsets.only(left: 20),
              child: CircularImage(
                imageLink:assetsPath,
                imageWidth: 50, imageHeight: 50, borderColor: Colors.black,),
            ),

            SizedBox(
              width: 14.w,
            ),
            Flexible(
              child: Column(
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
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                width: 80.0.w,
                height: 40.0.h,
                child: IconButton(onPressed:onPress, icon: Icon(FeatherIcons.edit3))
                /* ElevatedButton(
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
                ),*/
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
              lineHeight: 13.0,
              animationDuration: 2000,
              percent: indicator,
              center: Text('$progressValue% Completed',style: TextStyle(fontSize: 8.sp),),
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
