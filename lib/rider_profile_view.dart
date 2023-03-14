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
  const RiderProfileView({Key? key}) : super(key: key);

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
        backgroundColor: CustomColor.yellow,
        elevation: 15,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: IconButton(
              onPressed: () {
                Get.back(canPop: true);
              },
              icon: const Icon(
                Icons.arrow_back_sharp,
                color: CustomColor.black,
                size: 30,
              )),
        ),
        title: Text("Your Profile",
            style: TextStyle(color: CustomColor.black,fontSize: 20, fontFamily: 'transport',)),
      ),
        body: FutureBuilder<List<RiderData>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                 profileImage= "${snapshot.data![index].profileImage}";
                  //mystate="${snapshot.data![index].presentAddress?.state.toString()}";
                  //mycity="${snapshot.data![index].presentAddress?.city.toString()}";
                // print(mycity+" "+mystate);
                 print(profileImage);
                 print("@@@@@@@@@@@@@@@@@@@@@@@@@@");
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         /* Padding(
                            padding: EdgeInsets.only(left: 20.h,top: 10.h),
                            child:  MyText(
                                text: "Rider Profile",
                                fontFamily: 'transport',
                                color: CustomColor.black,
                                fontSize: 20.sp),
                          ),*/
                          const SizedBox(
                            height: 40,
                          ),
                          ProfileWidget(profileName:"${snapshot.data![index].firstName.toString()} ${snapshot.data![index].lastName.toString()}"  == "null" ? " " :
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
                                       contactPerson1: '${snapshot.data![index].personName1.toString()}' == "null" ? " " : '${snapshot.data![index].personName1.toString()}', )
                                 ))
                                     .then((value) {

                                  setState(() {
                                  });
                                  return value;
                                });

                                },
                              assetsPath: profileImage,

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
                                        left: 15, right: 15, top: 0, bottom: 0),
                                    child:  Icon(Icons.email_outlined),
                                  ),
                                  Text(
                                    "Email Id",
                                    style: TextStyle(
                                        fontFamily: 'transport', fontSize: 16),
                                  ),
                                ],
                              ),
                              VerticalDivider(width: 33.0),
                              Expanded(
                                  child: Center(
                                    child: MyTextField(
                                      textEditingController: emailController,
                                      fontName: 'transport',
                                      fontSize: 16,
                                      enabledBorderColor: CustomColor.buttonColor, focusedBorderColor: CustomColor.buttonColor,
                                      width: 1, broad: 4,
                                      textInputType: TextInputType.emailAddress,
                                      enable: false,
                                      hintText:'${snapshot.data![index].emailId.toString()}' == "null" ? " " : '${snapshot.data![index].emailId.toString()}' , textColor: Colors.black54, ),
                                  )),

                            ],
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, top: 0, bottom: 0),
                                    child: Image.asset('images/calendar.png',
                                        height: 22, width: 25),
                                  ),
                                  Text(
                                    "DOB",
                                    style: TextStyle(
                                        fontFamily: 'transport', fontSize: 16),
                                  ),
                                ],
                              ),
                              VerticalDivider(width: 56.0),
                              Expanded(
                                            flex: 2,
                                            child: SizedBox(
                                              height: 45,
                                              child: TextFormField(
                                                // keyboardType: TextInputType.number,
                                                style: const TextStyle(
                                                    fontFamily: 'transport',
                                                    fontSize: 18),
                                                maxLines: 1,
                                                controller: _dateController,
                                                decoration:  InputDecoration(
                                                  enabled: false,
                                                  hintText: this.formatDate('${snapshot.data![index].dob.toString()}' == "null" ? " " : '${snapshot.data![index].dob.toString()}'),
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
                                                  // hintText: 'YYYY/MM/DD',
                                                  hintStyle: TextStyle(
                                                      fontFamily: 'transport',
                                                      fontSize: 15,color: Colors.black54),
                                                ),
                                                readOnly: true,
                                                onTap: () async {
                                                  _selectDate(context);
                                                },
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty ){
                                                    return 'Please enter your Date of Birth';
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
                                        left: 15, right: 15, top: 0, bottom: 0),
                                    child:  Icon(Icons.location_city_outlined)
                                  ),
                                  const Text(
                                    "State",
                                    style:
                                    TextStyle(fontFamily: 'transport', fontSize: 16),
                                  ),
                                ],
                              ),
                              VerticalDivider(width: 50.0),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 45,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please enter your state name.';
                                      }
                                      return null;
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[A-Za-z]")),
                                     // LengthLimitingTextInputFormatter(6),
                                    ],
                                    style: const TextStyle(
                                        fontSize: 16.0, fontFamily: "transport"),
                                    keyboardType: TextInputType.text,
                                    maxLines: 1,
                                    controller: stateController,
                                    decoration:  InputDecoration(
                                      enabled: false,
                                      hintText:  '${snapshot.data![index].presentAddress?.state.toString()}' == "null" ? " " : '${snapshot.data![index].presentAddress?.state.toString()}',
                                      hintStyle: TextStyle(
                                          fontFamily: 'transport',
                                          fontSize: 15,color: Colors.black54),
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
                          VerticalDivider(width: 30.0),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15, top: 0, bottom: 0),
                                    child:  Icon(Icons.location_city_outlined)
                                  ),
                                  const Text(
                                    "City",
                                    style:
                                    TextStyle(fontFamily: 'transport', fontSize: 16),
                                  ),
                                ],
                              ),
                              VerticalDivider(width: 60.0),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 45,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please enter your city name.';
                                      }
                                      return null;
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[A-Za-z]")),
                                      //LengthLimitingTextInputFormatter(6),
                                    ],
                                    style: const TextStyle(
                                        fontSize: 16.0, fontFamily: "transport"),
                                    keyboardType: TextInputType.text,
                                    maxLines: 1,
                                    controller: cityController,
                                    decoration:  InputDecoration(
                                      enabled: false,
                                      hintText:  '${snapshot.data![index].presentAddress?.city.toString()}' == "null" ? " " : '${snapshot.data![index].presentAddress?.city.toString()}',
                                      hintStyle: TextStyle(
                                          fontFamily: 'transport',
                                          fontSize: 15,color: Colors.black54),
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
                          VerticalDivider(width: 30.0),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15, top: 0, bottom: 0),
                                    child: Icon(Icons.location_pin)
                                  ),
                                  const Text(
                                    "PinCode",
                                    style:
                                    TextStyle(fontFamily: 'transport', fontSize: 16,),
                                  ),
                                ],
                              ),
                              VerticalDivider(width: 30.0),
                              VerticalDivider(width: 30.0),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 45,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.length != 6) {
                                        return 'Please enter 6 digit number.';
                                      }
                                      return null;
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9]")),
                                      LengthLimitingTextInputFormatter(6),
                                    ],
                                    style: const TextStyle(
                                        fontSize: 16.0, fontFamily: "transport"),
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    controller: pinController,
                                    decoration:  InputDecoration(
                                      enabled: false,
                                      hintText:  '${snapshot.data![index].presentAddress?.pincode.toString()}' == "null" ? " " : '${snapshot.data![index].presentAddress?.pincode.toString()}',
                                      hintStyle: TextStyle(
                                          fontFamily: 'transport',
                                          fontSize: 15,color: Colors.black54),
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
                            height: 20,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: const Text(
                                      "Gender",
                                      style:
                                      TextStyle(fontFamily: 'transport', fontSize: 16,),
                                    ),
                                  ),
                                ],
                              ),
                              VerticalDivider(width: 30.0),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 45,
                                  child: TextFormField(

                                    style: const TextStyle(
                                        fontSize: 16.0, fontFamily: "transport"),
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    controller: genderController,
                                    decoration:  InputDecoration(
                                      enabled: false,
                                      hintText:  '${snapshot.data![index].gender.toString()}' == "null" ? " " : '${snapshot.data![index].gender.toString()}',
                                      hintStyle: TextStyle(
                                          fontFamily: 'transport',
                                          fontSize: 15,color: Colors.black54),
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
                            height: 20,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: const Text(
                                      "Blood Group",
                                      style:
                                      TextStyle(fontFamily: 'transport', fontSize: 16,),
                                    ),
                                  ),
                                ],
                              ),
                              VerticalDivider(width: 30.0),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 45,
                                  child: TextFormField(

                                    style: const TextStyle(
                                        fontSize: 16.0, fontFamily: "transport"),
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    controller: bloodgroupController,
                                    decoration:  InputDecoration(
                                      enabled: false,
                                      hintText:  '${snapshot.data![index].bloodGroup.toString()}' == "null" ? " " : '${snapshot.data![index].bloodGroup.toString()}',
                                      hintStyle: TextStyle(
                                          fontFamily: 'transport',
                                          fontSize: 15,color: Colors.black54),
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
                            height: 20,
                          ),

                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 0, bottom: 0),
                                child:  Icon(Icons.location_pin)
                              ),
                              const Text(
                                "Address",
                                style:
                                TextStyle(fontFamily: 'transport', fontSize: 16),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    height: 45,
                                    child: TextFormField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[A-Za-z0-9'\.\-\s\,\ ]")),
                                      ],
                                      style: const TextStyle(
                                          fontFamily: 'transport', fontSize: 16),
                                      maxLines: 1,
                                      controller:
                                      addressController,
                                      decoration:  InputDecoration(
                                        hintText: '${snapshot.data![index].presentAddress?.address.toString()}' == "null" ? " " : '${snapshot.data![index].presentAddress?.address.toString()}',
                                        hintStyle: TextStyle(
                                            fontFamily: 'transport',
                                            fontSize: 15,color: Colors.black54),
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
                                          return 'Please enter your address.';
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
                                        "Emergency contact number's ",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, right: 10),
                                          child: MyText(
                                              text:
                                              snapshot.data![index].personName.toString() == "null" ? " " :  snapshot.data![index].personName.toString(),
                                              fontFamily: 'transport',
                                              color:
                                              Color(0xff48422B),
                                              fontSize: 14.sp),
                                        ),
                                        Container(
                                            width: 30.w,
                                            height: 38.h,
                                            child: VerticalDivider()),
                                        Expanded(
                                            child: Center(
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: snapshot.data![index].emergencyContact.toString() == "null"
                                                        ? " "
                                                        : snapshot.data![index].emergencyContact.toString(),
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
                                                ))),
                                      ],
                                    ),
                                    Divider(
                                      color: CustomColor.text,
                                      height: 0,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, right: 34),
                                          child: MyText(
                                              text: snapshot.data![index].personName1.toString() == "null"
                                                  ? " "
                                                  : snapshot.data![index].personName1.toString() ,
                                              fontFamily: 'transport',
                                              color:
                                              Color(0xff48422B),
                                              fontSize: 14.sp),
                                        ),
                                        Container(
                                            width: 5.w,
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
                                                ),
                                                enabled: false,
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
      (Uri.parse('https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/userList')),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': loginToken
      },
      body: jsonEncode(<String, String>{
        'mobile_number': mobileNumber,
      }),
    );
   // OverlayLoadingProgress.stop(context);
    if (response.statusCode == 200) {
      print('RES:${response.body}');
      List<RiderData> loginData = jsonDecode(response.body)['data']
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
