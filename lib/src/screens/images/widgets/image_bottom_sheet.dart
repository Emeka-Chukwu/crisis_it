import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/view_model/image_vm.dart';
import 'package:create_it/src/view_model/user.dart';
import 'package:create_it/src/view_model/user_riverpod_initialization.dart';
import 'package:create_it/src/widgets/widgets.dart';
// import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dialog.dart';

void imageBottomSheet(BuildContext context, TextEditingController controller) {
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
              child: ImageUploadSheet(
            controller: controller,
          )),
        );
      });
}

// ignore: non_constant_identifier_names
// ChangeNotifierProvider<VideoProvider>((ref) => VideoProvider());

class ImageUploadSheet extends StatelessWidget {
  final TextEditingController controller;

  const ImageUploadSheet({Key? key, required this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final image = watch(imageProvider);
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
                  color: AppColor.darkBlue,
                ),
              ),
              YMargin(10),
              FieldTextWithBorder(
                controller: controller,
                color: AppColor.blue,
              ),
              YMargin(20),
              Text("Photo",
                  style: TextStyle(
                    color: AppColor.darkBlue,
                  )),
              YMargin(10),
              GestureDetector(
                onTap: () => selectTypeOfImageToUpload(
                  context,
                  () {
                    // if(user.userModel ! == null){}
                    image.pickImages(user.userModel, context, controller.text);
                  },
                  () => image.recordAnImage(
                      user.userModel, context, controller.text),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: Responsive.screenHeight(30, context),
                  width: Responsive.screenHeight(50, context),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: AppColor.blue,
                  )),
                  child: image.filePath != ""
                      ? Image.file(image.file)
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
                      // audio.stopTheAudio();
                      Navigator.pop(context);
                    },
                  ),
                  XMargin(10),
                  ButtonImplSecond(
                      title: "upload ",
                      width: 35,
                      textColor: AppColor.white,
                      boxColor: AppColor.darkBlue,
                      onTap: () => null
                      //  image.sendFileToFirebase(
                      //     context, user.userModel, controller.text),
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
