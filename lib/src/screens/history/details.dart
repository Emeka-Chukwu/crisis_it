import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/model/crisis_it.dart';
import 'package:create_it/src/view_model/user_riverpod_initialization.dart';
// import 'package:create_it/src/screens/menu/single_view.dart';
import 'package:create_it/src/view_model/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatelessWidget {
  final CrisisItModel model;

  const DetailsScreen({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final videoProvider = ChangeNotifierProvider<VideoProvider>((ref) {
      final init = VideoProvider();
      if (MediaType.VIDEO == model.mediaType) {
        init.playRemoteVideos(model.imageUrl, model.id);
      }
      return init;
    });
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Responsive.screenHeight(3, context)),
        child: Consumer(
          builder: (context, watch, child) {
            final video = watch(videoProvider);
            final audio = watch(audioProvider);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(Responsive.screenHeight(7, context)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      audio.stopTheAudioRemote();
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: AppColor.lightGrey,
                    ),
                  ),
                ),
                YMargin(Responsive.screenHeight(3, context)),
                Container(
                  height: Responsive.screenHeight(33, context),
                  child: getWidgetTODisplay(
                      model.mediaType, model.imageUrl, context, video, model),
                ),
                if (model.mediaType == MediaType.AUDIO)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      audio.isPlaying && audio.audioId == model.id
                          ? IconButton(
                              icon: Icon(
                                Icons.stop,
                                color: AppColor.darkGreen,
                              ),
                              onPressed: () => audio.stopTheAudioRemote(),
                            )
                          : IconButton(
                              icon: Icon(Icons.play_circle_fill),
                              onPressed: () => audio.playTheAudioRemote(
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
                          color: AppColor.darkGreen,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                // Container(
                //   width: Responsive.screenWidth(100, context),
                //   height: 222,
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(10),
                //     child: Image(
                //       image: AssetImage("fire_d".png),
                //     ),
                //   ),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                // ),
                YMargin(Responsive.screenHeight(2, context)),
                Text(
                  model.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 2,
                    color: Color(0xff0e1a26),
                  ),
                ),
                Text(
                  DateFormat("EEEE d MMMM, yyyy")
                      .format(DateTime.fromMicrosecondsSinceEpoch(model.time)),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.4,
                    color: Color(0xff7f8e9d),
                  ),
                ),
                YMargin(Responsive.screenHeight(2, context)),
                Text(
                  "Location",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1.4,
                    color: Color(0xff7f8e9d),
                  ),
                ),
                Text(
                  model.place,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.4,
                      color: Color(
                        (0xff0e1a26),
                      )),
                ),
                YMargin(Responsive.screenHeight(2, context)),
                Text(
                  "Type of Incident",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1.4,
                    color: Color(0xff7f8e9d),
                  ),
                ),
                Text(
                  model.incidentType,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.4,
                      color: Color(
                        (0xff0e1a26),
                      )),
                ),
                YMargin(Responsive.screenHeight(2, context)),
                Text(
                  "Details",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1.4,
                    color: Color(0xff7f8e9d),
                  ),
                ),
                Text(
                  model.details,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.4,
                      color: Color(
                        (0xff0e1a26),
                      )),
                ),
                YMargin(Responsive.screenHeight(2, context)),
                Text(
                  "Type of Incident",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1.4,
                    color: Color(0xff7f8e9d),
                  ),
                ),
                Text(
                  model.incidentType,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.4,
                      color: Color(
                        (0xff0e1a26),
                      )),
                ),
                YMargin(Responsive.screenHeight(2, context)),
                Text(
                  "Time",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1.4,
                    color: Color(0xff7f8e9d),
                  ),
                ),
                Text(
                  DateFormat("kk:mm")
                      .format(DateTime.fromMicrosecondsSinceEpoch(model.time)),
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.4,
                      color: Color(
                        (0xff0e1a26),
                      )),
                ),
              ],
            );
          },
        ),
      ),
    ));
  }
}
