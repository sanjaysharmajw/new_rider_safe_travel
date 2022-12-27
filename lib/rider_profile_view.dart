import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
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
import 'RiderUserList.dart';

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


  var selectedState = [];
  var state;
  var states;
  var statName;
  bool isStateSelected = false;

  var selectedCity = [];
  var cities;
  var stateid;
  bool isCitySelected = false;

  DateTime selectedDate = DateTime.now();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  //var mobile=Preferences.getMobileNumber(Preferences.mobileNumber);
  File? imageTemp;
  var myState;

  @override
  void initState() {
    statesList();
    expiryDateController.text = "";
    super.initState();
    Random random = Random();
    int randomNumber = random.nextInt(1000000);
    stringRandomNumber = randomNumber.toString();
    _future = getRiderData();
  }

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


  late Future<List<RiderUserListData>> futurePost;

  var _future;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
      ),
        body: FutureBuilder<List<RiderUserListData>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20,top: 10),
                            child: const MyText(
                                text: "Rider Profile",
                                fontFamily: 'transport',
                                color: CustomColor.black,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ProfileWidget(profileName:"${snapshot.data![index].firstName.toString()} ${snapshot.data![index].lastName.toString()}",
                              profileMobile:  '${snapshot.data![index].mobileNumber.toString()}', onPress: () { Get.to(RiderProfileEdit()) ; }, assetsPath: '${snapshot.data![index].profileImage.toString()}'),
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
                                      width: 1, broad: 4, textInputType: TextInputType.emailAddress, enable: false, hintText: '${snapshot.data![index].emailId.toString()}',),
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
                                                  hintText: "${snapshot.data![index].dob.toString()}",
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
                                                      fontSize: 15),
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
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[A-Za-z0-9'\.\-\s\,\ ]")),
                                    ],
                                    style: const TextStyle(
                                        fontFamily: 'transport', fontSize: 16),
                                    maxLines: 1,
                                    controller: stateController,
                                    decoration:  InputDecoration(
                                      hintText: "${snapshot.data![index].permanentAddress.toString()}",
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
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[A-Za-z0-9'\.\-\s\,\ ]")),
                                    ],
                                    style: const TextStyle(
                                        fontFamily: 'transport', fontSize: 16),
                                    maxLines: 1,
                                    controller: cityController,
                                    decoration:  InputDecoration(
                                      hintText: "${snapshot.data![index].permanentAddress.toString()}",
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
                                      hintText:  "${snapshot.data![index].permanentAddress.toString()}",
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
                          // Row(
                          //   children: [
                          //     Padding(
                          //       padding: EdgeInsets.only(left: 20),
                          //       child: Text(
                          //         "DOB  -",
                          //         style: TextStyle(
                          //             fontSize: 14,
                          //             fontWeight: FontWeight.bold,
                          //             color: CustomColor.riderprofileColor),
                          //       ),
                          //     ),
                          //     VerticalDivider(width: 80.0),
                          //     Expanded(
                          //         child: Center(
                          //           child: MyTextField(
                          //             textEditingController: dobController,
                          //             fontName: 'transport',
                          //             fontSize: 16,
                          //             enabledBorderColor: CustomColor.buttonColor, focusedBorderColor: CustomColor.buttonColor,
                          //             width: 1, broad: 4, textInputType: TextInputType.text, enable: false, hintText: '${snapshot.data![index].dob.toString()}',),
                          //         )),
                          //   ],
                          // ),
                          // Row(
                          //   children: [
                          //     Padding(
                          //       padding: EdgeInsets.only(left: 20),
                          //       child: Text(
                          //         "Gender  -",
                          //         style: TextStyle(
                          //             fontSize: 14,
                          //             fontWeight: FontWeight.bold,
                          //             color: CustomColor.riderprofileColor),
                          //       ),
                          //     ),
                          //     VerticalDivider(width: 60.0),
                          //     Expanded(
                          //         child: Center(
                          //           child: MyTextField(
                          //               textEditingController: genderController,
                          //               fontName: 'transport',
                          //               fontSize: 16,
                          //               enabledBorderColor: CustomColor.buttonColor, focusedBorderColor: CustomColor.buttonColor,
                          //               width: 1, broad: 4, textInputType: TextInputType.text, enable: false, hintText: '${snapshot.data![index].gender.toString()}',),
                          //         )),
                          //   ],
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12),
                                child: Row(
                                  children: const [
                                    Expanded(
                                      child: Text(
                                        "Gender",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "transport"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Radio(
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => CustomColor.yellow),
                                    focusColor:
                                    MaterialStateColor.resolveWith(
                                            (states) => CustomColor.yellow),
                                    value: 1,
                                    groupValue: id,
                                    onChanged: (val) {
                                      radioButtonItem = "${snapshot.data![index].gender.toString()}" ;
                                      id = 1;
                                      if(radioButtonItem != "${snapshot.data![index].gender.toString()}"){
                                        buttonSelection("${snapshot.data![index].gender.toString()}", id);
                                      }
                                    },
                                  ),
                                  const Text(
                                    'Female',
                                    style: TextStyle(fontSize: 17.0),
                                  ),
                                  Radio(
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => CustomColor.yellow),
                                    focusColor:
                                    MaterialStateColor.resolveWith(
                                            (states) => CustomColor.yellow),
                                    value: 2,
                                    groupValue: id,
                                    onChanged: (val) {
                                      radioButtonItem != "${snapshot.data![index].gender.toString()}" ;
                                      id = 2;
                                      if(radioButtonItem == "${snapshot.data![index].gender.toString()}"){
                                        buttonSelection("${snapshot.data![index].gender.toString()}", id);
                                      }
                                    },
                                  ),
                                  const Text(
                                    'Male',
                                    style: TextStyle(
                                      fontSize: 17.0,
                                    ),
                                  ),
                                  Radio(
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => CustomColor.yellow),
                                    focusColor:
                                    MaterialStateColor.resolveWith(
                                            (states) => CustomColor.yellow),
                                    value: 3,
                                    groupValue: id,
                                    onChanged: (val) {
                                      radioButtonItem = "${snapshot.data![index].gender.toString()}" ;
                                      id = 3;
                                      if(radioButtonItem != "${snapshot.data![index].gender.toString()}"){
                                        buttonSelection("${snapshot.data![index].gender.toString()}", id);
                                      }
                                    },
                                  ),
                                  const Text(
                                    'Other',
                                    style: TextStyle(fontSize: 17.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 15, left: 15),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: <Widget>[
                          //       Container(width: 2),
                          //       Expanded(
                          //         flex: 2,
                          //         child: Row(
                          //           children: [
                          //             Icon(Icons.location_city_outlined,color: Colors.yellow,),
                          //             // Image.asset(
                          //             //   "icons/enter_mobile_number.png",
                          //             //   height: 20,
                          //             // ),
                          //             Container(width: 15),
                          //             const Text("Select State",
                          //                 style: TextStyle(
                          //                     color: CustomColor.black,
                          //                     fontFamily: 'transport',
                          //                     fontSize: 16)),
                          //           ],
                          //         ),
                          //       ),
                          //       Container(width: 35),
                          //       Expanded(
                          //         flex: 2,
                          //         child: Row(
                          //           children: [
                          //             Icon(Icons.location_city_outlined,color: Colors.yellow,),
                          //             // Image.asset(
                          //             //   "icons/enter_mobile_number.png",
                          //             //   height: 20,
                          //             // ),
                          //             Container(width: 15),
                          //             const Text("Select City",
                          //                 style: TextStyle(
                          //                     color: CustomColor.black,
                          //                     fontFamily: 'transport',
                          //                     fontSize: 16)),
                          //           ],
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // Padding(
                          //   padding:  EdgeInsets.only(right: 15, left: 15),
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //         flex: 2,
                          //         child: SizedBox(
                          //           height: 60,
                          //           child: Card(
                          //             color: Colors.white,
                          //             shape: UnderlineInputBorder(
                          //                 borderRadius: BorderRadius.circular(10),
                          //                 borderSide:
                          //                 BorderSide(color: CustomColor.yellow)),
                          //             child: Padding(
                          //               padding: EdgeInsets.all(15),
                          //               child: DropdownButton(
                          //                 underline: Container(),
                          //                 // hint: Text("Select State"),
                          //                hint:  Text("${snapshot.data![index].state.toString()}",),
                          //                 icon: Icon(Icons.keyboard_arrow_down),
                          //                 isDense: true,
                          //                 isExpanded: true,
                          //
                          //                 items: selectedState.map((e) {
                          //                   return DropdownMenuItem(
                          //                     value: e["state_id"].toString(),
                          //                     child: Text(e['name'].toString()),
                          //                   );
                          //                 }).toList(),
                          //                 value: states,
                          //                 onChanged: (value) {
                          //                   setState(() {
                          //                     selectedCity = [];
                          //                     states = value;
                          //                     isStateSelected = true;
                          //                     for (int i = 0;
                          //                     i < selectedState.length;
                          //                     i++) {
                          //                       if (states.toString() ==
                          //                           selectedState[i]['state_id']
                          //                               .toString()) {
                          //                         statName = selectedState[i]['name'];
                          //                         print(statName);
                          //                       }
                          //                     }
                          //                     if (states != null) {
                          //                       citiesList(states);
                          //                     }
                          //                   });
                          //                 },
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       Container(width: 15),
                          //       Expanded(
                          //         flex: 2,
                          //         child: SizedBox(
                          //           height: 60,
                          //           child: Card(
                          //             color: Colors.white,
                          //             shape: UnderlineInputBorder(
                          //                 borderRadius: BorderRadius.circular(10),
                          //                 borderSide:
                          //                 BorderSide(color: CustomColor.yellow)),
                          //             child: Padding(
                          //               padding: EdgeInsets.all(15),
                          //               child: DropdownButton<String>(
                          //                 underline: Container(),
                          //                 // hint: Text("Select City",),
                          //                 icon: Icon(Icons.keyboard_arrow_down),
                          //                 isDense: true,
                          //                 isExpanded: true,
                          //                 enableFeedback: false,
                          //                 hint:  Text("${snapshot.data![index].city.toString()}",),
                          //                 items: selectedCity.map((e) {
                          //                   return DropdownMenuItem<String>(
                          //                     child: Text(e["name"]),
                          //                     value: e["name"],
                          //                   );
                          //                 }).toList(),
                          //                 value: cities,
                          //                 onChanged: (value) {
                          //                   setState(() {
                          //                     cities = value;
                          //                     print(cities);
                          //                   });
                          //                 },
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Row(
                          //   children: [
                          //     Padding(
                          //       padding: const EdgeInsets.only(
                          //           left: 15, right: 15, top: 0, bottom: 0),
                          //       child: Image.asset('assets/registration_no.png',
                          //           height: 25, width: 25),
                          //     ),
                          //     const Text(
                          //       "State",
                          //       style:
                          //       TextStyle(fontFamily: 'transport', fontSize: 16),
                          //     ),
                          //   ],
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 15, left: 15),
                          //   child: Row(
                          //     children: <Widget>[
                          //       Expanded(
                          //         flex: 2,
                          //         child: SizedBox(
                          //           height: 45,
                          //           child: TextFormField(
                          //             inputFormatters: [
                          //               FilteringTextInputFormatter.allow(
                          //                   RegExp("[A-Za-z0-9'\.\-\s\,\ ]")),
                          //             ],
                          //             style: const TextStyle(
                          //                 fontFamily: 'transport', fontSize: 16),
                          //             maxLines: 1,
                          //             controller: addressController,
                          //             decoration:  InputDecoration(
                          //               hintText: "${snapshot.data![index].state.toString()}",
                          //               enabled: false,
                          //               border: UnderlineInputBorder(),
                          //               enabledBorder: UnderlineInputBorder(
                          //                   borderSide: BorderSide(
                          //                       width: 1, color: CustomColor.yellow)),
                          //               focusedBorder: UnderlineInputBorder(
                          //                 borderSide: BorderSide(
                          //                     width: 1, color: Colors.amberAccent),
                          //               ),
                          //             ),
                          //             validator: (value) {
                          //               if (value == null || value.isEmpty) {
                          //                 return 'Please enter your address.';
                          //               }
                          //               return null;
                          //             },
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Row(
                          //   children: [
                          //     Padding(
                          //       padding: const EdgeInsets.only(
                          //           left: 15, right: 15, top: 0, bottom: 0),
                          //       child: Image.asset('assets/registration_no.png',
                          //           height: 25, width: 25),
                          //     ),
                          //     const Text(
                          //       "city",
                          //       style:
                          //       TextStyle(fontFamily: 'transport', fontSize: 16),
                          //     ),
                          //   ],
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 15, left: 15),
                          //   child: Row(
                          //     children: <Widget>[
                          //       Expanded(
                          //         flex: 2,
                          //         child: SizedBox(
                          //           height: 45,
                          //           child: TextFormField(
                          //             inputFormatters: [
                          //               FilteringTextInputFormatter.allow(
                          //                   RegExp("[A-Za-z0-9'\.\-\s\,\ ]")),
                          //             ],
                          //             style: const TextStyle(
                          //                 fontFamily: 'transport', fontSize: 16),
                          //             maxLines: 1,
                          //             controller: addressController,
                          //             decoration:  InputDecoration(
                          //               hintText: "${snapshot.data![index].city.toString()}",
                          //               enabled: false,
                          //               border: UnderlineInputBorder(),
                          //               enabledBorder: UnderlineInputBorder(
                          //                   borderSide: BorderSide(
                          //                       width: 1, color: CustomColor.yellow)),
                          //               focusedBorder: UnderlineInputBorder(
                          //                 borderSide: BorderSide(
                          //                     width: 1, color: Colors.amberAccent),
                          //               ),
                          //             ),
                          //             validator: (value) {
                          //               if (value == null || value.isEmpty) {
                          //                 return 'Please enter your address.';
                          //               }
                          //               return null;
                          //             },
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 25,
                          // ),
                          // const SizedBox(
                          //   height: 25,
                          // ),
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
                                      controller: addressController,
                                      decoration:  InputDecoration(
                                        hintText: "${snapshot.data![index].permanentAddress.toString()}",
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
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 15,left: 20,right: 20),
                          //   child: Container(
                          //     height: 100,
                          //     decoration:  BoxDecoration (
                          //         borderRadius:  BorderRadius.circular(8),
                          //         border:  Border.all(color: const Color(0xffEFEFEF)),
                          //         color: CustomColor.buttonColor
                          //     ),
                          //     child: Padding(
                          //       padding: const EdgeInsets.only(left: 15),
                          //       child: TextFormField(
                          //         enabled: false,
                          //         // autovalidateMode: _submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                          //         decoration: InputDecoration(
                          //           border: InputBorder.none,
                          //           hintText: "Address"
                          //           // hintText: '${snapshot.data![index].permanentAddress!.address.toString()} ',
                          //         ),
                          //         keyboardType: TextInputType.multiline,
                          //         minLines: 1,//Normal textInputField will be displayed
                          //         maxLines: 8,// when user presses en
                          //         autovalidateMode: AutovalidateMode.onUserInteraction,
                          //         validator: (text) {
                          //           if (text == null || text.isEmpty) {
                          //             return 'Can\'t be empty';
                          //           }
                          //           if (text.length < 4) {
                          //             return 'Too short';
                          //           }
                          //           return null;
                          //         },
                          //         // update the state variable when the text changes
                          //         // onChanged: (text) => setState(() => _name = text),
                          //       ),
                          //     ),
                          //
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
                          //   child: Container(
                          //       height: 160,
                          //       width: 400,
                          //       decoration:  BoxDecoration (
                          //           borderRadius:  BorderRadius.circular(8),
                          //           border:  Border.all(color: const Color(0xffEFEFEF)),
                          //           color: CustomColor.buttonColor
                          //       ),
                          //       child: Column(
                          //         mainAxisAlignment: MainAxisAlignment.start,
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Padding(
                          //             padding: const EdgeInsets.only(left: 10,top: 10),
                          //             child: Text("Documents Details" ,style: TextStyle(
                          //               fontSize: 15,fontWeight: FontWeight.bold,
                          //             ),),
                          //           ),
                          //           Row(
                          //             children: [
                          //               Padding(
                          //                 padding: EdgeInsets.only(left: 20,right: 76),
                          //                 child: Text(
                          //                   "Aadhar Card Number",
                          //                   style: TextStyle(
                          //                       fontSize: 14,
                          //                       fontWeight: FontWeight.bold,
                          //                       color: CustomColor.riderprofileColor),
                          //                 ),
                          //               ),
                          //               Container(
                          //                   width: 20,
                          //                   height: 40,
                          //                   child: VerticalDivider()),
                          //               Expanded(
                          //                   child: Center(
                          //                       child:TextField(
                          //
                          //                         enabled: false,
                          //                         decoration: InputDecoration(
                          //                           border: InputBorder.none,
                          //                           // hintText: "${snapshot.data![index].aadharNumber.toString()}",
                          //                         ),
                          //                         keyboardType : TextInputType.number,
                          //                         inputFormatters: <TextInputFormatter>[
                          //                           FilteringTextInputFormatter.digitsOnly
                          //                         ],
                          //                       )
                          //                   )),
                          //             ],
                          //           ),
                          //           Divider(color: CustomColor.text),
                          //           Row(
                          //             children: [
                          //               const Padding(
                          //                 padding: EdgeInsets.only(left: 20,right: 100),
                          //                 child: Text(
                          //                   "Pan Card Number",
                          //                   style: TextStyle(
                          //                       fontSize: 14,
                          //                       fontWeight: FontWeight.bold,
                          //                       color: CustomColor.riderprofileColor),
                          //                 ),
                          //               ),
                          //               Container(
                          //                   width: 20,
                          //                   height: 40,
                          //                   child: VerticalDivider()),
                          //               Expanded(
                          //                   child:TextField(
                          //                       enabled: false,
                          //                       decoration: InputDecoration(
                          //                         border: InputBorder.none,
                          //                         // hintText: "${snapshot.data![index].panNumber.toString()} ",
                          //                       ),
                          //                       inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")), ]                                )
                          //               ),
                          //             ],
                          //           ),
                          //           Divider(color: CustomColor.text,),
                          //         ],
                          //       )
                          //   ),
                          // ),
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
            return const CircularProgressIndicator();
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

  Future<List<RiderUserListData>> getRiderData() async {
    await Preferences.setPreferences();
    String mobileNumber = Preferences.getMobileNumber(Preferences.mobileNumber).toString();
    final response = await http.post(
      (Uri.parse('https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/userList')),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mobile_number': mobileNumber,
      }),
    );

    if (response.statusCode == 200) {
      print('RES:${response.body}');
      List<RiderUserListData> loginData = jsonDecode(response.body)['data']
          .map<RiderUserListData>((data) => RiderUserListData.fromJson(data))
          .toList();
      return loginData;
    } else {

      throw Exception('Failed to load');
    }
  }

  Future<StateModel> statesList() async {
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
  }

  Future<CityModel> citiesList(String states) async {
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
  }

  buttonSelection(String gender, int idd){

    setState(() {
      radioButtonItem = gender ;
      id = idd;
    });

  }


}
