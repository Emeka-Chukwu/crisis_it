import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/model/crisis_it.dart';
import 'package:create_it/src/view_model/audio.dart';
import 'package:create_it/src/view_model/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final audioProvider =
    ChangeNotifierProvider<AudioProvider>((ref) => AudioProvider());

class MenuSingleView extends StatelessWidget {
  final CrisisItModel model;

  const MenuSingleView({
    Key? key,
    required this.model,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final videoProvider = ChangeNotifierProvider<VideoProvider>((ref) {
      final init = VideoProvider();
      if (MediaType.VIDEO == model.mediaType) {
        init.playRemoteVideos(model.imageUrl, "");
      }
      return init;
    });
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Container(
              height: Responsive.screenHeight(110, context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer(
                    builder: (context, watch, child) {
                      final video = watch(videoProvider);
                      final audio = watch(audioProvider);
                      return Container(
                        height: Responsive.screenHeight(50, context),
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.screenWidth(3, context),
                        ),
                        child: Column(children: [
                          YMargin(Responsive.screenHeight(3, context)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back),
                              ),
                            ],
                          ),
                          YMargin(Responsive.screenHeight(3, context)),

                          Container(
                            height: Responsive.screenHeight(33, context),
                            child: getWidgetTODisplay(model.mediaType,
                                model.imageUrl, context, video),
                          ),

                          if (model.mediaType == MediaType.AUDIO)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                audio.isPlaying && audio.audioId == model.id
                                    ? IconButton(
                                        icon: Icon(Icons.stop),
                                        onPressed: () =>
                                            audio.stopTheAudioRemote(),
                                      )
                                    : IconButton(
                                        icon: Icon(Icons.play_circle_fill),
                                        onPressed: () =>
                                            audio.playTheAudioRemote(
                                                model.imageUrl, model.id),
                                      ),
                                // audio.started && audio.isPaused
                                //     ? IconButton(
                                //         icon: Icon(Icons.play_arrow),
                                //         onPressed: () =>
                                //             audio.resumeTheAudioRemote(),
                                //       )
                                //     : audio.started
                                //         ? IconButton(
                                //             icon: Icon(Icons.pause),
                                //             onPressed: () =>
                                //                 audio.pauseTheAudioRemote())
                                //         : SizedBox.shrink(),
                                Text(
                                  "${audio.minutes}:${audio.seconds}",
                                  style: TextStyle(
                                    // color: AppColor.bBlue,
                                    color: AppColor.darkBlue,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),

                          if (model.mediaType == MediaType.VIDEO)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                video.isPlaying && video.videoId == model.id
                                    ? IconButton(
                                        icon: Icon(Icons.stop),
                                        onPressed: () => video.stopRemote(),
                                      )
                                    : IconButton(
                                        icon: Icon(Icons.play_circle_fill),
                                        onPressed: () => video.playRemote(
                                            model.imageUrl, model.id)),
                                video.isPlaying && video.videoId == model.id
                                    ? Text(
                                        "${video.minutes}:${video.seconds}",
                                        style: TextStyle(
                                          color: AppColor.darkBlue,
                                          // color: AppColor.bBlue,
                                          fontSize: 20,
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ],
                            )
                          // Image(
                          //   image: NetworkImage(),
                          //   height: Responsive.screenHeight(26, context),
                          //   width: double.infinity,
                          //   fit: BoxFit.cover,
                          // ),
                        ]),
                      );
                    },
                  ),
                  // YMargin(Responsive.screenHeight(5, context)),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.screenWidth(10, context),
                      ),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.title,
                            style: TextStyle(
                                color: AppColor.darkBlue,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                          YMargin(Responsive.screenHeight(1.5, context)),
                          Text(
                            model.place,
                            style: TextStyle(
                              color: AppColor.darkBlue,
                              fontWeight: FontWeight.w300,
                            ),
                          ),

                          YMargin(Responsive.screenHeight(2.5, context)),
                          // Text(
                          //   "N ${Currency.format(price.toString())}",
                          //   style: TextStyle(
                          //       color: black,
                          //       fontWeight: FontWeight.w600,
                          //       fontSize: Responsive.textSize(4.4, context)),
                          // ),
                          YMargin(Responsive.screenHeight(1, context)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        Responsive.screenHeight(2, context)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Latitude",
                                      style: TextStyle(
                                        color: AppColor.darkBlue,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    YMargin(
                                        Responsive.screenHeight(1, context)),
                                    Text(
                                      model.lat.toStringAsFixed(4),
                                      style: TextStyle(
                                        color: AppColor.darkBlue,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: Responsive.screenWidth(35, context),
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        Responsive.screenHeight(2, context)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name",
                                      style: TextStyle(
                                        color: AppColor.darkBlue,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    YMargin(
                                        Responsive.screenHeight(1, context)),
                                    Text(
                                      model.name,
                                      style: TextStyle(
                                        color: AppColor.darkBlue,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // YMargin(Responsive.constScreenHeight(3, context)),
                          // YMargin(Responsive.screenHeight(3, context)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        Responsive.screenHeight(2, context)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Longitude",
                                      style: TextStyle(
                                        color: AppColor.darkBlue,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    YMargin(
                                        Responsive.screenHeight(1, context)),
                                    Text(
                                      model.long.toStringAsFixed(3),
                                      style: TextStyle(
                                        color: AppColor.darkBlue,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: Responsive.screenWidth(35, context),
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        Responsive.screenHeight(2, context)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "File Type",
                                      style: TextStyle(
                                        color: AppColor.darkBlue,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    YMargin(
                                        Responsive.screenHeight(1, context)),
                                    // ${DateFormat('yyyy-MM-dd – kk:mm').format(_user.data.subscription[0]['expiryTime'])}
                                    if (model.mediaType == MediaType.IMAGE)
                                      Text(
                                        "Image",
                                        style: TextStyle(
                                          color: AppColor.darkBlue,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    if (model.mediaType == MediaType.VIDEO)
                                      Text(
                                        "Video",
                                        style: TextStyle(
                                          color: AppColor.darkBlue,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    if (model.mediaType == MediaType.AUDIO)
                                      Text(
                                        "Audio",
                                        style: TextStyle(
                                          color: AppColor.darkBlue,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Container(
                            alignment: Alignment.center,
                            width: Responsive.screenWidth(35, context),
                            padding: EdgeInsets.symmetric(
                                vertical: Responsive.screenHeight(2, context)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Time",
                                  style: TextStyle(
                                    color: AppColor.darkBlue,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                YMargin(Responsive.screenHeight(1, context)),
                                // ${DateFormat('yyyy-MM-dd – kk:mm').format(_user.data.subscription[0]['expiryTime'])}
                                Text(
                                  DateFormat("EEEE d MMMM, yyyy  kk:mm").format(
                                      DateTime.fromMicrosecondsSinceEpoch(
                                          model.time)),
                                  style: TextStyle(
                                    color: AppColor.darkBlue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
