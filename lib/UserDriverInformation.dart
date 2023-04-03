import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:majascan/majascan.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/DriverVehicleList.dart';
import 'package:ride_safe_travel/FamilyMemberAddScreen.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/Utils/view_image.dart';
import 'package:ride_safe_travel/bottom_nav/custom_bottom_navi.dart';
import 'package:ride_safe_travel/color_constant.dart';
import 'package:ride_safe_travel/custom_button.dart';
import 'package:ride_safe_travel/new_items/tracking_me_list.dart';
import 'package:ride_safe_travel/start_ride_map.dart';

import 'Error.dart';
import 'LoginModule/MainPage.dart';

import 'LoginModule/custom_color.dart';
import 'LoginModule/preferences.dart';
import 'UserVehiclesInfo.dart';

class UserDriverInformation extends StatefulWidget {
  String vehicleId = "";
  String driverId = "";
  String driverName = "";
  String driverMob = "";
  String driverLicense = "";
  String vOwnerName = "";
  String vRegNumber = "";
  String vPucvalidity = "";
  String vFitnessValidity = "";
  String vInsurance = "";
  String vModel = "";
  String dPhoto = "";
  String vPhoto = "";
  String totalComment = " ";
  num rating ;




  UserDriverInformation({Key? key,
    required this.vehicleId,required this.driverId,
    required this.driverName,required this.driverMob,
    required this.driverLicense,required this.vOwnerName,
    required this.vRegNumber,required this.vPucvalidity,
    required this.vFitnessValidity,required this.vInsurance,
    required this.vModel,required this.dPhoto,
    required this.vPhoto,required this.rating, required this.totalComment
  }) : super(key: key);

  @override
  State<UserDriverInformation> createState() => _UserDriverInformationState();
}

class _UserDriverInformationState extends State<UserDriverInformation> {

  var date = "";
  Timer? timer;
  var userId;
  late Location location;
  double? lat;
  double? lng;
  double drating = 0.0;

  @override
  void initState() {
    super.initState();
    locationMethod();
    sharePre();
    final now = DateTime.now();
    date = DateFormat('yMd').format(now);
    drating = widget.rating.toDouble();
  }


  void locationMethod() async {
    location = Location();
    location.onLocationChanged.listen((LocationData cLoc) async {
      lat = cLoc.latitude!;
      lng = cLoc.longitude!;
    });
  }

  void sharePre() async {
    await Preferences.setPreferences();
    userId = Preferences.getId(Preferences.id).toString();
    // Get.snackbar("Hit with time", userId);
  }

