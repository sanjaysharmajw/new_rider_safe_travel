import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/LoginModule/Error.dart';
import 'package:ride_safe_travel/LoginModule/RiderVerifyOtpPage.dart';
import 'package:ride_safe_travel/LoginModule/custom_button.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/Utils/toast.dart';

import '../color_constant.dart';
import '../custom_button.dart';

class RiderLoginPage extends StatefulWidget {
  RiderLoginPage({Key? key, }) : super(key: key);

  // const LoginScreenPage({Key? key}) : super(key: key);

  @override
  State<RiderLoginPage> createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<RiderLoginPage> {
  final TextEditingController _controllerMobile = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
         /* leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.keyboard_backspace_rounded,
                color: CustomColor.black,
                size: 30,
              )),  */
        ),
        backgroundColor: const Color(0xFFffffff),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    child: Text("login".tr,
                        style: TextStyle(
                            fontSize: 21,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 80,
                                  child: TextFormField(

                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9]")),
                                      FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                                      LengthLimitingTextInputFormatter(10),
                                      FilteringTextInputFormatter.deny('  ')
                                    ],
                                    style:  TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.normal,
                                    ),
                                    controller: _controllerMobile,
                                    keyboardType: TextInputType.number,
                                    decoration:  InputDecoration(
                                      labelText: "mobile_number".tr,
                                      labelStyle: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Gilroy',
                                        fontWeight: FontWeight.normal,
                                      ),
                                      prefixText: "+91",
                                      // hintText: widget.dlMobNumber ,
                                      border: UnderlineInputBorder(),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: appBlack)),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: appBlue),
                                      ),
                                    ),

                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.length != 10) {
                                        return 'please_enter_10_digit_number'.tr;
                                      }
                                      return null;
                                    },

                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ]),
                  const SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 17, right: 17),
                    child: CustomButton(press: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          OverlayLoadingProgress.start(context);
                        });
                        sendOtpApi(_controllerMobile.text.toString());
                        setState(() {});
                      }

                    }, buttonText: 'next'.tr,)

                    /*Button(
                        textColor: CustomColor.black,
                        size: 75,
                        buttonTitle: "Next",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              OverlayLoadingProgress.start(context);
                            });
                            sendOtpApi(_controllerMobile.text.toString());
                            setState(() {});
                          }
                        }),*/
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<http.Response?> sendOtpApi(String mobileNumber) async {
   // var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    final response =  await http.post(
      Uri.parse('https://l8olgbtnbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/sendOtpNew'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': loginToken
      },
      body: jsonEncode(<String, String>{
        'mobile_number': mobileNumber.toString(),
      }),
    );
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      if (status == true) {
        OverlayLoadingProgress.stop();

        Get.to(RiderVerifyOtpPage(mobileNumber: mobileNumber.toString()));
      } else {
        OverlayLoadingProgress;
        ToastMessage.toast(msg);
        //Get.snackbar("Message", msg, snackPosition: SnackPosition.BOTTOM);
      }
      return null;
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
