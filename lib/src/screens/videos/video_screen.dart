import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/screens/menu/widgets/home_header.dart';
import 'package:create_it/src/screens/menu/widgets/widgets.dart';
import 'package:create_it/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'widget/bottom_sheet.dart';

class VideoUpload extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.screenWidth(5, context),
            vertical: Responsive.screenHeight(1, context),
          ),
          child: Column(
            children: [
              Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_outlined,
                      color: AppColor.grey,
                    ),
                  ),
                ),
              ),
              YMargin(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Videos",
                    style: TextStyle(
                      color: AppColor.darkBlue,
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
                    "My Videos ",
                    style: TextStyle(
                      color: AppColor.darkBlue,
                      fontSize: 18,
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
              YMargin(10),
              WidgetCardVideoBuilder(),
              YMargin(20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Want to upload a happening \nvideo ",
                  style: TextStyle(
                    color: AppColor.darkBlue,
                    height: 1.6,
                    fontSize: 18,
                  ),
                ),
              ),
              YMargin(20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Click on the button below to start sharing  ",
                  style: TextStyle(
                    color: AppColor.darkBlue,
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
              ),
              YMargin(30),
              ButtonImpl(
                  title: "Share a happening event",
                  onTap: () => videoBottomSheet(context, controller)),
            ],
          ),
        ),
      ),
    );
  }
}
