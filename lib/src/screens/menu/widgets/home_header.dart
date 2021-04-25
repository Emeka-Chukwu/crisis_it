import 'package:create_it/src/cores/colors.dart';
import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/services/user_services.dart';
import 'package:create_it/src/view_model/user.dart';
import 'package:create_it/src/view_model/user_riverpod_initialization.dart';
import 'package:create_it/src/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.screenWidth(100, context),
      height: 90,
      decoration: BoxDecoration(
        color: Color(0xffF2F0E7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          XMargin(10),
          Icon(
            Icons.location_on,
            size: 35,
            color: AppColor.darkGreen,
          ),
          XMargin(20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Current Location",
                style: TextStyle(
                  color: Color(0xff7F8E9D),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              YMargin(5),
              Consumer(
                builder: (context, watch, child) {
                  final user = watch(userProvider);
                  return Text(
                    "${user.place}",
                    style: TextStyle(
                      color: AppColor.darkGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class HomeHeaderSecond extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final user = watch(userProvider);
        print("user name ${user.userModel.email}");

        if (user.place == "") {
          user.getUserLocation();
        }
        print("name here ${user.email}");
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hello,",
                    style: TextStyle(
                      color: AppColor.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    )),
                YMargin(5),
                Text("${user.userModel.name}!",
                    style: TextStyle(
                      color: AppColor.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    )),
              ],
            ),
            GestureDetector(
                onTap: () => AlertDialogClass.newDialogLogout(
                      context,
                      onTap: () => user.logoutUser(context),
                    ),

                // AlertDialogClass.newDialogLoading(
                //       context,
                //       title: "Loading...",
                //       description:
                //           "We're getting your request done. \nKindly wait a bit",
                //     ),
                child: Icon(
                  Icons.logout,
                  color: AppColor.red,
                ))
          ],
        );
      },
    );
  }
}

class HomeHeaderThird extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Videos",
            style: TextStyle(
              color: AppColor.darkBlue,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        GestureDetector(
            onTap: null,
            child: Text("See all",
                style: TextStyle(
                  color: AppColor.darkBlue,
                ))),
      ],
    );
  }
}

class HomeHeaderFouth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Audios",
            style: TextStyle(
              color: AppColor.darkBlue,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        GestureDetector(
            onTap: null,
            child: Text("See all",
                style: TextStyle(
                  color: AppColor.bBlue,
                ))),
      ],
    );
  }
}

class HomeHeaderFifth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Photos",
            style: TextStyle(
              color: AppColor.darkBlue,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        GestureDetector(
            onTap: null,
            child: Text("See all",
                style: TextStyle(
                  color: AppColor.darkBlue,
                ))),
      ],
    );
  }
}
