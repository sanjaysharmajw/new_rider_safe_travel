import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_loading_progress/overlay_loading_progress.dart';

import 'DriverVehicleList.dart';
import 'Error.dart';
import 'FamilyMemberAddOtherTrack.dart';
import 'FamilyMemberDataModel.dart';

import 'LoginModule/custom_color.dart';
import 'LoginModule/preferences.dart';
import 'Models/MemberBlockDeleteModel.dart';


class UserFamilyList extends StatefulWidget {
  const UserFamilyList({Key? key}) : super(key: key);

  @override
  State<UserFamilyList> createState() => _UserFamilyListState();
}

class _UserFamilyListState extends State<UserFamilyList> {
  var _future;

  Future<List<FamilyMemberDataModel>> getUserFamilyList() async {
    await Preferences.setPreferences();
    String userId = Preferences.getId(Preferences.id).toString();
    print(userId);
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    final response = await http.post(
      (Uri.parse(
          'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/myFamilyList')), //old end url: userFamilyList
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"user_id": userId}),
    );
    if (response.statusCode == 200) {
      print('RES:${response.body}');
      List<FamilyMemberDataModel> loginData = jsonDecode(response.body)['data']
          .map<FamilyMemberDataModel>((data) => FamilyMemberDataModel.fromJson(data))
          .toList();
      return loginData;
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  void initState() {
    super.initState();
    _future = getUserFamilyList();
   // updateStatus();
  }

  var image;
  var memberId;
  String? statusType;
  bool blockbuttonVisibility = false;
  bool unblockbuttonVisibility = false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColor.yellow,
          elevation: 15,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  color: CustomColor.black,
                  size: 30,
                )),
          ),
          title: const Text("My Family List",
              style: TextStyle(
                color: CustomColor.black,
                fontSize: 20,
                fontFamily: 'transport',
              )),
        ),
        // floatingActionButton: Container(
        //   height: 60,
        //   width: 60,
        //   child: Material(
        //     type: MaterialType
        //         .transparency,
        //     child: Ink(
        //       decoration: BoxDecoration(
        //         border: Border.all(color: CustomColor.black, width: 2.0),
        //         color: CustomColor.yellow,
        //         shape: BoxShape.circle,
        //       ),
        //       child: InkWell(
        //
        //         borderRadius: BorderRadius.circular(
        //             500.0),
        //         onTap: () {
        //           Get.to(const FamilyMemberAddOtherTrack());
        //         },
        //         child: Icon(
        //           Icons.add,
        //           color: CustomColor.black,
        //           size: 38,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),

        body: FutureBuilder<List<FamilyMemberDataModel>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.isEmpty
                  ? Center(
                      child: Text(
                      'Data not found',
                      style: TextStyle(fontSize: 20, color: Colors.black12),
                    ))
                  : ListView.builder(
                      itemCount: snapshot.data!.length,
                       itemBuilder: (context, index) {
                       // var item = snapshot.data![index].data?[index];
                        image =
                            "${snapshot.data![index].memberProfileImage.toString()}";
                        memberId = snapshot.data![index].memberId.toString();
                        print(snapshot.data!.length);
                        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
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
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 20),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              color: CustomColor.yellow,
                              child: Column(
                                //mainAxisSize: MainAxisSize.min,
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
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: CustomColor.yellow,
                                        ),
                                        child: Column(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                    "Status:  " + snapshot.data![index].memberStatus.toString(),
                                                    style: TextStyle(
                                                        fontFamily: 'transport',
                                                        fontSize: 15.sp)),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 10.w,
                                                  height: 20.w,
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: ClipOval(
                                                    child: (snapshot.data![index]
                                                                .memberProfileImage !=
                                                            null)
                                                        ? Image.network(
                                                      snapshot.data![index]
                                                                        .memberProfileImage ==
                                                                    null
                                                                ? " "
                                                                : snapshot.data![index]
                                                                    .memberProfileImage.toString()
                                                                    ,
                                                            width: 50.w,
                                                            height: 60.h,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            'assets/user_avatar.png'),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20.w,
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Name: ",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'transport',
                                                              fontSize: 15.sp)),
                                                      Text(
                                                          snapshot.data![index]
                                                                          .memberFName
                                                                          .toString() +
                                                                      " " +
                                                              snapshot.data![index]
                                                                          .memberLName
                                                                          .toString() ==
                                                                  "null"
                                                              ? " "
                                                              :  snapshot.data![index]
                                                                      .memberFName
                                                                      .toString() +
                                                                  " " +
                                                              snapshot.data![index]
                                                                      .memberLName
                                                                      .toString(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'transport',
                                                              fontSize: 13.sp)),
                                                      SizedBox(
                                                        height: 20.h,
                                                      ),
                                                      Text("Email Id:",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'transport',
                                                              fontSize: 15.sp)),
                                                      Text(
                                                          snapshot.data![index]
                                                                      .memberEmailId
                                                                      .toString() ==
                                                                  "null"
                                                              ? " "
                                                              :  snapshot.data![index]
                                                                  .memberEmailId
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'transport',
                                                              fontSize: 13.sp)),
                                                      SizedBox(
                                                        height: 20.h,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Mobile Number: ",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'transport',
                                                              fontSize: 15.sp)),
                                                      Text(
                                                          snapshot.data![index]
                                                                      .memberMobileNumber
                                                                      .toString() ==
                                                                  "null"
                                                              ? " "
                                                              :  snapshot.data![index]
                                                                  .memberMobileNumber
                                                                  .toString(),
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'transport',
                                                            fontSize: 13.sp,
                                                          )),
                                                      SizedBox(
                                                        height: 20.h,
                                                      ),
                                                      Text("Relation:",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'transport',
                                                              fontSize: 15.sp)),
                                                      Text(
                                                          snapshot.data![index]
                                                                      .relation
                                                                      .toString() ==
                                                                  "null"
                                                              ? " "
                                                              :  snapshot.data![index]
                                                                  .relation
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'transport',
                                                              fontSize: 13.sp)),
                                                      SizedBox(
                                                        height: 20.h,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                // Visibility(
                                                //     visible:
                                                //         blockbuttonVisibility,
                                                //     child: Row(
                                                //       children: [
                                                //         ElevatedButton(onPressed: (){
                                                //           getMembersStatus("Blocked");
                                                //
                                                //         }, child: Text('Block'),
                                                //           style: ElevatedButton.styleFrom(
                                                //               backgroundColor: Colors.red,
                                                //               foregroundColor: Colors.white,
                                                //               shape: RoundedRectangleBorder(
                                                //                 borderRadius: BorderRadius.circular(32.0),
                                                //               ),
                                                //
                                                //               side: BorderSide(color: Colors.black),
                                                //               elevation: 10
                                                //
                                                //           ),),
                                                //       ],
                                                //     )),
                                                // Visibility(
                                                //     visible:
                                                //     unblockbuttonVisibility,
                                                //     child: Row(
                                                //       children: [
                                                //         ElevatedButton(onPressed: (){
                                                //           getMembersStatus("Unblocked");
                                                //
                                                //         }, child: Text('UnBlock'),
                                                //           style: ElevatedButton.styleFrom(
                                                //               backgroundColor: Colors.red,
                                                //               foregroundColor: Colors.white,
                                                //               shape: RoundedRectangleBorder(
                                                //                 borderRadius: BorderRadius.circular(32.0),
                                                //               ),
                                                //
                                                //               side: BorderSide(color: Colors.black),
                                                //               elevation: 10
                                                //
                                                //           ),),
                                                //       ],
                                                //     )),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                        context) {
                                                          return StatefulBuilder(
                                                              builder: (BuildContext
                                                              context,
                                                                  StateSetter
                                                                  setState) {
                                                                return AlertDialog(
                                                                  content:
                                                                  Container(
                                                                    height: 100,
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                          10,
                                                                        ),
                                                                        Text(
                                                                            "Do you really want to"+" "+snapshot.data![index].memberStatus.toString() +" " +  snapshot.data![index]
                                                                                .memberFName
                                                                                .toString()+" "+"?"),
                                                                        SizedBox(
                                                                            height:
                                                                            15),
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child:
                                                                              ElevatedButton(
                                                                                onPressed:
                                                                                    () {
                                                                                  // OverlayLoadingProgress.start(context);

                                                                                      getMembersStatus("Blocked");
                                                                                },
                                                                                child:
                                                                                Text("Yes"),
                                                                                style:
                                                                                ElevatedButton.styleFrom(primary: CustomColor.yellow),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                                width:
                                                                                15),
                                                                            Expanded(
                                                                                child:
                                                                                ElevatedButton(
                                                                                  onPressed:
                                                                                      () {
                                                                                    print('no selected');
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                  child: Text(
                                                                                      "No",
                                                                                      style: TextStyle(color: Colors.black)),
                                                                                  style:
                                                                                  ElevatedButton.styleFrom(
                                                                                    primary:
                                                                                    Colors.white,
                                                                                  ),
                                                                                ))
                                                                          ],
                                                                        )
                                                                      ]
                                                                    ),
                                                                  ),
                                                                );
                                                              });
                                                        });
                                                    //getMembersStatus( "Deleted");
                                                    //snapshot.data!.removeAt(index);
                                                  },
                                                  child: Text(  snapshot.data![index].memberStatus.toString() == "blocked" ? "Unblock"  : "Block"),
                                                  style:
                                                  ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                      Colors.red,
                                                      foregroundColor:
                                                      Colors.white,
                                                      shape:
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            32.0),
                                                      ),
                                                      side: BorderSide(
                                                          color:
                                                          Colors.black),
                                                      elevation: 10),
                                                ),

                                                SizedBox(
                                                  width: 30,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return StatefulBuilder(
                                                              builder: (BuildContext
                                                                      context,
                                                                  StateSetter
                                                                      setState) {
                                                            return AlertDialog(
                                                              content:
                                                                  Container(
                                                                height: 100,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                        "Do you really want to delete data ?"),
                                                                    SizedBox(
                                                                        height:
                                                                            15),
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              ElevatedButton(
                                                                            onPressed:
                                                                                () {
                                                                              // OverlayLoadingProgress.start(context);
                                                                              getMembersStatus("Deleted");
                                                                              setState(() {
                                                                                Get.back();
                                                                                snapshot.data!.removeAt(index);
                                                                              });
                                                                            },
                                                                            child:
                                                                                Text("Yes"),
                                                                            style:
                                                                                ElevatedButton.styleFrom(primary: CustomColor.yellow),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                15),
                                                                        Expanded(
                                                                            child:
                                                                                ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            print('no selected');
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child: Text(
                                                                              "No",
                                                                              style: TextStyle(color: Colors.black)),
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            primary:
                                                                                Colors.white,
                                                                          ),
                                                                        ))
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                        });
                                                    //getMembersStatus( "Deleted");
                                                    //snapshot.data!.removeAt(index);
                                                  },
                                                  child: Text('Delete'),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.green,
                                                          foregroundColor:
                                                              Colors.white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        32.0),
                                                          ),
                                                          side: BorderSide(
                                                              color:
                                                                  Colors.black),
                                                          elevation: 10),
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
                          ),
                        );
                      },
                    );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  Future<MemberBlockDeleteModel> getMembersStatus(String status) async {
    if (status.toLowerCase().toString() == "Deleted") {
      Get.snackbar("Hello!", "Family member is deleted",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: CustomColor.black);
    } if (status.toLowerCase().toString() == "Blocked") {
      Get.snackbar("Hello!", "Family member is blocked",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: CustomColor.black);
      //updateStatus();
    }
       statusType = status.toLowerCase().toString();
    await Preferences.setPreferences();
    String userId = Preferences.getId(Preferences.id).toString();
    final response = await http.post(
      Uri.parse(
          'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/userRide/deleteblockFamilyMember'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "user_id": userId,
        "member_id": memberId,
        "status": statusType.toString()
      }),
    );
    print("FamilyMemberStatus" +
        jsonEncode(<String, String>{
          "user_id": userId,
          "member_id": memberId,
          "status": statusType.toString()
        }));
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      print("Body: " + response.body);
      if (status == true) {
        Navigator.pop(context);
       // updateStatus();
        Get.snackbar("Hello!", msg.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: CustomColor.black);
      } else if (status == false) {
        Get.snackbar("Ooops!", msg.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: CustomColor.red,
            colorText: CustomColor.black);
        Navigator.pop(context);
      }
      return MemberBlockDeleteModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }

 /* void updateStatus() {
    if (memberId.toString() == "Blocked") {
     // statusType = "Blocked";

      unblockbuttonVisibility = true;
    } else {
     // statusType = "Unblocked";
      blockbuttonVisibility = true;
    }
  } */
}