  bool checkBoxValue = false;
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return SafeArea(

        child: Scaffold(
          appBar: AppBar(
            backgroundColor: appBlue,
            elevation: 15,
            leading: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: IconButton(
                  onPressed: () {
                    Get.back(canPop: true);
                  },
                  icon: Icon(
                    Icons.arrow_back_sharp,
                    color: CustomColor.white,
                    size: 25,
                  )),
            ),

          ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(
                      height: 30,
                    ),
                    const Text("Driver Information",
                        style: TextStyle(fontFamily: 'transport', fontSize: 18)),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                     // scrollDirection: Axis.horizontal,
                      child: Container(
                        width: 350,
                        decoration: BoxDecoration(
                            color: CustomColor.listColor,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 250,top: 10),
                              child: SizedBox(
                                height: 25,
                                width: 25,
                                child: ClipOval(
                                  child: Material(
                                    color: Colors.lightBlue, // button color
                                    child: InkWell(
                                     // splashColor: Colors.green, // splash color
                                      onTap: () {}, // button pressed
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(widget.totalComment), // text
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 250,top: 10),
                              child: RatingBarIndicator(
                                rating: drating,
                                itemBuilder: (context, index) => Icon(Icons.star, color: Colors.lightBlue),
                                itemCount: 5,
                                itemSize: 15,
                                direction: Axis.horizontal,
                              ),
                            ),

                            Row(
                              children: [



                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: CustomColor.black,
                                        radius: 30,
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.white,
                                          child: ClipOval(
                                            child: (widget.dPhoto != null)
                                                ? Image.network(
                                              widget.dPhoto,
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            )
                                                : Image.asset('assets/user_avatar.png'),
                                          ),


                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(widget.driverName,
                                            style: const TextStyle(
                                                fontSize: 16, fontWeight: FontWeight.w400)),
                                        // Text(dInfoMobile,
                                        //     style: const TextStyle(
                                        //         fontFamily: 'transport', fontSize: 16)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [

                                        Text(widget.driverMob,
                                            style: const TextStyle(
                                                fontSize: 16,fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text("License No: ",
                                            style: TextStyle(
                                                 fontSize: 17,fontWeight: FontWeight.bold)),
                                        Text(widget.driverLicense,
                                            style: const TextStyle(
                                                fontSize: 16, fontWeight: FontWeight.w400)),
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
                    const SizedBox(height: 40),
                    const Text("Vehicles Information",
                        style: TextStyle(fontFamily: 'transport', fontSize: 18)),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: CustomColor.listColor,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: appBlack),
                                      borderRadius: const BorderRadius.all(Radius.circular(50))
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children:  [
                                      InkWell(
                                        onTap: (){
                                        },
                                        child:  ClipRRect(
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          borderRadius: const BorderRadius.all(Radius.circular(60)),
                                          child: CachedNetworkImage(
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.fill,
                                            imageUrl: widget.vPhoto,
                                            placeholder: (context, url) => const CircularProgressIndicator(
                                                color: appBlue,strokeWidth: 2),
                                            errorWidget: (context, url, error) =>
                                                Image.asset('images/car.png',width: 100,height: 100,fit: BoxFit.fill),
                                          ),


                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                               /* CircleAvatar(
                                  backgroundColor: CustomColor.black,
                                  radius: 30.0,
                                  child: CircleAvatar(
                                    radius: 29.0,
                                    backgroundColor: Colors.white,
                                    child: ClipOval(
                                      child: (widget.vPhoto.toString() != null)
                                          ? Image.network(
                                        widget.vPhoto.toString(),
                                        fit: BoxFit.cover,
                                      )
                                          : Image.asset('assets/car.png'),
                                    ),
                                  ),
                                ),*/
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(widget.vModel,
                                        style: const TextStyle(
                                             fontSize: 16, fontWeight: FontWeight.w400)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text("Owner Name: ",
                                        style: TextStyle(
                                            fontSize: 16,fontWeight: FontWeight.bold)),
                                    Text(widget.vOwnerName,
                                        style: const TextStyle(
                                            fontSize: 16,fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Registration Number: ",
                                    style:
                                    TextStyle( fontSize: 16,fontWeight: FontWeight.bold)),
                                Text(widget.vRegNumber,
                                    style:
                                    TextStyle( fontSize: 16,fontWeight: FontWeight.w400)),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("PUC Validity: ",
                                    style:
                                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                Text(widget.vPucvalidity,
                                    style: const TextStyle(
                                         fontSize: 16, fontWeight: FontWeight.w400)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Fitness Validity: ",
                                    style:
                                    TextStyle( fontSize: 16,fontWeight: FontWeight.bold)),
                                Text(widget.vFitnessValidity,
                                    style: const TextStyle(
                                         fontSize: 16,fontWeight: FontWeight.w400)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Insurance Validity: ",
                                    style:
                                    TextStyle( fontSize: 16,fontWeight: FontWeight.bold)),
                                Text(widget.vInsurance,
                                    style: const TextStyle(
                                        fontSize: 16,fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Details not matched ?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),

                                SizedBox(width: 40,),
                                Transform.scale(

                                  scale: 1.0,
                                  child: Checkbox(

                                      value: checkBoxValue,
                                      checkColor: CustomColor.white,
                                      activeColor: CustomColor.yellow,
                                      onChanged: (value){
                                        setState((){
                                          checkBoxValue = value!;
                                          checkBoxValue = true;
                                        });

                                      }),
                                )
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SizedBox(
                              child: Container(
                                height: 100,
                                decoration:  BoxDecoration (
                                  borderRadius:  BorderRadius.circular(8),
                                  border:  Border.all(color: appBlack),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20,top: 2),
                                  child: TextFormField(
                                    controller: commentController,

                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Write a Comment',
                                    ),
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Can\'t be empty';
                                      }
                                      if (text.length < 4) {
                                        return 'Too short';
                                      }
                                      return null;
                                    },
                                    // update the state variable when the text changes

                                  ),

                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 125,
                          height: 65,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomButton(press: () async{
                              OverlayLoadingProgress.start(context);
                              await userRideAdd(userId, widget.vehicleId.toString(), widget.driverId.toString());
                              setState(() {});
                            },
                                buttonText: "Next")
                           /* ElevatedButton(onPressed: () async{
                              OverlayLoadingProgress.start(context);
                              await userRideAdd(userId, widget.vehicleId.toString(), widget.driverId.toString());
                              setState(() {});
                            }, child: Text("Next", style: const
                            TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16),),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: CustomColor.yellow,
                                  foregroundColor: CustomColor.black),),*/
                          ),
                        ),
                        SizedBox(
                          width: 125,
                          height: 65,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomButton(press: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const CustomBottomNav())); //MainPage
                              setState(() {});
                            },
                                buttonText: "Cancel Ride")
                           /* ElevatedButton(onPressed: () async{
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const CustomBottomNav())); //MainPage
                              setState(() {});
                            }, child: Text("Cancel Ride", style:
                            TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16),),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: CustomColor.yellow,
                                  foregroundColor: CustomColor.black),),*/
                          ),
                        )
                      ],
                    ),
                   /* Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 65,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: ElevatedButton(
                            onPressed: () async{
                              OverlayLoadingProgress.start(context);
                              await userRideAdd(userId, widget.vehicleId.toString(), widget.driverId.toString());
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: CustomColor.yellow,
                                foregroundColor: CustomColor.black),
                            child: Text(
                              "Start Ride",
                              style: const TextStyle(
                                  fontFamily: "transport",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 65,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: ElevatedButton(
                            onPressed: () async{
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage()));
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: CustomColor.yellow,
                                foregroundColor: CustomColor.black),
                            child: Text(
                              "Cancel Ride",
                              style: const TextStyle(
                                  fontFamily: "transport",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ), */
                  ],
                ),
              ),
            ),
           /* UserVehicleInfo(
            dInfoName: widget.driverName.toString() == 'null' ? "Data not available" : widget.driverName.toString(),
                dInfoImage: widget.dPhoto.toString() == 'null' ? "Data not available" : widget.dPhoto.toString(),
                dInfoMobile: widget.driverMob.toString() == 'null' ? "Data not available" : widget.driverMob.toString(),
                dInfoLicense: widget.driverLicense.toString() == 'null' ? "Data not available" : widget.driverLicense.toString(),
                vInfoImage: widget.vPhoto.toString() == 'null' ? "Data not available" : widget.vPhoto.toString(),
                vInfoModel:  widget.vModel.toString() == 'null' ? "Data not available" : widget.vModel.toString(),
                vInfoOwnerName: widget.vOwnerName.toString() == 'null' ? "Data not available" : widget.vOwnerName.toString(),
                vInfoRegNo: widget.vRegNumber.toString() == 'null' ? "Data not available" : widget.vRegNumber.toString(),
                vInfoPuc: formatDate(widget.vPucvalidity.toString()) == 'null' ? "Data not available" : formatDate(widget.vPucvalidity.toString()),
    vInfoFitness: formatDate(widget.vFitnessValidity.toString()) == 'null' ? "Data not available" : formatDate(widget.vFitnessValidity.toString()),
    vInfoInsurance: formatDate(widget.vInsurance.toString()) == 'null' ? "Data not available" : formatDate(widget.vInsurance.toString()),
    press:  () {
    Get.to(MainPage());
    },
    pressBtn: () async {
        OverlayLoadingProgress.start(context);
        await userRideAdd(userId, widget.vehicleId.toString(), widget.driverId.toString());
        setState(() {});
    },
    pressBtnText: 'Start Ride',) */

          ],
        ),
      ),
    ));
  }

  String formatDate(String date) {
    final DateTime now = DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);
    return formatted;
  }

  Future<http.Response?> userFamilyList(
      String userId, rideId, socketToken, rideOtp) async {
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    final response = await http.post(
      Uri.parse('https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/userFamilyList'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': loginToken},
      body: jsonEncode(<String, String>{
        'user_id': userId,
      }),
    );
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      //var msg = jsonDecode(response.body)[ErrorMessage.message];
      if (status == true) {
        Get.to(
            TrackingMeList(
                riderId: rideId.toString(),
                dName: widget.driverName.toString() == 'null' ? "Data not available" : widget.driverName.toString(),
                dMobile: widget.driverMob.toString() == 'null' ? "Data not available" : widget.driverMob.toString(),
                dPhoto: widget.dPhoto.toString() == 'null' ? "Data not available" :  widget.dPhoto.toString(),
                model: widget.vModel.toString() == 'null' ? "Data not available" : widget.vModel.toString(),
                vOwnerName: widget.vOwnerName.toString() == 'null' ? "Data not available" : widget.vOwnerName.toString(),
                vRegNo: widget.vRegNumber.toString() == 'null' ? "Data not available" : widget.vRegNumber.toString(),
                socketToken: socketToken, driverLicense: widget.driverLicense.toString(),otpRide: rideOtp.toString())
        );

        // Get.to(
        //     StartRide(
        //     riderId: rideId.toString(),
        //     dName: widget.driverName.toString() == 'null' ? "Data not available" : widget.driverName.toString(),
        //     dMobile: widget.driverMob.toString() == 'null' ? "Data not available" : widget.driverMob.toString(),
        //     dPhoto: widget.dPhoto.toString() == 'null' ? "Data not available" :  widget.dPhoto.toString(),
        //     model: widget.vModel.toString() == 'null' ? "Data not available" : widget.vModel.toString(),
        //     vOwnerName: widget.vOwnerName.toString() == 'null' ? "Data not available" : widget.vOwnerName.toString(),
        //     vRegNo: widget.vRegNumber.toString() == 'null' ? "Data not available" : widget.vRegNumber.toString(),
        //     socketToken: socketToken, driverLicense: widget.driverLicense.toString(),otpRide: rideOtp.toString())
        // );
        OverlayLoadingProgress.stop();
        print("Userinformation" + widget.driverId + widget.vehicleId);
      } else {
        Get.to(FamilyMemberAddScreen(
            driverId: widget.driverId == 'null' ? "Data not available" : widget.driverId,
            vehicleId: widget.vehicleId == 'null' ? "Data not available" :  widget.vehicleId,
            riderId: rideId.toString(),
            dName: widget.driverName.toString() == 'null' ? "Data not available" : widget.driverName.toString(),
            dMobile: widget.driverMob.toString() == 'null' ? "Data not available" : widget.driverMob.toString(),
            dPhoto: widget.dPhoto.toString() == 'null' ? "Data not available" : widget.dPhoto.toString(),
            model: widget.vModel.toString() == 'null' ? "Data not available" : widget.vModel.toString(),
            vOwnerName: widget.vOwnerName.toString() == 'null' ? "Data not available" : widget.vOwnerName.toString(),
            vRegNo: widget.vRegNumber.toString() == 'null' ? "Data not available" : widget.vRegNumber.toString(),
            socketToken: socketToken, driverLicense: widget.driverLicense.toString(),otpRide: rideOtp.toString()));
        OverlayLoadingProgress.stop();
      }
      return null;
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<http.Response> userRideAdd(
      String userId, String vehicleId, String driverId) async {
    final response = await http.post(Uri.parse(ApiUrl.userRideAdd),
        body: json.encode({
          'user_id': userId,
          'vehicle_id': vehicleId,
          'driver_id': driverId,
          'date': date.toString(),
          'start_point': {
            'time': DateTime.now().millisecondsSinceEpoch.toString(),
            'latitude': lat,
            'longitude': lng,
            'location': "",
            "details_match_check":checkBoxValue,
            "details_match_comment": commentController.text.toString()
          }
        }));
    print(json.encode({
      'user_id': userId,
      'vehicle_id': vehicleId,
      'driver_id': driverId,
      'date': date,
      'start_point': {
        'time': DateTime.now().millisecondsSinceEpoch.toString(),
        'latitude': lat,
        'longitude': lng,
        'location': "",
        "details_match_check":checkBoxValue,
        "details_match_comment": commentController.text.toString()
      }
    }));

    print(response.body);
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      print("start Ride:" + response.body);
      if (status == true) {
        if (jsonDecode(response.body)['data'] != null) {
          var rideId = jsonDecode(response.body)['data'];
          var socketToken = jsonDecode(response.body)['sockettoken'];
          var rideOtp = jsonDecode(response.body)['ride_start_otp'];
          Preferences.setRideOtp(rideOtp.toString());
          await userFamilyList(userId, rideId, socketToken,rideOtp);
        }
      } else if (status == false) {
        // Get.snackbar(response.body, 'Failed');
      }
      return response;
    } else {
      print(response.body);
      throw Exception('Failed to create album.');
    }
  }
}
