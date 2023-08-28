import 'package:flutter/material.dart';
import 'package:ride_safe_travel/Event/event_models/event_models.dart';
import 'package:ride_safe_travel/Widgets/my_text.dart';

class EventDetailsScreen extends StatefulWidget {
  final EventListData eventListData;

  const EventDetailsScreen({super.key, required this.eventListData});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const MyText(text: "Event Details", fontName: "Gilroy", fontSize: 18,
            fontWeight: FontWeight.w600, textColor: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(widget.eventListData.imageUrl.toString(),height: 200,width: double.infinity,fit: BoxFit.fitWidth),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Row(
                      children:  [
                        const Icon(Icons.date_range,size: 20),
                        const SizedBox(width: 5),
                        MyText(text: "${widget.eventListData.fromDate.toString()} to ${widget.eventListData.toDate.toString()}", fontName: "Gilroy", fontSize: 16, fontWeight: FontWeight.w600, textColor: Colors.black)
                      ],
                    ),
                    Row(
                      children:  [
                        const Icon(Icons.timer_rounded,size: 20),
                        const SizedBox(width: 5),
                        MyText(text: widget.eventListData.time.toString(), fontName: "Gilroy", fontSize: 16, fontWeight: FontWeight.w600, textColor: Colors.black)
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Row(
                      children:  [
                        const Icon(Icons.location_city,size: 20),
                        const SizedBox(width: 5),
                        MyText(text: widget.eventListData.city.toString(), fontName: "Gilroy", fontSize: 18, fontWeight: FontWeight.w600, textColor: Colors.black)
                      ],
                    ),

                    Row(
                      children:  [
                        const Icon(Icons.location_on_rounded,size: 20),
                        const SizedBox(width: 5),
                        MyText(text: widget.eventListData.state.toString(), fontName: "Gilroy", fontSize: 18, fontWeight: FontWeight.w600, textColor: Colors.black)
                      ],
                    ),
                  ],
                ),
                MyText(text: "Add: ${widget.eventListData.address.toString()}", fontName: "Gilroy", fontSize: 16, fontWeight: FontWeight.w600, textColor: Colors.black),
                const SizedBox(height: 30),
                MyText(text: widget.eventListData.name.toString(), fontName: "Gilroy", fontSize: 18, fontWeight: FontWeight.w600, textColor: Colors.black),
                const SizedBox(height: 10),
                 MyText(text: widget.eventListData.description.toString(), fontName: "Gilroy", fontSize: 16, fontWeight: FontWeight.w600, textColor: Colors.grey),
              ],
            ),
          )


        ],
      ),
    ));
  }
}
