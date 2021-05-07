import 'package:create_it/src/cores/cores.dart';
import 'package:flutter/material.dart';

import 'help_details.dart';

class HelpHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.screenWidth(4, context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(
                Responsive.screenHeight(10, context),
              ),
              Text(
                "Info hub",
                style: TextStyle(
                  color: AppColor.darkGreen,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              YMargin(10),
              Text(
                "Learn how to handle crisis situations and use of First Aid",
                style: TextStyle(
                  color: AppColor.greyText,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              YMargin(30),
              HelperComponentsDivider(
                onTap: () => changeScreen(context, HelpScreenDetails()),
                title: "How to use first aid kits",
              ),
              YMargin(15),
              HelperComponentsDivider(
                onTap: () {},
                title: "How to use first aid kits",
              ),
              YMargin(15),
              HelperComponentsDivider(
                onTap: () => changeScreen(context, HelpScreenDetails()),
                title: "How to use first aid kits",
              ),
              YMargin(15),
              HelperComponentsDivider(
                onTap: () => changeScreen(context, HelpScreenDetails()),
                title: "How to use first aid kits",
              ),
              YMargin(15),
              HelperComponentsDivider(
                onTap: () => changeScreen(context, HelpScreenDetails()),
                title: "How to use first aid kits",
              ),
              YMargin(15),
              HelperComponentsDivider(
                onTap: () => changeScreen(context, HelpScreenDetails()),
                title: "How to use first aid kits",
              ),
            ],
          )),
    );
  }
}

class HelperComponentsDivider extends StatelessWidget {
  final String title;
  final Function onTap;

  const HelperComponentsDivider(
      {Key? key, required this.title, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onTap(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff535C66),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xffC7CAD9),
                  size: 15,
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
            color: Color(0xffC7CAD9),
          ),
        ],
      ),
    );
  }
}
