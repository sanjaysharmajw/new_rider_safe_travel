import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:http/http.dart' as http;
import 'Error.dart';
import 'LoginModule/custom_color.dart';
import 'LoginModule/preferences.dart';
import 'Models/MemberBlockDeleteModel.dart';

class ToggleSwitchButton extends StatefulWidget {
  String mstatus;
  String memberId;
  String userId;
   ToggleSwitchButton({Key? key, required this.mstatus, required this.memberId,required this.userId}) : super(key: key);

  @override
  State<ToggleSwitchButton> createState() => _ToggleSwitchButtonState();
}

class _ToggleSwitchButtonState extends State<ToggleSwitchButton> {
  @override
  Widget build(BuildContext context) {
    return   Container(
      child: Column(
        children: [
         // Text("Status:"+widget.mstatus.toString()),
          FlutterSwitch(
            activeText: "Block",
            inactiveText: "Unblock",
            value: (widget.mstatus.toString()=='Blocked'?true:false),
            activeTextColor: Colors.black54,
            inactiveTextColor: Colors.black54,
            activeColor: Colors.red,
            inactiveColor: Colors.green,
            valueFontSize: 15.0,
            width: 100,
            height: 40,
            borderRadius: 32.0,
            //switchBorder: Border.all(
            //color: Colors.black,
            //width: 1.0,
            //),

            showOnOff: true,
            toggleSize: 20,
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
                                  getMembersStatus();
                                  Navigator.pop(context);
                                }
                                else {
                                  widget.mstatus = "Active";
                                  getMembersStatus();
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


            },

          ),
        ],
      ),
    );
  }

  Future<MemberBlockDeleteModel> getMembersStatus() async {
    setState(() {

    });


    await Preferences.setPreferences();
    String userId = Preferences.getId(Preferences.id).toString();
    final response = await http.post(
      Uri.parse(
          'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/userRide/deleteblockFamilyMember'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "user_id": widget.userId,
        "member_id": widget.memberId,
        "status": widget.mstatus.toString()
      }),
    );
    print("FamilyMemberStatusData" +
        jsonEncode(<String, String>{
          "user_id": widget.userId,
          "member_id": widget.memberId,
          "status": widget.mstatus.toString()
        }));
    if (response.statusCode == 200) {
      setState(() {

      });
     // getUserFamilyList();
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      print("Body: " + response.body);
      if (status == true) {

        setState(() {
          // getUserFamilyList();
        });
       // getUserFamilyList();
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
