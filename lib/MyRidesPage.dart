import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/Utils/view_image.dart';
import 'package:ride_safe_travel/color_constant.dart';
import 'Error.dart';
import 'LoginModule/Api_Url.dart';
import 'LoginModule/custom_color.dart';
import 'LoginModule/preferences.dart';
import 'Models/RideDataModel.dart';
import 'bottom_nav/custom_bottom_navi.dart';

class MyRidesPage extends StatefulWidget {
  String changeAppbar;
   MyRidesPage({Key? key, required this.changeAppbar}) : super(key: key);

  @override
  State<MyRidesPage> createState() => _MyRidesPageState();
}

class _MyRidesPageState extends State<MyRidesPage> {
  var image;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(

          backgroundColor:  appBlue,
          elevation: 0,
          title:  Text("My Rides",
              style: TextStyle(color:  appWhiteColor,fontSize: 22, fontFamily: 'Gilroy',)),
          leading: IconButton(
            color:  appWhiteColor,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomBottomNav()));
            },
            icon: const Icon(Icons.arrow_back_outlined),
          ),
        ),

        body: FutureBuilder<List<RideDataModel>>(
          future: getData(),
          builder: (context, snapshot) {

            if (snapshot.hasData) {
              return snapshot.data!.isEmpty ? Center(child: Text('Data not found',style: TextStyle(fontSize: 20,color: Colors.black12),)) :
                ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  image = snapshot.data![index].driverPhoto.toString();
                  DateTime tempDate = DateTime.parse(snapshot.data![index].date.toString());


                 //DateFormat.yMd('es').format(now)
                  final DateFormat formatter = DateFormat.yMMMd();
                  final String formatted = formatter.format(tempDate);
                  print("RideDate..."+formatted.toString());
                  return InkWell(
                    onTap: () {
                      setState(() {
                        // Get.to(FamilyMemberViewRiderMap(
                        //   rideId: snapshot.data![index].id.toString(), driverName: snapshot.data![index].driverName.toString(), driverImage: snapshot.data![index].driverPhoto.toString(),
                        // driverLicenseNo: snapshot.data![index].drivingLicenceNumber.toString(), driverMobile:
                        // snapshot.data![index].driverMobileNumber.toString(),
                        //vRegistration: snapshot.data![index].vehicleRegistrationNumber.toString(),
                        // vModel:  snapshot.data![index].vehicleModel.toString(), vOwner: snapshot.data![index].ownerName.toString()));
                      });
                    },
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: CustomColor.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15,top: 15),
                                    child: Text(  snapshot.data![index].vehicleRegistrationNumber
                                        .toString() !=
                                        "null"
                                        ? snapshot.data![index].vehicleRegistrationNumber
                                        .toString()
                                        : "NA",
                                        style: const TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontSize: 18,
                                            color: CustomColor.black)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15,top: 15),
                                    child: Text(  formatted !=
                                        "null"
                                        ? formatted
                                        : "NA",
                                        style: const TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontSize: 15,
                                            color: CustomColor.black)),
                                  ),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.only(right: 10,top: 15,left: 10,bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Timing : ",style: const TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontSize: 16,
                                            color: CustomColor.black,fontWeight: FontWeight.bold)),
                                        Text( snapshot.data![index].startTime
                                            .toString() !=
                                            "null"
                                            ? snapshot.data![index].startTime
                                            .toString()
                                            : "NA",style: const TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontSize: 16,
                                            color: CustomColor.black)),
                                        Text(snapshot.data![index].startTime
                                            .toString() !=
                                            "null"
                                            ? " to "
                                            : " ",style: const TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontSize: 16,
                                            color: CustomColor.black)),
                                        Text( snapshot.data![index].endTime
                                            .toString() !=
                                            "null"
                                            ? snapshot.data![index].endTime
                                            .toString()
                                            : "NA",style: const TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontSize: 16,
                                            color: CustomColor.black)),
                                      ],
                                    ),
                                  
                                  ],
                                ),
                              ),
                             /* Padding(
                                padding: const EdgeInsets.only(left: 15,bottom: 10),
                                child: Row(
                                  children: [
                                  CircularImage(
                                      imageUrl: image,
                                      boxFit: BoxFit.fill,
                                      width: 60,
                                      height: 60,
                                  ),
                                  /* CircleAvatar(
                                      backgroundColor:
                                      Colors.black54,
                                      radius: 27.0,
                                      child: CircleAvatar(
                                        radius: 25.0,
                                        backgroundColor:
                                        Colors.white,
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: ClipOval(
                                            //""
                                            child:(image != null)
                                                ? Image.network(
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
                                    ), */
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15),
                                          child: Column(

                                            children: [
                                              Row(
                                                children: [
                                                  Text("Registation No.: ", style: const TextStyle(
                                                      fontFamily: 'Gilroy',
                                                      fontSize: 16,
                                                      color: CustomColor.black,fontWeight: FontWeight.bold)),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                        snapshot.data![index].vehicleRegistrationNumber
                                                            .toString() !=
                                                            "null"
                                                            ? snapshot.data![index].vehicleRegistrationNumber
                                                            .toString()
                                                            : "NA",
                                                        style: const TextStyle(
                                                            fontFamily: 'Gilroy',
                                                            fontSize: 16,
                                                            color: CustomColor.black,fontWeight: FontWeight.normal)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              /* Text("From destination : ",style: const TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontSize: 16,
                                              color: CustomColor.black,fontWeight: FontWeight.bold)),*/
                                              Text(
                                                  snapshot.data![index].fromDestination
                                                      .toString() ==
                                                      "null"
                                                      ? "NA - "
                                                      : snapshot
                                                      .data![index].fromDestination
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontFamily: 'Gilroy',
                                                      fontSize: 16,
                                                      color: CustomColor.black,fontWeight: FontWeight.normal)),
                                              Text(
                                                  snapshot.data![index].toDestination
                                                      .toString() ==
                                                      "null"
                                                      ? "NA"
                                                      : snapshot
                                                      .data![index].toDestination
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontFamily: 'Gilroy',
                                                      fontSize: 16,
                                                      color: CustomColor.black,fontWeight: FontWeight.normal)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )



                                  ],
                                ),
                              )*/


                              /*ExpansionTile(

                                iconColor: Colors.black,

                                leading:    CircleAvatar(
                                  backgroundColor:
                                  Colors.black54,
                                  radius: 27.0,
                                  child: CircleAvatar(
                                    radius: 25.0,
                                    backgroundColor:
                                    Colors.white,
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: ClipOval(
                                        //""
                                        child:(image != null)
                                            ? Image.network(
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
                                ),
                                title: Column(

                                  children: [
                                    Row(
                                      children: [
                                        Text("Registation No.: ", style: const TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontSize: 16,
                                            color: CustomColor.black,fontWeight: FontWeight.bold)),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              snapshot.data![index].vehicleRegistrationNumber
                                                  .toString() !=
                                                  "null"
                                                  ? snapshot.data![index].vehicleRegistrationNumber
                                                  .toString()
                                                  : "NA",
                                              style: const TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  fontSize: 16,
                                                  color: CustomColor.black,fontWeight: FontWeight.normal)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  children: [
                                    Row(
                                      children: [
                                       /* Text("From destination : ",style: const TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontSize: 16,
                                            color: CustomColor.black,fontWeight: FontWeight.bold)),*/
                                        Text(
                                            snapshot.data![index].fromDestination
                                                .toString() ==
                                                "null"
                                                ? "NA - "
                                                : snapshot
                                                .data![index].fromDestination
                                                .toString(),
                                            style: const TextStyle(
                                                fontFamily: 'Gilroy',
                                                fontSize: 16,
                                                color: CustomColor.black,fontWeight: FontWeight.normal)),
                                        Text(
                                            snapshot.data![index].toDestination
                                                .toString() ==
                                                "null"
                                                ? "NA"
                                                : snapshot
                                                .data![index].toDestination
                                                .toString(),
                                            style: const TextStyle(
                                                fontFamily: 'Gilroy',
                                                fontSize: 16,
                                                color: CustomColor.black,fontWeight: FontWeight.normal)),
                                      ],
                                    ),

                                  ],
                                ),
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                    child: Divider(
                                      thickness: 3,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 10, bottom: 10, top: 10),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border:
                                            Border.all(color: Colors.black45),
                                            color: Colors.transparent),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, top: 10),
                                              child: Text(
                                                "Vehicle Details",
                                                style: TextStyle(
                                                    fontFamily: 'Gilroy',
                                                    fontSize: 17,
                                                    color: CustomColor.black)
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 20, right: 25),
                                                  child: Text("Model Name",
                                                      style: const TextStyle(
                                                          fontFamily: 'Gilroy',
                                                          fontSize: 16,
                                                          color: CustomColor.black, fontWeight: FontWeight.bold)),
                                                ),
                                                Container(
                                                    width: 20,
                                                    height: 40,
                                                    child: VerticalDivider(
                                                      thickness: 3,
                                                    )),
                                                Expanded(
                                                    child: Center(
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets.all(10.0),
                                                          child: TextField(
                                                            decoration: InputDecoration(
                                                              border: InputBorder.none,
                                                              hintText:  snapshot.data![index].vehicleModel != "null" ?
                                                              snapshot.data![index].vehicleModel : " ",
                                                              hintStyle: TextStyle(
                                                                  fontFamily: 'Gilroy',
                                                                  fontSize: 16,
                                                                  color: CustomColor.black,fontWeight: FontWeight.normal)
                                                            ),
                                                            readOnly: true,
                                                          ),
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
                                                      left: 20, right: 5),
                                                  child: Text("Registration No",
                                                      style: const TextStyle(
                                                          fontFamily: 'Gilroy',
                                                          fontSize: 16,
                                                          color: CustomColor.black, fontWeight: FontWeight.bold)),
                                                ),
                                                Container(
                                                    width: 20,
                                                    height: 40,
                                                    child: VerticalDivider(
                                                      thickness: 3,
                                                    )),
                                                Expanded(
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.all(10.0),
                                                        child: TextField(
                                                          decoration: InputDecoration(
                                                            border: InputBorder.none,
                                                            hintText:  snapshot.data![index].vehicleRegistrationNumber != "null" ?
                                                            snapshot.data![index].vehicleRegistrationNumber : " ",
                                                            hintStyle: TextStyle(
                                                                fontFamily: 'Gilroy',
                                                                fontSize: 16,
                                                                color: CustomColor.black,fontWeight: FontWeight.normal)
                                                          ),
                                                          readOnly: true,
                                                        ),
                                                      ),
                                                    )),
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
                                                      left: 20, right: 30),
                                                  child: Text("RC Number",
                                                      style: const TextStyle(
                                                          fontFamily: 'Gilroy',
                                                          fontSize: 16,
                                                          color: CustomColor.black,fontWeight: FontWeight.bold)),
                                                ),
                                                Container(
                                                    width: 20,
                                                    height: 40,
                                                    child: VerticalDivider(
                                                      thickness: 3,
                                                    )),
                                                Expanded(
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.all(10.0),
                                                        child: TextField(
                                                          decoration: InputDecoration(
                                                            border: InputBorder.none,
                                                            hintText: snapshot.data![index].vehicleRcNumber.toString() != "null" ?
                                                            snapshot.data![index].vehicleRcNumber.toString() : " ",
                                                            hintStyle: TextStyle(
                                                                fontFamily: 'Gilroy',
                                                                fontSize: 16,
                                                                color: CustomColor.black,fontWeight: FontWeight.normal)
                                                          ),
                                                          readOnly: true,
                                                        ),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        )),
                                  ),

                                ],
                              ),*/
                            ],
                          )


                      ),
                    ),

                    /* Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 20),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: CustomColor.yellow,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  border: Border.all(
                                      color: CustomColor.black,
                                      width: 1.5)),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: CustomColor.yellow,
                                  ),
                                  child: Column(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              "DATE:  " +
                                                  snapshot.data![index].date
                                                      .toString(),
                                              style: TextStyle(
                                                  fontFamily: 'transport',
                                                  fontSize: 15.sp)),
                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10.w,
                                            height: 20.w,
                                          ),
                                          Expanded(
                                            child: ClipOval(
                                              child: (snapshot.data![index]
                                                          .driverPhoto !=
                                                      null)
                                                  ? Image.network(
                                                      snapshot
                                                          .data![index].driverPhoto == null ? " " : snapshot
                                                          .data![index].driverPhoto.toString(),
                                                      width: 50.w,
                                                      height: 60.h,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.asset(
                                                      'assets/user_avatar.png'),
                                            ),
                                            flex: 2,
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Driver Name: "),
                                                Text(
                                                    snapshot.data![index].driverName
                                                        .toString() == "null" ? " " :  snapshot.data![index].driverName
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontFamily: 'transport',
                                                        fontSize: 15.sp)),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Text("Driver Mobile Number: "),
                                                Text(
                                                    snapshot.data![index]
                                                        .driverMobileNumber
                                                        .toString() == "null" ? " " : snapshot.data![index]
                                                        .driverMobileNumber
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontFamily: 'transport',
                                                      fontSize: 15.sp,
                                                    ))
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Vehicle Re.No. : "),
                                                Text(
                                                    snapshot.data![index]
                                                        .vehicleRegistrationNumber
                                                        .toString() == "null" ? " " : snapshot.data![index]
                                                        .vehicleRegistrationNumber
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontFamily: 'transport',
                                                        fontSize: 15.sp)),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Text("Veicle Model Name:"),
                                                Text(
                                                    snapshot
                                                        .data![index].vehicleModel
                                                        .toString() == "null" ? " " : snapshot
                                                        .data![index].vehicleModel
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontFamily: 'transport',
                                                        fontSize: 15.sp))
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),  */
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return Center(child: const CircularProgressIndicator());
          },
        ));
  }

  Future<List<RideDataModel>> getData() async {
    await Preferences.setPreferences();
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    String userId = Preferences.getId(Preferences.id).toString();
    final response = await http.post(
      Uri.parse(ApiUrl.getMyTripApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': loginToken
      },
      body: jsonEncode(<String, String>{
        'user_id': userId,
      }),
    );
    print('User Id:${userId.toString()}');
    if (response.statusCode == 200) {
      //OverlayLoadingProgress.stop();

      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      List<RideDataModel> rideData = jsonDecode(response.body)['data']
          .map<RideDataModel>((data) => RideDataModel.fromJson(data))
          .toList();
      return rideData;
    } else {
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to load');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }
}
