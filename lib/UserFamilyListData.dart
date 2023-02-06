import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'Error.dart';
import 'FamilyMemberDataModel.dart';
import 'LoginModule/custom_color.dart';
import 'LoginModule/preferences.dart';
import 'Models/MemberBlockDeleteModel.dart';

class ListViewItem extends StatefulWidget {
  String name;
  String mobileNumber;
  String email;
  String relation;
  String mstatus;
  String image;
  String memberId;

   ListViewItem({Key? key, required this.relation, required this.name, required this.mobileNumber,
     required this.email, required this.mstatus, required this.image,required this.memberId,}) : super(key: key);

  @override
  State<ListViewItem> createState() => _ListViewItemState();
}

class _ListViewItemState extends State<ListViewItem> {



  Future<List<FamilyMemberDataModel>> getUserFamilyList() async {
    setState(() {
    });
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
      setState(() {
      });
      print('RES:${response.body}');
      List<FamilyMemberDataModel> loginData = jsonDecode(response.body)['data']
          .map<FamilyMemberDataModel>((data) => FamilyMemberDataModel.fromJson(data))
          .toList();
      return loginData;
    } else {
      throw Exception('Failed to load');
    }
  }


  bool isSwitched = false;
  var statusarr=[];



  @override
  Widget build(BuildContext context) {

        return InkWell(
          onTap: () {
            setState(() {

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
                                    "Status:  " + widget.mstatus.toString() ,
                                    style: TextStyle(
                                        fontFamily: 'transport',
                                        fontSize: 15)),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                  height: 20,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: ClipOval(
                                    child: (widget.image!=
                                        null)
                                        ? Image.network(
                                      widget.image ==
                                          null
                                          ? " "
                                          : widget.image
                                      ,
                                      width: 50,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    )
                                        : Image.asset(
                                        'assets/user_avatar.png'),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
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
                                              fontSize: 15)),
                                      Text(
                                         widget.name
                                             ==
                                              "null"
                                              ? " "
                                              :  widget.name,
                                          style: TextStyle(
                                              fontFamily:
                                              'transport',
                                              fontSize: 13)),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text("Email Id:",
                                          style: TextStyle(
                                              fontFamily:
                                              'transport',
                                              fontSize: 15)),
                                      Text(
                                         widget.email ==
                                              "null"
                                              ? " "
                                              :  widget.email,
                                          style: TextStyle(
                                              fontFamily:
                                              'transport',
                                              fontSize: 13)),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
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
                                              fontSize: 15)),
                                      Text(
                                          widget.mobileNumber ==
                                              "null"
                                              ? " "
                                              :  widget.mobileNumber,
                                          style: TextStyle(
                                            fontFamily:
                                            'transport',
                                            fontSize: 13,
                                          )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text("Relation:",
                                          style: TextStyle(
                                              fontFamily:
                                              'transport',
                                              fontSize: 15)),
                                      Text(
                                          widget.relation.toString()==
                                              "null"
                                              ? " "
                                              :  widget.relation.toString(),
                                          style: TextStyle(
                                              fontFamily:
                                              'transport',
                                              fontSize: 13)),
                                      SizedBox(
                                        height: 20,
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

                               FlutterSwitch(
                                  activeText: "Block",
                                  inactiveText: "Unblock",
                                  value: (widget.mstatus.toString()=='Blocked'?true:false),

                                  activeTextColor: Colors.black54,
                                  inactiveTextColor: Colors.black54,
                                  activeColor: Colors.red,
                                  inactiveColor: Colors.green,
                                  valueFontSize: 14.0,
                                  width: 90,
                                  borderRadius: 32.0,
                                  //switchBorder: Border.all(
                                    //color: Colors.black,
                                    //width: 1.0,
                                  //),

                                  showOnOff: true,
                                  toggleSize: 15,
                                  toggleColor: Colors.black54,

                                  onToggle: (val) {
                                    setState(() {
                                      showDialog(context: context, builder: (BuildContext
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
                                                      Text(widget.mstatus=="Blocked"?"Do you really want to Unblock this family member ?":"Do you really want to Block this family member  ?"),
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
                                                                setState((){
                                                                  if(val==true) {
                                                                    widget.mstatus = "Blocked";
                                                                    getMembersStatus(widget.mstatus);
                                                                    Navigator.pop(context);
                                                                  }
                                                                  else {
                                                                    widget.mstatus = "Active";
                                                                    getMembersStatus(widget.mstatus);
                                                                    Navigator.pop(context);
                                                                  }

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
                                    });

                                  /*  setState(() {

                                      if(val==true) {
                                        widget.mstatus = "Blocked";
                                        getMembersStatus(widget.mstatus);
                                      }
                                      else {
                                        widget.mstatus = "Active";
                                        getMembersStatus(widget.mstatus);
                                      }

                                    }); */

                                  },
                                ),








                                SizedBox(
                                  width: 30,
                                ),

                                SizedBox(
                                 height: 45,
                                  width: 100,
                                  child: InkWell(
                                    onTap: () {
                                      setState((){
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
                                                            Text(
                                                                "Do you really want to delete"+" "+widget.mobileNumber+" "+"?"),
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
                                                                      });
                                                                      Get.back();
                                                                      //_myList.removeAt(index);
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
                                    child: Card(
                                      color: Colors.green,
                                      shape:  RoundedRectangleBorder(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(32.0),

                                        ),
                                      ),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons.delete_outline_outlined,color: Colors.black54,), // <-- Icon
                                            Text("Delete",style: TextStyle(color: Colors.black54,fontSize: 14.0),), // <-- Text
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

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
  }

  Future<MemberBlockDeleteModel> getMembersStatus(String status) async {
    setState(() {

    });

     if (status.toLowerCase().toString() == "Deleted") {
      Get.snackbar("Hello!", "Family member is deleted",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: CustomColor.black);
      setState(() {
        getUserFamilyList();
      });

    }else if (status.toLowerCase().toString() == "Blocked") {
      Get.snackbar("Hello!", "Family member is blocked",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: CustomColor.black);
      //updateStatus();
    }/*else if (status.toLowerCase().toString() == "Active") {
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
        "member_id": widget.memberId,
        "status": status.toString()
      }),
    );
    print("FamilyMemberStatusData" +
        jsonEncode(<String, String>{
          "user_id": userId,
          "member_id": widget.memberId,
          "status": status.toString()
        }));
    if (response.statusCode == 200) {
      setState(() {

      });
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

}
