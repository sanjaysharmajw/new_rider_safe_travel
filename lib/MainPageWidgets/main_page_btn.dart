import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';

class MainPageBtn extends StatelessWidget {
  final String icons;
  final String text;
  final VoidCallback press;

  const MainPageBtn(
      {Key? key, required this.icons, required this.text, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: CustomColor.lightYellow,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icons, height: 20.h, width: 20.w),
            SizedBox(width: 10.w),
            Text(text,
                style: const TextStyle(
                    fontFamily: 'transport', fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}
