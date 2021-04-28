import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/dashboard/main_screens.dart';
import 'package:create_it/src/view_model/user.dart';
import 'package:create_it/src/view_model/user_riverpod_initialization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewMenuHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, watch, child) {
          final user = watch(userProvider);
          return Container(
            child: Column(
              children: [
                YMargin(
                  Responsive.screenHeight(7, context),
                ),
                Text(
                  "Welcome",
                  style: TextStyle(
                    color: AppColor.darkGreen,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                YMargin(10),
                Text(
                  "Quickly report an event around you",
                  style: TextStyle(
                    color: AppColor.greyText,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                YMargin(20),
                IndicentTypeSelector(
                  incident: "Flood/Erosion",
                  onTap: () => user.setIndexCategory(1),
                  user: user,
                  index: 1,
                ),
                IndicentTypeSelector(
                  incident: "Accidents",
                  onTap: () => user.setIndexCategory(2),
                  user: user,
                  index: 2,
                ),
                IndicentTypeSelector(
                  incident: "Fire",
                  onTap: () => user.setIndexCategory(3),
                  user: user,
                  index: 3,
                ),
                IndicentTypeSelector(
                  incident: "Building collapse",
                  onTap: () => user.setIndexCategory(4),
                  user: user,
                  index: 4,
                ),
                IndicentTypeSelector(
                  incident: "Kidnapping",
                  onTap: () => user.setIndexCategory(5),
                  user: user,
                  index: 5,
                ),
                IndicentTypeSelector(
                  incident: "Thefts and Robbery",
                  onTap: () => user.setIndexCategory(6),
                  user: user,
                  index: 6,
                ),
                IndicentTypeSelector(
                  incident: "Others",
                  onTap: () => user.setIndexCategory(7),
                  user: user,
                  index: 7,
                ),
                YMargin(50),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => user.indexCategory != 0
                      ? changeScreen(context, MainScreenDashBoard())
                      : null,
                  child: Container(
                    width: Responsive.screenWidth(90, context),
                    height: 60,
                    decoration: BoxDecoration(
                      color: user.indexCategory != 0
                          ? AppColor.darkGreen
                          : AppColor.cyan,
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
                ),
                YMargin(10),
                GestureDetector(
                  onTap: null,
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class IndicentTypeSelector extends StatelessWidget {
  final Function onTap;
  final UserProvider user;
  final int index;
  final String incident;

  const IndicentTypeSelector({
    Key? key,
    required this.onTap,
    required this.user,
    required this.index,
    required this.incident,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          checkColor: AppColor.white, // color of tick Mark
          activeColor: AppColor.darkGreen,
          value: user.indexCategory == index,
          onChanged: (value) => user.setIndexCategory(index),
        ),
        XMargin(15),
        Text(
          incident,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.4,
              color: Color(0xff133B53)),
        )
      ],
    );
  }
}
