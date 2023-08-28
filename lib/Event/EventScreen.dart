import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/Event/event_controller.dart';
import 'package:ride_safe_travel/Event/event_list_items.dart';
import 'package:ride_safe_travel/Widgets/my_text.dart';
import 'package:ride_safe_travel/utils/CustomLoader.dart';
import '../bottom_nav/EmptyScreen.dart';
import '../color_constant.dart';


class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final eventController = Get.put(EventController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: appBlue,
            title:  const MyText(text: "Event Screen", fontName: "Gilroy", fontSize: 18,
                fontWeight: FontWeight.w600, textColor: Colors.white),
          ),
            body: Column(
      children:  [
       Expanded(
         child: Obx(() {
           return
           eventController.isLoading.value
                ? CustomLoader.loader()
                : eventController.getEventListData.isEmpty
                ? Center(
              child: EmptyScreen(text: 'Event not found'),
           ) :
            ListView.builder(
                itemCount: eventController.getEventListData.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return  EventListItems(eventListData: eventController.getEventListData[index]);
                });
         })),

      ],
    )));
  }


}
