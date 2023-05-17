
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ride_safe_travel/Models/VideoListModel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../color_constant.dart';
import '../new_widgets/my_new_text.dart';

class VideoViewPage extends StatefulWidget {
  VideoData? videoResponseData;


  VideoViewPage({Key? key,  this.videoResponseData}) : super(key: key);

  @override
  State<VideoViewPage> createState() => _VideoViewPageState();
}

class _VideoViewPageState extends State<VideoViewPage> {
  late YoutubePlayerController _controller;



  @override
  void initState() {

    debugPrint("video link ${widget.videoResponseData!.videoLink.toString()}");
    final videoID = YoutubePlayer.convertUrlToId(

        widget.videoResponseData!.videoLink.toString());
    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          showLiveFullscreenButton: true,
        ));


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  InkWell(highlightColor: Colors.black38,
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(
                          'new_assets/new_back.png', width: 17, height: 17)),
                  const SizedBox(height: 20),
                  NewMyText(
                      textValue: widget.videoResponseData!.name.toString(),
                      fontName: 'Gilroy',
                      color: appBlack,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () => debugPrint("ready"),
              bottomActions: [
                CurrentPosition(),
                ProgressBar(
                  isExpanded: true,
                  colors: const ProgressBarColors(
                      playedColor: Colors.black, handleColor: Colors.grey),
                ),
                const PlaybackSpeedButton(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.videoResponseData!.description.toString()),
            )
          ],
        ),
      ),
    );
  }
}