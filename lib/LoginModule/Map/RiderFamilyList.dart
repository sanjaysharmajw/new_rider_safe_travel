import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/LoginModule/Map/RiderMap.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/Models/Familymodel.dart';

import '../../Error.dart';
import '../../FamilyMemberAddOtherTrack.dart';
import '../../FamilyMemberAddScreen.dart';
import '../../Models/MemberBlockDeleteModel.dart';
import '../../ToggleSwitch.dart';
import '../../familydatamodel.dart';
import '../../switchbutton.dart';
import 'FamilyListDataModel.dart';

class FamilyMemberListScreen extends StatefulWidget {
  const FamilyMemberListScreen({Key? key}) : super(key: key);

  @override
  State<FamilyMemberListScreen> createState() => _FamilyMemberListScreenState();
}

class _FamilyMemberListScreenState extends State<FamilyMemberListScreen> {
  var _future;
  var status;
  var memberId;


  Future<List<FamilyListDataModel>> getFamilyList() async {
    setState(() {});
    await Preferences.setPreferences();
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    String userId = Preferences.getId(Preferences.id).toString();
    print(userId);
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    final response = await http.post(
      (Uri.parse(
          'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/userRide/familymemberRideList')),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': loginToken
      },
      body: jsonEncode(<String, String>{"user_id": userId}),
    );
    if (response.statusCode == 200) {
      print('RES:${response.body}');
      List<FamilyListDataModel> loginData = jsonDecode(response.body)['data']
          .map<FamilyListDataModel>(
              (data) => FamilyListDataModel.fromJson(data))
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
    _future = getFamilyList();
  }

  var image;

