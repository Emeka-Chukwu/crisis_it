import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/screens/menu/upload_form.dart';
import 'package:create_it/src/view_model/user_riverpod_initialization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecordingAudio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, watch, child) {
          final audio = watch(audioProvider);
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Voice Recorder",
                  style: TextStyle(
                    color: AppColor.darkGreen,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                YMargin(Responsive.screenHeight(15, context)),
                Text(
                  audio.isRecording
                      ? "Recording..."
                      : audio.filePath != ""
                          ? "recorded"
                          : "",
                  style: TextStyle(
                    color: AppColor.darkGreen,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                YMargin(Responsive.screenHeight(3, context)),

                Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: AppColor.darkGreen,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.mic,
                    color: AppColor.white,
                    size: 100,
                  ),
                ),
                // Text("Duration"),
                YMargin(20),
                Text(
                  "${audio.minutes}: ${audio.seconds}",
                  style: TextStyle(
                    color: AppColor.darkGreen,
                    fontSize: 20,
                  ),
                ),
                YMargin(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    audio.isRecording
                        ? GestureDetector(
                            onTap: () => audio.stopRecordAudio(),
                            child: Container(
                              alignment: Alignment.center,
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColor.darkGreen,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.stop,
                                color: AppColor.white,
                                size: 25,
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () => audio.recordAudio(),
                            child: Container(
                              alignment: Alignment.center,
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColor.darkGreen,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.mic,
                                color: AppColor.white,
                                size: 25,
                              ),
                            ),
                          ),
                    XMargin(20),
                    if (audio.filePath != "" && audio.isRecording)
                      audio.isPaused
                          ? GestureDetector(
                              onTap: () => audio.resume(),
                              child: Container(
                                alignment: Alignment.center,
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColor.darkGreen,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.play_arrow,
                                  color: AppColor.white,
                                  size: 25,
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () => audio.pause(),
                              child: Container(
                                alignment: Alignment.center,
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColor.darkGreen,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.pause,
                                  color: AppColor.white,
                                  size: 25,
                                ),
                              ),
                            )
                  ],
                ),
                YMargin(40),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => !audio.isRecording && audio.filePath != ''
                      ? changeScreen(
                          context,
                          UploadFormMenu(
                            index: 3,
                            filePath: audio.filePath,
                          ))
                      : () {},
                  child: Container(
                    alignment: Alignment.center,
                    width: Responsive.screenWidth(90, context),
                    height: 50,
                    decoration: BoxDecoration(
                      color: !audio.isRecording && audio.filePath != ''
                          ? AppColor.darkGreen
                          : AppColor.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(color: AppColor.white),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
