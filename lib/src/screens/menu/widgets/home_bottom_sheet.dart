import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/view_model/user_riverpod_initialization.dart';
import 'package:create_it/src/view_model/video.dart';
import 'package:create_it/src/widgets/widgets.dart';
// import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../upload_form.dart';

void menuBottomSheet(BuildContext context, TextEditingController controller) {
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
        final audio = watch(audioProvider);
        final image = watch(imageProvider);
        // flick = video.flickManager;

        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: Responsive.screenWidth(10, context),
              vertical: Responsive.screenHeight(4, context)),
          // height: Responsive.screenHeight(80, context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Report Incident",
                  style: TextStyle(
                    color: AppColor.darkGreen,
                    fontSize: 18,
                  ),
                ),
              ),
              YMargin(10),
              Text(
                "Select an option or proceed to report an incident ",
                style: TextStyle(
                  color: AppColor.darkTextGreen,
                ),
              ),
              YMargin(30),
              UploadWidget(
                onTap: () {
                  image.pickImages(user.userModel, context);
                },
                icon: Icons.image,
                title: 'Upload Image',
              ),
              YMargin(30),
              UploadWidget(
                onTap: () {
                  audio.pickAudio(context);
                },
                icon: Icons.mic,
                title: 'Audio',
              ),
              YMargin(30),
              UploadWidget(
                onTap: () {
                  video.pickVideos(user.userModel, context);
                },
                icon: Icons.video_collection_sharp,
                title: 'Upload video',
              ),
              YMargin(30),
              GestureDetector(
                onTap: () {
                  user.setShowMeassage();
                },
                child: Text(
                  user.showMessage
                      ? "Hide message field"
                      : "Send message field",
                  style: TextStyle(
                    color: Color(0xff535C66),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
              if (user.showMessage) YMargin(30),
              if (user.showMessage)
                Container(
                  width: Responsive.screenWidth(90, context),
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColor.lightGreen,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: controller,
                    maxLines: 5,
                    textCapitalization: TextCapitalization.sentences,
                    validator: (text) => text!.length < 4
                        ? "Details should be more than 4 characters"
                        : null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter meassage",
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: Responsive.screenWidth(3, context),
                        vertical: 5,
                      ),
                    ),
                  ),
                ),
              if (user.showMessage) YMargin(30),
              if (user.showMessage)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  // onTap: () => changeScreen(context, UploadFormMenu()),
                  onTap: () {
                    if (controller.text.isNotEmpty) {
                      user.sendSMSToAdmin(
                          controller, ["+37256193217"], context);
                    }
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: Responsive.screenWidth(90, context),
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColor.darkGreen,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "Proceed",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColor.white,
                          fontSize: 16,
                        ),
                      )),
                )
            ],
          ),
        );
      },
    );
  }
}

class UploadWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  const UploadWidget(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppColor.lightGrey,
              ),
              XMargin(8),
              Expanded(
                child: Text(
                  "$title",
                  style: TextStyle(
                    color: Color(0xff535C66),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: AppColor.lightGrey,
              )
            ],
          ),
          Divider(
            thickness: 1,
            color: Color(0xffe5e5e5),
          ),
        ],
      ),
    );
  }
}
