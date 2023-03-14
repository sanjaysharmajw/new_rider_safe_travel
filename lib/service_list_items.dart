import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import 'Error.dart';
import 'LoginModule/custom_color.dart';
import 'LoginModule/preferences.dart';
import 'SearchServicesModel.dart';


class ServiceListItems extends StatelessWidget {
  final ServiceListData data;
  ServiceListItems({Key? key, required this.data}) : super(key: key);

  final TextEditingController commentController = TextEditingController();
  var serviceId;
  var Id;
  var comment;
  var serviceProvideId;
  num? lat;
  num? lng;
  var userId;


  @override
  Widget build(BuildContext context) {
    serviceId = data.serviceId.toString();
    Id = data.id.toString();
    comment = commentController.text.toString();
    //serviceProvideId = data.
    lat = data.addressDetails?.lat;
    lng = data.addressDetails?.lng;
    userId = data.userId.toString();

    return Card(
        elevation: 15,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data.title.toString(),
                      style: TextStyle(color: CustomColor.black, fontSize: 20),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data.serviceName.toString(),
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Text(
                          "Kilometer",
                          style: TextStyle(color: Colors.black54, fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          data.dist.toString(),
                          style: TextStyle(color: Colors.black87, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [


                        Text("Rejected on",style: TextStyle(color: Colors.black54,fontSize: 18),),
                        SizedBox(height: 10,),
                        Text("04 March 2023 05.50 PM",style: TextStyle(color: Colors.black87,fontSize: 16),),

                      ],
                    ),


                  ), */
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8),
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                content: Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 15),
                                  child: SizedBox(
                                    child: Container(
                                      height: 80,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Color(0xffffd91d)),
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 20, top: 2),
                                        child: TextFormField(
                                          controller: commentController,

                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Write a Comment',
                                          ),
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
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
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 70),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          serviceRequest();
                                          },
                                        child: const Text("Send Request"),
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.black87,
                                          primary: CustomColor.yellow,
                                        )),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text("Request"),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black87,
                            primary: CustomColor.yellow,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Future<http.Response> serviceRequest() async {

    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    final response = await http.post(
      Uri.parse("https://i981xwdx4g.execute-api.ap-south-1.amazonaws.com/dev/api/serviceProvider/sendServiceRequest"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': loginToken
      },
      body: jsonEncode({
        "service_id": serviceId,
        "id": Id,
        "comment": commentController.text.toString(),
        "service_provider_id": Id,
        "lng": lng,
        "lat":lat,
        "user_id": userId
      }),
    );
    print("SendServiceRequest..."+jsonEncode({
      "service_id": serviceId,
      "id": Id,
      "comment":commentController.text.toString(),
      "service_provider_id": Id,
      "lng": lng,
      "lat":lat,
      "user_id": userId
    }),);
    if (response.statusCode == 200) {
      //var jsonResponse = json.decode(response.body)['data'];
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];

      Get.back();
      print("ServiceRequestMessage"+msg);
      print(response.body);
      return response;
    } else {
      throw Exception('Failed');
    }
  }

}
