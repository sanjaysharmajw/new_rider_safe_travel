import 'dart:async';
import 'dart:convert';


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
import 'UserFamilyList.dart';
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
  String rating ;




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
  String? insurance;
  String? puc;
  String? fitness;


  @override
  void initState() {
    super.initState();
    locationMethod();
    sharePre();
    final now = DateTime.now();
    date = DateFormat('yMd').format(now);
    drating = double.parse(widget.rating.toString());
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
    /*DateFormat formatter = DateFormat.yMMMd(); // use any format
     insurance = formatter.format(DateTime.parse(widget.vInsurance));
    print(insurance);
    puc = formatter.format(DateTime.parse(widget.vPucvalidity));
    print(puc);
     fitness = formatter.format(DateTime.parse(widget.vFitnessValidity));
    print(fitness);*/

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
                        style: TextStyle(fontFamily: 'Gilroy', fontSize: 18)),
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

                                        ClipRRect(
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          borderRadius: const BorderRadius.all(Radius.circular(60)),
                                          child: CachedNetworkImage(
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.fill,
                                            imageUrl: widget.dPhoto,
                                            placeholder: (context, url) => const CircularProgressIndicator(
                                                color: appBlue,strokeWidth: 2),
                                            errorWidget: (context, url, error) =>
                                                Image.asset('assets/user_avatar.png',width: 100,height: 100,fit: BoxFit.fill),
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
                                      children: [
                                        Text(widget.driverName,
                                            style: const TextStyle(
                                                fontSize: 16, fontWeight: FontWeight.w400),
                                        overflow: TextOverflow.ellipsis,),

                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [

                                        Text(widget.driverMob.toString() == "null" ? " " : widget.driverMob,
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
                                        Text(widget.driverLicense.toString() == "null" ? " " : widget.driverLicense,
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
                        style: TextStyle(fontFamily: 'Gilroy', fontSize: 18)),
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
                                Flexible(
                                  child: Text(widget.vRegNumber,
                                      style:
                                      TextStyle( fontSize: 16,fontWeight: FontWeight.w400)),
                                )

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
                                Text(widget.vPucvalidity.toString(),
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
                                Text(widget.vFitnessValidity.toString(),
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
                                Text(widget.vInsurance.toString(),
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
                                Text("Details not matched ?", style: TextStyle(fontFamily: 'Gilroy', fontSize: 18)),

                                SizedBox(width: 20,),
                                Transform.scale(

                                  scale: 1.0,
                                  child: Checkbox(

                                      value: checkBoxValue,
                                      checkColor: appWhiteColor,
                                      activeColor: appBlue,
                                      onChanged: (value){
                                        setState((){
                                          checkBoxValue = value!;
                                         // checkBoxValue = true;
                                        });

                                      }),
                                )
                              ],
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: 20,top: 2),
                            child:  TextFormField(

                              controller: commentController,
                              style: TextStyle(fontFamily: 'Gilroy',fontSize: 16),
                              cursorColor: appBlack,
                              maxLines: 3,
                              minLines: 3,
                              decoration: InputDecoration(
                                hintText: 'Write a Comment',
                                hintStyle: const TextStyle(color: appBlack),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                  const BorderSide(color: appBlack, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                  const BorderSide(color: appBlack, width: 1),
                                ),

                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Can\'t be empty';
                                }
                                if (text.length < 4) {
                                  return 'Too short';
                                }
                                return null;
                              },

                            ),



                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        SizedBox(
                          width: 150,
                          height: 65,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomButton(press: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const CustomBottomNav())); //MainPage
                              setState(() {});
                            },
                                buttonText: "Cancel Ride")

                          ),
                        ),
                        SizedBox(
                          width: 150,
                          height: 65,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomButton(press: () async{
                                OverlayLoadingProgress.start(context);
                                await userRideAdd(userId, widget.vehicleId.toString(), widget.driverId.toString());
                                setState(() {});
                              },
                                  buttonText: "Next")

                          ),
                        )
                      ],
                    ),

                  ],
                ),
              ),
            ),


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
      Uri.parse(ApiUrl.userFamilyList),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': loginToken},
      body: jsonEncode(<String, String>{
        'user_id': userId,
      }),
    );
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      //var msg = jsonDecode(response.body)[ErrorMessage.message];
      if (status == true) {
        //Get.to(FamilyList()
        Get.to(
            TrackingMeList(
                riderId: rideId.toString(),
                dName: widget.driverName.toString() == 'null' ? "" : widget.driverName.toString(),
                dMobile: widget.driverMob.toString() == 'null' ? "" : widget.driverMob.toString(),
                dPhoto: widget.dPhoto.toString() == 'null' ? "" :  widget.dPhoto.toString(),
                model: widget.vModel.toString() == 'null' ? "" : widget.vModel.toString(),
                vOwnerName: widget.vOwnerName.toString() == 'null' ? "" : widget.vOwnerName.toString(),
                vRegNo: widget.vRegNumber.toString() == 'null' ? "" : widget.vRegNumber.toString(),
                socketToken: socketToken, driverLicense: widget.driverLicense.toString(),otpRide: rideOtp.toString())
        );


        OverlayLoadingProgress.stop();
        print("Userinformation" + widget.driverId + widget.vehicleId);
      } else {
        Get.to(FamilyMemberAddScreen(
            driverId: widget.driverId == 'null' ? "" : widget.driverId,
            vehicleId: widget.vehicleId == 'null' ? "" :  widget.vehicleId,
            riderId: rideId.toString(),
            dName: widget.driverName.toString() == 'null' ? "" : widget.driverName.toString(),
            dMobile: widget.driverMob.toString() == 'null' ? "" : widget.driverMob.toString(),
            dPhoto: widget.dPhoto.toString() == 'null' ? "" : widget.dPhoto.toString(),
            model: widget.vModel.toString() == 'null' ? "" : widget.vModel.toString(),
            vOwnerName: widget.vOwnerName.toString() == 'null' ? "" : widget.vOwnerName.toString(),
            vRegNo: widget.vRegNumber.toString() == 'null' ? "" : widget.vRegNumber.toString(),
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
