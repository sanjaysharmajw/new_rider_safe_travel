import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ride_safe_travel/home_page_controller/sos_controller.dart';
import '../color_constant.dart';
import 'get_sos_controller_master.dart';

Future<bool> sosPopUp(context, String riderId, String lat, String lng) async {
  final getSosMasterController = Get.put(GetSosMasterController());
  final sosPushController = Get.put(SOSController());
  String? reason;

  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            crossAxisAlignment:
            CrossAxisAlignment
                .start,
            children: [
              Text(
                  "are_you_in_trouble_?_please_select_your_reason_: ".tr),
              const SizedBox(height: 15),
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
                          const BorderSide(
                              color:
                              appBlue)),
                      child: Padding(
                        padding:
                        const EdgeInsets
                            .all(
                            15),
                        child:
                        DropdownButton(
                          underline:
                          Container(),
                          // hint: Text("Select State"),
                          icon: const Icon(Icons
                              .keyboard_arrow_down),
                          isDense: true,
                          isExpanded: true,
                          items: getSosMasterController.getSosReasonMasterData.map((e) {
                            return DropdownMenuItem(
                              value: reason.toString(),
                              child: Text(e.name.toString()),
                            );
                          }).toList(),
                          value: reason,
                          onChanged: (value) {
                                  reason = value;

                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
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
                        sosPushController.SOSNotification(reason.toString(), riderId, lat.toString(), lng.toString());
                      },
                      style: ElevatedButton
                          .styleFrom(
                          primary:
                          appBlue),
                      child:  Text("yes".tr),
                    ),
                  ),
                  const SizedBox(width: 15),
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
                        style:
                        ElevatedButton
                            .styleFrom(
                          primary:
                          Colors.white,
                        ),
                        child: Text("no".tr,
                            style: const TextStyle(
                                color: Colors
                                    .black)),
                      ))
                ],
              )
            ],
          ),
        );
      });
}
