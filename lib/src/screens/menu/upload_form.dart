import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/model/crisis_it.dart';
import 'package:create_it/src/screens/audio/widget/audio_bottom_sheet.dart';
import 'package:create_it/src/screens/history/history.dart';
import 'package:create_it/src/screens/images/widgets/image_bottom_sheet.dart';
// import 'package:create_it/src/screens/menu/widgets/home_bottom_sheet.dart';
import 'package:create_it/src/view_model/user_riverpod_initialization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadFormMenu extends StatelessWidget {
  final int index;
  String filePath;
  final TextEditingController type = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final GlobalKey<FormState> uploadFormkey = GlobalKey<FormState>();

  UploadFormMenu({Key? key, this.index = 0, this.filePath = ""})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    type.text = "Fire";
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Consumer(
          builder: (context, watch, child) {
            final image = watch(imageProvider);
            final user = watch(userProvider);
            final video = watch(videoProvider);
            final audio = watch(audioProvider);
            return WillPopScope(
              onWillPop: () async {
                // if (video.videoController.value.isPlaying)
                //   video.stopLocalFile();
                video.pauseVideoLocal();
                audio.stopTheAudio();
                return true;
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Responsive.screenWidth(5, context)),
                child: Form(
                  key: uploadFormkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      YMargin(Responsive.screenHeight(5, context)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: AppColor.grey,
                            ),
                            onTap: () {
                              // if (video.videoController.value.isPlaying)
                              //   video.stopLocalFile();
                              video.pauseVideoLocal();
                              audio.stopTheAudio();
                              Navigator.pop(context);
                            },
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.phone_in_talk,
                              color: AppColor.darkGreen,
                            ),
                            onTap: () => null,
                          ),
                        ],
                      ),
                      YMargin(Responsive.screenHeight(2, context)),
                      Container(
                        width: Responsive.screenWidth(100, context),
                        height: Responsive.screenHeight(32, context),
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          children: [
                            YMargin(5),
                            getWidgetTypeTODisplay(
                                index, filePath, context, video),
                            if (index == 2)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  video.isPlaying
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.pause,
                                            color: AppColor.darkGreen,
                                          ),
                                          onPressed: () =>
                                              video.pauseVideoLocal())
                                      : IconButton(
                                          icon: Icon(
                                            Icons.play_circle_fill,
                                            color: AppColor.darkGreen,
                                          ),
                                          onPressed: () =>
                                              video.playVideoLocal()),
                                  video.isPlaying
                                      ? Text(
                                          "${video.minutes}:${video.seconds}",
                                          style: TextStyle(
                                            color: AppColor.darkGreen,
                                            // color: AppColor.bBlue,
                                            fontSize: 20,
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                  video.isPlaying
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.restore,
                                            color: AppColor.darkGreen,
                                          ),
                                          onPressed: () => video.restart())
                                      : SizedBox.shrink(),
                                ],
                              ),
                            if (index == 3)
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    audio.isPlaying
                                        ? IconButton(
                                            icon: Icon(Icons.stop),
                                            onPressed: () =>
                                                audio.stopTheAudio(),
                                          )
                                        : IconButton(
                                            icon: Icon(Icons.play_circle_fill),
                                            onPressed: () =>
                                                audio.playTheAudio(),
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
                              ),
                          ],
                        ),
                      ),
                      YMargin(Responsive.screenHeight(3, context)),
                      Text(
                        "Title",
                        style: TextStyle(
                          color: Color(0xff0E1A26),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                        ),
                      ),
                      YMargin(Responsive.screenHeight(1, context)),
                      Container(
                        width: Responsive.screenWidth(90, context),
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColor.lightGreen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                            controller: titleController,
                            textCapitalization: TextCapitalization.sentences,
                            validator: (text) => text!.length < 4
                                ? "title should be more than 4 characters"
                                : null,
                            style: TextStyle(),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal:
                                        Responsive.screenWidth(3, context)),
                                border: InputBorder.none,
                                hintText: "Give a brief title")),
                      ),
                      YMargin(Responsive.screenHeight(1, context)),
                      Text(
                        "Details",
                        style: TextStyle(
                          color: Color(0xff0E1A26),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                        ),
                      ),
                      YMargin(Responsive.screenHeight(1, context)),
                      Container(
                        width: Responsive.screenWidth(90, context),
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColor.lightGreen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: detailsController,
                          maxLines: 5,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (text) => text!.length < 4
                              ? "Details should be more than 4 characters"
                              : null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Details",
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: Responsive.screenWidth(3, context),
                              vertical: 5,
                            ),
                          ),
                        ),
                      ),
                      YMargin(Responsive.screenHeight(2, context)),
                      Text(
                        "Type of incident",
                        style: TextStyle(
                          color: Color(0xff0E1A26),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                        ),
                      ),
                      YMargin(Responsive.screenHeight(1, context)),
                      Container(
                        width: Responsive.screenWidth(90, context),
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColor.lightGreen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonFormField(
                          hint: Text("Select type"),
                          items: crisis.map((String crises) {
                            return DropdownMenuItem(
                              value: crises,
                              child:
                                  // Icon(Icons.male),
                                  Text(
                                crises,
                                style: TextStyle(color: AppColor.darkGreenText),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            type.text = newValue.toString();
                            print(type.text);
                            // user.setGender(newValue.toString());
                            // print(newValue);
                            //  user.setGender()
                            // do other stuff with _category
                            //  setState(() => _category = newValue);
                          },
                          // value: type.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: Responsive.screenWidth(3, context)),
                          ),
                        ),
                      ),
                      YMargin(Responsive.screenHeight(2, context)),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          print("jjjjjjjjjjj");
                          if (uploadFormkey.currentState!.validate()) {
                            if (index == 1) {
                              image.sendFileToFirebase(
                                  context,
                                  user.userModel,
                                  titleController.text,
                                  detailsController.text,
                                  type.text);
                              print(index);
                            } else if (index == 2) {
                              if (video.videoStringPAth != "") {
                                video.uploadVideoToFirebase(
                                    context,
                                    user.userModel,
                                    titleController.text,
                                    detailsController.text,
                                    type.text);
                                print(index);
                              }
                            } else if (index == 3) {
                              if (audio.isRecording) {
                                audio.stopRecordAudio();
                              }
                              if (titleController.text.isEmpty) {
                                return;
                              }
                              audio.uploadAudioToServer(
                                  context,
                                  user.userModel,
                                  titleController.text,
                                  detailsController.text,
                                  type.text);
                              print(index);
                            } else {}
                          } else {
                            print("kkkkkkkkkkkkkkkkkkkkk");
                            print(index);
                          }
                        },
                        child: Container(
                          width: Responsive.screenWidth(90, context),
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColor.darkGreen,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Submit",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.white,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      YMargin(Responsive.screenHeight(2, context)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

List<String> crisis = [
  "Flood/Erosion",
  "Accidents",
  "Fire",
  "Building collapse",
  "Kidnapping",
  "Thefts and Robbery",
  "Others"
];
