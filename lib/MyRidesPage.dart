import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'Error.dart';
import 'LoginModule/Api_Url.dart';
import 'LoginModule/custom_color.dart';
import 'LoginModule/preferences.dart';
import 'Models/RideDataModel.dart';

class MyRidesPage extends StatefulWidget {
  const MyRidesPage({Key? key}) : super(key: key);

  @override
  State<MyRidesPage> createState() => _MyRidesPageState();
}

class _MyRidesPageState extends State<MyRidesPage> {
  var _future;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: CustomColor.yellow,
              elevation: 15,
              title: const Text("My Trips List",
                  style: TextStyle(color: CustomColor.black,fontSize: 20, fontFamily: 'transport',)),
              leading: IconButton(
                color: Colors.black,
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_outlined),
              ),
            ),

            body: FutureBuilder<List<RideDataModel>>(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      print(
                        snapshot.data?.length,
                      );
                      print("______________________________________");
                      return InkWell(
                        onTap: () {
                          setState(() {
                            // Get.to(FamilyMemberViewRiderMap(
                            //   rideId: snapshot.data![index].id.toString(), driverName: snapshot.data![index].driverName.toString(), driverImage: snapshot.data![index].driverPhoto.toString(),
                            // driverLicenseNo: snapshot.data![index].drivingLicenceNumber.toString(), driverMobile: snapshot.data![index].driverMobileNumber.toString(),
                            //vRegistration: snapshot.data![index].vehicleRegistrationNumber.toString(), vModel:  snapshot.data![index].vehicleModel.toString(), vOwner: snapshot.data![index].ownerName.toString()));
                          });
                        },

                          child:
                          Container(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 20,
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, top: 8, bottom: 8),
                                  child: Container(
                                    height: 150,
                                    width: 360,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      color: CustomColor.yellow,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 20.0,
                                  // left: 90,
                                  right: 35,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                          "DATE:  " +
                                              snapshot.data![index].date
                                                  .toString() == null ? '' :  snapshot.data![index].date
                                              .toString(),
                                          style: TextStyle(
                                              fontFamily: 'transport',
                                              fontSize: 15)),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Positioned.fill(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                        height: 30,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: CustomColor.yellow,
                                        radius: 30.r,
                                        child: CircleAvatar(
                                          radius: 28.r,
                                          backgroundColor: Colors.white,
                                          child: ClipOval(
                                            child: (snapshot.data![index]
                                                .driverPhoto !=
                                                null)
                                                ? Image.network(
                                              snapshot
                                                  .data![index].driverPhoto
                                                  .toString(),
                                              width: 50,
                                              height: 60,
                                              fit: BoxFit.cover,
                                            )
                                                : Image.asset(
                                                'assets/user_profile.png'),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text("Driver Name:"),
                                          Text(
                                              snapshot.data![index].driverName == null ? "" : snapshot.data![index].driverName.toString(),
                                              style: TextStyle(
                                                  fontFamily: 'transport',
                                                  fontSize: 15)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Driver MobileNo:"),
                                          Text(
                                              snapshot.data![index]
                                                  .driverMobileNumber
                                                  == null ? "" : snapshot.data![index]
                                                  .driverMobileNumber.toString(),
                                              style: TextStyle(
                                                fontFamily: 'transport',
                                                fontSize: 15.sp,
                                              ))
                                        ],
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text("Vehicle Re.No.:"),
                                          Text(
                                              snapshot.data![index]
                                                  .vehicleRegistrationNumber
                                                  == null ? " " :  snapshot.data![index]
                                                  .vehicleRegistrationNumber.toString(),
                                              style: TextStyle(
                                                  fontFamily: 'transport',
                                                  fontSize: 15)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Veicle Model Name:"),
                                          Text(
                                              snapshot
                                                  .data![index].vehicleModel
                                                  == null ? "" :  snapshot
                                                  .data![index].vehicleModel.toString(),
                                              style: TextStyle(
                                                  fontFamily: 'transport',
                                                  fontSize: 15.sp))
                                        ],
                                      )
                                    ],
                                  ),
                                ),


                              ],
                            ),
                          ),

                        /* Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: CustomColor.yellow,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    border: Border.all(
                                        color: CustomColor.black,
                                        width: 1.5)),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Positioned(
                                        top: 10.0,
                                        // left: 90,
                                        right: 10,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                                "DATE:  " +
                                                    snapshot.data![index].date
                                                        .toString(),
                                                style: TextStyle(
                                                    fontFamily: 'transport',
                                                    fontSize: 15)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Positioned.fill(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                              height: 20,
                                            ),
                                        CircleAvatar(
                                          backgroundColor: CustomColor.yellow,
                                          radius: 30.r,
                                              child: CircleAvatar(
                                                radius: 28.r,
                                                backgroundColor: Colors.white,
                                                child: ClipOval(
                                                  child: (snapshot.data![index]
                                                              .driverPhoto !=
                                                          null)
                                                      ? Image.network(
                                                          snapshot
                                                              .data![index].driverPhoto
                                                              .toString(),
                                                          width: 50,
                                                          height: 60,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.asset(
                                                          'assets/user_profile.png'),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Driver Name:"),
                                                Text(
                                                    snapshot.data![index].driverName
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontFamily: 'transport',
                                                        fontSize: 15)),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text("Driver MobileNo:"),
                                                Text(
                                                    snapshot.data![index]
                                                        .driverMobileNumber
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontFamily: 'transport',
                                                      fontSize: 15.sp,
                                                    ))
                                              ],
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Vehicle Re.No.:"),
                                                Text(
                                                    snapshot.data![index]
                                                        .vehicleRegistrationNumber
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontFamily: 'transport',
                                                        fontSize: 15)),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text("Veicle Model Name:"),
                                                Text(
                                                    snapshot
                                                        .data![index].vehicleModel
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontFamily: 'transport',
                                                        fontSize: 15.sp))
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ), */

                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return Center(child: const CircularProgressIndicator());
              },
            )));
  }

  Future<List<RideDataModel>> getData() async {
    await Preferences.setPreferences();
    String userId = Preferences.getId(Preferences.id).toString();
    final response = await http.post(
      Uri.parse(ApiUrl.getMyTripApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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
