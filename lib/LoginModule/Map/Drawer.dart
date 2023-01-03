import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';

class DrawerInfo extends StatelessWidget {
  final String dInfoName;
  final String dInfoMobile;
  final String dInfoImage;
  final String dInfoLicense;

  final String vInfoImage;
  final String vInfoModel;
  final String vInfoOwnerName;
  final String vInfoRegNo;

  final VoidCallback press;
  final bool visibility;

  DrawerInfo(
      {Key? key,
      required this.dInfoName,
      required this.dInfoMobile,
      required this.dInfoImage,
      required this.vInfoImage,
      required this.vInfoModel,
      required this.vInfoOwnerName,
      required this.vInfoRegNo,
      required this.dInfoLicense,
      required this.press, required this.visibility})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Padding(
      padding: EdgeInsets.all(15.0.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: press,
              child: const Icon(Icons.keyboard_backspace_sharp,
                  color: CustomColor.black)),
           SizedBox(
            height: 20.h,
          ),
          Text("Driver Information",
              style: TextStyle(fontFamily: 'transport', fontSize: 18.sp)),
          SizedBox(height: 10.h),
          Container(
            decoration: BoxDecoration(
                color: CustomColor.listColor,
                borderRadius: BorderRadius.circular(5.0.r)),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0.sp),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Image.network(
                        dInfoImage,
                        width: 60.w,
                        height: 60.h,
                      ),
                      // CircleAvatar(
                      //   backgroundColor: CustomColor.yellow,
                      //   radius: 30.0,
                      //   child: CircleAvatar(
                      //     radius: 29.0,
                      //     backgroundColor: Colors.white,
                      //     child: ClipOval(
                      //       child: (dInfoImage != null)
                      //           ? Image.network(
                      //         dInfoImage!,
                      //         width: 100,
                      //         height: 100,
                      //         fit: BoxFit.cover,
                      //       )
                      //           : Image.asset('images/bottom_drawer_comp.png'),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                 SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 35.h),
                          child: Text(dInfoName,
                              style: TextStyle(
                                  fontFamily: 'transport', fontSize: 16.sp)),
                        ),
                        Text(dInfoMobile,
                            style: TextStyle(
                                fontFamily: 'transport', fontSize: 16.sp)),
                      ],
                    ),
                    SizedBox(
                      height: 5.h
                      ,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     //   Text("Mobile No: ",
                    //     //     style: TextStyle(
                    //     //         fontFamily: 'transport', fontSize: 16)),
                    //     // Text(dInfoMobile,
                    //     //     style:   TextStyle(
                    //     //         fontFamily: 'transport', fontSize: 16)),
                    //   ],
                    // ),

                    Visibility(
                      visible: visibility,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Padding(
                            padding: EdgeInsets.only(right: 16.sp),
                            child: Text("Driving License No: ",
                                style: TextStyle(
                                    fontFamily: 'transport', fontSize: 16.sp)),
                          ),
                          Text(dInfoLicense,
                              style: TextStyle(
                                  fontFamily: 'transport', fontSize: 16.sp)),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 40.h),
           Text("Vehicles Information",
              style: TextStyle(fontFamily: 'transport', fontSize: 18.sp)),
           SizedBox(height: 10.h),
          Container(
            decoration: BoxDecoration(
                color: CustomColor.listColor,
                borderRadius: BorderRadius.circular(5.0.r)),
            child: Padding(
              padding:  EdgeInsets.all(8.0.sp),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Image(
                            image: AssetImage(vInfoImage),
                            width: 60.w,
                            height: 60.h,
                          ),
                        ],
                      ),
                       SizedBox(
                        width: 20.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(vInfoModel,
                              style:  TextStyle(
                                  fontFamily: 'transport', fontSize: 16.sp)),
                           SizedBox(
                            height: 5.h,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Padding(
                                padding: EdgeInsets.only(right: 26.h),
                                child: Text("Vehicle Owner Name: ",
                                    style: TextStyle(
                                        fontFamily: 'transport', fontSize: 16.sp)),
                              ),
                              Text(vInfoOwnerName,
                                  style: TextStyle(
                                      fontFamily: 'transport', fontSize: 14.sp)),
                               SizedBox(
                                height: 5.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text("Registration Number:",
                                      style: TextStyle(
                                          fontFamily: 'transport',
                                          fontSize: 16.sp)),
                                  Text(vInfoRegNo,
                                      style:  TextStyle(
                                          fontFamily: 'transport',
                                          fontSize: 14.sp)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
