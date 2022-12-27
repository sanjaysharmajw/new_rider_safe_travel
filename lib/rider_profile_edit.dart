import 'dart:convert';
import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:overlay_loading_progress/overlay_loading_progress.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Models/CityModel.dart';

import '../Models/StateModel.dart';
import 'Aws/AwsSignedApi.dart';
import 'Aws/AwsUrlPath.dart';
import 'Error.dart';
import 'LoginModule/Api_Url.dart';
import 'LoginModule/custom_button.dart';
import 'LoginModule/custom_color.dart';
import 'LoginModule/preferences.dart';
import 'Models/UpdateRiderProfileModel.dart';
import 'MyTextField.dart';
import 'RiderUserList.dart';


class RiderProfileEdit extends StatefulWidget {


   RiderProfileEdit({Key? key}) : super(key: key) ;


  @override
  State<RiderProfileEdit> createState() => _RiderProfileEditState();
}

class _RiderProfileEditState extends State<RiderProfileEdit> {

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController firstNameController =  TextEditingController();
  final TextEditingController  lastNameController = TextEditingController() ;
  final TextEditingController emailController = TextEditingController()  ;
  final TextEditingController  dobController = TextEditingController();
  final TextEditingController  genderController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  String radioButtonItem = '';
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
  late Future<List<RiderUserListData>> futurePost;

  var _future;

  var profile;

  var stringRandomNumber;
  File? image;
  var filePath;
  late File file;
  var fileName="";


  AwsSignedApi awsSignedApi = AwsSignedApi();

  @override
  initState() {
    _dateController.text = "";
     Random random = Random();
     statesList();
     expiryDateController.text = "";
     super.initState();
     int randomNumber = random.nextInt(1000000);
    _future = getRiderData();
     stringRandomNumber = randomNumber.toString();
     super.initState();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      file = File(await image.path);
      filePath = imageTemp.path.split(Platform.pathSeparator).last;
      awsUpload(stringRandomNumber + filePath);
      print("Image Picker: " + stringRandomNumber + filePath);
      OverlayLoadingProgress.start(context);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickCameraImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      file = File(await image.path);
      filePath = imageTemp.path.split(Platform.pathSeparator).last;
      awsUpload(stringRandomNumber + filePath);
      fileName= AwsUrl.awsImagePathUrl +
          stringRandomNumber +
          filePath;
      print("Image Picker: " + stringRandomNumber + filePath);
      OverlayLoadingProgress.start(context);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }


