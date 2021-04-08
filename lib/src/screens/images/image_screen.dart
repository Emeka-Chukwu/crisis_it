import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/screens/images/widgets/image_bottom_sheet.dart';
import 'package:create_it/src/screens/menu/widgets/widgets.dart';
import 'package:create_it/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ImageUpload extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.screenWidth(4, context),
            vertical: Responsive.screenHeight(1, context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HomeHeader(),
              YMargin(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Photos",
                    style: TextStyle(
                      color: AppColor.blue,
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
                    "My Photos ",
                    style: TextStyle(
                      color: AppColor.blue,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                      color: AppColor.blue,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              YMargin(30),
              WidgetCardImageBuilder(
                imagePath: "dummy".png,
              ),
              YMargin(20),
              Text(
                "Want to upload a \nhappening image",
                style: TextStyle(
                  color: AppColor.darkBlue,
                  fontSize: 18,
                  height: 1.7,
                  fontWeight: FontWeight.w400,
                ),
              ),
              YMargin(30),
              Text(
                "Click on the button below to start sharing  ",
                style: TextStyle(
                  color: AppColor.darkBlue,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
              YMargin(30),
              ButtonImpl(
                title: "Share a happening event",
                onTap: () => imageBottomSheet(context, controller),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
