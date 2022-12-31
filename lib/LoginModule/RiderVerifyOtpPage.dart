import 'dart:convert';
import 'package:flutter/material.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class RiderVerifyOtpPage extends StatefulWidget {
  RiderVerifyOtpPage({Key? key, required this.mobileNumber}) : super(key: key);

  String mobileNumber;

  @override
  State<RiderVerifyOtpPage> createState() => _NumberVerifyScreenPageState();
}

class _NumberVerifyScreenPageState extends State<RiderVerifyOtpPage> {
  OtpTimerButtonController timercontroller = OtpTimerButtonController();
  final otpController = TextEditingController();

  _requestOtp() {
    timercontroller.loading();
    Future.delayed(const Duration(seconds: 2), () {
      timercontroller.startTimer();
    });

    sendOtpApi(widget.mobileNumber.toString());
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 100,
      height: 50,
      textStyle: const TextStyle(
          fontSize: 25,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: const Color.fromRGBO(114, 178, 238, 1),
      ),
      borderRadius: BorderRadius.circular(8),
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
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Form(
              // key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Verify Mobile Number",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'transport',
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Enter 4 digit verification code set to",
                    style: TextStyle(
                        fontFamily: "transport",
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Text(
                        "your mobile number ",
                        style: TextStyle(
                            fontFamily: "transport",
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                      Text(
                        widget.mobileNumber.toString(),
                        style: const TextStyle(
                            fontFamily: "transport",
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                      InkWell(
                        onTap: () {
                          //Get.to(const RiderLoginPage());
                        },
                        child: const Text(
                          '  Edit',
                          style: TextStyle(
                              color: CustomColor.yellow,
                              fontFamily: "transport",
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  const SizedBox(
                    width: 315,
                    child: Text(
                      "Enter OTP here",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "transport",
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Pinput(
                      controller: otpController,
                      length: 4,
                      focusedPinTheme: focusedPinTheme,
                      // submittedPinTheme: submittedPinTheme,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: 300,
                    child: Text(
                      "Didn't receive OTP ? ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "transport",
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OtpTimerButton(
                        controller: timercontroller,
                        onPressed: () => _requestOtp(),
                        text: const Text(
                          'RESEND OTP',
                          style: TextStyle(
                              fontFamily: "transport",
                              fontSize: 15,
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
                  const SizedBox(
                    height: 70,
                  ),
                  Button(
                      textColor: CustomColor.black,
                      size: 75,
                      buttonTitle: "VERIFY NUMBER",
                      onPressed: () async {
                        setState(() {
                          OverlayLoadingProgress.start(context);
                        });
                        await new_VerifyOtpApi(widget.mobileNumber.toString(),
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
        OverlayLoadingProgress.stop(context);
        Get.snackbar("Message", msg, snackPosition: SnackPosition.BOTTOM);
        await regUserNew(mobileNumber.toString());
      } else {
        OverlayLoadingProgress.stop(context);
        Get.snackbar("Message", msg, snackPosition: SnackPosition.BOTTOM);
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
        OverlayLoadingProgress.stop(context);
        Get.snackbar("Message", msg, snackPosition: SnackPosition.BOTTOM);
        Get.to(RiderVerifyOtpPage(mobileNumber: mobileNumber.toString()));
      } else {
        OverlayLoadingProgress.stop(context);
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
      }),
    );
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      //var msg = jsonDecode(response.body)[ErrorMessage.message];
      if (status == true) {
        OverlayLoadingProgress.stop(context);

        OverlayLoadingProgress.stop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("asdfghjk")),
        );

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
            firstname! +
            lastname! +
            emailId! +
            mobileNumber! +
            profileImage!);
        await Preferences.setPreferences();
        Preferences.setId(Preferences.id, id);
        Preferences.setFirstName(Preferences.firstname, firstname);
        Preferences.setLastName(Preferences.lastname, lastname);
        Preferences.setEmailID(Preferences.emailId, emailId);
        Preferences.setMobileNumber(Preferences.mobileNumber, mobileNumber);
        Preferences.setUserType(Preferences.userType, userType!);
        Preferences.setProfileImage(profileImage);
        Get.to(const MainPage());
        Get.snackbar("Message", "Successful", snackPosition: SnackPosition.BOTTOM);
      } else {
        OverlayLoadingProgress.stop(context);
        Get.snackbar("Message", "wertyuio",
            snackPosition: SnackPosition.BOTTOM);
      }
      return Data.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
