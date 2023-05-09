import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/home_page_controller/sos_controller.dart';

import '../color_constant.dart';
import 'get_sos_controller_master.dart';

Future<bool> sosPopUp(context, String riderId, String lat, String lng) async {
  final getSosMasterController = Get.put(GetSosMasterController());
  final sosPushController = Get.put(SOSController());
  var reason;
  var Sos_status = 'Ok';
  bool isSelected = false;

  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 190,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,
              children: [
                Text(
                    "are_you_in_trouble_?_please_select_your_reason_: ".tr),
                SizedBox(height: 15),
                Column(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .center,
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .center,
                  children: <Widget>[
                    SizedBox(
                      height: 65,
                      child: Card(
                        color:
                        Colors.white,
                        shape: UnderlineInputBorder(
                            borderRadius:
                            BorderRadius
                                .circular(
                                10),
                            borderSide:
                            BorderSide(
                                color:
                                appBlue)),
                        child: Padding(
                          padding:
                          EdgeInsets
                              .all(
                              15),
                          child:
                          DropdownButton(
                            underline:
                            Container(),
                            // hint: Text("Select State"),
                            icon: Icon(Icons
                                .keyboard_arrow_down),
                            isDense: true,
                            isExpanded:
                            true,

                            items: getSosMasterController.getSosReasonMasterData
                                .map((e) {
                              return DropdownMenuItem(
                                value: e.name.toString(),
                                child: Text(e.name.toString()),
                              );
                            }).toList(),
                            value: reason,
                            onChanged:
                                (value) {

                                    Sos_status =
                                    "SOS";
                                    reason =
                                        value;
                                    isSelected =
                                    true;

                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child:
                      ElevatedButton(
                        onPressed: () {
                          OverlayLoadingProgress
                              .start(
                              context);
                          sosPushController.SOSNotification(reason, riderId, lat.toString(), lng.toString());
                        },
                        child:
                        Text("yes".tr),
                        style: ElevatedButton
                            .styleFrom(
                            primary:
                            appBlue),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                        child:
                        ElevatedButton(
                          onPressed: () {
                            print(
                                'no selected');
                            Navigator.of(
                                context)
                                .pop();
                          },
                          child: Text("no".tr,
                              style: TextStyle(
                                  color: Colors
                                      .black)),
                          style:
                          ElevatedButton
                              .styleFrom(
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
}
