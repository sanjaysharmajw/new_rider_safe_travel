import 'dart:convert';
import 'dart:async';

import 'dart:io';
import 'dart:math';
import 'package:age_calculator/age_calculator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/custom_button.dart';
import 'package:ride_safe_travel/rider_profile_view.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Models/CityModel.dart';

import '../Models/StateModel.dart';
import 'Aws/AwsSignedApi.dart';
import 'Aws/AwsUrlPath.dart';
import 'Error.dart';
import 'LoginModule/Api_Url.dart';
import 'LoginModule/MainPage.dart';
import 'LoginModule/custom_button.dart';
import 'LoginModule/custom_color.dart';
import 'LoginModule/preferences.dart';
import 'Models/UpdateRiderProfileModel.dart';
import 'MyTextField.dart';

import 'RiderUserListData.dart';
import 'Sharepreferences.dart';
import 'bottom_nav/custom_bottom_navi.dart';
import 'bottom_nav/home_page_nav.dart';
import 'bottom_nav/profile_nav.dart';
import 'color_constant.dart';


class RiderProfileEdit extends StatefulWidget {
  String backbutton;
  String birthdate;
  String state;
  String city;
  String pincode;
  String address;
  String firstname;
  String lastname;
  String emailId;
  String imageProfile;
  String mobileNumber;
  String gender;
  String emergencyContact;
  String emergencyContact1;
  String contactPerson;
  String contactPerson1;
  String bloodgroup;

  RiderProfileEdit(
      {Key? key,
        required this.birthdate,
        required this.address,
        required this.pincode,
        required this.city,
        required this.state,
        required this.emailId,
        required this.lastname,
        required this.firstname,
        required this.mobileNumber,
        required this.imageProfile,
        required this.gender,
      required this.emergencyContact,
      required this.bloodgroup,
      required this.contactPerson,
      required this.emergencyContact1,
      required this.contactPerson1,
      required this.backbutton})
      : super(key: key);

  @override
  State<RiderProfileEdit> createState() => _RiderProfileEditState();
}

class _RiderProfileEditState extends State<RiderProfileEdit> {
  // final TextEditingController _dateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  //final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emergencyContact0Controller = TextEditingController();
  final TextEditingController emergencyContact1Controller = TextEditingController();
  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController contactPerson1Controller = TextEditingController();
  final TextEditingController bloodgroupController = TextEditingController();


  var firstname;
  var lastname;
  var dob;
  var email;
  var myaddress;
  var pinNumber;
  var mobilenumber;
  var mystates;
  var mycities;
  var age;
  var gender;


  final _formKey = GlobalKey<FormState>();

  String radioButtonItem = 'Male';
  var id=0;
  String type = "";

  // late Future<DateTime?> selectedDate;
  String date = "";
  String from = "";

  // var selectedState = [];

  //var states;
  //var statName;
  //bool isStateSelected = false;

  // var selectedCity = [];
  //var citiesname;
  //var stateid;
  //bool isCitySelected = false;

  DateTime selectedDate = DateTime.now();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  //var mobile=Preferences.getMobileNumber(Preferences.mobileNumber);
  // File? imageTemp;
  // var myState;
  late Future<List<RiderUserListData>> futurePost;

  var _future;

  var profile;
  var statename;
  var cityname;

  var stringRandomNumber;
  File? image;
  var filePath;
  late File file;
  var fileName = "";

  var response_date = "";

  String imageFilePath = "";
  var birthDate;
  AwsSignedApi awsSignedApi = AwsSignedApi();
  var uploadedImage;

