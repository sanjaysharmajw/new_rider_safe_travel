import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import 'DriverVehicleList.dart';
import 'LoginModule/custom_color.dart';
import 'LoginModule/preferences.dart';
import 'UserFamilyListModel.dart';

class UserFamilyList extends StatefulWidget {
  const UserFamilyList({Key? key}) : super(key: key);

  @override
  State<UserFamilyList> createState() => _UserFamilyListState();
}

class _UserFamilyListState extends State<UserFamilyList> {

  var _future;

  Future<List<FamilyMembersData>> getUserFamilyList() async {
    await Preferences.setPreferences();
    String userId = Preferences.getId(Preferences.id).toString();
    print(userId);
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    final response = await http.post(
      (Uri.parse('https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/userFamilyList')),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "user_id":userId
      }),
    );
    if (response.statusCode == 200) {
      print('RES:${response.body}');
      List<FamilyMembersData> loginData = jsonDecode(response.body)['data']
          .map<FamilyMembersData>((data) => FamilyMembersData.fromJson(data))
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
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
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
          ),
          body:  FutureBuilder<List<FamilyMembersData>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return  ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data!.length);
                        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                        return  Container(
                          padding: const EdgeInsets.only(left: 15, right: 15,),
                          child:  Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 25),
                                child: Container(
                                  height: 170,
                                  width: 360,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: CustomColor.yellow,
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: "${snapshot.data![index].memberProfileImage.toString()}",
                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                CircularProgressIndicator(value: downloadProgress.progress),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("First Name.- ${snapshot.data![index].memberFName.toString()}",),
                                                Text("Last Name.- ${snapshot.data![index].memberLName.toString()}",),
                                                ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 70,bottom: 10),
                                  child: Divider(
                                    color: Colors.white,
                                    height: 20,
                                    thickness: 2,
                                  )),
                              Container(
                                child:  Padding(
                                      padding: const EdgeInsets.only(top: 90.0,left: 20),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:  EdgeInsets.all(5.0),
                                                  child: Text("Mobile Number.- ${snapshot.data![index].memberMobileNumber.toString()}",),
                                                ),
                                                Padding(
                                                  padding:  EdgeInsets.all(5.0),
                                                  child: Text("Email Id.- ${snapshot.data![index].memberEmailId.toString()}",),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Text("Member Relation.- ${snapshot.data![index].relation.toString()}",),
                                                ),
                                              ],
                                            ),

                                    ),
                              ),
                              Center(
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 190,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Color(0xffffd91d)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),) ;
                      },
                    ) ;
              }
              else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return  CircularProgressIndicator();
            },
          )

      );
  }


}
