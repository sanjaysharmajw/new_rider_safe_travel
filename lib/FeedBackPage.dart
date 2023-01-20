import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:ride_safe_travel/Utils/small_submit_button.dart';
import 'Error.dart';
import 'LoginModule/Api_Url.dart';
import 'LoginModule/SaveUserFeedback.dart';
import 'LoginModule/custom_color.dart';
import 'LoginModule/preferences.dart';
import 'Models/SaveRideFeedbackModel.dart';
import 'Models/TripDataModel.dart';

class FeedBackScreenPage extends StatefulWidget {
  const FeedBackScreenPage({Key? key}) : super(key: key);

  @override
  State<FeedBackScreenPage> createState() => _FeedBackScreenPageState();
}

class _FeedBackScreenPageState extends State<FeedBackScreenPage> {

  String? userFeedbackId;
  String _name = '';
  String? starRating;
  TextEditingController reviewController = new TextEditingController();
  TextEditingController userReviewController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: CustomColor.yellow,
            elevation: 15,
            leading: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: IconButton(
                  onPressed: () {
                    Get.back(canPop: true);
                  },
                  icon: Icon(
                    Icons.arrow_back_sharp,
                    color: CustomColor.black,
                    size: 30,
                  )),
            ),
            title: Text("FeedBack",
              style: TextStyle(color: CustomColor.black,fontSize: 20, fontFamily: 'transport',),),
          ),
          body: Container(
            padding: const EdgeInsets.only(left: 15, right: 15,top: 15),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: FutureBuilder<List<TripDataModel>>(
                    future: getData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            print(snapshot.data?.length,);
                            print("______________________________________");
                            return InkWell(
                                onTap: (){},
                                child:
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: CustomColor.yellow)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: CustomColor.yellow),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 10,),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                    "DATE:  " +
                                                        snapshot.data![index].date.toString() == null ? '' : snapshot.data![index].date.toString(),
                                                    style: TextStyle(
                                                        fontFamily: 'transport',
                                                        fontSize: 15)),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(12.0),
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: CustomColor.yellow,
                                                        radius: 30,
                                                        child: CircleAvatar(
                                                          backgroundColor: CustomColor.yellow,
                                                          radius: 29,
                                                          child: ClipOval(
                                                            child:
                                                            ( snapshot.data![index].vehiclePhoto !=
                                                                null)
                                                                ? Image.network(
                                                              snapshot.data![index].vehiclePhoto
                                                                  .toString(),
                                                              width: 55,
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
                                                        padding: const EdgeInsets.only(top: 2, left: 6),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Text(
                                                              "Driver Name",
                                                              style: TextStyle(
                                                                  color: CustomColor.text,
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                            Text(snapshot.data![index].driverName == null ? '' : snapshot.data![index].driverName.toString(),
                                                                style: const TextStyle(
                                                                    color: CustomColor.black,
                                                                    fontWeight: FontWeight.bold))
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 2, left: 25),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Text(
                                                              "Vehicle Reg. No",
                                                              style: TextStyle(
                                                                  color: CustomColor.text,
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                            Text(snapshot.data![index].vehicleRegistrationNumber == null ? '' : snapshot.data![index].vehicleRegistrationNumber.toString(),
                                                                style: const TextStyle(
                                                                    color: CustomColor.black,
                                                                    fontWeight: FontWeight.bold))
                                                          ],
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                              color: Colors.white,
                                              height: 3,
                                              thickness: 1,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left:10, right: 5, top: 5, bottom: 5),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Source Location :",
                                                    style: TextStyle(
                                                        color: CustomColor.text,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(snapshot.data![index].fromDestination == null ? '' : snapshot.data![index].fromDestination.toString(),
                                                      style: const TextStyle(
                                                          color: CustomColor.text,
                                                          fontWeight: FontWeight.bold)),

                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10,right: 5,  bottom: 10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Destination Location :",
                                                    style: TextStyle(
                                                        color: CustomColor.text,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text( snapshot.data![index].toDestination == null ? '' : snapshot.data![index].toDestination.toString(),
                                                      style: const TextStyle(
                                                          color: CustomColor.text,
                                                          fontWeight: FontWeight.bold)),

                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 180),
                                              child: ElevatedButton(
                                                child: Text("Give Feedback"),
                                                onPressed: (){
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        content:Container(
                                                          height: 200,
                                                          child: Column(
                                                            children: [
                                                              const Center(
                                                                  child: Text(
                                                                    "Say Something About Your Experience ",
                                                                    style: TextStyle(fontWeight: FontWeight.w900, color: CustomColor.black
                                                                    ),)
                                                              ),
                                                              const SizedBox(height: 22,),
                                                              SizedBox(
                                                                child: Container(
                                                                  height: 100,
                                                                  decoration:  BoxDecoration (
                                                                    borderRadius:  BorderRadius.circular(8),
                                                                    border:  Border.all(color: Color(0xffffd91d)),
                                                                  ),
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(left: 20,top: 2),
                                                                    child: TextFormField(
                                                                      controller: reviewController,
                                                                      // autovalidateMode: _submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                                                                      decoration: InputDecoration(
                                                                        border: InputBorder.none,
                                                                        hintText: 'Write a Review',
                                                                      ),
                                                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                      validator: (text) {
                                                                        if (text == null || text.isEmpty) {
                                                                          return 'Can\'t be empty';
                                                                        }
                                                                        if (text.length < 4) {
                                                                          return 'Too short';
                                                                        }
                                                                        return null;
                                                                      },
                                                                      // update the state variable when the text changes
                                                                      onChanged: (text) => setState(() => _name = text),
                                                                    ),

                                                                  ),
                                                                ),
                                                              ),
                                                              RatingBar.builder(
                                                                initialRating: 3,
                                                                minRating: 1,
                                                                direction: Axis.horizontal,
                                                                allowHalfRating: true,
                                                                itemCount: 5,
                                                                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                                itemBuilder: (context, _) => Icon(
                                                                  Icons.star,
                                                                  color: Colors.amber,
                                                                ),
                                                                onRatingUpdate: (rating) {
                                                                  print(rating);
                                                                  starRating = rating.toString() ;
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          Column(
                                                            children: [
                                                              Center(
                                                                child: SmallButton(
                                                                    textColor: CustomColor.black,
                                                                    height: 50,
                                                                    buttonTitle: "Submit",
                                                                    onPressed: () async {
                                                                      print("RIDER-USER-FEEDBACK-ID");
                                                                      print(snapshot.data![index].id.toString());
                                                                      saveRiderFeedback(snapshot.data![index].id.toString());
                                                                    },
                                                                    width: 160),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.green,
                                                  onPrimary: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(32.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      // By default, show a loading spinner.
                      return Center(child: const CircularProgressIndicator());
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: CustomColor.yellow)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: CustomColor.yellow),
                            child: Column(
                              children: [
                                Padding(
                                    padding:  EdgeInsets.only(
                                        left:10, right: 5, top: 15, bottom: 5),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Help ?",style: TextStyle(color: CustomColor.black,fontWeight: FontWeight.bold),),

                                        ]
                                    )
                                ),
                                Divider(
                                  color: Colors.white,
                                  height: 3,
                                  thickness: 1,
                                ),
                                Padding(
                                    padding:  EdgeInsets.only(
                                        left:10, right: 5, top: 5, bottom: 5),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Driver Feedback",style: TextStyle(color: CustomColor.black,fontWeight: FontWeight.bold),),
                                          InkWell(
                                            onTap: (){
                                              showDialgueBox("driver");
                                            },
                                            child: Image(image: AssetImage('images/turn-right.png'),width: 30,height: 30,),
                                          )
                                        ]
                                    )
                                ),
                                Divider(
                                  color: Colors.white,
                                  height: 3,
                                  thickness: 1,
                                ),
                                Padding(
                                    padding:  EdgeInsets.only(
                                        left:10, right: 5, top: 5, bottom: 5),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Usage Feedback",style: TextStyle(color: CustomColor.black,fontWeight: FontWeight.bold),),
                                          InkWell(
                                            onTap: (){
                                              showDialgueBox("usage");
                                            },
                                            child: Image(image: AssetImage('images/turn-right.png'),width: 30,height: 30,),
                                          )
                                        ]
                                    )
                                ),
                                Divider(
                                  color: Colors.white,
                                  height: 3,
                                  thickness: 1,
                                ),
                                Padding(
                                    padding:  EdgeInsets.only(
                                        left:10, right: 5, top: 5, bottom: 5),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("App Feedback",style: TextStyle(color: CustomColor.black,fontWeight: FontWeight.bold),),
                                          InkWell(
                                            onTap: (){
                                              showDialgueBox("app");
                                            },
                                            child: Image(image: AssetImage('images/turn-right.png'),width: 30,height: 30,),
                                          )
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),

              ],
            ),
          ),
    ));
  }

  Future<List<TripDataModel>> getData() async {
    await Preferences.setPreferences();
    String userId = Preferences.getId(Preferences.id).toString();
    userFeedbackId = userId ;
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
      List<TripDataModel> rideData = jsonDecode(response.body)['data'].map<TripDataModel>((data) =>
          TripDataModel.fromJson(data)).toList();
      return rideData;

    } else {
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to load');
    }
  }

  Future<SaveRideFeedbackModel> saveRiderFeedback(String riderUserId )
  async {
    await Preferences.setPreferences();
    print("RIDER-USER-FEEDBACK: "+riderUserId!);
    print( jsonEncode(<String, String>{
      "ride_id": riderUserId,
      "user_type": "rider",
      "feedback": reviewController.text.toString(),
      "rating": starRating.toString()
    }),);

    final response = await http.post(Uri.parse(
        'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/userRide/saveRideFeedback'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "ride_id": riderUserId,
        "user_type": "rider",
        "feedback": reviewController.text.toString(),
        "rating": starRating.toString()
      }),
    );
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      print("Body: "+response.body);
      if (status == true) {
        Navigator.pop(context);

        Get.snackbar("Hello", msg.toString(),snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.green,colorText: CustomColor.black);

      }else if(status==false){
        Get.snackbar("Ooops!", msg.toString(),snackPosition: SnackPosition.BOTTOM,backgroundColor: CustomColor.red,colorText: CustomColor.black);
        Navigator.pop(context);
      }

      return SaveRideFeedbackModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }

  showDialgueBox(String type){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content:Container(
            height: 200,
            child: Column(
              children: [
                const Center(
                    child: Text(
                      "Say Something About Your Experience ",
                      style: TextStyle(fontWeight: FontWeight.w900, color: CustomColor.black
                      ),)
                ),
                const SizedBox(height: 22,),
                SizedBox(
                  child: Container(
                    height: 100,
                    decoration:  BoxDecoration (
                      borderRadius:  BorderRadius.circular(8),
                      border:  Border.all(color: Color(0xffffd91d)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20,top: 2),
                      child: TextFormField(
                        controller: userReviewController,
                        // autovalidateMode: _submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write a Review',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Can\'t be empty';
                          }
                          if (text.length < 4) {
                            return 'Too short';
                          }
                          return null;
                        },
                        // update the state variable when the text changes
                        onChanged: (text) => setState(() => _name = text),
                      ),

                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Column(
              children: [
                Center(
                  child: SmallButton(
                      textColor: CustomColor.black,
                      height: 50,
                      buttonTitle: "Submit",
                      onPressed: () async {
                        print("USER-FEEDBACK-ID");
                        saveUserFeedback(type);
                      },
                      width: 160),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Future<SaveUserFeedback> saveUserFeedback(String type)
  async {
    print("USER-FEEDBACK: "+userFeedbackId.toString());
    print( "SaveUserFeedback"+jsonEncode(<String, String>{
      "user_id": userFeedbackId.toString(),
      "type": type ,
      "comment": userReviewController.text.toString(),
    }),);

    final response = await http.post(Uri.parse(
        'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/user/saveUserFeedback'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "user_id": userFeedbackId.toString(),
        "type": type ,
        "comment": userReviewController.text.toString(),
      }),



    );
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      print("Body: "+response.body);
      if (status == true) {
        Navigator.pop(context);

        Get.snackbar("Hello!", msg.toString(),snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.green,colorText: CustomColor.black);

      }else if(status==false){

        Get.snackbar("Ooops!", msg.toString(),snackPosition: SnackPosition.BOTTOM,backgroundColor: CustomColor.red,colorText: CustomColor.black);
        Navigator.pop(context);
      }
      return SaveUserFeedback.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
