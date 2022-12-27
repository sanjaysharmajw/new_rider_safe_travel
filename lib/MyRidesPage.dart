import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
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
    return SafeArea(
        child: Scaffold(

            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: CustomColor.white,
              elevation: 0,
              title: const Text("My Trips List",
                  style: TextStyle(color: CustomColor.black)),
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
                      print(snapshot.data?.length,);
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
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: CustomColor.yellow
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                 // left: 90,
                                  right: 30,
                                  child: Column(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("DATE:  "+
                                          snapshot
                                              .data![index].date.toString(),
                                          style: const TextStyle(
                                              fontFamily:
                                              'transport',
                                              fontSize:
                                              15)),
                                    ],
                                  ),
                                ),

                                Positioned.fill(
                                  top: 20,
                                  child: Row(
                                    children: [
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: ClipOval(
                                          child:
                                          (snapshot
                                              .data![
                                          index]
                                              .driverPhoto !=
                                              null)
                                              ? Image.network(
                                            snapshot
                                                .data![
                                            index]
                                                .driverPhoto
                                                .toString(),
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit
                                                .cover,
                                          )
                                              : Image.asset(
                                              'assets/user_avatar.png'),
                                        ),
                                        flex: 2,
                                      ),
                                      SizedBox(width: 20,),
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Driver Name: "),
                                            Text(snapshot
                                                .data![index]
                                                .driverName
                                                .toString(),
                                                style: const TextStyle(
                                                    fontFamily:
                                                    'transport',
                                                    fontSize:
                                                    15)),
                                            SizedBox(height: 10,),
                                            Text("Driver Mobile Number: "),
                                            Text(snapshot
                                                .data![index]
                                                .driverMobileNumber
                                                .toString(),
                                                style: const TextStyle(
                                                    fontFamily:
                                                    'transport',
                                                    fontSize:
                                                    15))
                                          ],


                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Vehicle Re.No. : "),
                                            Text(snapshot
                                                .data![index].vehicleRegistrationNumber.toString(),
                                                style: const TextStyle(
                                                    fontFamily:
                                                    'transport',
                                                    fontSize:
                                                    15)),
                                            SizedBox(height: 10,),
                                            Text("Veicle Model Name: "),
                                            Text(snapshot
                                                .data![index].vehicleModel.toString(),
                                                style: const TextStyle(
                                                    fontFamily:
                                                    'transport',
                                                    fontSize:
                                                    15))
                                          ],
                                        ),
                                      )




                                    ],
                                  ),
                                )
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
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            )
        ));
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

      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      List<RideDataModel> rideData = jsonDecode(response.body)['data'].map<RideDataModel>((data) => RideDataModel.fromJson(data)).toList();
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
