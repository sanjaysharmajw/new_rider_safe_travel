import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';
import 'package:ride_safe_travel/Utils/my_button.dart';
import 'package:ride_safe_travel/body_request/start_ride_request.dart';
import 'package:ride_safe_travel/controller/demo.dart';
import 'package:ride_safe_travel/controller/location_controller.dart';
import 'package:ride_safe_travel/controller/ride_start_with_vehicleno_controller.dart';
import 'package:ride_safe_travel/controller/send_otp_controller.dart';
import 'package:ride_safe_travel/ride_start_screens/my_text_fieldform.dart';
import 'package:ride_safe_travel/ride_start_screens/start_ride_otp.dart';

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
                  keyboardType: TextInputType.text,
                  inputFormatters: null,
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
                  inputFormatters: null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: MyTextFieldForm(
                  hintText: 'Vehicle No',
                  controller: vehicleId,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return "Enter Vehicle No";
                    } else {
                      return null;
                    }
                  },
                  fontSize: 18,
                  readOnly: false,
                  onTap: () {},
                  keyboardType: TextInputType.text,
                  inputFormatters: null,
                ),
              ),
              MyButton(
                  press: () {
                    if (formKey.currentState!.validate()) {
                      resendOtpAPi(driverMobile.toString());
                    }
                  },
                  buttonText: 'Next'),
            ],
          ),
        ),
      ),
    ));
  }
  void resendOtpAPi(String mobile) async {
    final otpApiController = Get.put(SendOtpController());
    await otpApiController.sendOtp(mobile).then((value) async {
      if (value != null) {
        if (value.status == true) {
          LoaderUtils.showToast(value.message);
          Get.to(StartOTPScreen(mobile: driverMobile.value.text.toString(), driverName: driverName.value.text.toString(),
              vehicleNo: vehicleId.value.text.toString()));
        } else {
          LoaderUtils.showToast(value.message);
        }
      }
    });
  }

}
