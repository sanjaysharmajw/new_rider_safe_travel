import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';

class DashboardProfileWidgets extends StatelessWidget {
  final String image;
  final String profileName;
  final String profileMobile;
  final String emailId;
  const DashboardProfileWidgets({Key? key, required this.image, required this.profileName,
    required this.profileMobile, required this.emailId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(20.sp),
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: CustomColor.yellow,
              radius: 45.r,
              child: CircleAvatar(
                radius: 44.r,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: (image != null)
                      ? Image.network(
                    image,
                    width: 80.w,
                    height: 80.w,
                    fit: BoxFit.cover,
                  )
                      : Image.asset(
                      'assets/user_avatar.png'),
                ),
              ),
            ),
             SizedBox(height: 20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(profileName,
                    style:  TextStyle(
                        fontFamily: 'transport',
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp)),
                Text(emailId,
                    style:  TextStyle(
                        fontFamily: 'transport',
                        fontSize: 14.sp)),
                 SizedBox(height: 5.h),
                 Text(profileMobile,
                    style:  TextStyle(fontFamily: 'transport', fontSize: 13.sp))
              ],
            )
          ],
        ),
      ),
    );
  }
}
