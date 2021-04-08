import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/view_model/user_riverpod_initialization.dart';
import 'package:create_it/src/view_model/video.dart';
import 'package:create_it/src/widgets/widgets.dart';
// import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import 'dailog.dart';

final videoProvider =
    ChangeNotifierProvider<VideoProvider>((ref) => VideoProvider());
void videoBottomSheet(BuildContext context, TextEditingController controller) {
  showModalBottomSheet(
      // shape: ShapeBorder(),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            Responsive.screenWidth(10, context),
          ),
          topRight: Radius.circular(
            Responsive.screenWidth(10, context),
          ),
        ),
      ),
      context: context,
      builder: (ccontext) {
        return Container(
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                Responsive.screenWidth(10, context),
              ),
              topRight: Radius.circular(
                Responsive.screenWidth(10, context),
              ),
            ),
          ),
          child: SingleChildScrollView(
              child: VideoUploadSheet(
            controller: controller,
          )),
        );
      });
}

// ignore: non_constant_identifier_names
// ChangeNotifierProvider<VideoProvider>((ref) => VideoProvider());

class VideoUploadSheet extends StatelessWidget {
  final TextEditingController controller;

  const VideoUploadSheet({Key? key, required this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final video = watch(videoProvider);
        final user = watch(userProvider);
        // flick = video.flickManager;

        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: Responsive.screenWidth(10, context),
              vertical: Responsive.screenHeight(4, context)),
          height: Responsive.screenHeight(80, context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "To share your video, do below ",
                  style: TextStyle(
                    color: AppColor.blue,
                    fontSize: 18,
                  ),
                ),
              ),
              YMargin(20),
              Text(
                "Title",
                style: TextStyle(
                  color: AppColor.bBlue,
                ),
              ),
              YMargin(10),
              FieldTextWithBorder(
                controller: controller,
                color: AppColor.blue,
                width: Responsive.screenWidth(110, context),
              ),
              YMargin(20),
              Text(
                "Video",
                style: TextStyle(
                  color: AppColor.bBlue,
                ),
              ),
              YMargin(10),
              GestureDetector(
                onTap: () => selectTypeOfUpload(
                  context,
                  () => video.pickVideos(user.userModel, controller.text),
                  () => video.recordAVideo(user.userModel, controller.text),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: video.isPickVideo
                      ? Responsive.screenHeight(30, context)
                      : Responsive.screenHeight(20, context),
                  width: Responsive.screenHeight(50, context),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: AppColor.blue,
                  )),
                  child: video.isPickVideo
                      // ?
                      // AspectRatio(
                      //     child: Container(
                      //       child: FlickVideoPlayer(
                      //           flickManager: video.flickManager),
                      //     ),
                      //     aspectRatio: .7,
                      //   )
                      ? AspectRatio(
                          child: VideoPlayer(video.videoController),
                          // aspectRatio: video.videoController.value.aspectRatio,
                          aspectRatio: 1.6,
                        )
                      : Text("Import or Start recording"),
                ),
              ),
              YMargin(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonImplSecond(
                      title: "Cancel",
                      width: 35,
                      textColor: AppColor.darkBlue,
                      boxColor: AppColor.white,
                      onTap: () => Navigator.pop(context)),
                  XMargin(15),
                  ButtonImplSecond(
                    title: "upload ",
                    width: 35,
                    textColor: AppColor.white,
                    boxColor: AppColor.darkBlue,
                    onTap: () {
                      if (video.videoStringPAth != "") {
                        video.uploadVideoToFirebase(
                            context, user.userModel, controller.text);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