  @override
  initState() {
    OverlayLoadingProgress.stop();
    print(widget.birthdate);

    print("###################");
    print(widget.pincode);
    print(widget.city);
    print(widget.state);
    print(widget.imageProfile);
    print(widget.gender);

    print("********************************888");
    response_date=widget.birthdate.toString();
    print(response_date);
    if(response_date.toString() == "null" || response_date.toString().isEmpty) {
      var agedate = widget.birthdate.toString().split('-');
      var date = agedate[0];
       agedate[1]=agedate[1];
      var month = (int.parse(agedate[1]) < 10 ? '0' +
          int.parse(agedate[1]).toString() : agedate[1]);
      var year = (int.parse(agedate[2]) < 10 ? '0' +
          int.parse(agedate[2]).toString() : agedate[2]);
      response_date = date + "-" + month + "-" + year;
      dobController.text = response_date.toString();
      print(dobController.text.toString());
      print("####################");
    }

    dobController.text = response_date.toString();
    firstNameController.text = widget.firstname.toString();
    lastNameController.text = widget.lastname.toString();
    profile = widget.imageProfile.toString();
    addressController.text = widget.address.toString();
    stateController.text=widget.state.toString();
    cityController.text=widget.city.toString();
    pinController.text = widget.pincode.toString();
    emailController.text = widget.emailId.toString();
    mobileNumberController.text = widget.mobileNumber.toString();
    emergencyContact0Controller.text = widget.emergencyContact.toString();
    radioButtonItem = widget.gender.toString();
    emergencyContact1Controller.text = widget.emergencyContact1.toString();
    contactPerson1Controller.text = widget.contactPerson1.toString();
    contactPersonController.text = widget.contactPerson.toString();
    bloodgroupController.text = widget.bloodgroup.toString();
    if(radioButtonItem=='Female')
    {
      id=1;
    }
    if(radioButtonItem=='Male')
    {
      id=2;
    }
    if(radioButtonItem=='Other')
    {
      id=3;
    }
    // id=3;
    print("************" + addressController.text.toString() + "************");
    setState(() {

    });

    // Preferences.setAge(Preferences.age, age);
    //SharePreferences.saveAge(age.toString());

    Random random = Random();
    //statesList();
    // expiryDateController.text = "";

    int randomNumber = random.nextInt(1000000);
    // _future = getRiderData();
    stringRandomNumber = randomNumber.toString();
    preferences();


    super.initState();


  }



