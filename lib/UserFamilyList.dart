import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';
import 'package:ride_safe_travel/color_constant.dart';
import 'package:ride_safe_travel/switchbutton.dart';

import 'DriverVehicleList.dart';
import 'Error.dart';
import 'FamilyMemberAddOtherTrack.dart';
import 'FamilyMemberDataModel.dart';

import 'LoginModule/custom_color.dart';
import 'LoginModule/preferences.dart';
import 'Models/MemberBlockDeleteModel.dart';
import 'UserFamilyListData.dart';
import 'Utils/circular_image_widgets.dart';

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
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    String userId = Preferences.getId(Preferences.id).toString();
    print(userId);
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    final response = await http.post(
      (Uri.parse(
          'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/myFamilyList')), //old end url: userFamilyList
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': loginToken
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
  var listUserId;
  String? statusType;
  bool isblocked = false;
  bool unblockbuttonVisibility = false;
  var memberStatus;
  var memberName;

  bool isSwitched = false;
  bool value = true;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBlue,
          elevation: 15,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  color: CustomColor.white,
                  size: 25,
                )),
          ),
          title: const Text("People Tracking Me",
              style: TextStyle(
                color: CustomColor.white,
                fontSize: 22,
                fontFamily: 'Gilroy',
              )),

        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 40),
          child: FloatingActionButton(
            backgroundColor: appBlue,
            onPressed: () {
              Get.to(const FamilyMemberAddOtherTrack());
            },
            child: Icon(Icons.add,color: Colors.white,),
          ),
        ),
        /*floatingActionButton: Container(

          height: 60,
          width: 60,
          child: Material(
            elevation: 15,

            child: Ink(
              decoration: BoxDecoration(

                color: appBlue,
                shape: BoxShape.circle,
              ),
              child: InkWell(

                borderRadius: BorderRadius.circular(
                    500.0),
                onTap: () {
                  Get.to(const FamilyMemberAddOtherTrack());
                },
                child: Icon(
                  Icons.add,
                  color: CustomColor.black,
                  size: 38,
                ),
              ),
            ),
          ),
        ), */

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
                        listUserId = snapshot.data![index].userId.toString();
                        memberStatus = snapshot.data![index].memberStatus.toString();
                        memberName = "${snapshot.data![index].memberFName.toString()} ${snapshot.data![index].memberLName.toString()}";
                        print(listUserId+memberId);
                        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                        return InkWell(
                          onTap: () {
                            setState(() {});
                          },
                          child:  Padding(
                            padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10,),
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
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 10,top: 15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,

                                            children: [

                                              Row(
                                                children: [
                                                 /* Text("Name: ", style: const TextStyle(
                                                      fontFamily: 'Gilroy',
                                                      fontSize: 16,
                                                      color: CustomColor.black,fontWeight: FontWeight.bold)),*/
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 15),
                                                    child: Text(
                                                        memberName
                                                            .toString() !=
                                                            "null"
                                                            ? memberName
                                                            .toString()
                                                            : "NA",
                                                        style: const TextStyle(
                                                            fontFamily: 'Gilroy',
                                                            fontSize: 17,
                                                            color: CustomColor.black,fontWeight: FontWeight.w600)),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 15),
                                                child: Row(
                                                  children: [
                                                   /* Text("Email Id : ",style: const TextStyle(
                                                        fontFamily: 'Gilroy',
                                                        fontSize: 16,
                                                        color: CustomColor.black,fontWeight: FontWeight.bold)),*/
                                                    Text(
                                                        snapshot.data![index].memberEmailId
                                                            .toString() ==
                                                            "null"
                                                            ? "NA"
                                                            : snapshot
                                                            .data![index].memberEmailId
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontFamily: 'Gilroy',
                                                            fontSize: 16,
                                                            color: CustomColor.black,fontWeight: FontWeight.normal)),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                 /* Text("Mobile No : ",style: const TextStyle(
                                                      fontFamily: 'Gilroy',
                                                      fontSize: 16,
                                                      color: CustomColor.black,fontWeight: FontWeight.bold)),*/
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 15),
                                                    child: Text(
                                                        snapshot.data![index].memberMobileNumber
                                                            .toString() ==
                                                            "null"
                                                            ? "NA"
                                                            : snapshot
                                                            .data![index].memberMobileNumber
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontFamily: 'Gilroy',
                                                            fontSize: 16,
                                                            color: CustomColor.black,fontWeight: FontWeight.normal)),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  /* Text("Mobile No : ",style: const TextStyle(
                                                      fontFamily: 'Gilroy',
                                                      fontSize: 16,
                                                      color: CustomColor.black,fontWeight: FontWeight.bold)),*/
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 15),
                                                    child: Text(
                                                        snapshot.data![index].relation
                                                            .toString() ==
                                                            "null"
                                                            ? "NA"
                                                            : snapshot
                                                            .data![index].relation
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontFamily: 'Gilroy',
                                                            fontSize: 16,
                                                            color: CustomColor.black,fontWeight: FontWeight.normal)),
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 15,right: 25),
                                            child: CircularImage(
                                              imageLink: image,
                                              imageWidth: 60,
                                              imageHeight: 60,
                                              borderColor: Colors.black,)
                                            /*CircleAvatar(
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
                                                      fit: BoxFit.fill,
                                                    )
                                                        : Image.asset(
                                                        'assets/user_avatar.png'),
                                                  ),
                                                ),
                                              ),
                                            ),*/
                                          ),

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15,),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          ToggleSwitchButton(mstatus: memberStatus,
                                            memberId: snapshot.data![index].memberId.toString(),
                                            userId: snapshot.data![index].userId.toString(),),
                                          IconButton(
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
                                                                  height: 150,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                        10,
                                                                      ),
                                                                      Text("This will remove the user permanently from the list, You can also block the user to temporarily disable the users."),
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
                                                                                getMembersStatus("Deleted",snapshot.data![index].memberId.toString()
                                                                                    ,snapshot.data![index].userId.toString());
                                                                                setState(() {});
                                                                                Get.back();
                                                                                snapshot.data!.removeAt(index);
                                                                                //getUserFamilyList();
                                                                              },
                                                                              child:
                                                                              Text("Yes"),
                                                                              style:
                                                                              ElevatedButton.styleFrom(primary:appBlue),
                                                                            ),
                                                                          ),
                                                                          SizedBox(width: 15),
                                                                          Expanded(
                                                                              child:
                                                                              ElevatedButton(
                                                                                onPressed:
                                                                                    () {
                                                                                  Navigator.of(context).pop();
                                                                                  getMembersStatus('Blocked',snapshot.data![index].memberId.toString(),
                                                                                      snapshot.data![index].userId.toString());
                                                                                },
                                                                                child: Text(
                                                                                    "Block",
                                                                                    style: TextStyle(color: Colors.black,)),
                                                                                style:
                                                                                ElevatedButton.styleFrom(
                                                                                  primary:
                                                                                  Colors.white,
                                                                                ),
                                                                              )),
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
                                                Icons.delete,
                                                size: 27,
                                                color: CustomColor.red,
                                              ))
                                        ],
                                      ),
                                    ),
                                   /* Padding(
                                      padding:
                                      const EdgeInsets.only(left: 15, right: 15),
                                      child: Divider(
                                        thickness: 2,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Positioned(
                                          top: 140,
                                          left: 40,
                                          child: ToggleSwitchButton(
                                            mstatus: memberStatus.toString(),
                                            memberId: snapshot.data![index].memberId.toString(), userId: snapshot.data![index].userId.toString(),
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
                                                                    height: 150,
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                          10,
                                                                        ),
                                                                        Text("This will remove the user permanently from the list, You can also block the user to temporarily disable the users."),
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
                                                                                  getMembersStatus("Deleted",snapshot.data![index].memberId.toString()
                                                                                      ,snapshot.data![index].userId.toString());
                                                                                  setState(() {});
                                                                                  Get.back();
                                                                                  snapshot.data!.removeAt(index);
                                                                                  //getUserFamilyList();
                                                                                },
                                                                                child:
                                                                                Text("Yes"),
                                                                                style:
                                                                                ElevatedButton.styleFrom(primary:appBlue),
                                                                              ),
                                                                            ),
                                                                            SizedBox(width: 15),
                                                                            Expanded(
                                                                                child:
                                                                                ElevatedButton(
                                                                                  onPressed:
                                                                                      () {
                                                                                    Navigator.of(context).pop();
                                                                                    getMembersStatus('Blocked',snapshot.data![index].memberId.toString(),
                                                                                        snapshot.data![index].userId.toString());
                                                                                  },
                                                                                  child: Text(
                                                                                      "Block",
                                                                                      style: TextStyle(color: Colors.black,)),
                                                                                  style:
                                                                                  ElevatedButton.styleFrom(
                                                                                    primary:
                                                                                    Colors.white,
                                                                                  ),
                                                                                )),
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
                                                  size: 30,
                                                  color: CustomColor.red,
                                                )))
                                      ],
                                    ),*/
                                  ],
                                )


                            ),
                          ),

                         /* Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    height: 200,
                                    width: 320,
                                    child: Card(
                                      elevation: 5,
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: Container(
                                              height: 170,
                                              width: 350,
                                              decoration: BoxDecoration(
                                                  color: CustomColor.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0)),
                                            ),
                                          ),
                                          Positioned(
                                            top: 50,
                                            right: 20,
                                            child: Container(
                                              height: 70,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: CustomColor.white,
                                              ),
                                              child: CircleAvatar(
                                                radius: 70.r,
                                                backgroundColor: Colors.black,
                                                child: CircleAvatar(
                                                  radius: 70.r,
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
                                                            width: 70,
                                                            height: 70,
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
                                                    fontFamily: 'Gilroy',
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
                                                    fontFamily: 'Gilroy',
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
                                                    fontFamily: 'Gilroy',
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
                                                  fontFamily: 'Gilroy',
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
                                                    fontFamily: 'Gilroy',
                                                    fontSize: 14)),
                                          ),
                                          Positioned(
                                            top: 140,
                                            left: 40,
                                            child: ToggleSwitchButton(
                                              mstatus: memberStatus.toString(),
                                              memberId: snapshot.data![index].memberId.toString(), userId: snapshot.data![index].userId.toString(),
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
                                                                  height: 150,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Text("This will remove the user permanently from the list, You can also block the user to temporarily disable the users."),
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
                                                                                getMembersStatus("Deleted",snapshot.data![index].memberId.toString()
                                                                                ,snapshot.data![index].userId.toString());
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
                                                                          SizedBox(width: 15),
                                                                          Expanded(
                                                                              child:
                                                                              ElevatedButton(
                                                                                onPressed:
                                                                                    () {
                                                                                  Navigator.of(context).pop();
                                                                                  getMembersStatus('Blocked',snapshot.data![index].memberId.toString(),
                                                                                      snapshot.data![index].userId.toString());
                                                                                },
                                                                                child: Text(
                                                                                    "Block",
                                                                                    style: TextStyle(color: Colors.black,)),
                                                                                style:
                                                                                ElevatedButton.styleFrom(
                                                                                  primary:
                                                                                  Colors.white,
                                                                                ),
                                                                              )),
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
                                      ),
                                    )),
                              ],
                            ),
                          ), */
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

  Future<MemberBlockDeleteModel> getMembersStatus(String status, String memberIdsss, String usesssrIdList) async {
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
    }

    /*else if (status.toLowerCase().toString() == "Active") {
      Get.snackbar("Hello!", "Family member is blocked",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: CustomColor.black);
      //updateStatus();
    }*/
    await Preferences.setPreferences();
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
  //  String userId = Preferences.getId(Preferences.id).toString();
    final response = await http.post(
      Uri.parse(
          'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/userRide/deleteblockFamilyMember'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': loginToken
      },
      body: jsonEncode(<String, String>{
        "user_id": listUserId.toString(),
        "member_id": memberId.toString(),
        "status": status.toString()
      }),
    );
    print("FamilyMemberStatusData${jsonEncode(<String, String>{
          "user_id": listUserId,
          "member_id": memberId,
          "status": status.toString()
        })}");
    if (response.statusCode == 200) {
      setState(() {});
      getUserFamilyList();
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      print("Body: ${response.body}");
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
        setState(() {});
        _future = getUserFamilyList();
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
