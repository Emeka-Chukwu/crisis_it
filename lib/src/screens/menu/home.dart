import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/screens/images/widgets/image_bottom_sheet.dart';
import 'package:create_it/src/screens/menu/recording_audio.dart';
import 'package:create_it/src/screens/menu/widgets/widgets.dart';
import 'package:create_it/src/view_model/user_riverpod_initialization.dart';
// import 'package:create_it/src/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'widgets/action_button.dart';
import 'widgets/home_bottom_sheet.dart';
import 'widgets/home_tip.dart';

class MenuHome extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read(crisisProvider).getAllProducts();

    return Scaffold(
      // backgroundColor: AppColor.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.screenWidth(5, context),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                YMargin(20),

                YMargin(20),
                // align(),
                HomeHeaderSecond(),
                YMargin(20),
                // SearchBar(
                //   width: 95,
                //   onTap: () => null,
                //   controller: controller,
                // ),
                HomeTip(),
                YMargin(20),
                // HomeHeaderThird(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Quick actions",
                    style: TextStyle(
                      color: Color(0xff535C66),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ),
                YMargin(20),
                Consumer(
                  builder: (context, watch, child) {
                    final image = watch(imageProvider);
                    final user = watch(userProvider);
                    final video = watch(videoProvider);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        HomeActionButton(
                          icon: Icons.camera_alt,
                          title: "Take picture",
                          onTap: () {
                            image.recordAnImage(
                                user.userModel, context, controller.text);
                          },
                        ),
                        HomeActionButton(
                          icon: Icons.videocam,
                          title: "Record video",
                          onTap: () {
                            video.recordAVideo(
                                user.userModel, context, controller.text);
                          },
                        ),
                        HomeActionButton(
                          icon: Icons.mic,
                          title: "Record audio",
                          onTap: () {
                            changeScreen(context, RecordingAudio());
                          },
                        ),
                        HomeActionButton(
                          icon: Icons.phone_in_talk,
                          title: "Call security",
                          onTap: () {},
                        )
                      ],
                    );
                  },
                ),
                // HomeFilesWrap(),
                // HomeRecommendation(),
                YMargin(30),
                HomeHeader(),
                YMargin(30),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => menuBottomSheet(context, messageController),
                  child: Container(
                    width: Responsive.screenWidth(90, context),
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColor.darkGreen,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage("megaphone2".png),
                        ),
                        XMargin(15),
                        Text(
                          "Report Incident",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColor.white,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                )

                // HomeHeaderFouth(),
                // YMargin(15),
                // HomeRecommendation(),
                // YMargin(25),
                // HomeHeaderFifth(),
                // YMargin(15),
                // HomeRecommendation(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
