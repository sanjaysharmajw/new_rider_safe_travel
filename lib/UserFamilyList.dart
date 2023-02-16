import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/switchbutton.dart';

import 'DriverVehicleList.dart';
import 'Error.dart';
import 'FamilyMemberAddOtherTrack.dart';
import 'FamilyMemberDataModel.dart';

import 'LoginModule/custom_color.dart';
import 'LoginModule/preferences.dart';
import 'Models/MemberBlockDeleteModel.dart';
import 'UserFamilyListData.dart';

class UserFamilyList extends StatefulWidget {
  const UserFamilyList({Key? key}) : super(key: key);

  @override
  State<UserFamilyList> createState() => _UserFamilyListState();
}

class _UserFamilyListState extends State<UserFamilyList> {
  var _future;

  Future<List<FamilyMemberDataModel>> getUserFamilyList() async {
    setState(() {});
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
          .map<FamilyMemberDataModel>(
              (data) => FamilyMemberDataModel.fromJson(data))
          .toList();
      return loginData;
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
    _future = getUserFamilyList();
    // updateStatus();
  }

  var image;
  var memberId;
  String? statusType;
  bool isblocked = false;
  bool unblockbuttonVisibility = false;
  var memberStatus;
  var memberName;

  bool isSwitched = false;

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
                        memberStatus =
                            snapshot.data![index].memberStatus.toString();
                        memberName =
                            "${snapshot.data![index].memberFName.toString()}" +
                                " " +
                                "${snapshot.data![index].memberLName.toString()}";
                        print(snapshot.data!.length);
                        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                        return InkWell(
                          onTap: () {
                            setState(() {});
                          },
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    height: 210,
                                    width: 370,
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Container(
                                            height: 170,
                                            width: 350,
                                            decoration: BoxDecoration(
                                                color: CustomColor.yellow,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        18.0)),
                                          ),
                                        ),
                                        Positioned(
                                          top: 10,
                                          right: 20,
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: CustomColor.white,
                                            ),
                                            child: CircleAvatar(
                                              radius: 90.r,
                                              backgroundColor: Colors.black,
                                              child: CircleAvatar(
                                                radius: 90.r,
                                                backgroundColor: Colors.white,
                                                child: ClipOval(
                                                  child: (snapshot.data![index]
                                                              .memberProfileImage
                                                              .toString() !=
                                                          null)
                                                      ? Image.network(
                                                          snapshot.data![index]
                                                                      .memberProfileImage
                                                                      .toString() ==
                                                                  null
                                                              ? " "
                                                              : snapshot
                                                                  .data![index]
                                                                  .memberProfileImage
                                                                  .toString(),
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
                                        ),
                                        Positioned(
                                          top: 30,
                                          left: 40,
                                          child: Text(
                                              memberStatus.toString() == "null"
                                                  ? " "
                                                  : memberStatus.toString(),
                                              style: TextStyle(
                                                  fontFamily: 'transport',
                                                  fontSize: 16)),
                                        ),
                                        Positioned(
                                          top: 50,
                                          left: 40,
                                          child: Text(
                                              memberName.toString() == "null"
                                                  ? " "
                                                  : memberName.toString(),
                                              style: TextStyle(
                                                  fontFamily: 'transport',
                                                  fontSize: 16)),
                                        ),
                                        Positioned(
                                          top: 70,
                                          left: 40,
                                          child: Text(
                                              snapshot.data![index]
                                                          .memberEmailId
                                                          .toString() ==
                                                      "null"
                                                  ? " "
                                                  : snapshot.data![index]
                                                      .memberEmailId
                                                      .toString(),
                                              style: TextStyle(
                                                  fontFamily: 'transport',
                                                  fontSize: 16)),
                                        ),
                                        Positioned(
                                          top: 90,
                                          left: 40,
                                          child: Text(
                                              snapshot.data![index]
                                                          .memberMobileNumber
                                                          .toString() ==
                                                      "null"
                                                  ? " "
                                                  : snapshot.data![index]
                                                      .memberMobileNumber
                                                      .toString(),
                                              style: TextStyle(
                                                fontFamily: 'transport',
                                                fontSize: 16,
                                              )),
                                        ),
                                        Positioned(
                                          top: 110,
                                          left: 40,
                                          child: Text(
                                              snapshot.data![index].relation
                                                          .toString()
                                                          .toString() ==
                                                      "null"
                                                  ? " "
                                                  : snapshot
                                                      .data![index].relation
                                                      .toString()
                                                      .toString(),
                                              style: TextStyle(
                                                  fontFamily: 'transport',
                                                  fontSize: 14)),
                                        ),
                                        Positioned(
                                          top: 140,
                                          left: 40,
                                          child: ToggleSwitchButton(
                                            mstatus: memberStatus.toString(),
                                            memberId: snapshot
                                                .data![index].memberId
                                                .toString(),
                                          ),
                                        ),
                                        Positioned(
                                            top: 135,
                                            right: 20,
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    print("Deleted");
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
                                                                height: 120,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text("Do you really want to delete" +
                                                                        " " +
                                                                        snapshot
                                                                            .data![index]
                                                                            .memberMobileNumber
                                                                            .toString() +
                                                                        " " +
                                                                        "?"),
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
                                                                              setState(() {});
                                                                              Get.back();
                                                                              snapshot.data!.removeAt(index);
                                                                              //getUserFamilyList();
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
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.delete_rounded,
                                                  size: 40,
                                                  color: CustomColor.red,
                                                )))
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        );

                        /*ListViewItem( relation: snapshot.data![index].relation.toString(),
                          name: snapshot.data![index].memberFName.toString()+" "+snapshot.data![index].memberLName.toString(),
                          mobileNumber: snapshot.data![index].memberMobileNumber.toString(),
                          email: snapshot.data![index].memberEmailId.toString(),
                          mstatus: snapshot.data![index].memberStatus.toString(),
                          image: snapshot.data![index].memberProfileImage.toString(), memberId: memberId,); */
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
    setState(() {});

    if (status.toLowerCase().toString() == "Deleted") {
      Get.snackbar("Hello!", "Family member is deleted",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: CustomColor.black);
      setState(() {
        getUserFamilyList();
      });
    } else if (status.toLowerCase().toString() == "Blocked") {
      Get.snackbar("Hello!", "Family member is blocked",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: CustomColor.black);
      //updateStatus();
    } /*else if (status.toLowerCase().toString() == "Active") {
      Get.snackbar("Hello!", "Family member is blocked",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: CustomColor.black);
      //updateStatus();
    }*/
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
        "status": status.toString()
      }),
    );
    print("FamilyMemberStatusData" +
        jsonEncode(<String, String>{
          "user_id": userId,
          "member_id": memberId,
          "status": status.toString()
        }));
    if (response.statusCode == 200) {
      setState(() {});
      getUserFamilyList();
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      print("Body: " + response.body);
      if (status == true) {
        setState(() {
          // getUserFamilyList();
        });
        getUserFamilyList();
        // Navigator.pop(context);
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
