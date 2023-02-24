import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../LoginModule/custom_color.dart';

void sim(BuildContext context, TextEditingController otpController,
    VoidCallback press) {
  final focusNode = FocusNode();
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.r),
      border: Border.all(color: Colors.yellow),
    ),
  );

  final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(
      color: CustomColor.yellow,
    ),
    borderRadius: BorderRadius.circular(5.r),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Expanded(
        child: AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
             const Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('Enter OTP'),
              )),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                  child: const Center(child: Icon(Icons.close))
              ),
            ],
          ),
          actions: [
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
            const SizedBox(height: 50),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColor.yellow),
                  onPressed: press,
                  child: const Text(
                    'Verify',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}
