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

import '../../FamilyMemberAddOtherTrack.dart';
import '../../FamilyMemberAddScreen.dart';

class TrackFamilyMemberListScreen extends StatefulWidget {
  const TrackFamilyMemberListScreen({Key? key}) : super(key: key);

  @override
  State<TrackFamilyMemberListScreen> createState() => _TrackFamilyMemberListScreenState();
}

class _TrackFamilyMemberListScreenState extends State<TrackFamilyMemberListScreen> {
  var _future;

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
        body: FutureBuilder<List<Familymodel>>(
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
                            userId:  snapshot.data![index].userId.toString(),
                          ));
                        } else {
                          const Center(child: CircularProgressIndicator());
                        }
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  border: Border.all(
                                      color: CustomColor.black,
                                      width: 1.5)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: CustomColor.yellow,
                                  ),
                                  child: Column(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.all(0.0),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor:
                                                      CustomColor.yellow,
                                                  radius: 27.0,
                                                  child: CircleAvatar(
                                                    radius: 25.0,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: ClipOval(
                                                      //""
                                                      child: (snapshot
                                                                  .data![
                                                                      index]
                                                                  .member_photo !=
                                                              null)
                                                          ? Image.network(
                                                              snapshot
                                                                  .data![
                                                                      index]
                                                                  .member_photo
                                                                  .toString(),
                                                              width: 50,
                                                              height: 50,
                                                              fit: BoxFit
                                                                  .cover,
                                                            )
                                                          : Image.asset(
                                                              'assets/user_avatar.png'),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          15.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          snapshot
                                                                  .data![
                                                                      index]
                                                                  .memberName.toString() == "null" ? "Data Not Available" : snapshot
                                                              .data![
                                                          index]
                                                              .memberName.toString(),
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'transport',
                                                              fontSize:
                                                                  15)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Driver Name",
                                              style: TextStyle(
                                                  fontFamily: 'transport',
                                                  fontSize: 16,fontWeight: FontWeight.w800)),
                                          Text(
                                              snapshot
                                                  .data![index].driverName
                                                  .toString() == "null" ? "Data Not Available" : snapshot
                                                  .data![index].driverName
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'transport',
                                                  fontSize: 15)),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Driver Mobile",
                                              style: TextStyle(
                                                  fontFamily: 'transport',
                                                  fontSize: 16,fontWeight: FontWeight.w800)),
                                          Text(
                                              snapshot.data![index]
                                                  .driverMobileNumber
                                                  .toString() == "null" ? "Data Not Available" :  snapshot.data![index]
                                                  .driverMobileNumber
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'transport',
                                                  fontSize: 15)),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Ride Id",
                                              style: TextStyle(
                                                  fontFamily: 'transport',
                                                  fontSize: 16,fontWeight: FontWeight.w800)),
                                          Text(
                                              snapshot.data![index].id
                                                  .toString() == "null" ? "Data Not Available" :  snapshot.data![index].id
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'transport',
                                                  fontSize: 15)),
                                        ],
                                      ),
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
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return Center(child: const CircularProgressIndicator());
          },
        ));
  }

  Future<List<Familymodel>> getData(String userId) async {
    final response = await http.post(
      Uri.parse(ApiUrl.familyMember),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': userId,
      }),
    );
    print('User Id:${userId.toString()}');

    if (response.statusCode == 200) {
      List<Familymodel> familyData = jsonDecode(response.body)['data']
          .map<Familymodel>((data) => Familymodel.fromJson(data))
          .toList();
      return familyData;
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  void initState() {
    super.initState();
    sharePre();
  }

  void sharePre() async {
    await Preferences.setPreferences();
    String userId = Preferences.getId(Preferences.id).toString();
    _future = getData(userId);
    //Get.snackbar("Hit with time", userId);
    setState(() {});
  }
}
