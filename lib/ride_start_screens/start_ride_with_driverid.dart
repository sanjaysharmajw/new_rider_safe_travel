import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';
import 'package:ride_safe_travel/Utils/my_button.dart';
import 'package:ride_safe_travel/controller/ride_start_with_vehicleno_controller.dart';
import 'package:ride_safe_travel/controller/send_otp_controller.dart';
import 'package:ride_safe_travel/ride_start_screens/my_text_fieldform.dart';
import 'package:ride_safe_travel/ride_start_screens/start_ride_otp.dart';

import '../Language/custom_text_input_formatter.dart';

class StartRideWithDriverId extends StatefulWidget {

  const StartRideWithDriverId({Key? key}) : super(key: key);

  @override
  State<StartRideWithDriverId> createState() => _StartRideWithDriverIdState();

}

class _StartRideWithDriverIdState extends State<StartRideWithDriverId> {

  final apiController = Get.put(RideStartWithVehicleNoController());
  final driverName=TextEditingController();
  final driverMobile=TextEditingController();
  final vehicleId=TextEditingController();

  final ctrl1=TextEditingController();
  final ctrl2=TextEditingController();
  final ctrl3=TextEditingController();
  final ctrl4=TextEditingController();
  String? textValue;

  final formKey = GlobalKey<FormState>();

  LocationData? locationData;
  late Location location;


  @override
  void initState() {
    super.initState();
    locationFetch();
  }

  void locationFetch()async{
    location=Location();
    locationData=await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Start Ride"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: MyTextFieldForm(
                  hintText: 'Driver Name',
                  controller: driverName,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return "Enter Driver Name";
                    } else {
                      return null;
                    }
                  },
                  fontSize: 18,
                  readOnly: false,
                  onTap: () {},
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    engHindFormatter,
                    FilteringTextInputFormatter.deny('  '),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: MyTextFieldForm(
                  hintText: 'Driver Mobile',
                  controller: driverMobile,
                  maxLength: 10,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return "Enter Driver Mobile";
                    } else {
                      return null;
                    }
                  },
                  fontSize: 18,
                  readOnly: false,
                  onTap: () {},
                  keyboardType: TextInputType.number,
                  inputFormatters: [  FilteringTextInputFormatter.allow(
                      RegExp("[0-9]")),
                    FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.deny('  ')],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.characters,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontFamily: "Gilroy",fontSize: 18),
                        controller: ctrl1,
                        autofocus: true,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "Required";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "MH",
                          hintStyle: TextStyle(fontFamily: "Gilroy",fontSize: 18),
                          counterText: "",
                        ),
                        maxLength: 2,

                      ),
                    ),
                    Container(width: 10),
                    Flexible(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.center,
                        autofocus: true,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "Required";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(

                          hintText: "04",
                          hintStyle: TextStyle(fontFamily: "Gilroy",fontSize: 18),
                          counterText: "",
                        ),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontFamily: "Gilroy",fontSize: 18),
                        controller: ctrl2,
                        maxLength: 2,
                      ),
                    ),
                    Container(width: 10),
                    Flexible(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "Required";
                          } else {
                            return null;
                          }
                        },
                        textCapitalization: TextCapitalization.characters,
                        maxLength: 3,
                        textAlign: TextAlign.center,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: "ABC",
                          hintStyle: TextStyle(fontFamily: "Gilroy",fontSize: 18),
                          counterText: "",
                        ),
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontFamily: "Gilroy",fontSize: 18),
                        controller: ctrl3,
                      ),
                    ),
                    Container(width: 10),
                    Flexible(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "Required";
                          } else {
                            return null;
                          }
                        },
                        maxLength: 4,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "1234",
                          hintStyle: TextStyle(fontFamily: "Gilroy",fontSize: 18),
                          counterText: "",
                        ),
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        style: const TextStyle(fontFamily: "Gilroy",fontSize: 18),
                        controller: ctrl4,
                        onChanged: (value){
                          if(value.length==1){
                         textValue="000$value";
                          }else if(value.length==2){
                            textValue="00$value";
                          }
                          else if(value.length==3){
                            textValue="0$value";
                          }else if(value.length==4){
                            textValue=value;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              MyButton(
                  press: () {
                    String? controllerValue1=ctrl1.text.toString();
                    String? controllerValue2=ctrl2.text.toString();
                    String? controllerValue3=ctrl3.text.toString();
                    String? vehicleNo="$controllerValue1$controllerValue2$controllerValue3$textValue";
                    if (formKey.currentState!.validate()) {
                      resendOtpAPi(driverMobile.text.toString(),vehicleNo);
                    }
                  },
                  buttonText: 'Next'),
            ],
          ),
        ),
      ),
    ));
  }
  void resendOtpAPi(String mobile,vehicleNo) async {
    final otpApiController = Get.put(SendOtpController());
    await otpApiController.sendOtp(mobile).then((value) async {
      if (value != null) {
        if (value.status == true) {
          LoaderUtils.showToast(value.message);
          Get.to(StartOTPScreen(mobile: driverMobile.value.text.toString(), driverName: driverName.value.text.toString(),
              vehicleNo: vehicleNo));
        } else {
          LoaderUtils.showToast(value.message);
        }
      }
    });
  }

}
