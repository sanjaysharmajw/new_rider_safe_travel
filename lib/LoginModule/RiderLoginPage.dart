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
import 'package:ride_safe_travel/Utils/toast.dart';

class RiderLoginPage extends StatefulWidget {
  const RiderLoginPage({super.key});

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
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.keyboard_backspace_rounded,
                color: CustomColor.black,
                size: 30,
              )),
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
                  const Padding(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    child: Text("Login",
                        style: TextStyle(
                            fontSize: 21,
                            fontFamily: 'transport',
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 0, bottom: 0),
                              child: Image.asset('assets/phone.png',
                                  height: 25, width: 25),
                            ),
                            const Text(
                              "Enter Mobile Number",
                              style: TextStyle(
                                  fontFamily: 'transport', fontSize: 16),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15, left: 5),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 45,
                                  child: TextFormField(
                                    controller: _controllerMobile,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9]")),
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "transport"),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: const UnderlineInputBorder(),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: CustomColor.yellow),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.amberAccent),
                                      ),
                                      prefixIcon: Image.asset(
                                        "icons/flag.png",
                                        width: 50,
                                      ),
                                      prefixText: "+91",
                                      prefixStyle: const TextStyle(
                                          fontSize: 18,
                                          fontFamily: "transport",
                                          fontWeight: FontWeight.normal),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.length != 10) {
                                        return 'Please enter 10 digit number';
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
                    child: Button(
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
                        }),
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
    final response = await http.post(
      Uri.parse(
          'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/sendOtpNew'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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
        OverlayLoadingProgress.stop();
        ToastMessage.toast(msg);
        //Get.snackbar("Message", msg, snackPosition: SnackPosition.BOTTOM);
      }
      return null;
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