  Future<UpdateRiderProfileModel> getUserData(BuildContext context,String firstName, String lastName,
      String email, String dob, String gender , String address , String cities , String states, String profileImage , String pincode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('firstName', firstName.toString());
    prefs.setString("lastName", lastName.toString());
    prefs.setString("email",email.toString());
    prefs.setString("dob",dob.toString());
    prefs.setString("gender",gender.toString());
    prefs.setString("address",address.toString());
    prefs.setString("states",states.toString());
    prefs.setString("cities",cities.toString());
    prefs.setString("profileImage",profileImage.toString());
    prefs.setString("pincode",pincode.toString());
    await Preferences.setPreferences();
    String userId = Preferences.getId(Preferences.id).toString();
    String mobileNumber = Preferences.getMobileNumber(Preferences.mobileNumber);

    var image=profileImage.toString();
    if(fileName!= "")
      {
        image=fileName  ;
      }
    // String? firstName = prefs.getString(firstName
    // );
    print( jsonEncode(<String, String>{
      'profileImage': fileName,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'dob': dob,
      'gender': gender,
      'address': address,
      'states': states ,
      'cities': cities ,
    }),);

   var data = {
    "user_id": userId,
     "first_name" : firstName ,
     "last_name" :lastName,
     "email_id": emailController.text.toString(),
     "gender": radioButtonItem.toString(),
     "dob": _dateController.text.toString(),
     "mobile_number": mobileNumber,
    "alternate_contact_no": "",
    "profile_image": fileName,
    "marital_status": "",
     "city": cities.toString(),
     "state": states.toString(),
    "permanent_address": {
    "address": addressController.text.toString(),
    "city":cities.toString(),
    "state": states.toString(),
    "pincode": pinController.text.toString(),
    },

    "present_address": {
    "address":addressController.text.toString(),
    "city": cities.toString(),
    "state": states.toString(),
    "pincode": pinController.text.toString(),
    },
    "same_address": addressController.text.toString(),
     "pincode": pinController.text.toString(),
    "dldetails": {
    "dl_number": "",
    "dl_image": "",
    "dl_expiry_date": "",
    "dl_mobile_number": "",
    "accidental_history": "",
    "accidental_discription": "",
    "available24by7": "",
    "shift_time_from": "",
    "shift_time_to": ""
    },
     "address" : addressController.text.toString(),
    } ;

    final response = await http.post(
      Uri.parse(
          'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/updateUserProfile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      if (status == true) {
        OverlayLoadingProgress.stop(context);
        Text("Sucessfully updated");
        print("Sucessfully updated");
        Get.snackbar("Message", msg,snackPosition: SnackPosition.BOTTOM);
      }else{
        OverlayLoadingProgress.stop(context);
        // Get.to(DrawerScreen());
        // throw Exception('Failed to load')
          Get.snackbar("Failed to load", msg,snackPosition: SnackPosition.BOTTOM);
      }
      return UpdateRiderProfileModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body:  FutureBuilder<List<RiderUserListData>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20,top: 10),
                            child: Text(
                              "Rider Profile",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: CustomColor.riderprofileColor),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child:  Column(
                                    children: [
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: ((builder) =>
                                                      bottomSheet()));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  0, 20, 10, 0),
                                              child: Stack(
                                                alignment: Alignment.bottomRight,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: CustomColor.yellow,
                                                    radius: 45.0,
                                                    child: CircleAvatar(
                                                      radius: 43.0,
                                                      backgroundColor: Colors.white,
                                                      child: ClipOval(
                                                        child: (image != null)
                                                            ? Image.file(
                                                          image!,
                                                          width: 100,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                        )
                                                            : Image.asset(
                                                            'assets/user_avatar.png'),
                                                      ),
                                                    ),
                                                  ),
                                                  Image.asset(
                                                      'assets/select_image.png'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${snapshot.data![index].firstName.toString()} ${snapshot.data![index].lastName.toString()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: CustomColor.riderprofileColor),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${snapshot.data![index].mobileNumber.toString()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: CustomColor.text),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 64,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "First Name  -",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColor.riderprofileColor),
                                ),
                              ),
                              VerticalDivider(width: 40.0),
                              Expanded(
                                  child: Center(
                                    child: MyTextField(
                                      textEditingController: firstNameController,
                                      fontName: 'transport',
                                      fontSize: 16,
                                      enabledBorderColor: CustomColor.yellow, focusedBorderColor: CustomColor.yellow,
                                      width: 1, broad: 3, textInputType: TextInputType.text, enable: true, hintText: '${snapshot.data![index].firstName.toString()}',),
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "Last Name  -",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColor.riderprofileColor),
                                ),
                              ),
                              VerticalDivider(width: 40.0),
                              Expanded(
                                  child: Center(
                                    child: MyTextField(
                                      textEditingController: lastNameController,
                                      fontName: 'transport',
                                      fontSize: 16,
                                      enabledBorderColor: CustomColor.yellow, focusedBorderColor: CustomColor.yellow,
                                      width: 1, broad: 3 ,textInputType: TextInputType.text, enable: true, hintText: '${snapshot.data![index].lastName.toString()}',),
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "Email Id  -",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColor.riderprofileColor),
                                ),
                              ),
                              VerticalDivider(width: 60.0),
                              Expanded(
                                  child: Center(
                                    child: MyTextField(
                                      textEditingController: emailController,
                                      fontName: 'transport',
                                      fontSize: 16,
                                      enabledBorderColor: CustomColor.yellow, focusedBorderColor: CustomColor.yellow,
                                      width: 1, broad: 3, textInputType: TextInputType.emailAddress, enable: true, hintText: '${snapshot.data![index].emailId.toString()}',),
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
                                    child: InkWell(
                                      child: Image.asset('images/calendar.png',
                                          height: 22, width: 25,),
                                      onTap: () async {
                                        _selectDate(context);
                                      },
                                    ),

                                  ),
                                  Text(
                                    "DOB",
                                    style: TextStyle(
                                        fontFamily: 'transport', fontSize: 16),
                                  ),
                                ],
                              ),
                              VerticalDivider(width: 45.0),
                              Expanded(
                                  child: Center(
                                    child:Padding(
                                      padding:
                                      const EdgeInsets.only(right: 15, left: 15),
                                      child: Row(
                                        children: <Widget>[
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
                                                decoration: const InputDecoration(

                                                  border: UnderlineInputBorder(),
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 3,
                                                          color: CustomColor.yellow)),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 3,
                                                        color: Colors.amberAccent),
                                                  ),
                                                  // hintText: 'YYYY/MM/DD',
                                                  hintStyle: TextStyle(
                                                      fontFamily: 'transport',
                                                      fontSize: 15),
                                                ),
                                                readOnly: true,

                                                // onTap: () async {
                                                //   _selectDate(context);
                                                // },
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
                                    ),
                                  )),
                            ],
                          ),
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
                                      setState(() {
                                        radioButtonItem = 'Female';
                                        id = 1;
                                      });
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
                                      setState(() {
                                        radioButtonItem = 'Male';
                                        id = 2;
                                      });
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
                                      setState(() {
                                        radioButtonItem = 'Other';
                                        id = 3;
                                      });
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
                          //               textEditingController: dobController,
                          //               fontName: 'transport',
                          //               fontSize: 16,
                          //               enabledBorderColor: CustomColor.yellow, focusedBorderColor: CustomColor.yellow,
                          //               width: 1, broad: 3, textInputType: TextInputType.text, enable: true, hintText: '',),
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
                          //               enabledBorderColor: CustomColor.yellow, focusedBorderColor: CustomColor.yellow,
                          //               width: 1, broad: 3, textInputType: TextInputType.text, enable: true, hintText: '',),
                          //         )),
                          //   ],
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 15,left: 20,right: 20),
                          //   child: Container(
                          //     height: 100,
                          //     decoration:  BoxDecoration (
                          //       borderRadius:  BorderRadius.circular(8),
                          //       border:  Border.all(color: const Color(0xffffd91d)),
                          //     ),
                          //     child: Padding(
                          //       padding: const EdgeInsets.only(left: 15),
                          //       child: TextFormField(
                          //         // autovalidateMode: _submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                          //         decoration: InputDecoration(
                          //           border: InputBorder.none,
                          //           hintText: 'Enter Address ',
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
                          //   padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
                          //   child: Container(
                          //     height: 120,
                          //     decoration:  BoxDecoration (
                          //       borderRadius:  BorderRadius.circular(8),
                          //       border:  Border.all(color: const Color(0xffffd91d)),
                          //     ),
                          //     child: Padding(
                          //       padding: const EdgeInsets.only(left: 15),
                          //       child: TextFormField(
                          //         decoration: const InputDecoration(
                          //           border: InputBorder.none,
                          //           hintText: 'Enter Documents Details',
                          //         ),
                          //         keyboardType: TextInputType.multiline,
                          //         minLines: 1,//Normal textInputField will be displayed
                          //         maxLines: 8,// when user presses en
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(width: 2),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "icons/enter_mobile_number.png",
                                        height: 20,
                                      ),
                                      Container(width: 15),
                                      const Text("Select State",
                                          style: TextStyle(
                                              color: CustomColor.black,
                                              fontFamily: 'transport',
                                              fontSize: 16)),
                                    ],
                                  ),
                                ),
                                Container(width: 35),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "icons/enter_mobile_number.png",
                                        height: 20,
                                      ),
                                      Container(width: 15),
                                      const Text("Select City",
                                          style: TextStyle(
                                              color: CustomColor.black,
                                              fontFamily: 'transport',
                                              fontSize: 16)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    height: 60,
                                    child: Card(
                                      color: Colors.white,
                                      shape: UnderlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide:
                                          BorderSide(color: CustomColor.yellow)),
                                      child: Padding(
                                        padding: EdgeInsets.all(15),
                                        child: DropdownButton(
                                          underline: Container(),
                                          // hint: Text("Select State"),
                                          icon: Icon(Icons.keyboard_arrow_down),
                                          isDense: true,
                                          isExpanded: true,

                                          items: selectedState.map((e) {
                                            return DropdownMenuItem(
                                              value: e["state_id"].toString(),
                                              child: Text(e['name'].toString()),
                                            );
                                          }).toList(),
                                          value: states,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedCity = [];
                                              states = value;
                                              isStateSelected = true;
                                              for (int i = 0;
                                              i < selectedState.length;
                                              i++) {
                                                if (states.toString() ==
                                                    selectedState[i]['state_id']
                                                        .toString()) {
                                                  statName = selectedState[i]['name'];
                                                  print(statName);
                                                }
                                              }
                                              if (states != null) {
                                                citiesList(states);
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(width: 15),
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    height: 60,
                                    child: Card(
                                      color: Colors.white,
                                      shape: UnderlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide:
                                          BorderSide(color: CustomColor.yellow)),
                                      child: Padding(
                                        padding: EdgeInsets.all(15),
                                        child: DropdownButton<String>(
                                          underline: Container(),
                                          // hint: Text("Select City",),
                                          icon: Icon(Icons.keyboard_arrow_down),
                                          isDense: true,
                                          isExpanded: true,
                                          items: selectedCity.map((e) {
                                            return DropdownMenuItem<String>(
                                              child: Text(e["name"]),
                                              value: e["name"],
                                            );
                                          }).toList(),
                                          value: cities,
                                          onChanged: (value) {
                                            setState(() {
                                              cities = value;
                                              print(cities);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 0, bottom: 0),
                                child: Image.asset('assets/registration_no.png',
                                    height: 25, width: 25),
                              ),
                              const Text(
                                "PinCode",
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
                                          fontSize: 18.0, fontFamily: "transport"),
                                      keyboardType: TextInputType.number,
                                      maxLines: 1,
                                      controller: pinController,
                                      decoration: const InputDecoration(
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
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 0, bottom: 0),
                                child: Image.asset('assets/registration_no.png',
                                    height: 25, width: 25),
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
                                      decoration: const InputDecoration(
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
                          SizedBox(height: 110,),
                          Padding(
                            padding: const EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 20),
                            child: Button(textColor: CustomColor.black, size: 80, buttonTitle: "Update Profile",
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      OverlayLoadingProgress.start(context);
                                    });
                                    getUserData(
                                      context,
                                      firstNameController.text,
                                      lastNameController.text,
                                      emailController.text,
                                      _dateController.text,
                                      radioButtonItem,
                                      addressController.text ,
                                      cities,
                                      states,
                                      fileName,
                                      pinController.text,
                                    ).then((value) {
                                      if (value != null) {
                                        OverlayLoadingProgress.stop(context);
                                      } else {
                                        OverlayLoadingProgress.stop(context);
                                      }
                                    });
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.getString("firstName");
                                    prefs.getString("lastName");
                                    prefs.getString("email");
                                    prefs.getString("dob");
                                    prefs.getString("gender");
                                    Preferences.setFirstName(Preferences.firstname, firstNameController.text.toString());
                                    Preferences.setLastName(Preferences.lastname, lastNameController.text.toString());
                                    Preferences.setEmailID(Preferences.emailId, emailController.text.toString());
                                    Preferences.setDob(Preferences.dob, _dateController.text.toString());
                                    Preferences.setAddress(Preferences.address, addressController.text.toString());
                                    // Get.to(NumberVerifyScreenPage(firstName: firstNameController.text,
                                    //   lastName: lastNameController.text,mobileNumber:mobileNumberController.text));
                                  }

                                }
                            ),
                          )
                        ],
                      ),
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

  Widget bottomSheet() {
    return Container(
      height: 130.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Choose Profile Photo",
            style: TextStyle(fontFamily: 'transport', fontSize: 16),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  pickCameraImage();
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Image.asset("assets/camera.png"),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Camera",
                      style: TextStyle(fontFamily: 'transport'),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              GestureDetector(
                onTap: () {
                  pickImage();
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Image.asset("assets/gallery_image.png"),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Gallery",
                      style: TextStyle(fontFamily: "transport"),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              GestureDetector(
                onTap: () {
                  //pickImage();

                  setState(() {
                    imageCache.clear();
                    image=null;
                  });

                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Remove",
                      style: TextStyle(fontFamily: "transport"),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<List<RiderUserListData>> getRiderData() async {
    final response = await http.post(
      (Uri.parse('https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/userList')),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mobile_number': '8286566801',
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

  Future<http.Response?> awsUpload(String imagePath) async {
    final response = await http.post(
      Uri.parse(
          'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/getSignedUrlsgb/getSignedURL'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'contentType': 'img/jpeg',
        'filePath': imagePath,
      }),
    );
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)['status'];
      var data = jsonDecode(response.body)['data'];
      if (status == true) {
        awsUploadFinal(jsonDecode(response.body)['data']);
        print(response.body);
      } else {
        print(response.body);
      }
    } else {
      throw Exception('Failed to create album.');
    }
    return null;
  }

  Future<http.Response?> awsUploadFinal(path) async {
    final response = await http.put(
      Uri.parse(path),
      body: await file.readAsBytes(),
    );
    if (response.statusCode == 200) {
      OverlayLoadingProgress.stop(context);
      Get.snackbar("Message", "Successful Aws File",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: CustomColor.yellow,
          borderRadius: 5,
          colorText: CustomColor.white,
          margin: const EdgeInsets.all(15),
          duration: const Duration(seconds: 1));
      print(response.body);
    } else {
      OverlayLoadingProgress.stop(context);
      throw Exception('Failed to AWS.');
    }
    return null;
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

}


