import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ride_safe_travel/Event/alert_dialog.dart';
import 'package:ride_safe_travel/Event/custom_button.dart';
import 'package:ride_safe_travel/Event/event_attend_controller.dart';
import 'package:ride_safe_travel/Event/event_details_screen.dart';
import 'package:ride_safe_travel/Event/event_request/event_attend_req.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/Utils/CustomLoader.dart';
import 'package:ride_safe_travel/Utils/circular_images.dart';
import 'package:ride_safe_travel/Widgets/my_text.dart';
import 'package:ride_safe_travel/Event/event_models/event_models.dart';

class EventListItems extends StatelessWidget {
  final EventListData eventListData;
  const EventListItems({super.key, required this.eventListData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.black)),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                      text: eventListData.fromDate.toString(),
                      fontName: "Gilroy",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      textColor: Colors.black),
                  Row(
                    children: [
                      MyText(
                          text: eventListData.time.toString(),
                          fontName: "Gilroy",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.black),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          const Icon(MdiIcons.eye),
                          const SizedBox(width: 5),
                          MyText(
                              text: eventListData.views.toString(),
                              fontName: "Gilroy",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              textColor: Colors.black),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  CircularImage(
                      imageUrl: eventListData.imageUrl.toString(),
                      boxFit: BoxFit.fill,
                      width: 50,
                      height: 50),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyText(
                          text: eventListData.name.toString(),
                          fontName: "Gilroy",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.black),
                      const SizedBox(height: 10),
                      MyText(
                          text: eventListData.description.toString(),
                          fontName: "Gilroy",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.grey),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                      child: CustomButton(
                          press: () {
                            exitShowDialog(
                                context, 'Confirmation', 'Are you interested?',
                                () {
                                Get.back();
                            }, () {
                              eventAttend(Preferences.getId(Preferences.id),
                                  eventListData.id.toString(), "Interested");
                            });
                          },
                          buttonText: "Interested",height: 40)),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: CustomButton(
                          press: () {
                            viewEventAttend(Preferences.getId(Preferences.id),
                                eventListData.id.toString(), "");
                          }, buttonText: "View Details",height: 40))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void eventAttend(String userId, String eventId, String status) async {
    final eventAttendController = Get.put(EventAttendController());
    EventAttendReq req = EventAttendReq(userId: userId, eventId: eventId, status: status);
    await eventAttendController.eventAttendApi(req).then((value) {
      if (value != null) {
        if (value.status == true) {
          //CustomLoader.message(value.message.toString());
          Get.back();
        } else {
          CustomLoader.message(value.message.toString());
        }
      }
    });
  }
  void viewEventAttend(String userId, String eventId, String status) async {
    final eventAttendController = Get.put(EventAttendController());
    EventAttendReq req = EventAttendReq(userId: userId, eventId: eventId, status: status);
    await eventAttendController.eventAttendApi(req).then((value) {
      if (value != null) {
        if (value.status == true) {
          //CustomLoader.message(value.message.toString());
          Get.to(EventDetailsScreen(eventListData: eventListData));
        } else {
          CustomLoader.message(value.message.toString());
        }
      }
    });
  }
}
