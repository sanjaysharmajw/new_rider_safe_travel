import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:pinput/pinput.dart';
import 'package:ride_safe_travel/LoginModule/Error.dart';
import 'package:ride_safe_travel/LoginModule/MainPage.dart';
import 'package:ride_safe_travel/LoginModule/custom_button.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/LoginModule/riderNewRegisterLoginModel.dart';
import 'package:ride_safe_travel/Utils/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'RiderLoginPage.dart';

class RiderVerifyOtpPage extends StatefulWidget {
  RiderVerifyOtpPage({Key? key, required this.mobileNumber}) : super(key: key);

  String mobileNumber;

  @override
  State<RiderVerifyOtpPage> createState() => _NumberVerifyScreenPageState();
}

class _NumberVerifyScreenPageState extends State<RiderVerifyOtpPage> {
  OtpTimerButtonController timercontroller = OtpTimerButtonController();
  final otpController = TextEditingController();
  final focusNode = FocusNode();
  String? fcmToken;
  _requestOtp() {
    timercontroller.loading();
    Future.delayed(const Duration(seconds: 2), () {
      timercontroller.startTimer();
    });

    sendOtpApi(widget.mobileNumber.toString());
  }
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: Colors.red),
    ),
  );
  final TextEditingController mobileController = TextEditingController();
  void initState() {
    mobileController.text=widget.mobileNumber.toString();
    super.initState();
    firebaseToken();
  }
  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
  void firebaseToken()async{
    fcmToken = await FirebaseMessaging.instance.getToken();
      ToastMessage.toast(fcmToken.toString());
      print("Firebase Token: $fcmToken");

  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    final defaultPinTheme = PinTheme(
      width: 60.w,
      height: 60.w,
      textStyle:  TextStyle(
          fontSize: 25.sp,
          fontFamily: 'transport',
          color: CustomColor.black,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(5.r),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: CustomColor.yellow,
      ),
      borderRadius: BorderRadius.circular(5.r),
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: const Color(0xFFffffff),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding:  EdgeInsets.only(left: 40, right: 40),
            child: Form(
              // key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Verify Mobile Number",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: 'transport',
                          fontWeight: FontWeight.bold)),
                   SizedBox(
                    height: 15.h,
                  ),
                   Text(
                    "Enter 4 digit verification code sent to",
                    style: TextStyle(
                        fontFamily: "transport",
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp),
                  ),
                   SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "your mobile number ",
                        style: TextStyle(
                            fontFamily: "transport",
                            fontWeight: FontWeight.w400,
                            fontSize: 15.sp),
                      ),
                      Text(
                        mobileController.text.toString(),
                        style: TextStyle(
                            fontFamily: "transport",
                            fontWeight: FontWeight.w400,
                            fontSize: 13.sp),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(RiderLoginPage());
                        },
                        child: Text(
                          '  Edit',
                          style: TextStyle(
                              color: CustomColor.yellow,
                              fontFamily: "transport",
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  SizedBox(
                    width: 260.w,
                    child: Text(
                      "Enter OTP here",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "transport",
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: Pinput(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      defaultPinTheme: defaultPinTheme,
                      controller: otpController,
                      length: 4,
                      focusedPinTheme: focusedPinTheme,
                      focusNode: focusNode,
                      androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsUserConsentApi,
                      listenForMultipleSmsOnAndroid: true,
                      // submittedPinTheme: submittedPinTheme,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                    ),
                  ),
                   SizedBox(
                    height: 20.h,
                  ),
                   Padding(
                     padding: EdgeInsets.only(left: 25,right: 20),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [

                       SizedBox(
                         child: Text(
                           "Didn't receive OTP ? ",
                           textAlign: TextAlign.left,
                           style: TextStyle(
                             fontFamily: "transport",
                             fontWeight: FontWeight.w400,
                             fontSize: 14.sp,
                           ),
                         ),
                       ),
                       Column(
                         children: [
                           OtpTimerButton(
                             controller: timercontroller,
                             onPressed: () => _requestOtp(),
                             text:  Text(
                               'RESEND OTP',
                               style: TextStyle(
                                   fontFamily: "transport",
                                   fontSize: 12.sp,
                                   color: Colors.red),
                             ),
                             duration: 15,
                             backgroundColor: CustomColor.white,
                             //textColor: Colors.indigo,
                             buttonType: ButtonType.text_button,
                             // or ButtonType.outlined_button
                             loadingIndicator: const CircularProgressIndicator(
                               strokeWidth: 2,
                               color: Colors.red,
                             ),
                           ),
                         ],
                       ),
                     ]),
                   ),


                   SizedBox(
                    height: 70.h,
                  ),
                  Button(
                      textColor: CustomColor.black,
                      size: 75,
                      buttonTitle: "VERIFY NUMBER",
                      onPressed: () async {
                        setState(() {
                          OverlayLoadingProgress.start(context);
                        });
                        await new_VerifyOtpApi(mobileController.text.toString(),
                            otpController.text.toString());
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<http.Response?> new_VerifyOtpApi(
      String mobileNumber, String otp) async {
    final response = await http.post(
      Uri.parse(
          'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/verifyOtp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'mobile_number': mobileNumber, "otp": otp}),
    );
    print(jsonEncode(
        <String, String>{'mobile_number': mobileNumber, "otp": otp}));
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      if (status == true) {
        OverlayLoadingProgress.stop();
        //Get.snackbar("Message", msg, snackPosition: SnackPosition.BOTTOM);
        ToastMessage.toast(msg);
        await regUserNew(mobileNumber.toString());
      } else {
        OverlayLoadingProgress.stop();
        ToastMessage.toast(msg);
       // Get.snackbar("Message", msg, snackPosition: SnackPosition.BOTTOM);
      }
      return null;
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<http.Response?> sendOtpApi(String mobileNumber) async {
    final response = await http.post(
      Uri.parse(
          'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/sendOtpNew'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mobile_number': mobileNumber,
      }),
    );
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      if (status == true) {
        OverlayLoadingProgress.stop();
        //Get.snackbar("Message", msg, snackPosition: SnackPosition.BOTTOM);
        ToastMessage.toast(msg);
        Get.to(RiderVerifyOtpPage(mobileNumber: mobileNumber.toString()));
      } else {
        OverlayLoadingProgress.stop();
        //Get.snackbar("Message", msg, snackPosition: SnackPosition.BOTTOM);
      }
      return null;
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<Data> regUserNew(String mobileNumber) async {
    final response = await http.post(
      Uri.parse(
          'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/regUserNew'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mobile_number': mobileNumber.toString(),
        'fcmtoken': fcmToken.toString(),
      }),
    );
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      //var msg = jsonDecode(response.body)[ErrorMessage.message];
      if (status == true) {
        OverlayLoadingProgress.stop();
        List<Data> loginData = jsonDecode(response.body)['data']
            .map<Data>((data) => Data.fromJson(data))
            .toList();
        var id = loginData[0].id;
        var firstname = loginData[0].firstName;
        var lastname = loginData[0].lastName;
        var emailId = loginData[0].emailId;
        var mobileNumber = loginData[0].mobileNumber;
        var profileImage = loginData[0].profileImage;
        var userType = loginData[0].userType;

        print("UserId"+id! +
            firstname.toString()+
            lastname.toString() +
            emailId.toString() +
            mobileNumber.toString() +
            profileImage.toString());
        await Preferences.setPreferences();
        Preferences.setId(Preferences.id, id);
        Preferences.setFirstName(Preferences.firstname, firstname.toString());
        Preferences.setLastName(Preferences.lastname, lastname.toString());
        Preferences.setEmailID(Preferences.emailId, emailId.toString());
        Preferences.setMobileNumber(Preferences.mobileNumber, mobileNumber.toString());
        Preferences.setUserType(Preferences.userType, userType.toString());
        Preferences.setProfileImage(profileImage.toString());
        Get.to(const MainPage());
        ToastMessage.toast("Successful");
      } else {
        OverlayLoadingProgress.stop();
        ToastMessage.toast("Failed");
      }
      return Data.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