  void preferences() async {
    await Preferences.setPreferences();
    age = Preferences.getAge();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      file = File(await image.path);
      filePath = imageTemp.path.split(Platform.pathSeparator).last;
      awsUpload(stringRandomNumber + filePath);
      imageFilePath = AwsUrl.awsImagePathUrl + stringRandomNumber + filePath;
      print("Image Picker: " + imageFilePath);
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
      //fileName = AwsUrl.awsImagePathUrl + stringRandomNumber + filePath;
      imageFilePath = AwsUrl.awsImagePathUrl + stringRandomNumber + filePath;

      print("Image Picker: " + stringRandomNumber + filePath);
      OverlayLoadingProgress.start(context);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: (widget.backbutton == 'bottomNav') ? CustomColor.white : appBlue,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
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
          title: Text("edit_your_profile".tr,style: TextStyle(fontFamily: "Gilroy",fontSize: 22,color: Colors.white),),

        ),
        body: Container(
          height: 1000,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
               child: Column(
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /* Padding(
                            padding: EdgeInsets.only(left: 20.sp, top: 30.sp),
                            child: Text(
                              "Edit your profile",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Gilroy",
                                  color: CustomColor.black),
                            ),
                          ),*/
                          SizedBox(
                            height: 40.h,
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
                                                  0, 10, 10, 0),
                                              child: Stack(
                                                alignment: Alignment.bottomRight,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: CustomColor.black,
                                                    radius: 45.0,
                                                    child: CircleAvatar(
                                                      radius: 43.0,
                                                      backgroundColor: Colors.white,
                                                      //backgroundImage: NetworkImage(),
                                                      child: AspectRatio(
                                                        aspectRatio: 1,
                                                        child: ClipOval(
                                                          child: (image != null)
                                                              ? Image.file(
                                                            image!,
                                                            width: 100,
                                                            height: 100,
                                                            fit: BoxFit.fill,
                                                          )
                                                              : Image.network(
                                                            widget.imageProfile,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                 Container(
                                                   height: 35,
                                                   width: 35,
                                                   decoration: BoxDecoration(

                                                       color: Colors.white,
                                                     shape: BoxShape.circle
                                                   ),child: Icon(Icons.camera_alt_outlined,color: appBlack
                                                     ,)
                                                 )


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
                                width: 14.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    firstNameController.text.toString() +
                                        " " +
                                        lastNameController.text.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.sp,
                                        fontFamily: "Gilroy",
                                        color: CustomColor.riderprofileColor),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    mobileNumberController.text.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.sp,
                                        fontFamily: "Gilroy",
                                        color: CustomColor.text),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 64.w,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20.sp),
                                child: Icon(Icons.person_2_outlined,size: 20,)
                              ),
                              SizedBox(width: 5,),
                              Container(
                                width: 95,
                                child: Text(
                                  "first_name".tr,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Gilroy",
                                      color: CustomColor.riderprofileColor),
                                ),
                              ),

                              Expanded(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: TextFormField(

                                        showCursor: true,
                                        cursorHeight:30,
                                        cursorWidth: 2.0,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[a-zA-Z\]")),
                                          FilteringTextInputFormatter.deny('  '),

                                        ],
                                        style:TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: "Gilroy",
                                            color: CustomColor.riderprofileColor),
                                        controller: firstNameController,
                                        textCapitalization: TextCapitalization.words,
                                        keyboardType: TextInputType.text,

                                        decoration: InputDecoration(
                                          border: const UnderlineInputBorder(),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.black45)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2, color: Colors.black54)),
                                        ),
                                        onChanged: (value) {
                                          firstname = value;
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'please_enter_your_first_name'.tr;
                                          }
                                          return value.length < 2 ? 'Name must be greater than two characters' : null;
                                        },
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 20.sp,),
                                  child: Icon(Icons.person_2_outlined,size: 20,)
                              ),
                              SizedBox(width: 5,),
                              Container(
                                width: 95,
                                child: Text(
                                  "last_name".tr,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Gilroy",
                                      color: CustomColor.riderprofileColor),
                                ),
                              ),

                              Expanded(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: TextFormField(
                                        showCursor: true,
                                        cursorHeight:30,
                                        cursorWidth: 2.0,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[a-zA-Z\]")),
                                          FilteringTextInputFormatter.deny('  ')
                                        ],
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: "Gilroy",
                                            color: CustomColor.riderprofileColor),
                                        controller: lastNameController,
                                        textCapitalization: TextCapitalization.words,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: const UnderlineInputBorder(),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.black45)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2, color: Colors.black54)),
                                  ),
                                        onChanged: (value) {
                                          lastname = value;
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'please_enter_your_last_name'.tr;
                                          }
                                          return value.length < 2 ? 'Name must be greater than two characters' : null;
                                        },
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 20.sp),
                                  child: Icon(Icons.email_outlined,size: 20,)
                              ),
                              SizedBox(width: 5,),
                              Container(
                                width: 95,
                                child: Text(
                                  "email_id".tr,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Gilroy",
                                      color: CustomColor.riderprofileColor),
                                ),
                              ),

                              Expanded(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: TextFormField(
                                        showCursor: true,
                                        cursorHeight:30,
                                        cursorWidth: 2.0,
                                        inputFormatters: [

                                          FilteringTextInputFormatter.deny(' '),

                                        ],
                                        style:TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: "Gilroy",
                                            color: CustomColor.riderprofileColor),
                                        controller: emailController,
                                       // textCapitalization: TextCapitalization.none,
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          border: const UnderlineInputBorder(),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.black45)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2, color: Colors.black54)),
                                        ),
                                        onChanged: (value) {
                                          email = value;
                                        },
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty) {
                                            return 'email_is_required !'.tr;
                                          } if (
                                          !RegExp(
                                            r'^[a-z0-9]+@[a-z]+\.[a-z]')
                                          .hasMatch(value)
                                         // EmailValidator.validate(value)
                                          ) {
                                            return 'email_is_required !'.tr;
                                          }
                                          return null ;
                                        },
                                      ),
                                    ),
                                  )),
                            ],
                          ),

                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 20.sp),
                                  child: Icon(Icons.calendar_month_outlined,size: 25,)
                              ),
                              SizedBox(width: 5,),
                              Container(
                                width: 90 ,
                                child: Text(
                                  "dob".tr,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Gilroy",
                                      color: CustomColor.riderprofileColor),
                                ),
                              ),

                              Expanded(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: TextFormField(
                                      // keyboardType: TextInputType.number,
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Gilroy",
                                          color: CustomColor.riderprofileColor),
                                      maxLines: 1,
                                      controller: dobController,
                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.black45)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2, color: Colors.black54)),
                                      ),
                                      readOnly: true,

                                      onTap: () async {
                                        _selectDate(context);
                                      },
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty) {
                                          return 'please_enter_your_date_of_birth'.tr;
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        dob = value;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 20.sp),
                                  child: Icon(Icons.bloodtype_outlined,size: 25,)
                              ),
                              SizedBox(width: 5,),
                              Container(
                                width: 90,
                                child: Text(
                                  "blood_group".tr,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Gilroy",
                                      color: CustomColor.riderprofileColor),
                                ),
                              ),

                              Expanded(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: TextFormField(

                                        showCursor: true,
                                        cursorHeight:30,
                                        cursorWidth: 2.0,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp("[A|B|AB|O\+|\-]")),
                                          FilteringTextInputFormatter.deny(' '),

                                        ],
                                        style:TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: "Gilroy",
                                            color: CustomColor.riderprofileColor),
                                        controller: bloodgroupController,
                                        textCapitalization: TextCapitalization.words,
                                        keyboardType: TextInputType.text,

                                        decoration: InputDecoration(
                                          border: const UnderlineInputBorder(),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.black45)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2, color: Colors.black54)),
                                        ),

                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty) {
                                            return 'blood_group_is_required !'.tr;
                                          }
                                          if(value.length < 4){
                                            return null;
                                          }
                                          return 'blood_group_is_required !'.tr;
                                        },
                                      ),
                                    ),
                                  )),
                            ],
                          ),

                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 20.sp),
                                  child: Icon(Icons.location_city_outlined,)
                              ),
                              SizedBox(width: 5,),
                              Container(
                                width: 90,
                                child: Text(
                                  "state".tr,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Gilroy",
                                      color: CustomColor.riderprofileColor),
                                ),
                              ),

                              Expanded(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: TextFormField(

                                        showCursor: true,
                                        cursorHeight:30,
                                        cursorWidth: 2.0,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[A-Za-z]")),
                                          FilteringTextInputFormatter.deny(' '),

                                        ],
                                        style:TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: "Gilroy",
                                            color: CustomColor.riderprofileColor),
                                        controller: stateController,
                                        textCapitalization: TextCapitalization.words,
                                        keyboardType: TextInputType.text,

                                        decoration: InputDecoration(
                                          border: const UnderlineInputBorder(),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.black45)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2, color: Colors.black54)),
                                        ),

                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty) {
                                            return 'please_enter_your_state_name !'.tr;
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  )),
                            ],
                          ),

                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 20.sp),
                                  child: Icon(Icons.location_city_outlined,)
                              ),
                              SizedBox(width: 5,),
                              Container(
                                width: 90,
                                child: Text(
                                  "city".tr,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Gilroy",
                                      color: CustomColor.riderprofileColor),
                                ),
                              ),

                              Expanded(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: TextFormField(

                                        showCursor: true,
                                        cursorHeight:30,
                                        cursorWidth: 2.0,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[A-Za-z]")),
                                          FilteringTextInputFormatter.deny(' '),

                                        ],
                                        style:TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: "Gilroy",
                                            color: CustomColor.riderprofileColor),
                                        controller: cityController,
                                        textCapitalization: TextCapitalization.words,
                                        keyboardType: TextInputType.text,

                                        decoration: InputDecoration(
                                          border: const UnderlineInputBorder(),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.black45)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2, color: Colors.black54)),
                                        ),

                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty ) {
                                            return 'please_enter_your_city_name!'.tr;
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  )),
                            ],
                          ),

                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 20.sp),
                                  child: Icon(Icons.pin_outlined)
                              ),
                              SizedBox(width: 5,),
                              Container(
                                width: 90,
                                child: Text(
                                  "pin_code".tr,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Gilroy",
                                      color: CustomColor.riderprofileColor),
                                ),
                              ),

                              Expanded(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: TextFormField(

                                        showCursor: true,
                                        cursorHeight:30,
                                        cursorWidth: 2.0,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[0-9]")),
                                          FilteringTextInputFormatter.deny(' '),

                                        ],
                                        style:TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: "Gilroy",
                                            color: CustomColor.riderprofileColor),
                                        controller: pinController,
                                        textCapitalization: TextCapitalization.words,
                                        keyboardType: TextInputType.number,

                                        decoration: InputDecoration(
                                          border: const UnderlineInputBorder(),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.black45)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2, color: Colors.black54)),
                                        ),

                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty || value.length != 6) {
                                            return 'please_enter_6_digit_number !';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 20.sp,right: 10),
                                  child: Icon(Icons.person_3_outlined,size: 20,)
                              ),
                              SizedBox(width: 5,),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Text(
                                  "gender".tr,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Gilroy",
                                      color: CustomColor.riderprofileColor),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 23,right: 5),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 25,
                                      child: Radio(
                                        fillColor: MaterialStateColor.resolveWith(
                                                (states) => Colors.black54),
                                        focusColor: MaterialStateColor.resolveWith(
                                                (states) => Colors.black54),
                                        value: 1,
                                        groupValue: id,
                                        onChanged: (val) {
                                          setState(() {
                                            radioButtonItem = 'Female';
                                            id = 1;
                                          });
                                        },
                                      ),
                                    ),

                                     Text(
                                      'female'.tr,
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Gilroy",
                                          color: CustomColor.riderprofileColor),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 5,right: 5),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 25,
                                      child: Radio(
                                        fillColor: MaterialStateColor.resolveWith(
                                                (states) => Colors.black54),
                                        focusColor: MaterialStateColor.resolveWith(
                                                (states) => Colors.black54),
                                        value: 2,
                                        groupValue: id,
                                        onChanged: (val) {
                                          setState(() {
                                            radioButtonItem = 'Male';
                                            id = 2;
                                          });
                                        },
                                      ),
                                    ),
                                     Text(
                                      'male'.tr,
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Gilroy",
                                          color: CustomColor.riderprofileColor),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 5,right: 5),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 25,
                                      child: Radio(
                                        fillColor: MaterialStateColor.resolveWith(
                                                (states) => Colors.black54),
                                        focusColor: MaterialStateColor.resolveWith(
                                                (states) => Colors.black54),
                                        value: 3,
                                        groupValue: id,
                                        onChanged: (val) {
                                          setState(() {
                                            radioButtonItem = 'Other';
                                            id = 3;
                                          });
                                        },
                                      ),
                                    ),
                                     Text(
                                      'other'.tr,
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Gilroy",
                                          color: CustomColor.riderprofileColor),
                                    ),
                                  ],
                                ),
                              )

                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                         /* const SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(width: 2),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [

                                      const Text("State",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Gilroy",
                                              color: CustomColor.riderprofileColor),),
                                    ],
                                  ),
                                ),

                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Container(width: 15),
                                      const Text("City",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Gilroy",
                                              color: CustomColor.riderprofileColor),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    height: 45,
                                    child: TextFormField(
                                      showCursor: true,
                                      cursorHeight:30,
                                      cursorWidth: 2.0,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your state name';
                                        }
                                        return null;
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[A-Za-z]")),
                                        FilteringTextInputFormatter.deny('  ')
                                      ],
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Gilroy",
                                          color: CustomColor.riderprofileColor),
                                      controller: stateController,
                                      textCapitalization: TextCapitalization.words,
                                      keyboardType: TextInputType.text,

                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.black45)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2, color: Colors.black54)),
                                      ),
                                      onChanged: (value) {
                                        mystates = value;
                                      },
                                    ),
                                  ),
                                ),
                                Container(width: 15),
                                Expanded(

                                  flex: 2,
                                  child: SizedBox(
                                    height: 45,
                                    child: TextFormField(
                                      showCursor: true,
                                      cursorHeight:30,
                                      cursorWidth: 2.0,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your city name';
                                        }
                                        return null;
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[A-Za-z]")),
                                        FilteringTextInputFormatter.deny('  ')
                                      ],
                                      style:TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Gilroy",
                                          color: CustomColor.riderprofileColor),
                                      controller: cityController,
                                      textCapitalization: TextCapitalization.words,
                                      keyboardType: TextInputType.text,

                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.black45)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2, color: Colors.black54)),
                                      ),
                                      onChanged: (value) {
                                        mycities = value;
                                      },
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
                                padding: const EdgeInsets.only(left: 20),
                                child: const Text(
                                  "PinCode",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Gilroy",
                                      color: CustomColor.riderprofileColor),
                                ),
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
                                    child: Center(
                                      child: TextFormField(
                                        showCursor: true,
                                        cursorHeight:30,
                                        cursorWidth: 2.0,
                                        validator: (value) {
                                          if (value == null || value.isEmpty || value.length != 6) {
                                            return 'Please enter 6 pincode.';
                                          }
                                          return null;
                                        },
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[0-9]")),
                                          LengthLimitingTextInputFormatter(6),
                                        ],
                                        style:TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Gilroy",
                                            color: CustomColor.riderprofileColor),
                                        controller: pinController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: const UnderlineInputBorder(),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.black45)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2, color: Colors.black54)),
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
                          ),*/
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 20.sp),
                                  child: Icon(Icons.location_on_outlined)
                              ),
                              SizedBox(width: 5,),

                               Text(
                                "address".tr,
                                style: TextStyle(
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
                                  flex: 2,
                                  child: SizedBox(
                                    height: 45,
                                    child: TextFormField(
                                      showCursor: true,
                                      cursorHeight:30,
                                      cursorWidth: 2.0,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please_enter_your_address'.tr;
                                        }
                                        return null;
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[A-Za-z0-9'\.\-\s\,\ ]")),
                                        FilteringTextInputFormatter.deny('  ')
                                      ],
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                            fontFamily: "Gilroy",
                                          color: CustomColor.riderprofileColor),
                                      controller: addressController,
                                      textCapitalization: TextCapitalization.words,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 2,

                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.black45)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2, color: Colors.black54)),
                                      ),
                                      onChanged: (value) {
                                        myaddress = value;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Icon(Icons.person,size: 20,),
                                      SizedBox(width: 2,),

                                      Text("contact_person_name".tr,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Gilroy",
                                              color: CustomColor.riderprofileColor),),
                                    ],
                                  ),
                                ),
                                Container(width: 3),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [

                                      Icon(Icons.call_outlined,size: 20,),
                                      SizedBox(width: 2,),

                                       Text("emergency_contact_number".tr,
                                          style:TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,

                                              fontFamily: "Gilroy",
                                              color: CustomColor.riderprofileColor),),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 45,
                                    child: TextFormField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[A-Za-z \]")),
                                        FilteringTextInputFormatter.deny('  '),
                                      ],
                                      style:  TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Gilroy",
                                          color: CustomColor.riderprofileColor),
                                      maxLines: 1,
                                      controller: contactPersonController,
                                      textCapitalization: TextCapitalization.words,
                                      keyboardType: TextInputType.text,

                                        // suffixIcon:
                                        //GestureDetector(
                                        //  onTap: (){
                                        // },
                                        //child: Image(
                                        // image: AssetImage("images/circle_checked.png"),
                                        //width: 0,
                                        //height: 0,
                                        //)
                                        //),
                                        decoration: InputDecoration(
                                          border: const UnderlineInputBorder(),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.black45)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2, color: Colors.black54)),
                                        ),
                                      onTap: () async {

                                      },
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty) {
                                          return 'please_enter_person_name '.tr;
                                        }
                                        return null;
                                      },
                                    ),

                                  ),
                                ),
                                Container(width: 15),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 45,
                                    child: TextFormField(
                                      controller: emergencyContact0Controller,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9]")),
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Gilroy",
                                          color: CustomColor.riderprofileColor),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        enabledBorder:
                                        const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.black54),
                                        ),
                                        focusedBorder:
                                        const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.black54),
                                        ),

                                        prefixText: "+91",
                                        prefixStyle: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: "Gilroy",
                                            color: CustomColor.riderprofileColor),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            value.length != 10) {
                                          return 'please_enter_10_digit_mobile_number'.tr;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Icon(Icons.person,size: 20,),
                                      SizedBox(width: 2,),

                                      Text("contact_person_name".tr,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Gilroy",
                                            color: CustomColor.riderprofileColor),),
                                    ],
                                  ),
                                ),
                                Container(width: 3),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [

                                      Icon(Icons.call_outlined,size: 20,),
                                      SizedBox(width: 2,),

                                      Text("emergency_contact_number".tr,
                                        style:TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,

                                            fontFamily: "Gilroy",
                                            color: CustomColor.riderprofileColor),),
                                    ],
                                  ),
                                ),

                              ],
                            ),
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
                                            RegExp("[A-Za-z \]")),
                                        FilteringTextInputFormatter.deny('  '),
                                      ],
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Gilroy",
                                          color: CustomColor.riderprofileColor),
                                      maxLines: 1,
                                      controller: contactPerson1Controller,
                                      textCapitalization: TextCapitalization.words,
                                      keyboardType: TextInputType.text,

                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.black45)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2, color: Colors.black54)),
                                      ),
                                      onTap: () async {

                                      },
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty) {
                                          return 'please_enter_person_name '.tr;
                                        }
                                        return null;
                                      },
                                    ),

                                  ),
                                ),
                                Container(width: 15),
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    height: 45,
                                    child: TextFormField(
                                      controller: emergencyContact1Controller,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9]")),
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      style:  TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Gilroy",
                                          color: CustomColor.riderprofileColor),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        enabledBorder:
                                        const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.black54),
                                        ),
                                        focusedBorder:
                                        const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.black54),
                                        ),

                                        prefixText: "+91",
                                        prefixStyle:  TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: "Gilroy",
                                            color: CustomColor.riderprofileColor),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            value.length != 10) {
                                          return 'please_enter_10_digit_mobile_number'.tr;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),

                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 20),
                        child: CustomButton(press: () async{
                          if (_formKey.currentState!.validate()) {
                            await Preferences.setPreferences();
                            String userId = Preferences.getId(Preferences.id);
                            firstname = firstNameController.text.toString();
                            lastname = lastNameController.text.toString();
                            dob = dobController.text.toString();
                            email = emailController.text.toString();
                            myaddress = addressController.text.toString();
                            pinNumber = pinController.text.toString();
                            mobilenumber = mobileNumberController.text.toString();
                            gender=radioButtonItem.toString();
                            uploadedImage = imageFilePath.toString();
                            mystates = stateController.text.toString();
                            mycities = cityController.text.toString();
                            emergencyContact0Controller.text.toString();
                            print(userId);
                            print(pinNumber);
                            print(uploadedImage);
                            print(mycities);
                            print(mystates);
                            print(myaddress);
                            print(gender);
                            print("**************************");

                            // if (age < 6) {
                            //   openAndCloseLoadingDialog();
                            // } else {

                            updateProfile(userId);
                            // OverlayLoadingProgress.start(context);
                            // }
                          }
                        }, buttonText: "update_profile".tr)

                      /*Button(
                              textColor: CustomColor.black,
                              size: 80,
                              buttonTitle: "Update Profile",
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await Preferences.setPreferences();
                                  String userId = Preferences.getId(Preferences.id);
                                  firstname = firstNameController.text.toString();
                                  lastname = lastNameController.text.toString();
                                  dob = dobController.text.toString();
                                  email = emailController.text.toString();
                                  myaddress = addressController.text.toString();
                                  pinNumber = pinController.text.toString();
                                  mobilenumber = mobileNumberController.text.toString();
                                  gender=radioButtonItem.toString();
                                  uploadedImage = imageFilePath.toString();
                                  mystates = stateController.text.toString();
                                  mycities = cityController.text.toString();
                                  emergencyContact0Controller.text.toString();
                                  print(userId);
                                  print(pinNumber);
                                  print(uploadedImage);
                                  print(mycities);
                                  print(mystates);
                                  print(myaddress);
                                  print(gender);
                                  print("**************************");

                                  // if (age < 6) {
                                  //   openAndCloseLoadingDialog();
                                  // } else {

                                  updateProfile(userId);
                                  // OverlayLoadingProgress.start(context);
                                  // }
                                }
                              }),*/
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> openAndCloseLoadingDialog() async {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          ),
        ),
      ),
    );

    await Future.delayed(Duration(seconds: 3));
    // Dismiss CircularProgressIndicator
    Navigator.of(Get.overlayContext!).pop();

    Get.dialog(
      AlertDialog(
        content: Text("Please check your birth date!"),
        actions: <Widget>[
          TextButton(
            child: Text("CLOSE"),
            onPressed: () {
              Get.back();
            },
          )
        ],
      ),
      barrierDismissible: false,
    );

    // await Future.delayed(Duration(seconds: 3));
    // Navigator.of(Get.overlayContext).pop();
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: selectedDate);
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthDate =
        "${picked.toLocal().day}-${picked.toLocal().month}-${picked.toLocal().year}";
        dobController.text = birthDate;
        // print()
        // Get.snackbar("Selcted Date", birthDate.toString());
        // calAge(birthDate);
        //calculateAge(picked);
      });
    }
  }

  int calculateAge(DateTime birthDate) {

    DateTime currentDate = DateTime.now();
    var age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    //print("age cal: $age");
    //Preferences.setAge(age);
    return age;
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
           Text(
            "choose_profile_photo".tr,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                     Text(
                      "camera".tr,
                      style: TextStyle(fontFamily: 'Gilroy'),
                    )
                  ],
                ),
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
                     Text(
                      "gallery".tr,
                      style: TextStyle(fontFamily: "Gilroy"),
                    )
                  ],
                ),
              ),

              GestureDetector(
                onTap: () {
                  //pickImage();

                  setState(() {
                    imageCache.clear();
                    image = null;
                  });

                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    const SizedBox(
                      width: 10,
                    ),
                     Text(
                      "remove".tr,
                      style: TextStyle(fontFamily: "Gilroy"),
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

    await Preferences.setPreferences();
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    String mobileNumber = Preferences.getMobileNumber(Preferences.mobileNumber);
    print(mobileNumber);
    print("______________________________________");
    final response = await http.post(
      (Uri.parse(
          'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/userList')),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': loginToken
      },
      body: jsonEncode(<String, String>{
        'mobile_number': mobileNumber,
      }),
    );

    if (response.statusCode == 200) {
      // OverlayLoadingProgress.stop(context);
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
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    final response = await http.post(
      Uri.parse(
          'https://l8olgbtnbj.execute-api.ap-south-1.amazonaws.com/dev/api/getSignedUrlsgb/getSignedURL'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': loginToken
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
      OverlayLoadingProgress.stop();
      Get.snackbar("Message", "Successful Aws File",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: CustomColor.yellow,
          borderRadius: 5,
          colorText: CustomColor.white,
          margin: const EdgeInsets.all(15),
          duration: const Duration(seconds: 1));
      print(response.body);
    } else {
      OverlayLoadingProgress.stop();
      throw Exception('Failed to AWS.');
    }
    return null;
  }


  /* Future<StateModel> statesList() async {

    final response = await http.post(
      Uri.parse(ApiUrl.stateApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    OverlayLoadingProgress.stop();
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
  }  */

  Future<http.Response?> updateProfile(String userId) async {
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    //  var updatedAge= Preferences.getAge(Preferences.age);
    OverlayLoadingProgress.start(context);
    /* mystates = statename.toString();
    if (statName.toString() != null) {
      mystates = statName.toString();
      Get.snackbar("change mystate", mystates);
    }

   mycities = cityname.toString();
    if (citiesname.toString() != null) {
      mycities = citiesname.toString();
      Get.snackbar("change mycity", mycities);
    }*/




    uploadedImage = profile.toString();
    //Get.snackbar("image", uploadedImage);
    if (imageFilePath.toString() != "") {
      uploadedImage = imageFilePath.toString();


    }

    email = emailController.text.toString();
    //Get.snackbar("image", email);
    if (emailController.text.toString() != "") {
      email = emailController.text.toString();
    }






    myaddress = addressController.text.toString();
    if (addressController.text.toString() == "") {
      myaddress = addressController.text.toString();
    }
    var agedate=dobController.text.toString().split('-');
    var year=agedate[2];
    var month=(int.parse(agedate[1])<10?'0'+int.parse(agedate[1]).toString():agedate[1]);
    var date=(int.parse(agedate[0])<10?'0'+int.parse(agedate[0]).toString():agedate[0]);

    // print(DateTime.parse(agedate[2]+"-"+'0'+agedate[1].padLeft(1, '0')+"-"+agedate[0].padLeft(1, '0'))); // 2020-01-02 00:00:00.000


    int age=calculateAge(DateTime.parse(year+"-"+month+"-"+date));
    if(age<6)
    {
      Get.snackbar("Invalid Age", "Age should be greater than 6 years");
      OverlayLoadingProgress.stop();
      return null;
    }
    else {
      var data = {
        "user_id": userId.toString(),
        "first_name": firstname,
        "last_name": lastname,
        "email_id": email,
        "gender": gender,
        "dob": date+"-"+month+"-"+year,
        "mobile_number": mobilenumber,
        "alternate_contact_no": "",
        "profile_image": uploadedImage,
        "marital_status": "",
        "city": mycities,
        "state": mystates,
        "permanent_address": {
          "address": myaddress,
          "city": mycities,
          "state": mystates,
          "pincode": pinNumber,
        },
        "present_address": {
          "address": myaddress,
          "city": mycities,
          "state": mystates,
          "pincode": pinNumber,
        },
        "same_address": myaddress,
        "dldetails": {
          "dl_number": "",
          "dl_image": "",
          "dl_expiry_date": "",
          "dl_mobile_number": "",
          "accidental_history": "",
          "accidental_discription": "",
          "available24by7": "",
          "shift_time_from": "",
          "shift_time_to": "",
        },
        "address": myaddress,
        "emergency_contact_no": emergencyContact0Controller.text.toString(),
      "emergency_contact_person":contactPersonController.text.toString(),
      "emergency_contact_no1":emergencyContact1Controller.text.toString(),
      "emergency_contact_person1":contactPerson1Controller.text.toString(),
      "blood_group":bloodgroupController.text.toString()
      };
      final response = await http.post(
        Uri.parse(
            'https://l8olgbtnbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/updateUserProfile'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': loginToken
        },
        body: jsonEncode(data),
      );
      print(jsonEncode(data));

      if (response.statusCode == 200) {
        bool status = jsonDecode(response.body)[ErrorMessage.status];
        var msg = jsonDecode(response.body)[ErrorMessage.message];
        setState(() {
          getRiderData();
        });


        print(response.body);
        if (status == true) {
          Get.snackbar("Message", msg, snackPosition: SnackPosition.BOTTOM);
          OverlayLoadingProgress.stop();
          await Preferences.setPreferences();
          Preferences.setProfileImage(uploadedImage.toString());

          print("imageprofile:" + Preferences.getProfileImage());
          //Get.to(MainPage());
          Get.to(CustomBottomNav());
        } else {
          OverlayLoadingProgress;

          //Get.snackbar("Message", msg, snackPosition: SnackPosition.BOTTOM);
        }
        return null;
      } else {
        throw Exception('Failed.');
      }
    }
  }
}