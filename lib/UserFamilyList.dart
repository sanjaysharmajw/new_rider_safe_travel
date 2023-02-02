import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import 'DriverVehicleList.dart';
import 'FamilyMemberAddOtherTrack.dart';
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
      (Uri.parse(
          'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/myFamilyList')), //old end url: userFamilyList
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"user_id": userId}),
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

  var image;

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
              style: TextStyle(color: CustomColor.black,fontSize: 20, fontFamily: 'transport',)),
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

        body: FutureBuilder<List<FamilyMembersData>>(
          future: _future,
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Data not found"),
                CircularProgressIndicator()
                ],
              ));
            }else
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                 image= "${snapshot.data![index].memberProfileImage.toString()}";
                  print(snapshot.data!.length);
                  print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                  return Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 20,
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 8, bottom: 25),
                          child: Container(
                            height: 185,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: CustomColor.yellow,
                                      radius: 30.r,
                                      child: CircleAvatar(
                                        radius: 30.r,
                                        backgroundColor: Colors.white,
                                        child: ClipOval(
                                          child: (image != null)
                                              ? Image.network(
                                            image,
                                            width: 80.w,
                                            height: 80.w,
                                            fit: BoxFit.cover,
                                          )
                                              : Image.asset('assets/user_avatar.png'),
                                        ),


                                      ),
                                    ),
                                   /* CachedNetworkImage(
                                      imageUrl:
                                          "${snapshot.data![index].memberProfileImage.toString()}",
                                      height: 60,
                                      width: 60,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ), */
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "First Name.-",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800,
                                              fontFamily: "transport"),
                                              ),
                                              Text(
                                                "${snapshot.data![index].memberFName.toString()}" == "null" ? "Data not available" :
                                                "${snapshot.data![index].memberFName.toString()}",
                                                style: TextStyle(
                                                    fontSize: 16,

                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Last Name.-",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800,
                                                  fontFamily: "transport"),
                                              ),
                                              Text(
                                                "${snapshot.data![index].memberLName.toString()}" == "null" ? "Data not available" :
                                                "${snapshot.data![index].memberLName.toString()}",style: TextStyle(
                                                  fontSize: 16,

                                              ),
                                              ),
                                            ],
                                          ),
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
                                left: 10, right: 10, top: 80, bottom: 10),
                            child: Divider(
                              color: Colors.white,
                              height: 20,
                              thickness: 2,
                            )),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 100.0, left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Mobile Number.-",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800,
                                          fontFamily: "transport"),
                                      ),
                                      Text(
                                        "${snapshot.data![index].memberMobileNumber.toString()}" == "null" ? "Data not available" :
                                        "${snapshot.data![index].memberMobileNumber.toString()}",style: TextStyle(
                                        fontSize: 16,

                                      ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Email Id.-",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800,
                                          fontFamily: "transport"),
                                      ),
                                      Text(
                                        "${snapshot.data![index].memberEmailId.toString()}"  == "null" ? "Data not available" :
                                        "${snapshot.data![index].memberEmailId.toString()}",
                                        style: TextStyle(
                                        fontSize: 16,

                                      ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Member Relation.-",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800,
                                          fontFamily: "transport"),
                                      ),
                                      Text(
                                        "${snapshot.data![index].relation.toString()}" == "null" ? "Data not available" :
                                        "${snapshot.data![index].relation.toString()}",
                                        style: TextStyle(
                                        fontSize: 16,

                                      ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Color(0xffffd91d)),
                              ),
                            ),
                          ),
                        ),
                      ],
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
}