  String? statusType;
  bool isblocked = false;
  bool unblockbuttonVisibility = false;
  var memberStatus;
  var driverName;
  var memberName;

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: CustomColor.yellow,
          elevation: 15,
          title: const Text("Family Members",
              style: TextStyle(color: CustomColor.black,fontSize: 20, fontFamily: 'transport',)),
          leading: IconButton(
            color: Colors.black,
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_outlined),
          ),
        ),
        body: FutureBuilder<List<FamilyListDataModel>>(
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
                  "${snapshot.data![index].driverPhoto.toString()}";
                  memberId = snapshot.data![index].userId.toString();
                  memberStatus =
                      snapshot.data![index].memberStatus.toString();
                  memberName =
                      "${snapshot.data![index].memberName.toString()}";
                  print(snapshot.data!.length);
                  print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                  return InkWell(
                    onTap: () {
                      //setState(() {});
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
                                        radius: 90,
                                        backgroundColor: Colors.black,
                                        child: CircleAvatar(
                                          radius: 90,
                                          backgroundColor: Colors.white,
                                          child: ClipOval(
                                            child: (snapshot.data![index]
                                                .driverPhoto
                                                .toString() !=
                                                null)
                                                ? Image.network(
                                              snapshot.data![index]
                                                  .driverPhoto
                                                  .toString() ==
                                                  null
                                                  ? " "
                                                  : snapshot
                                                  .data![index]
                                                  .driverPhoto
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
                                            .driverName
                                            .toString() ==
                                            "null"
                                            ? " "
                                            : snapshot.data![index]
                                            .driverName
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
                                            .driverMobileNumber
                                            .toString() ==
                                            "null"
                                            ? " "
                                            : snapshot.data![index]
                                            .driverMobileNumber
                                            .toString(),
                                        style: TextStyle(
                                            fontFamily: 'transport',
                                            fontSize: 16)),
                                  ),
                                  Positioned(
                                    top: 110,
                                    left: 40,
                                    child: Text(
                                        snapshot.data![index]
                                            .drivingLicenceNumber
                                            .toString() ==
                                            "null"
                                            ? " "
                                            : snapshot.data![index]
                                            .drivingLicenceNumber
                                            .toString(),
                                        style: TextStyle(
                                          fontFamily: 'transport',
                                          fontSize: 16,
                                        )),
                                  ),

                                  Positioned(
                                    top: 140,
                                    left: 40,
                                    child: ToggleSwitch(
                                      mstatus: memberStatus.toString(),
                                      memberId: snapshot
                                          .data![index].userId
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
                                          icon: Icon(
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


    /*FutureBuilder<List<FamilyListDataModel>>(
          future: _future,
          builder: (context, snapshot) {

            if (snapshot.hasData) {
              return snapshot.data!.isEmpty ? Center(child: Text('Data not found',style: TextStyle(fontSize: 20,color: Colors.black12),)) :
                ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (snapshot.hasData) {
                          status = snapshot.data![index].memberStatus.toString();
                          memberId = snapshot.data![index].userId.toString();
                          OverlayLoadingProgress.start(context);
                          Get.to(RiderMap(
                            riderId: snapshot.data![index].id.toString(),
                            dName:
                                snapshot.data![index].driverName.toString() == "null" ? "Data Not Available" : snapshot.data![index].driverName.toString(),
                            dLicenseNo: snapshot
                                .data![index].drivingLicenceNumber
                                .toString() == "null" ? "Data Not Available" :  snapshot
                                .data![index].drivingLicenceNumber
                                .toString(),
                            vModel: snapshot.data![index].vehicleModel
                                .toString() == "null" ? "Data Not Available" : snapshot.data![index].vehicleModel
                                .toString(),
                            vOwnerName:
                                snapshot.data![index].ownerName.toString() == "null" ? "Data Not Available" : snapshot.data![index].ownerName.toString(),
                            vRegistration: snapshot
                                .data![index].vehicleRegistrationNumber
                                .toString() == "null" ? "Data Not Available" : snapshot
                                .data![index].vehicleRegistrationNumber
                                .toString(),
                            dMobile: snapshot
                                .data![index].driverMobileNumber
                                .toString() == "null" ? "Data Not Available" : snapshot
                                .data![index].driverMobileNumber
                                .toString(),
                            dImage: snapshot.data![index].driverPhoto
                                .toString() == "null" ? "Data Not Available" : snapshot.data![index].driverPhoto
                                .toString(),
                            memberName:
                                snapshot.data![index].memberName.toString() == "null" ? "Data Not Available" : snapshot.data![index].memberName.toString(),
                          ));
                        } else {
                          const Center(child: CircularProgressIndicator());
                        }
                      });
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              height: 250,
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
                                        radius: 90,
                                        backgroundColor: Colors.black,
                                        child: CircleAvatar(
                                          radius: 90,
                                          backgroundColor: Colors.white,
                                          child: ClipOval(
                                            child: (snapshot.data![index]
                                                .driverPhoto
                                                .toString() !=
                                                null)
                                                ? Image.network(
                                              snapshot.data![index]
                                                  .driverPhoto
                                                  .toString() ==
                                                  null
                                                  ? " "
                                                  : snapshot
                                                  .data![index]
                                                  .driverPhoto
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
                                    top: 50,
                                    left: 40,
                                    child: Row(
                                      children: [
                                        Text("MemberStatus:  "),
                                        Text(
                                            snapshot.data![index].memberStatus.toString() == "null" ? "Data Not Available" : snapshot.data![index].memberStatus.toString(),
                                            style: TextStyle(
                                                fontFamily: 'transport',
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 70,
                                    left: 40,
                                    child: Row(
                                      children: [
                                        Text("MemberName:  "),
                                        Text(
                                            snapshot.data![index].memberName.toString() == "null" ? "Data Not Available" : snapshot.data![index].memberName.toString(),
                                            style: TextStyle(
                                                fontFamily: 'transport',
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 90,
                                    left: 40,
                                    child: Row(
                                      children: [
                                        Text("DriverName:  "),
                                        Text(
                                            snapshot.data![index].driverName.toString() == "null" ? "Data Not Available" : snapshot.data![index].driverName.toString(),
                                            style: TextStyle(
                                                fontFamily: 'transport',
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 110,
                                    left: 40,
                                    child: Row(
                                      children: [
                                        Text("DriverMobileNo.:  "),
                                        Text(
                                            snapshot
                                                .data![index].driverMobileNumber
                                                .toString() == "null" ? "Data Not Available" : snapshot
                                                .data![index].driverMobileNumber
                                                .toString(),
                                            style: TextStyle(
                                                fontFamily: 'transport',
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 130,
                                    left: 40,
                                    child: Row(
                                      children: [
                                        Text("DrivingLicenceNo.:  "),
                                        Text(
                                            snapshot
                                                .data![index].drivingLicenceNumber
                                                .toString() == "null" ? "Data Not Available" :  snapshot
                                                .data![index].drivingLicenceNumber.toString(),
                                            style: TextStyle(
                                              fontFamily: 'transport',
                                              fontSize: 16,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 125,
                                    left: 40,
                                    child: Text(
                                        "",
                                        style: TextStyle(
                                            fontFamily: 'transport',
                                            fontSize: 14)),
                                  ),
                                  Positioned(
                                    top: 160,
                                    left: 40,
                                    child: ToggleSwitchButton(
                                      mstatus: status.toString(),
                                      memberId: snapshot.data![index].userId.toString()
                                    ),
                                  ),
                                  Positioned(
                                      top: 150,
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
                                                                     "data"+
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
                                          icon: Icon(
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
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return Center(child: const CircularProgressIndicator());
          },
        )); */
  }


  Future<MemberBlockDeleteModel> getMembersStatus(String status) async {
    setState(() {});

    if (status.toLowerCase().toString() == "Deleted") {
      Get.snackbar("Hello!", "Family member is deleted",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: CustomColor.black);
      setState(() {
        getFamilyList();
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
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    String userId = Preferences.getId(Preferences.id).toString();
    final response = await http.post(
      Uri.parse(
          'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/userRide/deleteblockFamilyMember'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': loginToken
      },
      body: jsonEncode(<String, String>{
        "user_id": userId,
        "member_id": memberId.toString(),
        "status": status.toString()
      }),
    );
    print("FamilyMemberStatusData" +
        jsonEncode(<String, String>{
          "user_id": userId,
          "member_id": memberId.toString(),
          "status": status.toString()
        }));
    if (response.statusCode == 200) {
      setState(() {});
      getFamilyList();
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      print("Body: " + response.body);
      if (status == true) {
        setState(() {
          getFamilyList();
        });
        getFamilyList();
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






}
