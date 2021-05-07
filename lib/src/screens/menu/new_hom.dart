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
      body: SingleChildScrollView(
        child: Consumer(
          builder: (context, watch, child) {
            final user = watch(userProvider);
            return Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.screenWidth(5, context)),
              child: Column(
                children: [
                  YMargin(
                    Responsive.screenHeight(7, context),
                  ),
                  YMargin(15),
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
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      IndicentTypeSelectorSec(
                        incident: "Floods/Erosion",
                        onTap: () {
                          user.setIndexCategory(1);
                          changeScreen(context, MainScreenDashBoard());
                        },
                        imageUrl: "assets/images/flood_.png",
                      ),
                      IndicentTypeSelectorSec(
                        incident: "Accidents",
                        onTap: () {
                          user.setIndexCategory(2);
                          changeScreen(context, MainScreenDashBoard());
                        },
                        imageUrl: "assets/images/accidents_.png",
                      ),
                      IndicentTypeSelectorSec(
                        incident: "Fire",
                        onTap: () {
                          user.setIndexCategory(3);
                          changeScreen(context, MainScreenDashBoard());
                        },
                        imageUrl: "assets/images/fire_.png",
                      ),
                      IndicentTypeSelectorSec(
                        incident: "Building collapse",
                        onTap: () {
                          user.setIndexCategory(4);
                          changeScreen(context, MainScreenDashBoard());
                        },
                        imageUrl: "assets/images/collapse_.png",
                      ),
                      IndicentTypeSelectorSec(
                        incident: "Kidnapping",
                        onTap: () {
                          user.setIndexCategory(5);
                          changeScreen(context, MainScreenDashBoard());
                        },
                        imageUrl: "assets/images/kidnapping.png",
                      ),
                      IndicentTypeSelectorSec(
                        incident: "Thefts and Robbery",
                        onTap: () {
                          user.setIndexCategory(6);
                          changeScreen(context, MainScreenDashBoard());
                        },
                        imageUrl: "assets/images/robbery.png",
                      ),
                      IndicentTypeSelectorSec(
                        incident: "Others",
                        onTap: () {
                          user.setIndexCategory(7);
                          changeScreen(context, MainScreenDashBoard());
                        },
                        imageUrl: "assets/images/crisis.png",
                      ),
                    ],
                  ),
                  YMargin(50),
                ],
              ),
            );
          },
        ),
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

class IndicentTypeSelectorSec extends StatelessWidget {
  final Function onTap;
  final String imageUrl;
  final String incident;

  const IndicentTypeSelectorSec({
    Key? key,
    required this.onTap,
    required this.imageUrl,
    required this.incident,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: EdgeInsets.all(8),
        width: Responsive.screenWidth(40, context),
        height: 110,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(imageUrl),
                width: Responsive.screenWidth(25, context),
                height: 50,
              ),
              YMargin(10),
              Text(
                incident,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    color: Color(0xff133B53)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
