



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ride_safe_travel/Widgets/video_items.dart';
import 'package:ride_safe_travel/controller/video_list_controller.dart';

import '../Utils/CustomLoader.dart';
import '../Utils/EmptyScreen.dart';
import '../body_request/video_request_model.dart';

class LiveVideoScreen extends StatefulWidget {
  String? status;
  LiveVideoScreen({Key? key,this.status}) : super(key: key);

  @override
  State<LiveVideoScreen> createState() => _LiveVideoScreenState();
}

class _LiveVideoScreenState extends State<LiveVideoScreen> {
  final videoController = Get.put(VideoListController());

  @override
  void initState() {
    super.initState();
    videoApi();

  }
  void videoApi()async{
    VideoRequest request=VideoRequest(
        type: widget.status,
        userType: "Rider"
    );
    await videoController.videoListApi(request);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children:  [
            Expanded(
              child: Obx(() {
                return videoController.isLoading.value
                    ? CustomLoader.loader()
                    : videoController.getVideoListData.isEmpty
                    ? const Center(
                  child: EmptyScreen(),
                ) :
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: (3 / 4),
                  shrinkWrap: true,
                  children: List.generate(videoController.getVideoListData.length, (index) {
                    return VideoItems(videoData: videoController.getVideoListData[index]);
                  }),
                );
              }),
            ),

          ],
        ),
      ),
    );
  }
}