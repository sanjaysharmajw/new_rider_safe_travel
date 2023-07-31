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
import 'controller/view_profile_controller.dart';


class RiderProfileView extends StatefulWidget {
  String backbutton;
  RiderProfileView({Key? key, required this.backbutton}) : super(key: key);

  @override
  State<RiderProfileView> createState() => _RiderProfileViewState();
}

class _RiderProfileViewState extends State<RiderProfileView> {

  final viewProfileController = Get.put(ViewProfileController());

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
      //_future = getRiderData();
    });

    Timer(
        const Duration(seconds: 1),
            () => viewProfileController.viewProfileApi(Preferences.getMobileNumber(Preferences.mobileNumber)),
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
  final TextEditingController remarkController = TextEditingController();


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
        body: Obx(() {
          return  ListView.builder(
            shrinkWrap: true,
            itemCount: viewProfileController.getViewProfileData.length,
            itemBuilder: (context, index) {
              profileImage= "${viewProfileController.getViewProfileData[index].profileImage}";
              //mystate="${snapshot.data![index].presentAddress?.state.toString()}";
              //mycity="${snapshot.data![index].presentAddress?.city.toString()}";
              // print(mycity+" "+mystate);
              print(viewProfileController.getViewProfileData.length);
              print("@@@@@@@@@@@@@@@@@@@@@@@@@@");
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,),
                      child: ProfileWidget(profileName:"${viewProfileController.getViewProfileData[index].firstName.toString()} ${viewProfileController.getViewProfileData[index].lastName.toString()}"  == "null" ? " " :
                      "${viewProfileController.getViewProfileData[index].firstName.toString()} ${viewProfileController.getViewProfileData[index].lastName.toString()} ",
                        profileMobile:  '${viewProfileController.getViewProfileData[index].mobileNumber.toString()}' == "null" ? " " : '${viewProfileController.getViewProfileData[index].mobileNumber.toString()}',
                        onPress: () async {
                          OverlayLoadingProgress.start(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              RiderProfileEdit()
                          ))
                              .then((value) {

                            setState(() {
                            });
                            return value;
                          });
                        },
                        assetsPath: profileImage,
                        progressIndicator: viewProfileController.getViewProfileData[index].profilePercentage ?? 100,
                        progressValue: viewProfileController.getViewProfileData[index].profilePercentage.toString() == "null" ? "100" :  viewProfileController.getViewProfileData[index].profilePercentage.toString(),
                      ),
                    ),

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
                                  hintText:  '${viewProfileController.getViewProfileData[index].emailId.toString()}' == "null" ? " " : '${viewProfileController.getViewProfileData[index].emailId.toString()}',
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
                                hintText: this.formatDate('${viewProfileController.getViewProfileData[index].dob.toString()}' == "null" ? " " : '${viewProfileController.getViewProfileData[index].dob.toString()}'),
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
                                hintText:  '${viewProfileController.getViewProfileData[index].presentAddress?.state.toString()}' == "null" ? " " : '${viewProfileController.getViewProfileData[index].presentAddress?.state.toString()}',
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
                                hintText:  '${viewProfileController.getViewProfileData[index].presentAddress?.city.toString()}' == "null" ? " " : '${viewProfileController.getViewProfileData[index].presentAddress?.city.toString()}',
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
                                hintText:  '${viewProfileController.getViewProfileData[index].presentAddress?.pincode.toString()}' == "null" ? " " : '${viewProfileController.getViewProfileData[index].presentAddress?.pincode.toString()}',
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
                                child: Icon(Icons.person_outlined)
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
                                hintText:  '${viewProfileController.getViewProfileData[index].gender.toString()}' == "null" ? " " : '${viewProfileController.getViewProfileData[index].gender.toString()}',
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
                                hintText:  '${viewProfileController.getViewProfileData[index].bloodGroup.toString()}' == "null" ? " " : '${viewProfileController.getViewProfileData[index].bloodGroup.toString()}',
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
                      padding: const EdgeInsets.only(right: 15, left: 20),
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
                              maxLines: 5,
                              controller:
                              addressController,
                              decoration:  InputDecoration(
                                hintText: '${viewProfileController.getViewProfileData[index].presentAddress?.address.toString()}' == "null" ? " " : '${viewProfileController.getViewProfileData[index].presentAddress?.address.toString()}',
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



                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 5, top: 0, bottom: 0),
                            child:  Icon(Icons.comment_outlined)
                        ),
                        Text(
                          "remark".tr,
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
                              remarkController,
                              decoration:  InputDecoration(
                                hintText: viewProfileController.getViewProfileData[index].remark.toString() ==
                                    "null"
                                    ? " "
                                    : viewProfileController.getViewProfileData[index].remark.toString(),
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
                                      left: 16,),
                                    child: MyText(
                                        text:
                                        viewProfileController.getViewProfileData[index].emergencyContactPerson.toString() == "null" ? " " :  '${viewProfileController.getViewProfileData[index].emergencyContactPerson.toString()}  :-  ',
                                        fontFamily: 'Gilroy',
                                        color:
                                        Color(0xff48422B),
                                        fontSize: 13.sp),
                                  ),

                                  /*Container(
                                      width: 15.w,
                                      height: 38.h,
                                      child: VerticalDivider()),*/
                                  Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: viewProfileController.getViewProfileData[0].emergencyContactNo.toString() == "null"
                                              ? " "
                                              : viewProfileController.getViewProfileData[0].emergencyContactNo.toString(),
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
                                        text: viewProfileController.getViewProfileData[index].emergencyContactPerson1.toString() == "null"
                                            ? " "
                                            : '${viewProfileController.getViewProfileData[index].emergencyContactPerson1.toString()+" :- "}' ,
                                        fontFamily: 'Gilroy',
                                        color:
                                        Color(0xff48422B),
                                        fontSize: 13.sp),
                                  ),

                                 /* Container(
                                      width: 15.w,
                                      height: 38.h,
                                      child: VerticalDivider()),*/
                                  Expanded(
                                      child: TextField(
                                          decoration:
                                          InputDecoration(
                                            border: InputBorder
                                                .none,
                                            hintText: viewProfileController.getViewProfileData[index].emergencyContactNo1.toString() ==
                                                "null"
                                                ? " "
                                                : viewProfileController.getViewProfileData[index].emergencyContactNo1.toString(),
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
        })




            // By default, show a loading spinner.
           // return Center(child: const CircularProgressIndicator());


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



  String formatDate(String date)
  {
    return date;
  }



  buttonSelection(String gender, int idd){

    setState(() {
      radioButtonItem = gender ;
      id = idd;
    });

  }


}
