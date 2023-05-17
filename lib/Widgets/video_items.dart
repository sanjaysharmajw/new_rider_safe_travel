import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/controller/video_attend_controller.dart';


import '../LoginModule/preferences.dart';
import '../Models/VideoListModel.dart';
import '../TabScreens/VideoViewPage.dart';
import 'my_text.dart';

class VideoItems extends StatelessWidget {
  final VideoData videoData;
  const VideoItems({Key? key, required this.videoData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        attendVideo(videoData.id.toString());
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.network(videoData.thumbnelImage.toString()),
            ),
            const SizedBox(height: 10),
            MyText(
                text: videoData.name.toString(),
                fontName: 'Gilroy',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                textColor: Colors.black),
            const SizedBox(height: 10),
            MyText(
                text: videoData.description.toString(),
                fontName: 'Gilroy',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textColor: Colors.black),
          ],
        ),
      ),
    );
  }
  void attendVideo(String videoId) async{
    final videoAttendController = Get.put(AttendSessionController());

    debugPrint("user id ${Preferences.getId(Preferences.id)}");
    debugPrint("video id ${videoId}");

    await videoAttendController.attendSession(Preferences.getId(Preferences.id), videoId).then((value){
      if(value!=null){
        if(value.status==true){
          Get.to(VideoViewPage(videoResponseData: videoData));
        }

      }
    });

  }
}
