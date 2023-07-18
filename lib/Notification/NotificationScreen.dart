import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/Notification/NotificationDialogBox.dart';
import 'package:ride_safe_travel/color_constant.dart';
import 'package:ride_safe_travel/notification-dict/notification_controller.dart';

import '../Error.dart';
import '../LoginModule/Api_Url.dart';
import '../LoginModule/custom_color.dart';
import '../Services_Module/requested_servicelists_item.dart';
import '../Utils/EmptyScreen.dart';
import '../Utils/Loader.dart';
import '../Utils/toast.dart';
import 'NotificationItems.dart';
import 'NotificationModels.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final notificationcontroller = Get.put(notificationController());
  @override
  Widget build(BuildContext context) {
    Color status;

    return SafeArea(

        child: Scaffold(
            appBar: AppBar(
              elevation: 15,
              backgroundColor: appBlue,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_outlined, color: Colors.white,size: 25,),
                  onPressed: () {
                    Navigator.of(context).pop('refresh');
                  }),
              title:  Text('notification'.tr,
                style: TextStyle(fontFamily: "Gilroy",fontSize: 22,color: Colors.white),),
            ),
            body: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Obx(() {
                      return notificationcontroller.isLoading.value
                          ? LoaderUtils.loader()
                          : notificationcontroller.getNotificationData.isEmpty
                          ? Center(
                        child: EmptyScreen(

                        ),
                      )
                          : ListView.builder(
                          itemCount:
                          notificationcontroller.getNotificationData.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {

                            print(
                              notificationcontroller.getNotificationData.length,
                            );
                            var notification = notificationcontroller.getNotificationData[index];
                            if (notification.type == 'ride sos alert') {
                              status = Colors.red;
                            } else {
                              status = Colors.blue;
                            }

                            return NotificationItems(Title: notification.title.toString(),
                                Des: notification.description.toString(), border: Colors.white,
                                click: () {
                                  NotificationPopup(
                                      context,
                                      notification.title.toString(),
                                      notification.description.toString(),
                                          () {
                                        setState(() {
                                          OverlayLoadingProgress.start(context);
                                          notificationcontroller.readNotification(notification.id.toString());

                                          Navigator.of(context).pop();
                                        });
                                      });
                                }, date: notification.date.toString(), borderColor: status);
                          });
                    }),
                  )
                ],
              ),
            ),
            /*FutureBuilder<List<NotificationData>>(
              future: getNotification(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      //DateFormat formatter = DateFormat.yMMMd(); // use any format
                      //String formatted = formatter.format(DateTime.parse(snapshot.data![index].date.toString()));
                      //print("NotificationDate..."+formatted);
                      if (snapshot.data![index].type == 'ride sos alert') {
                        status = Colors.red;
                      } else {
                        status = Colors.blue;
                      }
                      return NotificationItems(
                          Title: snapshot.data![index].title.toString(),
                          Des: snapshot.data![index].description.toString(),
                          border: Colors.white,
                          click: () {
                            NotificationPopup(
                                context,
                                snapshot.data![index].title.toString(),
                                snapshot.data![index].description.toString(),
                                () {
                              setState(() {
                                OverlayLoadingProgress.start(context);
                                readNotification(
                                    snapshot.data![index].id.toString());
                                Navigator.of(context).pop();
                              });
                            });
                          },
                          date: snapshot.data![index].date.toString(),
                        borderColor: status,);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Center(child: CircularProgressIndicator());
              },
            )*/
        ));
  }



 /* Future<List<NotificationData>> getNotification() async {
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);
    await Preferences.setPreferences();
    String userId = Preferences.getId(Preferences.id).toString();
    final response = await http.post(
      (Uri.parse(
          ApiUrl.countNotification)), //old end url: userFamilyList
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': loginToken
      },
      body: jsonEncode(<String, String>{"user_id": userId}),
    );
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      print('RES:${response.body}');
      List<NotificationData> Data = jsonDecode(response.body)['data']
          .map<NotificationData>((data) => NotificationData.fromJson(data))
          .toList();
      setState(() {});
      return Data;
    } else {
      throw Exception('Failed to load');
    }
  }*/

  /*Future<http.Response> readNotification(String id) async {
    var loginToken = Preferences.getLoginToken(Preferences.loginToken);

    final response = await http.post(Uri.parse(ApiUrl.readNotification),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': loginToken
        },
        body: json.encode({
          'id': id.toString(),
        }));

    print("userid: $id");

    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      if (status == true) {
        OverlayLoadingProgress.stop();
        setState(() async {
          await getNotification();
        });
        ToastMessage.toast(msg.toString());
        Navigator.of(context).pop();
      } else {
        OverlayLoadingProgress.stop();
        ToastMessage.toast(msg.toString());
      }
      return response;
    } else {
      throw Exception('Failed');
    }
  }*/
}
