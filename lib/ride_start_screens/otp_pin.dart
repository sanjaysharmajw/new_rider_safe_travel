
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../color_constant.dart';

class OTPPin extends StatelessWidget {

  final TextEditingController otpController;
  final FocusNode focusNode;
  const OTPPin({Key? key, required this.otpController, required this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 50.w,
      textStyle:  TextStyle(
          fontSize: 25.sp,
          fontFamily: 'transport',
          color: appBlack,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(5.r),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: appBlue,
      ),
      borderRadius: BorderRadius.circular(5.r),
    );
    return  Center(
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
    );
  }
}
