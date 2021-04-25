import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/model/crisis_it.dart';
import 'package:create_it/src/view_model/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final CrisisItModel model;

  const VideoPlayerScreen({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    final videoProviderMain = ChangeNotifierProvider<VideoProvider>((ref) {
      final init = VideoProvider();
      if (MediaType.VIDEO == widget.model.mediaType) {
        init.playRemoteVideos(widget.model.imageUrl, widget.model.id);
      }
      return init;
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer(builder: (context, watch, child) {
        final video = watch(videoProviderMain);

        return WillPopScope(
          onWillPop: () async {
            if (video.remoteController.value.isPlaying) video.stopRemote();
            return true;
          },
          child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.screenWidth(3.5, context)),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  YMargin(Responsive.screenHeight(5, context)),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                        onTap: () {
                          if (video.remoteController.value.isPlaying)
                            video.stopRemote();
                          Navigator.pop(context);
                        },
                        child:
                            Icon(Icons.arrow_back_ios, color: AppColor.white)),
                  ),
                  YMargin(Responsive.screenHeight(25, context)),
                  Container(
                    color: AppColor.white,
                    child: VideoPlayer(
                      video.remoteController,
                    ),
                    width: double.infinity,
                    height: Responsive.screenHeight(35, context),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 2,

                      valueIndicatorColor:
                          Colors.blue, // This is what you are asking for
                      inactiveTrackColor: AppColor.white, // Custom Gray Color
                      activeTrackColor: AppColor.green,
                      thumbColor: AppColor.white,
                      overlayColor:
                          Color(0x29EB1555), // Custom Thumb overlay Color
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 8.0),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 20.0),
                    ),
                    child: Slider(
                      value: video.recordDuration.toDouble(),
                      min: 0,
                      divisions: 100,
                      onChanged: (newValue) {},
                      max:
                          video.remoteController.value.duration.inSeconds
                                      .toDouble() !=
                                  0
                              ? video.remoteController.value.duration.inSeconds
                                      .toDouble() +
                                  4
                              : video.totalDuration.toDouble(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${video.minutes}:${video.seconds}",
                        style: TextStyle(
                          color: AppColor.white,
                          // color: AppColor.bBlue,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "${video.remoteController.value.duration.inSeconds.toDouble() ~/ 60}:${video.remoteController.value.duration.inSeconds.toInt() % 60}",
                        style: TextStyle(
                          color: AppColor.white,
                          // color: AppColor.bBlue,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  if (widget.model.mediaType == MediaType.VIDEO)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        video.isPlaying && video.videoId == widget.model.id
                            ? Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: AppColor.white,
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  icon: Icon(Icons.stop),
                                  onPressed: () => video.stopRemote(),
                                ),
                              )
                            : Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: AppColor.white,
                                    shape: BoxShape.circle),
                                child: IconButton(
                                    icon: Icon(Icons.play_circle_fill),
                                    onPressed: () => video.playRemote(
                                        widget.model.imageUrl,
                                        widget.model.id)),
                              ),
                        // video.isPlaying && video.videoId == model.id
                        //     ? Text(
                        //         "${video.minutes}:${video.seconds}",
                        //         style: TextStyle(
                        //           color: AppColor.darkBlue,
                        //           // color: AppColor.bBlue,
                        //           fontSize: 20,
                        //         ),
                        //       )
                        //     : SizedBox.shrink(),
                      ],
                    )
                ],
              )),
        );
      }),
    );
  }
}
