
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/CustomLoader.dart';
import '../Widgets/video_items.dart';
import '../body_request/video_request_model.dart';
import 'package:ride_safe_travel/Utils/EmptyScreen.dart';
import '../controller/video_list_controller.dart';

class ListVideScreen extends StatefulWidget {
  String? status;
  ListVideScreen({Key? key,this.status}) : super(key: key);

  @override
  State<ListVideScreen> createState() => _ListVideoScreenState();
}

class _ListVideoScreenState extends State<ListVideScreen> {
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
