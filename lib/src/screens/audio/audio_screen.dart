import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/screens/menu/widgets/widgets.dart';
import 'package:create_it/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'widget/audio_bottom_sheet.dart';

class AudioUpload extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.screenWidth(6, context),
            vertical: Responsive.screenHeight(1, context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HomeHeader(),
              YMargin(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Audio",
                    style: TextStyle(
                      color: AppColor.darkBlue,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  ImageClipRect(
                    width: 4,
                  ),
                ],
              ),
              YMargin(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Audios ",
                    style: TextStyle(
                      color: AppColor.darkBlue,
                      fontSize: 15,
                    ),
                  ),
                  // Text(
                  //   "See all",
                  //   style: TextStyle(
                  //     color: AppColor.blue,
                  //     fontSize: 15,
                  //   ),
                  // ),
                ],
              ),
              WidgetCardBuilder(
                imagePath: "audiopng".png,
              ),
              YMargin(30),
              Text(
                "Want to upload a \nhappening audio",
                style: TextStyle(
                  color: AppColor.darkBlue,
                  fontSize: 18,
                  height: 1.7,
                ),
              ),
              YMargin(20),
              Text(
                "Click on the button below to start sharing  ",
                style: TextStyle(
                  color: AppColor.darkBlue,
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
              ),
              YMargin(40),
              ButtonImpl(
                title: "Share a happening event",
                onTap: () => audioBottomSheet(context, controller),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
