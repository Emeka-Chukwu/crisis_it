import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/view_model/audio.dart';
import 'package:create_it/src/view_model/user_riverpod_initialization.dart';
import 'package:create_it/src/widgets/widgets.dart';
// import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dialog.dart';

final audioProvider =
    ChangeNotifierProvider<AudioProvider>((ref) => AudioProvider());
void audioBottomSheet(BuildContext context, TextEditingController controller) {
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

class VideoUploadSheet extends StatefulWidget {
  final TextEditingController controller;

  const VideoUploadSheet({Key? key, required this.controller})
      : super(key: key);

  @override
  _VideoUploadSheetState createState() => _VideoUploadSheetState();
}

class _VideoUploadSheetState extends State<VideoUploadSheet> {
  bool recording = true;
  bool pause = false;

  @override
  void initState() {
    recording = true;
    pause = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final audio = watch(audioProvider);
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
              Text(
                "To share your audio, do below ",
                style: TextStyle(
                  color: AppColor.blue,
                  fontSize: 18,
                ),
              ),
              YMargin(20),
              Text(
                "Title",
                style: TextStyle(
                  color: AppColor.blue,
                ),
              ),
              YMargin(10),
              FieldTextWithBorder(
                controller: widget.controller,
                color: AppColor.blue,
              ),
              YMargin(20),
              Text("Audio", style: TextStyle(color: AppColor.bBlue)),
              YMargin(10),
              GestureDetector(
                onTap: () => selectTypeOfAudioUpload(
                  context,
                  () => audio.pickAudio(),
                  () => audio.recordAudio(),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: Responsive.screenHeight(30, context),
                  width: Responsive.screenHeight(50, context),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: AppColor.blue,
                  )),
                  child: audio.filePath != ""
                      ? Consumer(builder: (context, watch, child) {
                          final controller = watch(audioProvider);
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              recording
                                  ? GestureDetector(
                                      onTap: () {
                                        controller.stopRecordAudio();
                                        setState(() {
                                          recording = false;
                                        });
                                      },
                                      child: Icon(
                                        Icons.stop,
                                        color: AppColor.errorRed,
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        controller.recordAudio();
                                        setState(() {
                                          recording = true;
                                        });
                                      },
                                      child: Icon(
                                        Icons.mic,
                                        color: AppColor.errorRed,
                                      ),
                                    ),
                              XMargin(15),
                              Text(
                                "${audio.minutes}: ${audio.seconds}",
                                style: TextStyle(
                                  color: AppColor.bBlue,
                                  fontSize: 20,
                                ),
                              ),

                              XMargin(15),
                              !recording
                                  ? pause
                                      ? GestureDetector(
                                          onTap: () {
                                            audio.pauseTheAudio();
                                            print("pause");
                                            setState(() {
                                              pause = false;
                                            });
                                          },
                                          child: Icon(
                                            Icons.pause,
                                            color: AppColor.errorRed,
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            audio.resumeTheAudio();
                                            setState(() {
                                              pause = true;
                                            });
                                          },
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: AppColor.errorRed,
                                          ),
                                        )
                                  : SizedBox.shrink(),
                              // audio.isRecording

                              //    ? GestureDetector(
                              //             onTap: () => audioProvider.pauseTheAudio(),
                              //             child: Icon(
                              //               Icons.pause,
                              //               color: AppColor.errorRed,
                              //             ),
                              //           ),
                              //         : GestureDetector(
                              //             onTap: () => audio.resumeTheAudio(),
                              //             child: Icon(
                              //               Icons.play_arrow,
                              //               color: AppColor.errorRed,
                              //             ),
                              //           )
                            ],
                          );
                        })

                      // )
                      // ? audio.isRecording
                      //     ? AudioClassPlayer(
                      //         audioProvider: audio,
                      //       )
                      //     : PlayRecordedAudio(
                      //         audioProvider: audio,
                      //       )
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
                    onTap: () {
                      audio.stopTheAudio();
                      audio.stopRecordAudio();
                      // Navigator.pop(context);
                    },
                  ),
                  XMargin(10),
                  ButtonImplSecond(
                      title: "upload ",
                      width: 35,
                      textColor: AppColor.white,
                      boxColor: AppColor.darkBlue,
                      onTap: () {
                        // audio.playTheAudio();
                        if (audio.isRecording) {
                          audio.stopRecordAudio();
                        }
                        if (widget.controller.text.isEmpty) {
                          return;
                        }
                        audio.uploadAudioToServer(
                            context, user.userModel, widget.controller.text);
                      }),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class AudioClassPlayer extends StatelessWidget {
  final AudioProvider audioProvider;

  const AudioClassPlayer({Key? key, required this.audioProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (audioProvider.isRecorder) {
      return Column(
        children: [
          YMargin(20),
          Text(
            "Recorder",
            style: TextStyle(
              color: AppColor.bBlue,
              fontSize: 20,
            ),
          ),
          YMargin(20),
          Text(
            "${audioProvider.minutes}: ${audioProvider.seconds}",
            style: TextStyle(
              color: AppColor.bBlue,
              fontSize: 20,
            ),
          ),
          YMargin(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              audioProvider.isRecording
                  ? GestureDetector(
                      onTap: () => audioProvider.stopRecordAudio(),
                      child: Icon(
                        Icons.stop,
                        color: AppColor.errorRed,
                      ),
                    )
                  : GestureDetector(
                      onTap: () => audioProvider.recordAudio(),
                      child: Icon(
                        Icons.mic,
                        color: AppColor.errorRed,
                      ),
                    ),
              audioProvider.isRecording
                  ? audioProvider.isPaused
                      ? GestureDetector(
                          onTap: () => null,
                          child: Icon(
                            Icons.play_arrow,
                            color: AppColor.errorRed,
                          ),
                        )
                      : GestureDetector(
                          onTap: () => audioProvider.pauseTheAudio(),
                          child: Icon(
                            Icons.pause,
                            color: AppColor.errorRed,
                          ),
                        )
                  : SizedBox.shrink(),
            ],
          )
        ],
      );
    } else {
      return PlayRecordedAudio(
        audioProvider: audioProvider,
      );
    }
  }
}

