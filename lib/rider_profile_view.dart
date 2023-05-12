import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/color_constant.dart';
import 'package:ride_safe_travel/riderData.dart';
import 'package:ride_safe_travel/rider_profile_edit.dart';

import 'Error.dart';
import 'LoginModule/Api_Url.dart';
import 'LoginModule/custom_color.dart';
import 'LoginModule/preferences.dart';
import 'Models/CityModel.dart';
import 'Models/StateModel.dart';
import 'MyText.dart';
import 'MyTextField.dart';
import 'ProfileWidget.dart';
import 'RiderUserListData.dart';


class RiderProfileView extends StatefulWidget {
  String backbutton;
  RiderProfileView({Key? key, required this.backbutton}) : super(key: key);

  @override
  State<RiderProfileView> createState() => _RiderProfileViewState();
}

class _RiderProfileViewState extends State<RiderProfileView> {


  String radioButtonItem = "";
  int id = 1;
  String type = "";

  // late Future<DateTime?> selectedDate;
  String date = "";
  String from = "";

  DateTime selectedDate = DateTime.now();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  //var mobile=Preferences.getMobileNumber(Preferences.mobileNumber);
  File? imageTemp;
 // var myState;
  String profileImage="";
  String mystate="";
  String mycity="";

  @override
  void initState() {
    //OverlayLoadingProgress.stop(context);
//profileImage=Preferences.getImage(Preferences.image).toString();
//print(profileImage);
//print("@@@@@@@@@@@@@@@@@@@@@@@22");

   // statesList();
    expiryDateController.text = "";
    super.initState();
    Random random = Random();
    int randomNumber = random.nextInt(1000000);
    stringRandomNumber = randomNumber.toString();
    setState((){
      _future = getRiderData();
    });

    Timer(
        const Duration(seconds: 1),
            () => getRiderData(),
    );

  }

  String result = "wait Navigator.pop";
  var stringRandomNumber;
  final _formKey = GlobalKey<FormState>();
  var emailController = new TextEditingController();
  var dobController = new TextEditingController();
  var genderController = new TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController emergencyContactController = TextEditingController();
  final TextEditingController emergencyContact1Controller = TextEditingController();
  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController contactPerson1Controller = TextEditingController();
  final TextEditingController bloodgroupController = TextEditingController();


  late Future<List<RiderUserListData>> futurePost;

  var _future;

