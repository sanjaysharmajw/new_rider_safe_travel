import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:location/location.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/Models/start_ride_details.dart';
import 'package:ride_safe_travel/MyText.dart';
import 'package:ride_safe_travel/Utils/toast.dart';
import 'package:ride_safe_travel/body_request/start_ride_request.dart';
import 'package:ride_safe_travel/controller/send_otp_controller.dart';
import 'package:ride_safe_travel/ride_start_screens/otp_pin.dart';
import 'package:ride_safe_travel/start_ride_map.dart';
import '../Utils/loader.dart';
import '../Utils/my_button.dart';
import '../color_constant.dart';
import '../controller/ride_start_with_vehicleno_controller.dart';

class StartOTPScreen extends StatefulWidget {
  final String driverName,vehicleNo,mobile;
  StartOTPScreen({Key? key, required this.mobile, required this.driverName, required this.vehicleNo}) : super(key: key);

  @override
  State<StartOTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<StartOTPScreen> {
  final otpController = TextEditingController();
  final otpApiController = Get.put(SendOtpController());
  final apiController = Get.put(RideStartWithVehicleNoController());
  OtpTimerButtonController controller = OtpTimerButtonController();
  final focusNode = FocusNode();
  LocationData? locationData;
  late Location location;

  requestOtp() {
    controller.loading();
    Future.delayed(const Duration(seconds: 2), () {
      resendOtpAPi(widget.mobile.toString());
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }


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
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  //const ImageSets(imagePath:'assets/back_icons.png', width: 50),
                  const SizedBox(height: 50),
                   MyText(
                      text: 'Enter OTP sent to your Mobile Number',
                      fontFamily: 'Gilroy',
                      fontSize: 18,
                      color: appBlack),
                  MyText(
                      text: '+91 - ${widget.mobile.toString()} (Edit?)',
                      fontFamily: 'Gilroy',
                      fontSize: 18,
                      color: appBlack),
                  const SizedBox(height: 50),
                  OTPPin(otpController: otpController, focusNode: focusNode),
                  const SizedBox(height: 10),
                  OtpTimerButton(
                    controller: controller,
                    height: 60,
                    text: const Text(
                      'Resend OTP',
                      style: TextStyle(fontFamily: 'Gilroy'),
                    ),
                    duration: 30,
                    radius: 30,
                    backgroundColor: appBlue,
                    textColor: appBlue,
                    buttonType:
                    ButtonType.text_button, // or ButtonType.outlined_button
                    loadingIndicator: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: appBlue,
                    ),
                    loadingIndicatorColor: appBlue,
                    onPressed: () {
                      requestOtp();
                    },
                  ),
                  MyButton(
                      press: () {
                        if (otpController.text.trim().isNotEmpty) {
                          verifyOTPApi(
                              widget.mobile, otpController.text.toString());
                        } else {
                          LoaderUtils.message('Enter 4 Digits OTP');
                        }
                      },
                      buttonText: 'Start Ride'),
                ],
              ),
            ),
          ),
        ));
  }

  void verifyOTPApi(String mobile, String otp) async {
    await otpApiController.verifyOtp(mobile, otp).then((value) async {
      if (value != null) {
        if (value.status==true) {
         // LoaderUtils.message(value.message.toString());
          startRideAPi();
        }else{
          ToastMessage.toast("Invalid OTP");
        }
      }
    });
  }

  void resendOtpAPi(String mobile) async {
    await otpApiController.sendOtp(mobile).then((value) async {
      if (value != null) {
        if (value.status == true) {
          LoaderUtils.showToast(value.message);
          controller.startTimer();
        } else {
          LoaderUtils.showToast(value.message);
        }
      }
    });
  }
  void startRideAPi() async {
    StartRideRequestForVehicle request = StartRideRequestForVehicle(
        userId: Preferences.getId(Preferences.id),
        vehicleNumber: widget.vehicleNo,
        driverName: widget.driverName,
        mobileNumber: widget.mobile.toString(),
        date: DateTime.now().millisecondsSinceEpoch.toString(),
        startPoint:StartPointForVehicle(
            time: DateTime.now().millisecondsSinceEpoch.toString(),
            latitude: locationData!.latitude,
            longitude: locationData!.longitude,
            location: ""
        )
    );
    await apiController.startRideWithVehicleId(request).then((value) {
      if(value!=null){
        if(value.status==true){
          LoaderUtils.message(value.message.toString());
          navigation(value);
        }
      }
    });
  }

  void navigation(StartRideDetails data){
    Get.to(StartRide(
      riderId: data.data.toString(),
      socketToken: data.sockettoken.toString(),
      dName: data.ridedetails![0].driverName.toString(),
      dMobile:
      data.ridedetails![0].driverMobileNumber.toString(),
      dPhoto: data.ridedetails![0].driverPhoto.toString(),
      model: data.ridedetails![0].vehicleModel.toString(),
      vOwnerName: data.ridedetails![0].ownerName.toString(),
      vRegNo: data.ridedetails![0].vehicleRegistrationNumber
          .toString(),
      driverLicense:
      data.ridedetails![0].drivingLicenceNumber.toString(),
      otpRide: data.ridedetails![0].rideStartOtp.toString(),
    ));
  }

}