class PlayRecordedAudio extends StatelessWidget {
  final AudioProvider audioProvider;

  const PlayRecordedAudio({Key? key, required this.audioProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (audioProvider.filePath != "") {
      return Column(
        children: [
          YMargin(20),
          Text(
            "Play Recorder",
            style: TextStyle(
              color: AppColor.bBlue,
              fontSize: 20,
            ),
          ),
          YMargin(20),
          Text(
            "${audioProvider.minutes}: ${audioProvider.seconds}",
            style: TextStyle(
              color: AppColor.bBlue,
              fontSize: 20,
            ),
          ),
          YMargin(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => audioProvider.playTheAudio(),
                child: Icon(
                  Icons.play_arrow,
                  color: AppColor.errorRed,
                ),
              ),
              audioProvider.isPaused
                  ? GestureDetector(
                      onTap: () => audioProvider.resumeTheAudio(),
                      child: Icon(
                        Icons.pause,
                        color: AppColor.errorRed,
                      ),
                    )
                  : GestureDetector(
                      onTap: () => audioProvider.pauseTheAudio(),
                      child: Icon(
                        Icons.play_circle_fill_outlined,
                        color: AppColor.errorRed,
                      ),
                    ),
              audioProvider.isPlaying
                  ? GestureDetector(
                      onTap: () => audioProvider.stopTheAudio(),
                      child: Icon(
                        Icons.stop,
                        color: AppColor.errorRed,
                      ),
                    )
                  : GestureDetector(
                      onTap: () => audioProvider.playTheAudio(),
                      child: Icon(
                        Icons.pause,
                        color: AppColor.errorRed,
                      ),
                    )
            ],
          )
        ],
      );
    } else {
      return Text("jjjjjjjjjjjjjjjjjj");
    }
  }
}
