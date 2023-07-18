import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:http/http.dart' as http;

import 'color_constant.dart';


class DeleteButtonWidget extends StatefulWidget {
  String userId;
  String memberId;
  String status;
  final VoidCallback click;
  final VoidCallback onTap;

   DeleteButtonWidget({Key? key, required this.userId, required this.memberId, required this.status,required this.click, required this.onTap }) : super(key: key);

  @override
  State<DeleteButtonWidget> createState() => _DeleteButtonWidgetState();
}

class _DeleteButtonWidgetState extends State<DeleteButtonWidget> {


  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
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
                                             widget.click();
                                              setState(() {});
                                             // Navigator.pop(context);
                                              Get.back();

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
                                              widget.onTap();
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
              color: Colors.red,
            ))
       /* IconButton(
            onPressed: () {
              setState(() {
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
                              SizedBox(
                                height: 150,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .center,
                                  children: [
                                    const SizedBox(
                                      height:
                                      10,
                                    ),
                                    const Text("This will remove the user permanently from the list, You can also block the user to temporarily disable the users.",style: TextStyle(fontFamily: 'Gilroy')),
                                    const SizedBox(
                                        height:
                                        15),
                                    Row(
                                      children: [
                                        Expanded(
                                          child:
                                          ElevatedButton(
                                            onPressed: widget.click,
                                            style:
                                            ElevatedButton.styleFrom(backgroundColor:appBlack),
                                            child:
                                            const Text("Yes",style: TextStyle(fontFamily: 'Gilroy',color: Colors.white)),
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        Expanded(
                                            child:
                                            ElevatedButton(
                                              onPressed: widget.onTap,
                                              style:
                                              ElevatedButton.styleFrom(
                                                backgroundColor:
                                                Colors.black,
                                              ),
                                              child: const Text(
                                                  "Block",
                                                  style: TextStyle(color: Colors.white,fontFamily: 'Gilroy')),
                                            )),
                                        const SizedBox(
                                            width:
                                            15),
                                        Expanded(
                                            child:
                                            ElevatedButton(
                                              onPressed:
                                                  () {
                                                Navigator.of(context).pop();
                                              },
                                              style:
                                              ElevatedButton.styleFrom(
                                                backgroundColor:
                                                Colors.black,
                                              ),
                                              child: const Text(
                                                  "No",
                                                  style: TextStyle(color: Colors.white,fontFamily: 'Gilroy')),
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
              color: Colors.red,
            ))*/

      ],
    );
  }

  /*Future<MemberBlockDeleteModel> getMembersStatus(String status, String memberIds, String userIdList) async {
    setState(() {});
    if (status.toLowerCase().toString() == "Deleted") {
      Get.snackbar("Hello!", "Family member is deleted",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: CustomColor.black);
      setState(() {
      });
    } else if (status.toLowerCase().toString() == "Blocked") {
      Get.snackbar("Hello!", "Family member is blocked",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: CustomColor.black);
    }
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
        "user_id": userIdList.toString(),
        "member_id": memberIds.toString(),
        "status": status.toString()
      }),
    );
    print("FamilyMemberStatusData${jsonEncode(<String, String>{
      "user_id": userIdList.toString(),
      "member_id": memberIds.toString(),
      "status": status.toString()
    })}");
    if (response.statusCode == 200) {
      setState(() {});
    //  getUserFamilyList();
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      print("Body: ${response.body}");
      if (status == true) {
        setState(() {
          // getUserFamilyList();
        });
        Get.snackbar("Hello!", msg.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: CustomColor.black);
        setState(() {});
       // _future = getUserFamilyList();
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
  }*/
}