  String? emergencyContact1;
  String? contactPerson;
  String? contactPerson1;
  String? bloodgroup;
  String? emergencyContact;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: (widget.backbutton == 'bottomNav') ? CustomColor.white : appBlue,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: IconButton(
              onPressed: () {
                Get.back(canPop: true);
              },
              icon: const Icon(
                Icons.arrow_back_sharp,
                color: CustomColor.white,
                size: 25,
              )),
        ),
        title: Text("your_profile".tr,style: TextStyle(fontFamily: "Gilroy",fontSize: 22,color: Colors.white),),

      ),
        body: FutureBuilder<List<RiderData>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                 profileImage= "${snapshot.data![index].profileImage}";
                  //mystate="${snapshot.data![index].presentAddress?.state.toString()}";
                  //mycity="${snapshot.data![index].presentAddress?.city.toString()}";
                // print(mycity+" "+mystate);
                 print(snapshot.data?.length);
                 print("@@@@@@@@@@@@@@@@@@@@@@@@@@");
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*Padding(
                          padding: EdgeInsets.only(left: 20.sp, top: 30.sp),
                          child: Text(
                            "Your profile",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Gilroy",
                                color: CustomColor.black),
                          ),
                        ),*/
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,),
                          child: ProfileWidget(profileName:"${snapshot.data![index].firstName.toString()} ${snapshot.data![index].lastName.toString()}"  == "null" ? " " :
                          "${snapshot.data![index].firstName.toString()} ${snapshot.data![index].lastName.toString()}",
                              profileMobile:  '${snapshot.data![index].mobileNumber.toString()}' == "null" ? " " : '${snapshot.data![index].mobileNumber.toString()}',
                              onPress: () async {
                                OverlayLoadingProgress.start(context);
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                     RiderProfileEdit(birthdate: '${snapshot.data![index].dob.toString()}' == "null" ? " " : '${snapshot.data![index].dob}',
                                       address: '${snapshot.data![index].presentAddress?.address.toString()}' == "null" ? " " : '${snapshot.data![index].presentAddress?.address.toString()}',
                                       pincode: '${snapshot.data![index].presentAddress?.pincode.toString()}' == "null" ? " " : '${snapshot.data![index].presentAddress?.pincode.toString()}',
                                       city: '${snapshot.data![index].presentAddress?.city.toString()}' == "null" ? " " : '${snapshot.data![index].presentAddress?.city.toString()}',
                                       state:'${snapshot.data![index].presentAddress?.state.toString()}' == "null" ? " " : '${snapshot.data![index].presentAddress?.state.toString()}',
                                       emailId: '${snapshot.data![index].emailId.toString()}' == "null" ? " " : '${snapshot.data![index].emailId.toString()}',
                                       lastname: '${snapshot.data![index].lastName.toString()}' == "null" ? " " : '${snapshot.data![index].lastName.toString()}',
                                       firstname: '${snapshot.data![index].firstName.toString()}' == "null" ? " " : '${snapshot.data![index].firstName.toString()}',
                                       mobileNumber: '${snapshot.data![index].mobileNumber.toString()}' == "null" ? " " : '${snapshot.data![index].mobileNumber.toString()}',
                                       imageProfile: profileImage,
                                       gender: '${snapshot.data![index].gender.toString()}' == "null" ? " " : '${snapshot.data![index].gender.toString()}',
                                       emergencyContact:  '${snapshot.data![index].emergencyContact.toString()}' == "null" ? " " : '${snapshot.data![index].emergencyContact.toString()}',
                                       bloodgroup: '${snapshot.data![index].bloodGroup.toString()}' == "null" ? " " : '${snapshot.data![index].bloodGroup.toString()}',
                                       contactPerson: '${snapshot.data![index].personName.toString()}' == "null" ? " " : '${snapshot.data![index].personName.toString()}',
                                       emergencyContact1: '${snapshot.data![index].emergencyNumber1.toString()}' == "null" ? " " : '${snapshot.data![index].emergencyNumber1.toString()}',
                                       contactPerson1: '${snapshot.data![index].personName1.toString()}' == "null" ? " " : '${snapshot.data![index].personName1.toString()}',
                                       backbutton: '', )
                                 ))
                                     .then((value) {

                                  setState(() {
                                  });
                                  return value;
                                });
                                },
                              assetsPath: profileImage,
                            progressIndicator: snapshot.data![index].profile_percentage ?? 100,
                            progressValue: snapshot.data![index].profile_percentage.toString() == "null" ? "100" :  snapshot.data![index].profile_percentage.toString(),

                          ),
                        ),
                        // const Padding(
                        //   padding: EdgeInsets.only(left: 20,top: 10),
                        //   child: Text(
                        //     "Rider Profile",
                        //     style: TextStyle(
                        //         fontSize: 18,
                        //         fontWeight: FontWeight.bold,
                        //         color: CustomColor.riderprofileColor),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 12,
                        // ),
                        // Row(
                        //   children: [
                        //     Padding(
                        //       padding: EdgeInsets.only(left: 20),
                        //       child: CircleAvatar(
                        //         backgroundImage: AssetImage('assets/Ellipse 1.png'),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 14,
                        //     ),
                        //     Column(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           "Vaishali Tanna",
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 15,
                        //               color: CustomColor.riderprofileColor),
                        //         ),
                        //         SizedBox(
                        //           height: 5,
                        //         ),
                        //         Text(
                        //           "+91 -9356432543",
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 15,
                        //               color: CustomColor.text),
                        //         ),
                        //       ],
                        //     ),
                        //     SizedBox(
                        //       width: 64,
                        //     ),
                        //     Container(
                        //       width: 110.0,
                        //       height: 40.0,
                        //       child: ElevatedButton(
                        //         onPressed: () {
                        //           Get.to(RiderProfile());
                        //         },
                        //         style: ElevatedButton.styleFrom(
                        //           shape: StadiumBorder(),
                        //           backgroundColor: CustomColor.yellow,
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //           children: const <Widget>[
                        //             Text(
                        //               'Edit Profile',
                        //               textAlign: TextAlign.start,
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.bold,
                        //                   fontSize:12,
                        //                   color: CustomColor.riderprofileColor),
                        //             ),
                        //             Image(image: AssetImage('assets/Union (1).png'),width: 10,height: 12,)
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 5, top: 0, bottom: 0),
                                  child:  Icon(Icons.email_outlined),
                                ),
                                Container(
                                  width: 115,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 35),
                                    child: Text(
                                      "email_id".tr,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Gilroy",
                                          color: CustomColor.riderprofileColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                           // VerticalDivider(width: 55.0),
                            Expanded(

                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: TextFormField(
                                    readOnly: true,
                                    validator: (value) {
                                      if (value == null) {
                                        return 'please_enter_your_emailId.'.tr;
                                      }
                                      return null;
                                    },

                                    style:  TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Gilroy",
                                        color: CustomColor.riderprofileColor),
                                    keyboardType: TextInputType.emailAddress,
                                    maxLines: 1,
                                    controller: emailController,
                                    decoration:  InputDecoration(

                                      enabled: false,
                                      hintText:  '${snapshot.data![index].emailId.toString()}' == "null" ? " " : '${snapshot.data![index].emailId.toString()}',
                                      hintStyle: TextStyle(
                                          fontSize: 13.sp,

                                          fontFamily: "Gilroy",
                                          color: CustomColor.riderprofileColor),
                                      border: UnderlineInputBorder(),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: CustomColor.yellow)),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.amberAccent),
                                      ),
                                    ),
                                  ),
                                )),

                          ],
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 5, top: 0, bottom: 0),
                                  child: Image.asset('images/calendar.png',
                                      height: 22, width: 25),
                                ),
                                Container(
                                  width: 115,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 50),
                                    child: Text(
                                      "dob".tr,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Gilroy",
                                          color: CustomColor.riderprofileColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          //  VerticalDivider(width: 78.0),
                            Expanded(

                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 10),
                                            child: TextFormField(
                                              // keyboardType: TextInputType.number,
                                              style:  TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Gilroy",
                                                  color: CustomColor.riderprofileColor),
                                              maxLines: 1,
                                              controller: _dateController,
                                              decoration:  InputDecoration(
                                                enabled: false,
                                                hintText: this.formatDate('${snapshot.data![index].dob.toString()}' == "null" ? " " : '${snapshot.data![index].dob.toString()}'),
                                                hintStyle: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Gilroy",
                  color: CustomColor.riderprofileColor),
                                                border: UnderlineInputBorder(),
                                                enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: CustomColor.yellow)),
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: Colors.amberAccent),
                                                ),

                                              ),
                                              readOnly: true,
                                              onTap: () async {
                                                _selectDate(context);
                                              },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty ){
                                                  return 'please_enter_your_date_of_birth'.tr;
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                          ],
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 5, top: 0, bottom: 0),
                                  child:  Icon(Icons.location_city_outlined)
                                ),
                                Container(
                                  width: 115,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 50),
                                    child: Text(
                                      "state".tr,
                                      style:
                                      TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Gilroy",
                                          color: CustomColor.riderprofileColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //VerticalDivider(width: 75.0),
                            Expanded(

                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null) {
                                      return 'please_enter_your_state_name'.tr;
                                    }
                                    return null;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[A-Za-z]")),
                                   // LengthLimitingTextInputFormatter(6),
                                  ],
                                  style:  TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Gilroy",
                                      color: CustomColor.riderprofileColor),
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  controller: stateController,
                                  decoration:  InputDecoration(
                                    enabled: false,
                                    hintText:  '${snapshot.data![index].presentAddress?.state.toString()}' == "null" ? " " : '${snapshot.data![index].presentAddress?.state.toString()}',
                                    hintStyle: TextStyle(
                                        fontSize: 13.sp,

                                        fontFamily: "Gilroy",
                                        color: CustomColor.riderprofileColor),
                                    border: UnderlineInputBorder(),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: CustomColor.yellow)),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.amberAccent),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                       // VerticalDivider(width: 30.0),
                        Row(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 5, top: 0, bottom: 0),
                                  child:  Icon(Icons.location_city_outlined)
                                ),
                                 Container(
                                   width: 115,
                                   child: Padding(
                                     padding: const EdgeInsets.only(right: 58),
                                     child: Text(
                                      "city".tr,
                                      style:
                                      TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Gilroy",
                                          color: CustomColor.riderprofileColor),
                                ),
                                   ),
                                 ),
                              ],
                            ),
                           // VerticalDivider(width: 85.0),
                            Expanded(

                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null) {
                                      return 'please_enter_your_city_name.'.tr;
                                    }
                                    return null;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[A-Za-z]")),
                                    //LengthLimitingTextInputFormatter(6),
                                  ],
                                  style:  TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Gilroy",
                                      color: CustomColor.riderprofileColor),
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  controller: cityController,
                                  decoration:  InputDecoration(
                                    enabled: false,
                                    hintText:  '${snapshot.data![index].presentAddress?.city.toString()}' == "null" ? " " : '${snapshot.data![index].presentAddress?.city.toString()}',
                                    hintStyle: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Gilroy",
                                        color: CustomColor.riderprofileColor),
                                    border: UnderlineInputBorder(),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: CustomColor.yellow)),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.amberAccent),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      //  VerticalDivider(width: 30.0),
                        Row(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 5, top: 0, bottom: 0),
                                  child: Icon(Icons.location_pin)
                                ),
                                 Container(
                                   width: 115,
                                   child: Padding(
                                     padding: const EdgeInsets.only(right: 35),
                                     child: Text(
                                      "pin_code".tr,
                                      style:
                                      TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Gilroy",
                                          color: CustomColor.riderprofileColor),
                                ),
                                   ),
                                 ),
                              ],
                            ),
                           // VerticalDivider(width: 50.0),

                            Expanded(

                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.length != 6) {
                                      return 'please_enter_6_digit_number.'.tr;
                                    }
                                    return null;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9]")),
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  style:  TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Gilroy",
                                      color: CustomColor.riderprofileColor),
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  controller: pinController,
                                  decoration:  InputDecoration(
                                    enabled: false,
                                    hintText:  '${snapshot.data![index].presentAddress?.pincode.toString()}' == "null" ? " " : '${snapshot.data![index].presentAddress?.pincode.toString()}',
                                    hintStyle: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Gilroy",
                                        color: CustomColor.riderprofileColor),
                                    border: UnderlineInputBorder(),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: CustomColor.yellow)),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.amberAccent),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),


                        Row(
                          children: [
                            Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 5, top: 0, bottom: 0),
                                    child: Icon(Icons.person_3_outlined)
                                ),

                                 Container(
                                   width: 115,
                                   child: Padding(
                                     padding: const EdgeInsets.only(right: 40),
                                     child: Text(
                                      "gender".tr,
                                      style:
                                      TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Gilroy",
                                          color: CustomColor.riderprofileColor),
                                ),
                                   ),
                                 ),
                              ],
                            ),
                           // VerticalDivider(width: 55.0),
                            Expanded(

                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: TextFormField(

                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Gilroy",
                                      color: CustomColor.riderprofileColor),
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  controller: genderController,
                                  decoration:  InputDecoration(
                                    enabled: false,
                                    hintText:  '${snapshot.data![index].gender.toString()}' == "null" ? " " : '${snapshot.data![index].gender.toString()}',
                                    hintStyle: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Gilroy",
                                        color: CustomColor.riderprofileColor),
                                    border: UnderlineInputBorder(),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: CustomColor.yellow)),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.amberAccent),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 5, top: 0, bottom: 0),
                                    child: Icon(Icons.bloodtype_outlined)
                                ),

                                 Container(
                                   width: 115,
                                   child: Padding(
                                     padding: const EdgeInsets.only(right: 15 ),
                                     child: Text(
                                      "blood_group".tr,
                                      style:
                                      TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Gilroy",
                                          color: CustomColor.riderprofileColor),
                                ),
                                   ),
                                 ),
                              ],
                            ),
                           // VerticalDivider(width: 20.0),
                            Expanded(

                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: TextFormField(


                                  style:  TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Gilroy",
                                      color: CustomColor.riderprofileColor),
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  controller: bloodgroupController,
                                  decoration:  InputDecoration(
                                    enabled: false,
                                    hintText:  '${snapshot.data![index].bloodGroup.toString()}' == "null" ? " " : '${snapshot.data![index].bloodGroup.toString()}',
                                    hintStyle: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Gilroy",
                                        color: CustomColor.riderprofileColor),
                                    border: UnderlineInputBorder(),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: CustomColor.yellow)),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.amberAccent),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 5, top: 0, bottom: 0),
                              child:  Icon(Icons.location_pin)
                            ),
                             Text(
                              "address".tr,
                              style:
                              TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Gilroy",
                                  color: CustomColor.riderprofileColor),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          child: Row(
                            children: <Widget>[
                              Expanded(

                                child: TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[A-Za-z0-9'\.\-\s\,\ ]")),
                                  ],
                                  style:  TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Gilroy",
                                      color: CustomColor.riderprofileColor),
                                  maxLines: 2,
                                  controller:
                                  addressController,
                                  decoration:  InputDecoration(
                                    hintText: '${snapshot.data![index].presentAddress?.address.toString()}' == "null" ? " " : '${snapshot.data![index].presentAddress?.address.toString()}',
                                    hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Gilroy",
                                        color: CustomColor.riderprofileColor),
                                    enabled: false,
                                    border: UnderlineInputBorder(),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: CustomColor.yellow)),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.amberAccent),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'please_enter_your_address.'.tr;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 10),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(8),
                                  border: Border.all(
                                      color:
                                      const Color(0xffEFEFEF)),
                                  color: CustomColor.buttonColor),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, top: 10),
                                    child: Text(
                                      "emergency_contact_number's".tr,
                                      style:TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Gilroy",
                                          color: CustomColor.riderprofileColor),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20,),
                                        child: MyText(
                                            text:
                                            snapshot.data![index].personName.toString() == "null" ? " " :  snapshot.data![index].personName.toString(),
                                            fontFamily: 'Gilroy',
                                            color:
                                            Color(0xff48422B),
                                            fontSize: 13.sp),
                                      ),

                                      Container(
                                          width: 15.w,
                                          height: 38.h,
                                          child: VerticalDivider()),
                                      Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: snapshot.data![index].emergencyContact.toString() == "null"
                                                  ? " "
                                                  : snapshot.data![index].emergencyContact.toString(),
                                              hintStyle: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: "Gilroy",
                                                  color: CustomColor.riderprofileColor),
                                            ),
                                            enabled: false,
                                            readOnly: true,
                                            keyboardType:
                                            TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                          )),
                                    ],
                                  ),
                                  Divider(
                                    color: CustomColor.text,
                                    height: 0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20,),
                                        child: MyText(
                                            text: snapshot.data![index].personName1.toString() == "null"
                                                ? " "
                                                : snapshot.data![index].personName1.toString() ,
                                            fontFamily: 'Gilroy',
                                            color:
                                            Color(0xff48422B),
                                            fontSize: 13.sp),
                                      ),

                                     Container(
                                          width: 15.w,
                                          height: 38.h,
                                          child: VerticalDivider()),
                                      Expanded(
                                          child: TextField(
                                              decoration:
                                              InputDecoration(
                                                border: InputBorder
                                                    .none,
                                                hintText: snapshot.data![index].emergencyNumber1.toString() ==
                                                    "null"
                                                    ? " "
                                                    : snapshot.data![index].emergencyNumber1.toString(),
                                                hintStyle: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: "Gilroy",
                                                    color: CustomColor.riderprofileColor),
                                              ),
                                              enabled: false,
                                              readOnly: true,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(
                                                    "[a-zA-Z0-9]")),
                                              ])),
                                    ],
                                  ),

                                ],
                              )),
                        ),

                      ],
                    ),
                  );
                },
              );

            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return Center(child: const CircularProgressIndicator());
          },
        ) ,
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}-${picked.toLocal().month}-${picked.toLocal().year}";
        _dateController.text = date;
      });
    }
  }

  Future<List<RiderData>> getRiderData() async {
   // OverlayLoadingProgress.start(context);
    await Preferences.setPreferences();
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    String mobileNumber = Preferences.getMobileNumber(Preferences.mobileNumber).toString();
    final response = await http.post(
      (Uri.parse('https://l8olgbtnbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/userList')),
      headers: ApiUrl.headerToken,
      body: jsonEncode(<String, String>{
        'mobile_number': mobileNumber,
      }),
    );
   // OverlayLoadingProgress.stop(context);
    if (response.statusCode == 200) {
      print('RES:${response.body}');
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      List<RiderData> loginData = jsonDecode(decodedBytes)['data']
          .map<RiderData>((data) => RiderData.fromJson(data))
          .toList();
      setState(() {

      });
      return loginData;
    } else {

      throw Exception('Failed to load');
    }
  }

  String formatDate(String date)
  {
    return date;
  }

 /* Future<StateModel> statesList() async {
    final response = await http.post(
      Uri.parse(ApiUrl.stateApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body)['data'];
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      if (status == true) {
        setState(() {
          selectedState = jsonResponse;
        });
        print(selectedState.toString());
      }
      return StateModel.fromJson(jsonDecode(response.body));
    } else {
      print("----------------------------");
      print(response.statusCode);
      print("----------------------------");

      throw Exception('Unexpected error occured!');
    }
  }   */

 /* Future<CityModel> citiesList(String states) async {
    final response = await http.post(
      Uri.parse(ApiUrl.cityApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"state_id": states}),
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body)['data'];
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      if (status == true) {
        setState(() {
          selectedCity = jsonResponse;
        });
        print(selectedCity.toString());
      }
      return CityModel.fromJson(jsonDecode(response.body));
    } else {
      print("City: ----------------------------");
      print(response.statusCode);
      print("----------------------------");

      throw Exception('Unexpected error occured!');
    }
  }  */

  buttonSelection(String gender, int idd){

    setState(() {
      radioButtonItem = gender ;
      id = idd;
    });

  }


}
